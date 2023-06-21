Class {
	#name : #PheEditionMarker,
	#superclass : #Object,
	#instVars : [
		'editionList'
	],
	#category : #PharoHexEditor
}

{ #category : #initialization }
PheEditionMarker >> addEditedSection: anAssociation [

	editionList := self
		               addLink: (ValueLink value: anAssociation)
		               to: editionList
]

{ #category : #initialization }
PheEditionMarker >> addLink: newLink to: aLink [

	aLink ifNil: [ ^ newLink ] ifNotNil: [
		newLink value value < aLink value key ifTrue: [
			newLink nextLink: aLink.
			^ newLink ].
		^ self
			  fuseLink: aLink
			  to: (self addLink: newLink to: aLink nextLink) ]
]

{ #category : #'as yet unclassified' }
PheEditionMarker >> do: aBlock [ 
	|currentLink|
	currentLink := editionList.
		
	[currentLink] whileNotNil: [ 
		aBlock value: (currentLink value).
		currentLink := currentLink nextLink ]
]

{ #category : #initialization }
PheEditionMarker >> fuseLink: firstLink to: secondLink [

	| newLink links |
	secondLink value value < firstLink value key ifTrue: [
		secondLink next: firstLink.
		^ secondLink ].
	
	firstLink value value < secondLink value key ifTrue: [
		firstLink nextLink: secondLink.
		^ firstLink ].

	links := {
		         firstLink.
		         secondLink }.
	newLink := ValueLink value: (Association
		           key: (links collect: [ :link | link value key ]) min
		           value: (links collect: [ :link | link value value ]) max).
	newLink nextLink: secondLink nextLink.
	^newLink
]
