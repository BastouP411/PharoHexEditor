Class {
	#name : #PheHexEditorTest,
	#superclass : #TestCase,
	#classVars : [
		'dataProvider',
		'hexEditor'
	],
	#category : #'PharoHexEditor-Tests'
}

{ #category : #running }
PheHexEditorTest >> setUp [

	super setUp.

	dataProvider := PheDummyDataProvider newWithTestData:
		                (ByteArray new: 16).
	dataProvider randomize.

	hexEditor := PheHexEditor newWithProvider: dataProvider
]
