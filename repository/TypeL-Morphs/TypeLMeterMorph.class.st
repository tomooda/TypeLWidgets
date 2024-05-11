Class {
	#name : 'TypeLMeterMorph',
	#superclass : 'Morph',
	#instVars : [
		'form',
		'units'
	],
	#category : 'TypeL-Morphs',
	#package : 'TypeL-Morphs'
}

{ #category : 'defaults' }
TypeLMeterMorph >> defaultExtent [
	^ self defaultWidth @ self defaultHeight
]

{ #category : 'defaults' }
TypeLMeterMorph >> defaultHeight [
	^ 100
]

{ #category : 'defaults' }
TypeLMeterMorph >> defaultWidth [

	^ 161
]

{ #category : 'drawing' }
TypeLMeterMorph >> drawBezelOn: aCanvas [

	^ self subclassResponsibility
]

{ #category : 'drawing' }
TypeLMeterMorph >> drawKnurlingOn: aCanvas [

	^ self subclassResponsibility
]

{ #category : 'drawing' }
TypeLMeterMorph >> drawNeedlesOn: aCanvas [

	self unitsDo: [ :unit | unit drawNeedleOn: aCanvas ]
]

{ #category : 'drawing' }
TypeLMeterMorph >> drawOn: aCanvas [

	| canvas |
	(form isNil or: [ form extent ~= self extent ]) ifTrue: [
		form := Form extent: self extent depth: 32.
		self flushCacheForms ].
	canvas := form getCanvas.
	canvas fillColor: Smalltalk ui theme desktopColor.
	self drawKnurlingOn: canvas.
	self drawNeedlesOn: canvas.
	self drawBezelOn: canvas.
	aCanvas paintImage: form at: self position
]

{ #category : 'drawing' }
TypeLMeterMorph >> drawTicksOn: aCanvas [

	self unitsDo: [ :unit | unit drawTicksOn: aCanvas ]
]

{ #category : 'drawing' }
TypeLMeterMorph >> flushCacheForms [

	
]

{ #category : 'event handling' }
TypeLMeterMorph >> handleMouseDown: anEvent [

	anEvent wasHandled ifTrue: [ ^ self ].
	anEvent yellowButtonPressed
		ifTrue: [
			anEvent wasHandled: true.
			self openSettings ]
		ifFalse: [ super handleMouseDown: anEvent ]
]

{ #category : 'event handling' }
TypeLMeterMorph >> handlesMouseDown: event [

	^ event yellowButtonPressed or: [ super handlesMouseDown: event ]
]

{ #category : 'initialization' }
TypeLMeterMorph >> initialize [

	super initialize.
	self extent: self defaultExtent.
	units := OrderedCollection new
]

{ #category : 'utilities' }
TypeLMeterMorph >> newBottomLeftRadialUnit [

	^ units add: (TypeLMeterRadialUnit bottomLeftRadialFor: self)
]

{ #category : 'utilities' }
TypeLMeterMorph >> newBottomRadialUnit [

	^ units add: (TypeLMeterRadialUnit bottomRadialFor: self)
]

{ #category : 'utilities' }
TypeLMeterMorph >> newBottomRightRadialUnit [

	^ units add: (TypeLMeterRadialUnit bottomRightRadialFor: self)
]

{ #category : 'utilities' }
TypeLMeterMorph >> newCenterRadialUnit [

	^ units add: (TypeLMeterRadialUnit centerRadialFor: self)
]

{ #category : 'utilities' }
TypeLMeterMorph >> newRightRadialUnit [

	^ units add: (TypeLMeterRadialUnit rightRadialFor: self)
]

{ #category : 'utilities' }
TypeLMeterMorph >> newSmallBottomRadialUnit [

	^ units add: (TypeLMeterRadialUnit smallBottomRadialFor: self)
]

{ #category : 'utilities' }
TypeLMeterMorph >> newSmallRightRadialUnit [

	^ units add: (TypeLMeterRadialUnit smallRightRadialFor: self)
]

{ #category : 'user interface' }
TypeLMeterMorph >> openSettings [

	^ self subclassResponsibility
]

{ #category : 'enumerating' }
TypeLMeterMorph >> unitsDo: aBlock [

	units do: aBlock
]
