Class {
	#name : #TypeL3MeterMorph,
	#superclass : #TypeL2MeterMorph,
	#instVars : [
		'max3',
		'min3',
		'unit3',
		'value3'
	],
	#category : #TypeL-Morphs
}

{ #category : #utilities }
TypeL3MeterMorph class >> openCPUMemoryEventInWorld [
	"TypeL3MeterMorph openCPUMemoryEventInWorld"

	| morph |
	morph := self new.
	morph
		max2: 50000000;
		max3: 1000000.
	morph openInWorld.
	[ | lastLoad lastSpace |
	lastLoad := 0.0.
	lastSpace := Smalltalk primBytesLeft.
	[ morph owner notNil ]
		whileTrue: [ | tally newSpace |
			tally := (Processor tallyCPUUsageFor: 0.5 every: 10) value.
			newSpace := Smalltalk primBytesLeft.
			morph
				value1:
					(lastLoad := (1.0
						- ((tally occurrencesOf: Processor backgroundProcess) asFloat / tally size asFloat)
						+ lastLoad) / 2.0);
				value2: newSpace;
				value3: newSpace - lastSpace.
			lastSpace := newSpace ] ] forkAt: Processor userBackgroundPriority
]

{ #category : #utilities }
TypeL3MeterMorph class >> openHeartbeatInWorld [
	"TypeL3MeterMorph openHeartbeatInWorld"

	| morph |
	morph := self new.
	morph openInWorld.
	[ [ morph owner notNil ]
		whileTrue: [ morph value1: (Time millisecondClockValue / 1000.0 * Float pi) sin / 2.0 + 0.5.
			morph value2: ((Time millisecondClockValue / 2000.0 * Float pi) sin - 0.5) * 1.5.
			morph value3: ((Time millisecondClockValue / 3000.0 * Float pi) sin - 0.5) * 1.5.
			(Delay forMilliseconds: 100) wait ] ] forkAt: Processor userBackgroundPriority
]

{ #category : #utilities }
TypeL3MeterMorph class >> openMouseEventInWorld [
	"TypeL3MeterMorph openMouseEventInWorld"

	| morph |
	morph := self new.
	morph
		unit1: morph createBottomLeftRadialUnit;
		unit2: morph createBottomRightRadialUnit;
		unit3: morph createSmallBottomRadialUnit.
	morph openInWorld.
	[ | value3 |
	value3 := 0.0.
	[ morph owner notNil ]
		whileTrue: [ ActiveHand anyButtonPressed
				ifTrue: [ value3 := 1.0 ].
			morph
				value1: ActiveHand position x asFloat / World width asFloat;
				value2: ActiveHand position y asFloat / World height asFloat;
				value3: value3.
			value3 := value3 * 0.7.
			(Delay forMilliseconds: 100) wait ] ] forkAt: Processor userBackgroundPriority
]

{ #category : #defaults }
TypeL3MeterMorph >> defaultUnit3 [
	^ TypeLMeterRadialUnit rightRadialFor: self
]

{ #category : #drawing }
TypeL3MeterMorph >> drawMarksOn: aCanvas color: aColor [
	super drawMarksOn: aCanvas color: aColor.
	self unit3 drawMarksOn: aCanvas color: aColor
]

{ #category : #drawing }
TypeL3MeterMorph >> drawNeedlesOn: aCanvas [
	super drawNeedlesOn: aCanvas.
	self unit3 drawNeedleOn: aCanvas value: self normalizedValue3 color: Color black
]

{ #category : #accessing }
TypeL3MeterMorph >> max3 [
	^ max3 ifNil: [ max3 := self defaultMax ]
]

{ #category : #accessing }
TypeL3MeterMorph >> max3: anObject [
	max3 := anObject
]

{ #category : #accessing }
TypeL3MeterMorph >> min3 [
	^ min3 ifNil: [ min3 := self defaultMin ]
]

{ #category : #accessing }
TypeL3MeterMorph >> min3: anObject [
	min3 := anObject
]

{ #category : #accessing }
TypeL3MeterMorph >> normalizedValue3 [
	^ self value3 - self min3 / (self max3 - self min3)
]

{ #category : #accessing }
TypeL3MeterMorph >> unit3 [
	^ unit3 ifNil: [ unit3 := self defaultUnit3 ]
]

{ #category : #accessing }
TypeL3MeterMorph >> unit3: aTypeLMeterUnit [
	unit3 := aTypeLMeterUnit
]

{ #category : #accessing }
TypeL3MeterMorph >> value3 [
	^ value3 ifNil: [ self defaultValue ]
]

{ #category : #accessing }
TypeL3MeterMorph >> value3: aNumber [
	value3 := aNumber
]
