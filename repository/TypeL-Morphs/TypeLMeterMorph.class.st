Class {
	#name : #TypeLMeterMorph,
	#superclass : #Morph,
	#instVars : [
		'min1',
		'max1',
		'value1',
		'unit1',
		'depth',
		'lineColor',
		'sideColor',
		'bottomColor',
		'bezelWidth',
		'knurlingForm',
		'bezelForm',
		'stencilForm',
		'form'
	],
	#category : #TypeL-Morphs
}

{ #category : #utilities }
TypeLMeterMorph class >> openCPULoadInWorld [
	"TypeLMeterMorph openCPULoadInWorld"

	| morph |
	morph := self new.
	morph openInWorld.
	[ [ morph owner notNil ]
		whileTrue: [ | tally |
			tally := (Processor tallyCPUUsageFor: 0.5 every: 10) value.
			morph
				value1: 1.0 - ((tally occurrencesOf: Processor backgroundProcess) asFloat / tally size asFloat) ] ]
		forkAt: Processor userBackgroundPriority
]

{ #category : #utilities }
TypeLMeterMorph class >> openHeartbeatInWorld [
	"TypeLMeterMorph openHeartbeatInWorld"

	| morph |
	morph := self new.
	morph openInWorld.
	[ [ morph owner notNil ]
		whileTrue: [ morph value1: (Time millisecondClockValue / 500.0 * Float pi) sin.
			(Delay forMilliseconds: 100) wait ] ] forkAt: Processor userBackgroundPriority
]

{ #category : #accessing }
TypeLMeterMorph >> bezelWidth [
	^ bezelWidth ifNil: [ bezelWidth := self defaultBezelWidth ]
]

{ #category : #accessing }
TypeLMeterMorph >> bezelWidth: aNumber [
	bezelWidth := aNumber
]

{ #category : #accessing }
TypeLMeterMorph >> bottomColor [
	^ bottomColor ifNil: [ bottomColor := self defaultBottomColor ]
]

{ #category : #accessing }
TypeLMeterMorph >> bottomColor: anObject [
	bottomColor := anObject
]

{ #category : #utilities }
TypeLMeterMorph >> createBottomLeftRadialUnit [
	^ TypeLMeterRadialUnit bottomLeftRadialFor: self
]

{ #category : #utilities }
TypeLMeterMorph >> createBottomRadialUnit [
	^ TypeLMeterRadialUnit bottomRadialFor: self
]

{ #category : #utilities }
TypeLMeterMorph >> createBottomRightRadialUnit [
	^ TypeLMeterRadialUnit bottomRightRadialFor: self
]

{ #category : #utilities }
TypeLMeterMorph >> createCenterRadialUnit [
	^ TypeLMeterRadialUnit centerRadialFor: self
]

{ #category : #utilities }
TypeLMeterMorph >> createRightRadialUnit [
	^ TypeLMeterRadialUnit rightRadialFor: self
]

{ #category : #utilities }
TypeLMeterMorph >> createSmallBottomRadialUnit [
	^ TypeLMeterRadialUnit smallBottomRadialFor: self
]

{ #category : #utilities }
TypeLMeterMorph >> createSmallRightRadialUnit [
	^ TypeLMeterRadialUnit smallRightRadialFor: self
]

{ #category : #defaults }
TypeLMeterMorph >> defaultBezelWidth [
	^ 10
]

{ #category : #defaults }
TypeLMeterMorph >> defaultBottomColor [
	^ Color yellow mixed: 0.1 with: Color white
]

{ #category : #defaults }
TypeLMeterMorph >> defaultDepth [
	^ 10
]

{ #category : #defaults }
TypeLMeterMorph >> defaultExtent [
	^ self defaultWidth @ self defaultHeight
]

{ #category : #defaults }
TypeLMeterMorph >> defaultHeight [
	^ 70
]

{ #category : #defaults }
TypeLMeterMorph >> defaultLineColor [
	^ Color black
]

{ #category : #defaults }
TypeLMeterMorph >> defaultMax [
	^ 1.0
]

{ #category : #defaults }
TypeLMeterMorph >> defaultMin [
	^ 0.0
]

{ #category : #defaults }
TypeLMeterMorph >> defaultSideColor [
	^ Color lightGray mixed: 0.1 with: Smalltalk ui theme backgroundColor
]

{ #category : #defaults }
TypeLMeterMorph >> defaultUnit1 [
	^ TypeLMeterRadialUnit centerRadialFor: self
]

{ #category : #defaults }
TypeLMeterMorph >> defaultValue [
	^ 0.0
]

{ #category : #defaults }
TypeLMeterMorph >> defaultWidth [
	^ 100
]

{ #category : #accessing }
TypeLMeterMorph >> depth [
	^ depth ifNil: [ depth := self defaultDepth ]
]

{ #category : #accessing }
TypeLMeterMorph >> depth: anObject [
	depth := anObject
]

{ #category : #drawing }
TypeLMeterMorph >> drawBezelOn: aCanvas [
	bezelForm
		ifNil: [ | canvas cx rx1 rx2 rx3 cy ry1 ry2 ry3 |
			bezelForm := Form extent: self extent depth: 32.
			canvas := bezelForm getCanvas.
			canvas fillColor: Color transparent.
			cx := rx1 := self width / 2.0.
			rx2 := rx1 - (self bezelWidth * 0.5).
			rx3 := rx1 - self bezelWidth.
			cy := ry1 := self height / 2.0.
			ry2 := ry1 - (self bezelWidth * 0.5).
			ry3 := ry1 - self bezelWidth.
			0 to: 360 by: 10 do: [ :t | 
				| theta1 theta2 theta3 |
				theta1 := t degreesToRadians.
				theta2 := (t + 5) degreesToRadians.
				theta3 := (t + 10) degreesToRadians.
				canvas
					drawPolygon:
						{((theta1 cos * rx3 + cx) asInteger @ (theta1 sin * ry3 + cy) asInteger).
						((theta1 cos * rx2 + cx) asInteger @ (theta1 sin * ry2 + cy) asInteger).
						((theta2 cos * rx2 + cx) asInteger @ (theta2 sin * ry2 + cy) asInteger).
						((theta2 cos * rx3 + cx) asInteger @ (theta2 sin * ry3 + cy) asInteger)}
					fillStyle: Color darkGray.
				canvas
					drawPolygon:
						{((theta2 cos * rx1 + cx) asInteger @ (theta2 sin * ry1 + cy) asInteger).
						((theta2 cos * rx3 + cx) asInteger @ (theta2 sin * ry3 + cy) asInteger).
						((theta3 cos * rx3 + cx) asInteger @ (theta3 sin * ry3 + cy) asInteger).
						((theta3 cos * rx1 + cx) asInteger @ (theta3 sin * ry1 + cy) asInteger)}
					fillStyle: Color darkGray ] ].
	aCanvas paintImage: bezelForm at: 0 @ 0
]

{ #category : #drawing }
TypeLMeterMorph >> drawKnurlingOn: aCanvas [
	knurlingForm isNil
		ifTrue: [ | c |
			knurlingForm := Form extent: self extent depth: 32.
			c := knurlingForm getCanvas.
			c fillColor: Color gray.
			{0.
			3.
			(self depth - 6).
			(self depth - 3).
			self depth}
				with:
					{self sideColor.
					self sideColor.
					self sideColor.
					self sideColor.
					self bottomColor}
				do: [ :dy :fillColor | 
					c
						fillOval: (0 @ dy + self ovalOrigin extent: self ovalExtent)
						color: fillColor
						borderWidth: 1
						borderColor: self lineColor ].
			0.0 to: Float pi by: 20.0 / self ovalExtent x do: [ :theta | 
				| x y |
				x := (theta cos + 1) * (self ovalExtent x / 2.0) + self ovalOrigin x.
				y := (1.0 - theta sin) * 0.5 * self ovalExtent y + self ovalOrigin y.
				c
					frameRectangle: ((x - 1) @ (y + 5) extent: 6 @ (self depth - 10))
					color: self lineColor ].
			self drawMarksOn: c color: (self lineColor alpha: 0.5) ].
	aCanvas paintImage: knurlingForm at: 0 @ 0
]

{ #category : #drawing }
TypeLMeterMorph >> drawMarksOn: aCanvas color: aColor [
	self unit1 drawMarksOn: aCanvas color: aColor
]

{ #category : #drawing }
TypeLMeterMorph >> drawNeedlesOn: aCanvas [
	self unit1 drawNeedleOn: aCanvas value: self normalizedValue1 color: Color blue
]

{ #category : #drawing }
TypeLMeterMorph >> drawOn: aCanvas [
	| canvas |
	(form isNil or: [ form extent ~= self extent ])
		ifTrue: [ form := Form extent: self extent depth: 32.
			knurlingForm := nil.
			bezelForm := nil.
			stencilForm := nil ].
	canvas := form getCanvas.
	canvas fillColor: Color transparent.
	self drawKnurlingOn: canvas.
	self drawNeedlesOn: canvas.
	self drawStencilOn: canvas.
	self drawBezelOn: canvas.
	aCanvas paintImage: form at: self position
]

{ #category : #drawing }
TypeLMeterMorph >> drawStencilOn: aCanvas [
	stencilForm
		ifNil: [ stencilForm := Form extent: self extent depth: 1.
			stencilForm getCanvas
				fillColor: Color black;
				fillOval: (self ovalOrigin extent: self ovalExtent) color: Color white ].
	aCanvas stencil: stencilForm at: 0 @ 0 color: Color red.
	aCanvas frameOval: (self ovalOrigin extent: self ovalExtent) color: lineColor.
	aCanvas form mapColor: Color red to: Color transparent
]

{ #category : #initialization }
TypeLMeterMorph >> initialize [
	super initialize.
	self extent: self defaultExtent
]

{ #category : #accessing }
TypeLMeterMorph >> lineColor [
	^ lineColor ifNil: [ lineColor := self defaultLineColor ]
]

{ #category : #accessing }
TypeLMeterMorph >> lineColor: anObject [
	lineColor := anObject
]

{ #category : #accessing }
TypeLMeterMorph >> max1 [
	^ max1 ifNil: [ max1 := self defaultMax ]
]

{ #category : #accessing }
TypeLMeterMorph >> max1: anObject [
	max1 := anObject
]

{ #category : #accessing }
TypeLMeterMorph >> min1 [
	^ min1 ifNil: [ min1 := self defaultMin ]
]

{ #category : #accessing }
TypeLMeterMorph >> min1: anObject [
	min1 := anObject
]

{ #category : #accessing }
TypeLMeterMorph >> normalizedValue1 [
	^ self value1 - self min1 / (self max1 - self min1)
]

{ #category : #accessing }
TypeLMeterMorph >> ovalExtent [
	^ self extent - (self bezelWidth * 2)
]

{ #category : #accessing }
TypeLMeterMorph >> ovalOrigin [
	^ self bezelWidth @ self bezelWidth
]

{ #category : #accessing }
TypeLMeterMorph >> sideColor [
	^ sideColor ifNil: [ sideColor := self defaultSideColor ]
]

{ #category : #accessing }
TypeLMeterMorph >> sideColor: anObject [
	sideColor := anObject
]

{ #category : #private }
TypeLMeterMorph >> thetaAt: aNormalizedValue [
	^ Float pi - (((aNormalizedValue min: 1.0 max: 0.0) * 170 + 5) / 180.0 * Float pi)
]

{ #category : #accessing }
TypeLMeterMorph >> unit1 [
	^ unit1 ifNil: [ unit1 := self defaultUnit1 ]
]

{ #category : #accessing }
TypeLMeterMorph >> unit1: aTypeLMeterUnit [
	unit1 := aTypeLMeterUnit
]

{ #category : #accessing }
TypeLMeterMorph >> value1 [
	^ value1 ifNil: [ self defaultValue ]
]

{ #category : #accessing }
TypeLMeterMorph >> value1: anObject [
	value1 := anObject.
	self changed
]

{ #category : #private }
TypeLMeterMorph >> xAt: aNormalizedNumber scale: aNumber [
	^ (self thetaAt: aNormalizedNumber) cos * self width / 2.0 * aNumber + (self width / 2.0)
]

{ #category : #private }
TypeLMeterMorph >> yAt: aNormalizedNumber scale: aNumber [
	^ (self thetaAt: aNormalizedNumber) sin negated * self height / 2.0 * aNumber + (self height / 2.0) + depth
]
