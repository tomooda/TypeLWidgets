Class {
	#name : 'TypeLMeterRadialUnit',
	#superclass : 'TypeLMeterAbstractUnit',
	#instVars : [
		'minDegree',
		'maxDegree',
		'offset',
		'rNeedleTip',
		'rNeedleEnd',
		'rMarkTop1',
		'rMarkTop2',
		'rMarkBottom1',
		'rMarkBottom2',
		'numMarks'
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
		rMarkTop1: 1.8;
		rMarkTop2: 1.8;
		rMarkBottom1: 1.76;
		rMarkBottom2: 1.70;
		yourself
]

{ #category : 'instance creation' }
TypeLMeterRadialUnit class >> bottomRadialFor: aTypeLMeterMorph [
	^ (self for: aTypeLMeterMorph)
		minDegree: 60;
		maxDegree: 120;
		offset: 0 @ -1.2;
		rNeedleTip: 1.5;
		rNeedleEnd: 0.0;
		rMarkTop1: 1.4;
		rMarkTop2: 1.4;
		rMarkBottom1: 1.38;
		rMarkBottom2: 1.35;
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
		rMarkTop1: 1.8;
		rMarkTop2: 1.8;
		rMarkBottom1: 1.76;
		rMarkBottom2: 1.70;
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
		rMarkTop1: 1.4;
		rMarkTop2: 1.4;
		rMarkBottom1: 1.38;
		rMarkBottom2: 1.35;
		yourself
]

{ #category : 'instance creation' }
TypeLMeterRadialUnit class >> smallBottomRadialFor: aTypeLMeterMorph [
	^ (self for: aTypeLMeterMorph)
		minDegree: 70;
		maxDegree: 110;
		numMarks: 10;
		offset: 0.0 @ -1.0;
		rNeedleTip: 0.8;
		rNeedleEnd: 0.0;
		rMarkTop1: 0.65;
		rMarkTop2: 0.7;
		rMarkBottom1: 0.6;
		rMarkBottom2: 0.6;
		yourself
]

{ #category : 'instance creation' }
TypeLMeterRadialUnit class >> smallRightRadialFor: aTypeLMeterMorph [
	^ (self for: aTypeLMeterMorph)
		minDegree: -10;
		maxDegree: 20;
		numMarks: 10;
		offset: 1.2 @ 0.0 ;
		rNeedleTip: 0.8;
		rNeedleEnd: 0.0;
		rMarkTop1: 0.65;
		rMarkTop2: 0.7;
		rMarkBottom1: 0.6;
		rMarkBottom2: 0.6;
		yourself
]

{ #category : 'defaults' }
TypeLMeterRadialUnit >> defaultMaxDegree [
	^ 175
]

{ #category : 'defaults' }
TypeLMeterRadialUnit >> defaultMinDegree [
	^ 5
]

{ #category : 'defaults' }
TypeLMeterRadialUnit >> defaultNumMarks [
	^ 100
]

{ #category : 'defaults' }
TypeLMeterRadialUnit >> defaultOffset [
	^ 0 @ 0
]

{ #category : 'defaults' }
TypeLMeterRadialUnit >> defaultRMarkBottom1 [
	^ 0.88
]

{ #category : 'defaults' }
TypeLMeterRadialUnit >> defaultRMarkBottom2 [
	^ 0.80
]

{ #category : 'defaults' }
TypeLMeterRadialUnit >> defaultRMarkTop1 [
	^ 0.9
]

{ #category : 'defaults' }
TypeLMeterRadialUnit >> defaultRMarkTop2 [
	^ 0.9
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
TypeLMeterRadialUnit >> defaultScale [
	^ 0.9
]

{ #category : 'drawing' }
TypeLMeterRadialUnit >> drawMarksOn: aCanvas color: aColor [
	0 to: self numMarks do: [ :t | 
		aCanvas
			line:
				(self
					pointAt: t / self numMarks asFloat
					scale:
						(t \\ 10 = 0
							ifTrue: [ self rMarkTop2 ]
							ifFalse: [ self rMarkTop1 ]))
			to:
				(self
					pointAt: t / self numMarks asFloat
					scale:
						(t \\ 10 = 0
							ifTrue: [ self rMarkBottom2 ]
							ifFalse: [ self rMarkBottom1 ]))
			color: aColor ]
]

{ #category : 'drawing' }
TypeLMeterRadialUnit >> drawNeedleOn: aCanvas value: aNumber color: aColor [
	aCanvas
		line: (self pointAt: aNumber scale: self rNeedleTip)
		to: (self pointAt: aNumber scale: self rNeedleEnd)
		width: 1.7
		color: aColor
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
TypeLMeterRadialUnit >> numMarks [
	^ numMarks ifNil: [ numMarks := self defaultNumMarks ]
]

{ #category : 'accessing' }
TypeLMeterRadialUnit >> numMarks: anInteger [
	numMarks := anInteger
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
	width := self morph ovalExtent x.
	height := self morph ovalExtent y.
	^ (theta cos * width / 2.0 * aNumber + ((1 + offset x) * width / 2.0))
		@
			(theta sin negated * height / 2.0 * aNumber + ((1 - offset y) * height / 2.0)
				+ self morph depth) + self morph ovalOrigin
]

{ #category : 'accessing' }
TypeLMeterRadialUnit >> rMarkBottom1 [
	^ rMarkBottom1 ifNil: [ rMarkBottom1 := self defaultRMarkBottom1 ]
]

{ #category : 'accessing' }
TypeLMeterRadialUnit >> rMarkBottom1: aNumber [
	^ rMarkBottom1 := aNumber
]

{ #category : 'accessing' }
TypeLMeterRadialUnit >> rMarkBottom2 [
	^ rMarkBottom2 ifNil: [ rMarkBottom2 := self defaultRMarkBottom2 ]
]

{ #category : 'accessing' }
TypeLMeterRadialUnit >> rMarkBottom2: aNumber [
	^ rMarkBottom2 := aNumber
]

{ #category : 'accessing' }
TypeLMeterRadialUnit >> rMarkTop1 [
	^ rMarkTop1 ifNil: [ rMarkTop1 := self defaultRMarkTop1 ]
]

{ #category : 'accessing' }
TypeLMeterRadialUnit >> rMarkTop1: aNumber [
	^ rMarkTop1 := aNumber
]

{ #category : 'accessing' }
TypeLMeterRadialUnit >> rMarkTop2 [
	^ rMarkTop2 ifNil: [ rMarkTop2 := self defaultRMarkTop2 ]
]

{ #category : 'accessing' }
TypeLMeterRadialUnit >> rMarkTop2: aNumber [
	^ rMarkTop2 := aNumber
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
TypeLMeterRadialUnit >> thetaAt: aNormalizedValue [
	^ Float pi
		-
			(((aNormalizedValue min: 1.0 max: 0.0) * (self maxDegree - self minDegree) + self minDegree)
				/ 180.0 * Float pi)
]
