Class {
	#name : #TypeLMeterAbstractUnit,
	#superclass : #Object,
	#instVars : [
		'morph'
	],
	#category : #TypeL-Morphs
}

{ #category : #'instance creation' }
TypeLMeterAbstractUnit class >> for: aTypeLMeterMorph [
	^ self new
		morph: aTypeLMeterMorph;
		yourself
]

{ #category : #accessing }
TypeLMeterAbstractUnit >> morph [
	^ morph
]

{ #category : #accessing }
TypeLMeterAbstractUnit >> morph: aTypeLMeterMorph [
	morph := aTypeLMeterMorph
]
