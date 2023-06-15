Class {
	#name : #BaselineOfPharoHexEditor,
	#superclass : #BaselineOf,
	#category : #BaselineOfPharoHexEditor
}

{ #category : #baselines }
BaselineOfPharoHexEditor >> baseline: spec [

	<baseline>
	spec for: #common do: [
		spec
			package: 'PharoHexEditor';
			package: 'PharoHexEditor-Tests'
			with: [ spec requires: 'PharoHexEditor' ].

		spec
			group: 'default' with: #( 'core' 'tests' );
			group: 'core' with: #( 'PharoHexEditor' );
			group: 'tests' with: #( 'PharoHexEditor-Tests' ) ]
]
