Class {
	#name : #PheDataProvider,
	#superclass : #Object,
	#category : #'PharoHexEditor-Core'
}

{ #category : #'class initialization' }
PheDataProvider class >> initialize [ 
	
]

{ #category : #testing }
PheDataProvider >> hasChanged [ 
	^false
]

{ #category : #testing }
PheDataProvider >> isWritable [ 
	^true
]

{ #category : #testing }
PheDataProvider >> loadContents: aBlock [
	self subclassResponsibility 
]

{ #category : #testing }
PheDataProvider >> saveContents: aBlock [
	self subclassResponsibility 
]
