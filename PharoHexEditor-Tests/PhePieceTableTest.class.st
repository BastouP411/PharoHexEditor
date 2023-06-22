Class {
	#name : #PhePieceTableTest,
	#superclass : #TestCase,
	#instVars : [
		'pieceTable'
	],
	#category : #'PharoHexEditor-Tests'
}

{ #category : #running }
PhePieceTableTest >> setUp [
	super setUp.

	pieceTable := PhePieceTable newFromArray: #[1 2 3 4 5 6 7 8 9 10].
]

{ #category : #running }
PhePieceTableTest >> testBaseArray [
	
	self assert: pieceTable asArray equals: #(1 2 3 4 5 6 7 8 9 10)
]

{ #category : #running }
PhePieceTableTest >> testInsertEnd [
	
	pieceTable at: 11 insert: #[11 12 13].
	
	self assert: pieceTable asArray equals: #(1 2 3 4 5 6 7 8 9 10 11 12 13)
]

{ #category : #running }
PhePieceTableTest >> testInsertMiddle [
	
	pieceTable at: 5 insert: #[ 11 12 13 ].
	
	self assert: pieceTable asArray equals: #(1 2 3 4 11 12 13 5 6 7 8 9 10)
]

{ #category : #running }
PhePieceTableTest >> testInsertMiddleThenDelete [
	
	pieceTable at: 5 insert: #[ 11 12 13 ].
	
	pieceTable at: 4 delete: 3.
	
	self assert: pieceTable asArray equals: #(1 2 3 13 5 6 7 8 9 10)
]

{ #category : #running }
PhePieceTableTest >> testInsertMiddleTwice [
	
	pieceTable at: 5 insert: #[ 11 12 13 ].
	
	pieceTable at: 7 insert: #[ 14 15 16 ].
	
	self assert: pieceTable asArray equals: #(1 2 3 4 11 12 14 15 16 13 5 6 7 8 9 10)
]

{ #category : #running }
PhePieceTableTest >> testInsertStart [
	
	pieceTable at: 1 insert: #[ 11 12 13 ].
	
	self assert: pieceTable asArray equals: #(11 12 13 1 2 3 4 5 6 7 8 9 10)
]

{ #category : #running }
PhePieceTableTest >> testRedoDelete [
	
	pieceTable at: 5 insert: #[ 11 12 13 ].
	
	pieceTable at: 4 delete: 3.
	
	pieceTable undo.
	
	pieceTable redo.
	
	self assert: pieceTable asArray equals: #(1 2 3 13 5 6 7 8 9 10)
]

{ #category : #running }
PhePieceTableTest >> testRedoInsert [
	
	pieceTable at: 5 insert: #[ 11 12 13 ].
	
	pieceTable at: 7 insert: #[ 14 15 16 ].
	
	pieceTable undo.
	
	pieceTable redo.
	
	self assert: pieceTable asArray equals: #(1 2 3 4 11 12 14 15 16 13 5 6 7 8 9 10)
]

{ #category : #running }
PhePieceTableTest >> testUndoDelete [
	
	pieceTable at: 5 insert: #[ 11 12 13 ].
	
	pieceTable at: 4 delete: 3.
	
	pieceTable undo.
	
	self assert: pieceTable asArray equals: #(1 2 3 4 11 12 13 5 6 7 8 9 10)
]

{ #category : #running }
PhePieceTableTest >> testUndoInsert [
	
	pieceTable at: 5 insert: #[ 11 12 13 ].
	
	pieceTable at: 7 insert: #[ 14 15 16 ].
	
	pieceTable undo.
	
	self assert: pieceTable asArray equals: #(1 2 3 4 11 12 13 5 6 7 8 9 10)
]
