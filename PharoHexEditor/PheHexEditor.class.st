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
PheHexEditor >> exportData [

	dataProvider saveBytes: lastExtractedData
]

{ #category : #accessing }
PheHexEditor >> exportDataAt: anOffset ofSize: anInteger [

	dataProvider
		saveBytes:
		(lastExtractedData copyFrom: anOffset + 1 to: anOffset + anInteger)
		atOffset: anOffset
]

{ #category : #accessing }
PheHexEditor >> lastExtractedData: anObject [

	lastExtractedData := anObject
]

{ #category : #accessing }
PheHexEditor >> reloadData [

	lastExtractedData := dataProvider load
]

{ #category : #accessing }
PheHexEditor >> reloadDataAt: anOffset ofSize: anInteger [

	| reloadedBytes |
	reloadedBytes := dataProvider
		                 loadBytesOfSize: anInteger
		                 fromOffset: anOffset.
	1 to: anInteger do: [ :i |
	lastExtractedData at: anOffset + i put: (reloadedBytes at: i) ]
]
