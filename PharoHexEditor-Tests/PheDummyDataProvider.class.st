Class {
	#name : #PheDummyDataProvider,
	#superclass : #PheDataProvider,
	#classVars : [
		'testData'
	],
	#category : #'PharoHexEditor-Tests'
}

{ #category : #'instance creation' }
PheDummyDataProvider class >> newWithTestData: aByteArray [

	| provider |
	provider := PheDummyDataProvider new.
	provider testData: aByteArray.
	^ provider
]

{ #category : #'as yet unclassified' }
PheDummyDataProvider >> dataSize [

	^ testData size
]

{ #category : #'as yet unclassified' }
PheDummyDataProvider >> loadBytesOfSize: aQuantity fromOffset: anInteger [

	^ testData copyFrom: anInteger + 1 to: aQuantity + anInteger
]

{ #category : #'as yet unclassified' }
PheDummyDataProvider >> randomize [

	| random |
	random := Random new.
	1 to: testData size do: [ :i |
	testData at: i put: (random nextIntegerBetween: 0 and: 255) ]
]

{ #category : #'as yet unclassified' }
PheDummyDataProvider >> saveBytes: aByteArray atOffset: anInteger [

	1 to: aByteArray size do: [ :index |
	testData at: anInteger + index put: (aByteArray at: index) ]
]

{ #category : #'as yet unclassified' }
PheDummyDataProvider >> testData [

	^ testData
]

{ #category : #'as yet unclassified' }
PheDummyDataProvider >> testData: aByteArray [

	testData := aByteArray 
]
