Class {
	#name : #BugJarTarandi,
	#superclass : #TestCase,
	#instVars : [
		'morph',
		'circleMorph'
	],
	#category : #BugJarTarandi
}

{ #category : #running }
BugJarTarandi >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	super setUp.
	morph := Morph new.
	circleMorph := CircleMorph new.
]

{ #category : #running }
BugJarTarandi >> tearDown [
	morph delete.
	circleMorph delete.
	super tearDown
]

{ #category : #running }
BugJarTarandi >> testP7MouseOverRotationHandleShouldNotSignalMessageNotUnderstood [
	"Mousing hover the rotation handle of a morph should not raise '#degrees was sent to nil'"

	"This test is performed on @circleMorph and not just @morph because the morph used needs to want to generate a rotation halo (see method #wantsHaloHandleWithSelector:inHalo:). Instances of Morph do not want that, but instances of CircleMorph do."
	| mouseDownEventToCreateHalos handMorph halo pos mouseMoveEvent |
	handMorph := (WorldMorph cursorOwnerWorld instVarNamed: #worldState) hands first.
	mouseDownEventToCreateHalos := MouseButtonEvent new setType: #mouseDown position: circleMorph position buttons: 73 hand: handMorph.
	circleMorph openInWorld.
	halo := circleMorph addHalo: mouseDownEventToCreateHalos.
	"Specifically finding the rotation halo does not seem easy to do in a robust way (you could always search for the name of the icon or some other characteristic like that, but what if the icon is changed in the future?). So we'll send a mouse hover event to each submorph. "
	halo submorphs do: [ :subMorph |
		pos := subMorph position.
		mouseMoveEvent := MouseMoveEvent new setType: #mouseMove startPoint: pos endPoint: pos trail: nil buttons: 0 hand: handMorph stamp: 0.
		self flag: #improvement. "Is there a way to be more precise in the following assertion: to say that the block shouldn't raise a MessageNotUnderstood **for the #degrees selector**?"
		self shouldnt: [subMorph handleEvent: mouseMoveEvent] raise: MessageNotUnderstood.
	].
]

{ #category : #running }
BugJarTarandi >> testP8MouseOverRotationHandleShouldNotSignalMessageNotUnderstood [
	"Mousing hover the rotation handle of a morph should not raise '#degrees was sent to nil'"

	"This test is performed on @circleMorph and not just @morph because the morph used needs to want to generate a rotation halo (see method #wantsHaloHandleWithSelector:inHalo:). Instances of Morph do not want that, but instances of CircleMorph do."
	| mouseDownEventToCreateHalos handMorph halo pos mouseMoveEvent |
	handMorph := WorldMorph cursorOwnerWorld worldState hands first.
	mouseDownEventToCreateHalos := MouseButtonEvent new setType: #mouseDown position: circleMorph position buttons: 73 hand: handMorph.
	circleMorph openInWorld.
	halo := circleMorph addHalo: mouseDownEventToCreateHalos.
	"Specifically finding the rotation halo does not seem easy to do in a robust way (you could always search for the name of the icon or some other characteristic like that, but what if the icon is changed in the future?). So we'll send a mouse hover event to each submorph. "
	halo submorphs do: [ :subMorph |
		pos := subMorph position.
		mouseMoveEvent := MouseMoveEvent new setType: #mouseMove startPoint: pos endPoint: pos trail: nil buttons: 0 hand: handMorph stamp: 0.
		self flag: #improvement. "Is there a way to be more precise in the following assertion: to say that the block shouldn't raise a MessageNotUnderstood **for the #degrees selector**?"
		self shouldnt: [subMorph handleEvent: mouseMoveEvent] raise: MessageNotUnderstood.
	].
]
