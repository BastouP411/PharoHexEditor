Class {
	#name : #PheTimeTravelChain,
	#superclass : #Object,
	#instVars : [
		'linkBefore',
		'chain'
	],
	#category : #'PharoHexEditor-PieceTable'
}

{ #category : #accessing }
PheTimeTravelChain >> chain [

	^ chain
]

{ #category : #accessing }
PheTimeTravelChain >> chain: anObject [

	chain := anObject
]

{ #category : #accessing }
PheTimeTravelChain >> linkBefore [

	^ linkBefore
]

{ #category : #accessing }
PheTimeTravelChain >> linkBefore: anObject [

	linkBefore := anObject
]
