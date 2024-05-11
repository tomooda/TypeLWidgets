Class {
	#name : 'TypeLRadialMeterSettingsPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'meter',
		'bezelWidth',
		'bezelColor',
		'depth',
		'lineColor',
		'sideColor',
		'bottomColor',
		'widthSlider',
		'heightSlider'
	],
	#category : 'TypeL-Presenters',
	#package : 'TypeL-Presenters'
}

{ #category : 'layout' }
TypeLRadialMeterSettingsPresenter class >> defaultLayout [

	^ SpBoxLayout newVertical
		  add: (SpBoxLayout newHorizontal
				   add: 'bezel width' width: 100;
				   add: #bezelWidth)
		  expand: false;
		  add: (SpBoxLayout newHorizontal
				   add: 'bezel color' width: 100;
				   add: #bezelColor)
		  expand: false;
		  add: (SpBoxLayout newHorizontal
				   add: 'knurling depth' width: 100;
				   add: #depth)
		  expand: false;
		  add: (SpBoxLayout newHorizontal
				   add: 'ring color' width: 100;
				   add: #lineColor)
		  expand: false;
		  add: (SpBoxLayout newHorizontal
				   add: 'side color' width: 100;
				   add: #sideColor)
		  expand: false;
		  add: (SpBoxLayout newHorizontal
				   add: 'face color' width: 100;
				   add: #bottomColor)
		  expand: false;
		  add: (SpBoxLayout newHorizontal
				   add: 'width' width: 100;
				   add: #widthSlider)
		  expand: false;
		  add: (SpBoxLayout newHorizontal
				   add: 'height' width: 100;
				   add: #heightSlider)
		  expand: false;
		  yourself
]

{ #category : 'instance creation' }
TypeLRadialMeterSettingsPresenter class >> on: aTypeLMeterMorph [

	^ self new
		  meter: aTypeLMeterMorph;
		  yourself
]

{ #category : 'instance creation' }
TypeLRadialMeterSettingsPresenter class >> openOn: aTypeLMeterMorph [

	^ self new
		  meter: aTypeLMeterMorph;
		  openAtPointer
]

{ #category : 'operations' }
TypeLRadialMeterSettingsPresenter >> changeBezelColor [

	meter ifNotNil: [
		self newColorPicker
			setColor: meter bezelColor;
			whenColorChangedDo: [ :c |
				bezelColor color: c.
				meter
					bezelColor: c;
					changed ];
			open ]
]

{ #category : 'operations' }
TypeLRadialMeterSettingsPresenter >> changeBottomColor [

	meter ifNotNil: [
		self newColorPicker
			setColor: meter bottomColor;
			whenColorChangedDo: [ :c |
				bottomColor color: c.
				meter
					bottomColor: c;
					changed ];
			open ]
]

{ #category : 'operations' }
TypeLRadialMeterSettingsPresenter >> changeLineColor [

	meter ifNotNil: [
		self newColorPicker
			setColor: meter lineColor;
			whenColorChangedDo: [ :c |
				lineColor color: c.
				meter
					lineColor: c;
					changed ];
			open ]
]

{ #category : 'operations' }
TypeLRadialMeterSettingsPresenter >> changeSideColor [

	meter ifNotNil: [
		self newColorPicker
			setColor: meter sideColor;
			whenColorChangedDo: [ :c |
				sideColor color: c.
				meter
					sideColor: c;
					changed ];
			open ]
]

{ #category : 'initialization' }
TypeLRadialMeterSettingsPresenter >> initializePresenters [

	super initializePresenters.
	bezelWidth := self newSlider
		              min: 10;
		              max: 100;
		              quantum: 5;
		              value: 10;
		              whenValueChangedDo: [
			              meter ifNotNil: [
					              meter bezelWidth: bezelWidth value.
					              meter changed ] ].
	bezelColor := self newButton action: [ self changeBezelColor ].
	depth := self newSlider
		         min: 10;
		         max: 100;
		         quantum: 5;
		         value: 10;
		         whenValueChangedDo: [
			         meter ifNotNil: [
					         meter depth: depth value.
					         meter changed ] ].
	lineColor := self newButton action: [ self changeLineColor ].
	sideColor := self newButton action: [ self changeSideColor ].
	bottomColor := self newButton action: [ self changeBottomColor ].
	widthSlider := self newSlider
		               min: 100;
		               max: 800;
		               quantum: 100;
		               value: 165;
		               whenValueChangedDo: [
			               meter ifNotNil: [ meter width: widthSlider value ] ].
	heightSlider := self newSlider
		                min: 100;
		                max: 800;
		                quantum: 100;
		                value: 100;
		                whenValueChangedDo: [
			                meter ifNotNil: [ meter height: heightSlider value ] ]
]

{ #category : 'initialization' }
TypeLRadialMeterSettingsPresenter >> initializeWindow: aSpWindowPresenter [

	super initializeWindow: aSpWindowPresenter.
	aSpWindowPresenter initialExtent: 400 @ 250
]

{ #category : 'accessing' }
TypeLRadialMeterSettingsPresenter >> meter [

	^ meter
]

{ #category : 'accessing' }
TypeLRadialMeterSettingsPresenter >> meter: aTypeLRadialMeterMorph [
	meter := aTypeLRadialMeterMorph.
	self meterChanged
]

{ #category : 'accessing' }
TypeLRadialMeterSettingsPresenter >> meterChanged [

	bezelWidth value: meter bezelWidth.
	depth value: meter depth.
	lineColor color: meter lineColor.
	sideColor color: meter sideColor.
	bottomColor color: meter bottomColor.
	widthSlider value: meter width.
	heightSlider value: meter height
]

{ #category : 'operations' }
TypeLRadialMeterSettingsPresenter >> openAtPointer [

	| window |
	window := self asWindow.
	window initialPosition: (self currentWorld activeHand position min:
			 self currentWorld extent - window initialExtent).
	window open
]

{ #category : 'accessing' }
TypeLRadialMeterSettingsPresenter >> title [

	^ 'TypeL meter settings'
]
