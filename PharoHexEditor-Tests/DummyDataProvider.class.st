Class {
	#name : #DummyDataProvider,
	#superclass : #PheDataProvider,
	#classVars : [
		'testData'
	],
	#category : #'PharoHexEditor-Tests'
}

{ #category : #'instance creation' }
DummyDataProvider class >> newWithTestData: aByteArray [

	| provider |
	provider := DummyDataProvider new.
	provider testData: aByteArray.
	^ provider
]

{ #category : #'as yet unclassified' }
DummyDataProvider >> dataSize [

	^ testData size
]

{ #category : #'as yet unclassified' }
DummyDataProvider >> loadBytes: aQuantity fromOffset: anInteger [

	^ testData copyFrom: anInteger + 1 to: aQuantity + anInteger
]

{ #category : #'as yet unclassified' }
DummyDataProvider >> saveBytes: aByteArray atOffset: anInteger [

	1 to: aByteArray size do: [ :index |
	testData at: anInteger + index put: (aByteArray at: index) ]
]

{ #category : #'as yet unclassified' }
DummyDataProvider >> testData [

	^ testData
]

{ #category : #'as yet unclassified' }
DummyDataProvider >> testData: aByteArray [

	testData := aByteArray 
]
