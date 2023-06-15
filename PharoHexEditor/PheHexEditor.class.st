Class {
	#name : #PheHexEditor,
	#superclass : #Object,
	#instVars : [
		'lastExtractedData',
		'dataProvider'
	],
	#category : #PharoHexEditor
}

{ #category : #'instance creation' }
PheHexEditor class >> newWithProvider: aProvider [
	|editor|
	editor := PheHexEditor new.
	editor dataProvider: aProvider.
	editor lastExtractedData: aProvider load.
	^ editor 
	
]

{ #category : #accessing }
PheHexEditor >> dataProvider [

	^ dataProvider
]

{ #category : #accessing }
PheHexEditor >> dataProvider: anObject [

	dataProvider := anObject
]

{ #category : #accessing }
PheHexEditor >> lastExtractedData [

	^ lastExtractedData
]

{ #category : #accessing }
PheHexEditor >> lastExtractedData: anObject [

	lastExtractedData := anObject
]
