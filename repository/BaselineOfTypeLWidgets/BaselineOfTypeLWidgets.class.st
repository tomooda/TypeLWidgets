Class {
	#name : 'BaselineOfTypeLWidgets',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfTypeLWidgets',
	#package : 'BaselineOfTypeLWidgets'
}

{ #category : 'baselines' }
BaselineOfTypeLWidgets >> baseline: spec [

	<baseline>
	spec for: #common do: [
		spec
			package: 'TypeL-Morphs'
			with: [ spec requires: #( 'TypeL-Presenters' ) ];
			package: 'TypeL-Presenters'.
		spec
			group: 'Core' with: #( 'TypeL-Morphs' 'TypeL-Presenters' );
			group: 'default' with: #( 'Core' ) ]
]
