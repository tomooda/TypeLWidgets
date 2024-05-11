Class {
	#name : 'TypeLRadialMeterMorph',
	#superclass : 'TypeLMeterMorph',
	#instVars : [
		'depth',
		'lineColor',
		'sideColor',
		'bottomColor',
		'bezelWidth',
		'knurlingForm',
		'bezelForm',
		'stencilForm'
	],
	#category : 'TypeL-Morphs',
	#package : 'TypeL-Morphs'
}

{ #category : 'utilities' }
TypeLRadialMeterMorph class >> openCPULoadInWorld [

	<script: 'TypeLRadialMeterMorph openCPULoadInWorld'>
	| meter cpuUnit |
	meter := self new.
	cpuUnit := meter newCenterRadialUnit
		           needleColor: Color blue;
		           yourself.
	meter openInWorld.
	[
	[ meter owner notNil ] whileTrue: [
		| tally |
		tally := (Processor tallyCPUUsageFor: 0.5 every: 10) value.
		cpuUnit value:
			(tally select: [ :context | context method selector = #idleProcess ])
				size asFloat / tally size asFloat.
		meter changed ] ] forkAt: Processor userBackgroundPriority
]

{ #category : 'utilities' }
TypeLRadialMeterMorph class >> openCPUMemoryInWorld [

	<script: 'TypeLRadialMeterMorph openCPUMemoryInWorld'>
	| meter cpuUnit memoryUnit |
	meter := self new
		         bezelWidth: 20;
		         depth: 30;
		         yourself.
	cpuUnit := meter newCenterRadialUnit
		           needleColor: Color blue;
		           yourself.
	memoryUnit := meter newRightRadialUnit
		              needleColor: Color brown;
		              needleThickness: 3.2;
		              maxValue: 1000000000;
		              yourself.
	meter
		extent: 324 @ 200;
		position: self currentWorld width - 340 @ 30;
		openInWorld.
	[
	[ meter owner notNil ] whileTrue: [
		| cpu memory |
		cpu := (Processor tallyCPUUsageFor: 0.5 every: 10) value.
		memory := Smalltalk vm memorySize.
		cpuUnit value:
			(cpu select: [ :context | context method selector = #idleProcess ])
				size asFloat / cpu size asFloat.
		memoryUnit value: memory.
		meter changed.
		1 second wait ] ] forkAt: Processor userBackgroundPriority
]

{ #category : 'menus' }
TypeLRadialMeterMorph class >> worldMenu: aBuilder [

	<worldMenu>
	(aBuilder item: #LoadMeter)
		parent: #Tools;
		label: 'CPU&Memory meter';
		action: [ TypeLRadialMeterMorph openCPUMemoryInWorld ];
		order: 1001
]

{ #category : 'accessing' }
TypeLRadialMeterMorph >> bezelWidth [

	^ bezelWidth
]

{ #category : 'accessing' }
TypeLRadialMeterMorph >> bezelWidth: aNumber [

	bezelWidth := aNumber.
	self flushCacheForms
]

{ #category : 'accessing' }
TypeLRadialMeterMorph >> bottomColor [

	^ bottomColor
]

{ #category : 'accessing' }
TypeLRadialMeterMorph >> bottomColor: anObject [

	bottomColor := anObject.
	self flushCacheForms
]

{ #category : 'defaults' }
TypeLRadialMeterMorph >> defaultBezelWidth [
	^ 20
]

{ #category : 'defaults' }
TypeLRadialMeterMorph >> defaultBottomColor [
	^ Color yellow mixed: 0.1 with: Color white
]

{ #category : 'defaults' }
TypeLRadialMeterMorph >> defaultDepth [
	^ 20
]

{ #category : 'defaults' }
TypeLRadialMeterMorph >> defaultLineColor [

	^ Color black
]

{ #category : 'defaults' }
TypeLRadialMeterMorph >> defaultSideColor [
	^ Color lightGray mixed: 0.1 with: Smalltalk ui theme backgroundColor
]

{ #category : 'accessing' }
TypeLRadialMeterMorph >> depth [

	^ depth
]

{ #category : 'accessing' }
TypeLRadialMeterMorph >> depth: anObject [

	depth := anObject.
	self flushCacheForms
]

{ #category : 'drawing' }
TypeLRadialMeterMorph >> drawBezelOn: aCanvas [

	bezelForm ifNil: [
		| canvas cx rx1 rx2 rx3 cy ry1 ry2 ry3 |
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
				drawPolygon: {
						((theta1 cos * rx3 + cx) asInteger
						 @ (theta1 sin * ry3 + cy) asInteger).
						((theta1 cos * rx2 + cx) asInteger
						 @ (theta1 sin * ry2 + cy) asInteger).
						((theta2 cos * rx2 + cx) asInteger
						 @ (theta2 sin * ry2 + cy) asInteger).
						((theta2 cos * rx3 + cx) asInteger
						 @ (theta2 sin * ry3 + cy) asInteger) }
				fillStyle: Color darkGray.
			canvas
				drawPolygon: {
						((theta2 cos * rx1 + cx) asInteger
						 @ (theta2 sin * ry1 + cy) asInteger).
						((theta2 cos * rx3 + cx) asInteger
						 @ (theta2 sin * ry3 + cy) asInteger).
						((theta3 cos * rx3 + cx) asInteger
						 @ (theta3 sin * ry3 + cy) asInteger).
						((theta3 cos * rx1 + cx) asInteger
						 @ (theta3 sin * ry1 + cy) asInteger) }
				fillStyle: Color darkGray ] ].
	aCanvas paintImage: bezelForm at: 0 @ 0
]

{ #category : 'drawing' }
TypeLRadialMeterMorph >> drawKnurlingOn: aCanvas [

	knurlingForm isNil ifTrue: [
		| c |
		knurlingForm := Form extent: self extent depth: 32.
		c := knurlingForm getCanvas.
		c fillColor: Color gray.
		{
			0.
			3.
			(self depth - 6).
			(self depth - 3).
			self depth }
			with: {
					self sideColor.
					self sideColor.
					self sideColor.
					self sideColor.
					self bottomColor }
			do: [ :dy :fillColor |
				c
					fillOval: (0 @ dy + self ovalOrigin extent: self ovalExtent)
					color: fillColor
					borderWidth: 1
					borderColor: self lineColor ].
		0.0 to: Float pi by: 20.0 / self ovalExtent x do: [ :theta |
			| x y |
			x := theta cos + 1 * (self ovalExtent x / 2.0) + self ovalOrigin x.
			y := 1.0 - theta sin * 0.5 * self ovalExtent y + self ovalOrigin y.
			c
				frameRectangle: (x - 1 @ (y + 5) extent: 6 @ (self depth - 10))
				color: self lineColor ].
		self drawTicksOn: c ].
	aCanvas drawImage: knurlingForm at: 0 @ 0
]

{ #category : 'drawing' }
TypeLRadialMeterMorph >> drawOn: aCanvas [
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

{ #category : 'drawing' }
TypeLRadialMeterMorph >> drawStencilOn: aCanvas [
	stencilForm
		ifNil: [ stencilForm := Form extent: self extent depth: 1.
			stencilForm getCanvas
				fillColor: Color black;
				fillOval: (self ovalOrigin extent: self ovalExtent) color: Color white ].
	aCanvas stencil: stencilForm at: 0 @ 0 color: Color red.
	aCanvas frameOval: (self ovalOrigin extent: self ovalExtent) color: lineColor.
	aCanvas form mapColor: Color red to: Color transparent
]

{ #category : 'drawing' }
TypeLRadialMeterMorph >> flushCacheForms [

	knurlingForm := nil.
	bezelForm := nil.
	stencilForm := nil
]

{ #category : 'initialization' }
TypeLRadialMeterMorph >> initialize [

	super initialize.
	depth := self defaultDepth.
	lineColor := self defaultLineColor.
	sideColor := self defaultSideColor.
	bottomColor := self defaultBottomColor.
	bezelWidth := self defaultBezelWidth
]

{ #category : 'accessing' }
TypeLRadialMeterMorph >> lineColor [

	^ lineColor
]

{ #category : 'accessing' }
TypeLRadialMeterMorph >> lineColor: anObject [

	lineColor := anObject.
	self flushCacheForms
]

{ #category : 'user interface' }
TypeLRadialMeterMorph >> openSettings [

	TypeLRadialMeterSettingsPresenter openOn: self
]

{ #category : 'accessing' }
TypeLRadialMeterMorph >> ovalExtent [
	^ self extent - (self bezelWidth * 2)
]

{ #category : 'accessing' }
TypeLRadialMeterMorph >> ovalOrigin [
	^ self bezelWidth @ self bezelWidth
]

{ #category : 'accessing' }
TypeLRadialMeterMorph >> sideColor [

	^ sideColor
]

{ #category : 'accessing' }
TypeLRadialMeterMorph >> sideColor: anObject [

	sideColor := anObject.
	self flushCacheForms
]

{ #category : 'private' }
TypeLRadialMeterMorph >> thetaAt: aNormalizedValue [
	^ Float pi - (((aNormalizedValue min: 1.0 max: 0.0) * 170 + 5) / 180.0 * Float pi)
]
