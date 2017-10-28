Class {
	#name : #TypeL2MeterMorph,
	#superclass : #TypeLMeterMorph,
	#instVars : [
		'max2',
		'min2',
		'unit2',
		'value2'
	],
	#category : #TypeL-Morphs
}

{ #category : #utilities }
TypeL2MeterMorph class >> openHeartbeatInWorld [
	"TypeL2MeterMorph openHeartbeatInWorld"

	| morph |
	morph := self new.
	morph openInWorld.
	[ [ morph owner notNil ]
		whileTrue: [ morph value1: (Time millisecondClockValue / 1000.0 * Float pi) sin / 2.0 + 0.5.
			morph value2: (Time millisecondClockValue / 2000.0 * Float pi) sin - 0.5 * 1.5.
			(Delay forMilliseconds: 100) wait ] ] forkAt: Processor userBackgroundPriority
]

{ #category : #defaults }
TypeL2MeterMorph >> defaultUnit2 [
	^ TypeLMeterRadialUnit bottomRadialFor: self
]

{ #category : #drawing }
TypeL2MeterMorph >> drawMarksOn: aCanvas color: aColor [
	super drawMarksOn: aCanvas color: aColor.
	self unit2 drawMarksOn: aCanvas color: aColor
]

{ #category : #drawing }
TypeL2MeterMorph >> drawNeedlesOn: aCanvas [
	super drawNeedlesOn: aCanvas.
	self unit2 drawNeedleOn: aCanvas value: self normalizedValue2 color: Color brown
]

{ #category : #accessing }
TypeL2MeterMorph >> max2 [
	^ max2 ifNil: [ max2 := self defaultMax ]
]

{ #category : #accessing }
TypeL2MeterMorph >> max2: anObject [
	max2 := anObject
]

{ #category : #accessing }
TypeL2MeterMorph >> min2 [
	^ min2 ifNil: [ min2 := self defaultMin ]
]

{ #category : #accessing }
TypeL2MeterMorph >> min2: anObject [
	min2 := anObject
]

{ #category : #accessing }
TypeL2MeterMorph >> normalizedValue2 [
	^ self value2 - self min2 / (self max2 - self min2)
]

{ #category : #accessing }
TypeL2MeterMorph >> unit2 [
	^ unit2 ifNil: [ unit2 := self defaultUnit2 ]
]

{ #category : #accessing }
TypeL2MeterMorph >> unit2: aTypeLMeterUnit [
	unit2 := aTypeLMeterUnit
]

{ #category : #accessing }
TypeL2MeterMorph >> value2 [
	^ value2 ifNil: [ self defaultValue ]
]

{ #category : #accessing }
TypeL2MeterMorph >> value2: anObject [
	value2 := anObject
]
