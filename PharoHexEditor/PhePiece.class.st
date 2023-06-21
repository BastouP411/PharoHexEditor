Class {
	#name : #PhePiece,
	#superclass : #Object,
	#instVars : [
		'isFromOriginalBuffer',
		'length',
		'position'
	],
	#category : #'PharoHexEditor-PieceTable'
}

{ #category : #'instance creation' }
PhePiece class >> newFromAddBufferFrom: anIndex ofLength: aLength [

	^ PhePiece new
		  isFromOriginalBuffer: false;
		  length: aLength;
		  position: anIndex;
		  yourself
]

{ #category : #'instance creation' }
PhePiece class >> newFromOriginalBufferFrom: anIndex ofLength: aLength [

	^ PhePiece new
		  isFromOriginalBuffer: true;
		  length: aLength;
		  position: anIndex;
		  yourself
]

{ #category : #accessing }
PhePiece >> isFromAddBuffer [

	^ isFromOriginalBuffer not
]

{ #category : #accessing }
PhePiece >> isFromOriginalBuffer [

	^ isFromOriginalBuffer
]

{ #category : #accessing }
PhePiece >> isFromOriginalBuffer: anObject [

	isFromOriginalBuffer := anObject
]

{ #category : #accessing }
PhePiece >> length [

	^ length
]

{ #category : #accessing }
PhePiece >> length: anObject [

	length := anObject
]

{ #category : #accessing }
PhePiece >> position [

	^ position
]

{ #category : #accessing }
PhePiece >> position: anObject [

	position := anObject
]
