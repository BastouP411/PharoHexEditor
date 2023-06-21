Class {
	#name : #PhePieceTable,
	#superclass : #Object,
	#instVars : [
		'originalBuffer',
		'addBuffer',
		'pieceTable',
		'cursor',
		'undoStack',
		'redoStack'
	],
	#category : #'PharoHexEditor-PieceTable'
}

{ #category : #'instance creation' }
PhePieceTable class >> newFromArray: aByteArray [

	| table |
	table := PhePieceTable new
		         originalBuffer: aByteArray;
		         yourself.
	table pieceTable add:
		(PhePiece newFromOriginalBufferFrom: 1 ofLength: aByteArray size).
	^ table
]

{ #category : #accessing }
PhePieceTable >> addBuffer [

	^ addBuffer
]

{ #category : #accessing }
PhePieceTable >> appendAtCursor: aCollectionOrElement [

	| elementSize cumulated |
	aCollectionOrElement isCollection
		ifTrue: [
			addBuffer addAllLast: aCollectionOrElement.
			elementSize := aCollectionOrElement size ]
		ifFalse: [
			addBuffer addLast: aCollectionOrElement.
			elementSize := 1 ].

	cumulated := 0.
	pieceTable do: [ :piece |
		(cumulated := cumulated + piece length) >= (cursor - 1) ifTrue: [
			piece length: piece length + elementSize.
			cursor := cursor + 1.
			^ self ] ]
]

{ #category : #accessing }
PhePieceTable >> asArray [
	^Array streamContents: [ :stream | self writeOnStream: stream ].
]

{ #category : #accessing }
PhePieceTable >> asByteArray [
	^ByteArray streamContents: [ :stream | self writeOnStream: stream ].
]

{ #category : #accessing }
PhePieceTable >> asString [ 
	^String streamContents: [ :stream | self writeOnStream: stream ].
]

{ #category : #accessing }
PhePieceTable >> at: index [

	| cumulated |
	(index > self size or: index <= 0) ifTrue: [
		SubscriptOutOfBounds signalFor: index.
		^ self ].

	cumulated := 0.
	pieceTable do: [ :piece |
		cumulated + piece length >= index ifTrue: [
			^ piece isFromOriginalBuffer
				  ifTrue: [
				  originalBuffer at: index - cumulated + (piece position - 1) ]
				  ifFalse: [
				  addBuffer at: index - cumulated + (piece position - 1) ] ] ]
]

{ #category : #accessing }
PhePieceTable >> at: index delete: length [

	| intersectStart intersectEnd truePiece pieceEndIndex pieceStartIndex inserted timeTravelChain |
	(index + length - 1 > self size or: index <= 0) ifTrue: [
		SubscriptOutOfBounds signalFor: index.
		^ self ].

	pieceEndIndex := 0.
	inserted := false.
	timeTravelChain := PheTimeTravelChain new.
	pieceTable rechain: [ :piece |
		truePiece := piece value.
		pieceStartIndex := pieceEndIndex + 1.
		pieceEndIndex := pieceEndIndex + truePiece length.

		intersectStart := {
			                  pieceStartIndex.
			                  index } max.
		intersectEnd := {
			                pieceEndIndex.
			                (index + length - 1) } min.

		"Maintenant conditions sur l'intersection"
		intersectStart > intersectEnd
			ifTrue: [
				timeTravelChain linkBefore: piece.
				piece ]
			ifFalse: [
				timeTravelChain chain ifNotNil: [ timeTravelChain chain: piece ].
				self
					createIntersectPieceLink: piece
					from: 1 + intersectStart - pieceStartIndex
					to: 1 + intersectEnd - pieceStartIndex ] ]
]

{ #category : #accessing }
PhePieceTable >> at: index insert: aCollectionOrElement [

	| elementSize positionInAddBuffer cumulated inserted timeTravelChain |
	(index > (self size + 1) or: index <= 0) ifTrue: [
		SubscriptOutOfBounds signalFor: index.
		^ self ].

	(cursor isNil not and: index = cursor) ifTrue: [
		^ self appendAtCursor: aCollectionOrElement ].

	positionInAddBuffer := addBuffer size + 1.
	aCollectionOrElement isCollection
		ifTrue: [
			addBuffer addAllLast: aCollectionOrElement.
			elementSize := aCollectionOrElement size ]
		ifFalse: [
			addBuffer addLast: aCollectionOrElement.
			elementSize := 1 ].

	index = (self size + 1) ifTrue: [
		undoStack push: (PheTimeTravelChain new
				 linkBefore: pieceTable lastLink;
				 yourself).
		pieceTable addLast: (PhePiece
				 newFromAddBufferFrom: positionInAddBuffer
				 ofLength: elementSize).
		^ self ].

	cumulated := 0.
	inserted := false.
	timeTravelChain := PheTimeTravelChain new.
	pieceTable rechain: [ :piece |
		(inserted not and:
			 (cumulated := cumulated + piece value length) >= index)
			ifTrue: [
				cursor := index + elementSize.
				timeTravelChain chain: piece.
				inserted := true.
				self
					insertFromAddBufferAtOffset: positionInAddBuffer
					inPiece: piece
					at: index - (cumulated - piece value length)
					ofLength: elementSize ]
			ifFalse: [
				timeTravelChain linkBefore: piece.
				piece ] ].
		undoStack push: timeTravelChain.
]

{ #category : #private }
PhePieceTable >> createIntersectPieceLink: pieceLink from: startIndex to: endIndex [

	| truePiece firstPiece secondPiece |
	
	truePiece := pieceLink value.

	(startIndex = 1 and: endIndex = truePiece length) ifTrue: [ ^ nil ].

	firstPiece := truePiece copy
		              length:
			              truePiece length
			              - (truePiece length - startIndex + 1);
		              yourself.
	secondPiece := truePiece copy
		               length: truePiece length - endIndex;
		               position: truePiece position + endIndex;
		               yourself.

	endIndex = truePiece length ifTrue: [ ^ firstPiece asLink ].

	startIndex = 1 ifTrue: [ ^ secondPiece asLink ].

	^ firstPiece asLink
		  nextLink: secondPiece asLink;
		  yourself
]

{ #category : #accessing }
PhePieceTable >> cursor [

	^ cursor
]

{ #category : #initialization }
PhePieceTable >> initialize [
	originalBuffer := ByteArray new.
	addBuffer := OrderedCollection new.
	pieceTable := LinkedList new.
	undoStack := Stack new.
	redoStack := Stack new.
	
]

{ #category : #private }
PhePieceTable >> insertFromAddBufferAtOffset: positionInAddBuffer inPiece: pieceLink at: index ofLength: elementSize [

	| addPieceLink afterPieceLink beforePieceLink |

	addPieceLink := (PhePiece
		                 newFromAddBufferFrom: positionInAddBuffer
		                 ofLength: elementSize) asLink.
	afterPieceLink := pieceLink value copy asLink.

	addPieceLink nextLink: afterPieceLink.

	index = 1 ifTrue: [ ^ addPieceLink ].

	beforePieceLink := pieceLink value copy asLink.

	beforePieceLink value length: index - 1.

	afterPieceLink value
		length: afterPieceLink value length - (index - 1);
		position:
			afterPieceLink value position + beforePieceLink value length.

	beforePieceLink nextLink: addPieceLink.

	^ beforePieceLink
]

{ #category : #accessing }
PhePieceTable >> originalBuffer [

	^ originalBuffer
]

{ #category : #accessing }
PhePieceTable >> originalBuffer: anObject [

	originalBuffer := anObject
]

{ #category : #accessing }
PhePieceTable >> pieceTable [

	^ pieceTable
]

{ #category : #accessing }
PhePieceTable >> printString [

	^ 'a PhePieceTable( ' , (String streamContents: [ :stream |
		   pieceTable do: [ :piece |
			   piece position to: piece position + piece length - 1 do: [ :i |
				   stream << ((piece isFromAddBuffer
					     ifTrue: [ addBuffer ]
					     ifFalse: [ originalBuffer ]) at: i) printString.
				   stream << Character space ] ] ]) , ')'
]

{ #category : #accessing }
PhePieceTable >> redo [

	| redoTravelChain undoTravelChain updateLink|
	redoStack ifEmpty: [ ^ self ].

	redoTravelChain := redoStack pop.
	undoTravelChain := PheTimeTravelChain new.
	
	undoTravelChain linkBefore: redoTravelChain linkBefore.
	
	redoTravelChain linkBefore 
	ifNil: [
		undoTravelChain chain: pieceTable firstLink.
		pieceTable firstLink: redoTravelChain chain ]
	ifNotNil: [
		undoTravelChain chain: redoTravelChain linkBefore nextLink.
		redoTravelChain linkBefore nextLink: redoTravelChain chain ].
	
	updateLink := redoTravelChain chain.
	[ updateLink isNil or: [updateLink nextLink isNil] ] whileFalse: [ updateLink := updateLink nextLink ].
	pieceTable lastLink: updateLink.
	
	undoStack push: undoTravelChain 
]

{ #category : #accessing }
PhePieceTable >> size [

	^ pieceTable sum: [ :piece | piece length ]
]

{ #category : #accessing }
PhePieceTable >> undo [

	| redoTravelChain undoTravelChain updateLink|
	undoStack ifEmpty: [ ^ self ].

	undoTravelChain := undoStack pop.
	redoTravelChain := PheTimeTravelChain new.
	
	redoTravelChain linkBefore: undoTravelChain linkBefore.
	
	undoTravelChain linkBefore 
	ifNil: [
		redoTravelChain chain: pieceTable firstLink.
		pieceTable firstLink: undoTravelChain chain ]
	ifNotNil: [
		redoTravelChain chain: undoTravelChain linkBefore nextLink.
		undoTravelChain linkBefore nextLink: undoTravelChain chain ].
	
	updateLink := undoTravelChain chain.
	[ updateLink isNil or: [updateLink nextLink isNil] ] whileFalse: [ updateLink := updateLink nextLink ].
	pieceTable lastLink: updateLink.
	
	redoStack push: redoTravelChain 
]

{ #category : #accessing }
PhePieceTable >> writeOnStream: stream [

	pieceTable do: [ :piece |
		piece position to: piece position + piece length - 1 do: [ :i |
			stream << ((piece isFromAddBuffer
				  ifTrue: [ addBuffer ]
				  ifFalse: [ originalBuffer ]) at: i) ] ]
]
