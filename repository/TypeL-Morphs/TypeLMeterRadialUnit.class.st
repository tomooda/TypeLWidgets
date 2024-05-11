Class {
	#name : 'TypeLMeterRadialUnit',
	#superclass : 'TypeLMeterAbstractUnit',
	#instVars : [
		'minDegree',
		'maxDegree',
		'offset',
		'rNeedleTip',
		'rNeedleEnd',
		'needleColor',
		'needleThickness',
		'tickColor',
		'rTickBottom1',
		'rTickBottom2',
		'rTickTop1',
		'rTickTop2',
		'numTicks'
	],
	#category : 'TypeL-Morphs',
	#package : 'TypeL-Morphs'
}

{ #category : 'instance creation' }
TypeLMeterRadialUnit class >> bottomLeftRadialFor: aTypeLMeterMorph [
	^ (self for: aTypeLMeterMorph)
		minDegree: 110;
		maxDegree: 160;
		offset: -0.8 @ -0.8;
		rNeedleTip: 1.82;
		rNeedleEnd: 0.0;
		rTickTop1: 1.8;
		rTickTop2: 1.8;
		rTickBottom1: 1.76;
		rTickBottom2: 1.70;
		yourself
]

{ #category : 'instance creation' }
TypeLMeterRadialUnit class >> bottomRadialFor: aTypeLMeterMorph [

	^ (self for: aTypeLMeterMorph)
		  minDegree: 60;
		  maxDegree: 120;
		  offset: 0 @ -1.2;
		  rNeedleTip: 2.0;
		  rNeedleEnd: 0.0;
		  rTickTop1: 1.7;
		  rTickTop2: 1.9;
		  rTickBottom1: 1.6;
		  rTickBottom2: 1.6;
		  yourself
]

{ #category : 'instance creation' }
TypeLMeterRadialUnit class >> bottomRightRadialFor: aTypeLMeterMorph [
	^ (self for: aTypeLMeterMorph)
		minDegree: 20;
		maxDegree: 70;
		offset: 0.8 @ -0.8;
		rNeedleTip: 1.82;
		rNeedleEnd: 0.0;
		rTickTop1: 1.8;
		rTickTop2: 1.8;
		rTickBottom1: 1.76;
		rTickBottom2: 1.70;
		yourself
]

{ #category : 'instance creation' }
TypeLMeterRadialUnit class >> centerRadialFor: aTypeLMeterMorph [
	^ (self for: aTypeLMeterMorph)
		minDegree: 5;
		maxDegree: 175;
		offset: 0 @ 0;
		yourself
]

{ #category : 'instance creation' }
TypeLMeterRadialUnit class >> rightRadialFor: aTypeLMeterMorph [
	^ (self for: aTypeLMeterMorph)
		minDegree: -30;
		maxDegree: 30;
		offset: 1.2 @ 0;
		rNeedleTip: 1.5;
		rNeedleEnd: 0.0;
		rTickTop1: 1.4;
		rTickTop2: 1.4;
		rTickBottom1: 1.38;
		rTickBottom2: 1.35;
		yourself
]

{ #category : 'instance creation' }
TypeLMeterRadialUnit class >> smallBottomRadialFor: aTypeLMeterMorph [
	^ (self for: aTypeLMeterMorph)
		minDegree: 70;
		maxDegree: 110;
		numTicks: 10;
		offset: 0.0 @ -1.0;
		rNeedleTip: 0.8;
		rNeedleEnd: 0.0;
		rTickTop1: 0.65;
		rTickTop2: 0.7;
		rTickBottom1: 0.6;
		rTickBottom2: 0.6;
		yourself
]

{ #category : 'instance creation' }
TypeLMeterRadialUnit class >> smallRightRadialFor: aTypeLMeterMorph [
	^ (self for: aTypeLMeterMorph)
		minDegree: -10;
		maxDegree: 20;
		numTicks: 10;
		offset: 1.2 @ 0.0 ;
		rNeedleTip: 0.8;
		rNeedleEnd: 0.0;
		rTickTop1: 0.65;
		rTickTop2: 0.7;
		rTickBottom1: 0.6;
		rTickBottom2: 0.6;
		yourself
]

{ #category : 'defaults' }
TypeLMeterRadialUnit >> defaultMaxDegree [
	^ 175
]

{ #category : 'defaults' }
TypeLMeterRadialUnit >> defaultMaxValue [

	^ 1.0
]

{ #category : 'defaults' }
TypeLMeterRadialUnit >> defaultMinDegree [
	^ 5
]

{ #category : 'defaults' }
TypeLMeterRadialUnit >> defaultMinValue [

	^ 0.0
]

{ #category : 'defaults' }
TypeLMeterRadialUnit >> defaultNeedleColor [

	^ Color black
]

{ #category : 'defaults' }
TypeLMeterRadialUnit >> defaultNeedleThickness [

	^ 2.7
]

{ #category : 'defaults' }
TypeLMeterRadialUnit >> defaultNumTicks [
	^ 40
]

{ #category : 'defaults' }
TypeLMeterRadialUnit >> defaultOffset [
	^ 0 @ 0
]

{ #category : 'defaults' }
TypeLMeterRadialUnit >> defaultRNeedleEnd [
	^ -0.2
]

{ #category : 'defaults' }
TypeLMeterRadialUnit >> defaultRNeedleTip [
	^ 0.9
]

{ #category : 'defaults' }
TypeLMeterRadialUnit >> defaultRTickBottom1 [
	^ 0.88
]

{ #category : 'defaults' }
TypeLMeterRadialUnit >> defaultRTickBottom2 [
	^ 0.80
]

{ #category : 'defaults' }
TypeLMeterRadialUnit >> defaultRTickTop1 [
	^ 0.9
]

{ #category : 'defaults' }
TypeLMeterRadialUnit >> defaultRTickTop2 [
	^ 0.9
]

{ #category : 'defaults' }
TypeLMeterRadialUnit >> defaultScale [
	^ 0.9
]

{ #category : 'defaults' }
TypeLMeterRadialUnit >> defaultTickColor [

	^ Color darkGray
]

{ #category : 'drawing' }
TypeLMeterRadialUnit >> drawNeedleOn: aCanvas [

	aCanvas
		line: (self pointAt: self normalizedValue scale: self rNeedleTip)
		to: (self pointAt: self normalizedValue scale: self rNeedleEnd)
		width: self needleThickness
		color: self needleColor
]

{ #category : 'drawing' }
TypeLMeterRadialUnit >> drawTicksOn: aCanvas [

	0 to: self numTicks do: [ :t |
		aCanvas
			line: (self pointAt: t / self numTicks asFloat scale: (t \\ 10 = 0
						  ifTrue: [ self rTickTop2 ]
						  ifFalse: [ self rTickTop1 ]))
			to: (self pointAt: t / self numTicks asFloat scale: (t \\ 10 = 0
						  ifTrue: [ self rTickBottom2 ]
						  ifFalse: [ self rTickBottom1 ]))
			color: tickColor ]
]

{ #category : 'initialization' }
TypeLMeterRadialUnit >> initialize [

	super initialize.

	minDegree := self defaultMinDegree.
	maxDegree := self defaultMaxDegree.
	offset := self defaultOffset.
	rNeedleTip := self defaultRNeedleTip.
	rNeedleEnd := self defaultRNeedleEnd.
	needleColor := self defaultNeedleColor.
	needleThickness := self defaultNeedleThickness.
	tickColor := self defaultTickColor.
	rTickBottom1 := self defaultRTickBottom1.
	rTickBottom2 := self defaultRTickBottom2.
	rTickTop1 := self defaultRTickTop1.
	rTickTop2 := self defaultRTickTop2.
	numTicks := self defaultNumTicks
]

{ #category : 'accessing' }
TypeLMeterRadialUnit >> maxDegree [
	^ maxDegree ifNil: [ maxDegree := self defaultMaxDegree ]
]

{ #category : 'accessing' }
TypeLMeterRadialUnit >> maxDegree: aNumber [
	maxDegree := aNumber
]

{ #category : 'accessing' }
TypeLMeterRadialUnit >> minDegree [
	^ minDegree ifNil: [ minDegree := self defaultMinDegree ]
]

{ #category : 'accessing' }
TypeLMeterRadialUnit >> minDegree: aNumber [
	minDegree := aNumber
]

{ #category : 'accessing' }
TypeLMeterRadialUnit >> needleColor [

	^ needleColor
]

{ #category : 'accessing' }
TypeLMeterRadialUnit >> needleColor: aColor [

	needleColor := aColor
]

{ #category : 'accessing' }
TypeLMeterRadialUnit >> needleThickness [

	^ needleThickness
]

{ #category : 'accessing' }
TypeLMeterRadialUnit >> needleThickness: aNumber [

	needleThickness := aNumber
]

{ #category : 'accessing' }
TypeLMeterRadialUnit >> numTicks [
	^ numTicks ifNil: [ numTicks := self defaultNumTicks ]
]

{ #category : 'accessing' }
TypeLMeterRadialUnit >> numTicks: anInteger [
	numTicks := anInteger
]

{ #category : 'accessing' }
TypeLMeterRadialUnit >> offset [
	^ offset ifNil: [ offset := self defaultOffset ]
]

{ #category : 'accessing' }
TypeLMeterRadialUnit >> offset: aPoint [
	offset := aPoint
]

{ #category : 'accessing' }
TypeLMeterRadialUnit >> pointAt: aNormalizedNumber scale: aNumber [
	| theta width height |
	theta := self thetaAt: aNormalizedNumber.
	width := self meter ovalExtent x.
	height := self meter ovalExtent y.
	^ (theta cos * width / 2.0 * aNumber + ((1 + offset x) * width / 2.0))
		@
			(theta sin negated * height / 2.0 * aNumber + ((1 - offset y) * height / 2.0)
				+ self meter depth) + self meter ovalOrigin
]

{ #category : 'accessing' }
TypeLMeterRadialUnit >> rNeedleEnd [
	^ rNeedleEnd ifNil: [ rNeedleEnd := self defaultRNeedleEnd ]
]

{ #category : 'accessing' }
TypeLMeterRadialUnit >> rNeedleEnd: aNumber [
	^ rNeedleEnd := aNumber
]

{ #category : 'accessing' }
TypeLMeterRadialUnit >> rNeedleTip [
	^ rNeedleTip ifNil: [ rNeedleTip := self defaultRNeedleTip ]
]

{ #category : 'accessing' }
TypeLMeterRadialUnit >> rNeedleTip: aNumber [
	^ rNeedleTip := aNumber
]

{ #category : 'accessing' }
TypeLMeterRadialUnit >> rTickBottom1 [
	^ rTickBottom1 ifNil: [ rTickBottom1 := self defaultRTickBottom1 ]
]

{ #category : 'accessing' }
TypeLMeterRadialUnit >> rTickBottom1: aNumber [
	^ rTickBottom1 := aNumber
]

{ #category : 'accessing' }
TypeLMeterRadialUnit >> rTickBottom2 [
	^ rTickBottom2 ifNil: [ rTickBottom2 := self defaultRTickBottom2 ]
]

{ #category : 'accessing' }
TypeLMeterRadialUnit >> rTickBottom2: aNumber [
	^ rTickBottom2 := aNumber
]

{ #category : 'accessing' }
TypeLMeterRadialUnit >> rTickTop1 [
	^ rTickTop1 ifNil: [ rTickTop1 := self defaultRTickTop1 ]
]

{ #category : 'accessing' }
TypeLMeterRadialUnit >> rTickTop1: aNumber [
	^ rTickTop1 := aNumber
]

{ #category : 'accessing' }
TypeLMeterRadialUnit >> rTickTop2 [
	^ rTickTop2 ifNil: [ rTickTop2 := self defaultRTickTop2 ]
]

{ #category : 'accessing' }
TypeLMeterRadialUnit >> rTickTop2: aNumber [
	^ rTickTop2 := aNumber
]

{ #category : 'accessing' }
TypeLMeterRadialUnit >> thetaAt: aNormalizedValue [
	^ Float pi
		-
			(((aNormalizedValue min: 1.0 max: 0.0) * (self maxDegree - self minDegree) + self minDegree)
				/ 180.0 * Float pi)
]

{ #category : 'accessing' }
TypeLMeterRadialUnit >> tickColor [

	^ tickColor
]

{ #category : 'accessing' }
TypeLMeterRadialUnit >> tickColor: anObject [

	tickColor := anObject
]
