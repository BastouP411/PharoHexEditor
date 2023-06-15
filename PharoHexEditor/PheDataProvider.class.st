Class {
	#name : #PheDataProvider,
	#superclass : #Object,
	#instVars : [
		'lastExtractedData',
		'dataProvider'
	],
	#category : #PharoHexEditor
}

{ #category : #'as yet unclassified' }
PheDataProvider >> dataSize [
	^self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
PheDataProvider >> loadBytes [
	^self loadBytes: (self dataSize) fromOffset: 0
]

{ #category : #'as yet unclassified' }
PheDataProvider >> loadBytes: aQuantity fromOffset: anInteger [
	^self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
PheDataProvider >> saveBytes: aByteArray [
	self saveBytes: aByteArray atOffset: 0
]

{ #category : #'as yet unclassified' }
PheDataProvider >> saveBytes: aByteArray atOffset: anInteger [
	self subclassResponsibility 
]
