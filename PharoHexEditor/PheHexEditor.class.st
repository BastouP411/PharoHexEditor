Class {
	#name : #PheHexEditor,
	#superclass : #Object,
	#instVars : [
		'lastExtractedData'
	],
	#classVars : [
		'DataProviders'
	],
	#category : #'PharoHexEditor-Core'
}

{ #category : #'as yet unclassified' }
PheHexEditor class >> initialize [ 
	DataProviders := Set new.
	
]

{ #category : #'instance creation' }
PheHexEditor class >> newWithProvider: aProvider [
	|editor|
	editor := PheHexEditor new.
	editor dataProvider: aProvider.
	editor lastExtractedData: aProvider load.
	^ editor 
	
]

{ #category : #'as yet unclassified' }
PheHexEditor class >> registerDataProvider: aClass [
	DataProviders add: aClass
	
]
