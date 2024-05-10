Class {
	#name : 'BaselineOfTypeL',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfTypeL',
	#package : 'BaselineOfTypeL'
}

{ #category : 'baselines' }
BaselineOfTypeL >> baseline: spec [

	<baseline>
	spec for: #common do: [
		spec package: 'TypeL-Morphs'.
		spec
			group: 'Core' with: #( 'TypeL-Morphs' );
			group: 'default' with: #( 'Core' ) ]
]
