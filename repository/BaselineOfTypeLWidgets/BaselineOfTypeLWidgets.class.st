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
		spec package: 'TypeL-Morphs'.
		spec
			group: 'Core' with: #( 'TypeL-Morphs' );
			group: 'default' with: #( 'Core' ) ]
]
