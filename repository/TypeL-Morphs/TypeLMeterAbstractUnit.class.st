Class {
	#name : 'TypeLMeterAbstractUnit',
	#superclass : 'Object',
	#instVars : [
		'meter',
		'maxValue',
		'minValue',
		'value'
	],
	#category : 'TypeL-Morphs',
	#package : 'TypeL-Morphs'
}

{ #category : 'instance creation' }
TypeLMeterAbstractUnit class >> for: aTypeLMeterMorph [
	^ self new
		meter: aTypeLMeterMorph;
		yourself
]

{ #category : 'testing' }
TypeLMeterAbstractUnit class >> isAbstract [

	^ self = TypeLMeterAbstractUnit
]

{ #category : 'defaults' }
TypeLMeterAbstractUnit >> defaultMaxValue [

	^ 1.0
]

{ #category : 'defaults' }
TypeLMeterAbstractUnit >> defaultMinValue [

	^ 0.0
]

{ #category : 'defaults' }
TypeLMeterAbstractUnit >> defaultValue [

	^ 0.0
]

{ #category : 'initialization' }
TypeLMeterAbstractUnit >> initialize [

	super initialize.
	maxValue := self defaultMaxValue.
	minValue := self defaultMinValue.
	value := self defaultValue
]

{ #category : 'accessing' }
TypeLMeterAbstractUnit >> maxValue [

	^ maxValue
]

{ #category : 'accessing' }
TypeLMeterAbstractUnit >> maxValue: aNumber [

	maxValue := aNumber
]

{ #category : 'accessing' }
TypeLMeterAbstractUnit >> meter [
	^ meter
]

{ #category : 'accessing' }
TypeLMeterAbstractUnit >> meter: aTypeLMeterMorph [
	meter := aTypeLMeterMorph
]

{ #category : 'accessing' }
TypeLMeterAbstractUnit >> minValue [

	^ minValue
]

{ #category : 'accessing' }
TypeLMeterAbstractUnit >> minValue: aNumber [

	minValue := aNumber
]

{ #category : 'accessing' }
TypeLMeterAbstractUnit >> normalizedValue [

	^ self value - self minValue / (self maxValue - self minValue)
		  min: 1.0
		  max: 0.0
]

{ #category : 'accessing' }
TypeLMeterAbstractUnit >> value [

	^ value
]

{ #category : 'accessing' }
TypeLMeterAbstractUnit >> value: aNumber [

	value := aNumber
]
