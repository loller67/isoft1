!classDefinition: #ElevatorEmergency category: #'Elevator-Ejercicio'!
Error subclass: #ElevatorEmergency
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!


!classDefinition: #ElevatorTest category: #'Elevator-Ejercicio'!
TestCase subclass: #ElevatorTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorTest methodsFor: 'tests 3' stamp: 'HernanWilkinson 7/10/2011 17:38'!
test09RequestToGoUpAreEnqueueWhenRequestedWhenCabinIsMoving

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinDoorOpened.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinWaitingForPeople.
	self assert: elevatorController isCabinDoorOpened.! !

!ElevatorTest methodsFor: 'tests 3' stamp: 'HernanWilkinson 7/10/2011 17:39'!
test10CabinDoorStartClosingAfterWaitingForPeople

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinDoorOpened.
	elevatorController waitForPeopleTimedOut.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorClosing.! !

!ElevatorTest methodsFor: 'tests 3' stamp: 'HernanWilkinson 7/10/2011 17:39'!
test11StopsWaitingForPeopleIfCloseDoorIsPressed

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinDoorOpened.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinWaitingForPeople.
	self assert: elevatorController isCabinDoorOpened.

	elevatorController closeCabinDoor.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorClosing.
! !

!ElevatorTest methodsFor: 'tests 3' stamp: 'HernanWilkinson 7/10/2011 17:39'!
test12CloseDoorDoesNothingIfIdle

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController closeCabinDoor.

	self assert: elevatorController isIdle.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpened.! !

!ElevatorTest methodsFor: 'tests 3' stamp: 'HernanWilkinson 7/10/2011 17:40'!
test13CloseDoorDoesNothingWhenCabinIsMoving

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinMoving.
	self assert: elevatorController isCabinDoorClosed.

	elevatorController closeCabinDoor.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinMoving.
	self assert: elevatorController isCabinDoorClosed.! !

!ElevatorTest methodsFor: 'tests 3' stamp: 'HernanWilkinson 7/10/2011 17:40'!
test14CloseDoorDoesNothingWhenOpeningTheDoorToWaitForPeople

	| elevatorController |
	elevatorController := ElevatorController new.
		
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.
	
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.

	elevatorController closeCabinDoor.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.! !


!ElevatorTest methodsFor: 'tests 4' stamp: 'HernanWilkinson 7/10/2011 17:42'!
test15ElevatorHasToEnterEmergencyIfStoppedAndOtherFloorSensorTurnsOn

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.
	self 
		should: [ elevatorController cabinOnFloor:0 ]
		raise: ElevatorEmergency 
		withExceptionDo: [ :elevatorEmergency | self assert: elevatorEmergency messageText = 'Sensor de cabina desincronizado' ]! !

!ElevatorTest methodsFor: 'tests 4' stamp: 'HernanWilkinson 7/10/2011 17:47'!
test16ElevatorHasToEnterEmergencyIfFalling

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.
	self 
		should: [ elevatorController cabinOnFloor:0 ]
		raise: ElevatorEmergency 
		withExceptionDo: [ :elevatorEmergency | self assert: elevatorEmergency messageText = 'Sensor de cabina desincronizado'. ]! !

!ElevatorTest methodsFor: 'tests 4' stamp: 'HernanWilkinson 7/10/2011 17:47'!
test17ElevatorHasToEnterEmergencyIfJumpsFloors

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:3.
	elevatorController cabinDoorClosed.
	self 
		should: [ elevatorController cabinOnFloor: 3 ]
		raise: ElevatorEmergency 
		withExceptionDo: [ :elevatorEmergency | self assert: elevatorEmergency messageText = 'Sensor de cabina desincronizado'. ]! !

!ElevatorTest methodsFor: 'tests 4' stamp: 'HernanWilkinson 7/10/2011 17:48'!
test18ElevatorHasToEnterEmergencyIfDoorClosesAutomatically
	| elevatorController |
	elevatorController := ElevatorController new.
	
	self 
		should: [ elevatorController cabinDoorClosed.]
		raise: ElevatorEmergency 
		withExceptionDo: [ :elevatorEmergency | self assert: elevatorEmergency messageText = 'Sensor de puerta desincronizado' ]! !

!ElevatorTest methodsFor: 'tests 4' stamp: 'HernanWilkinson 7/10/2011 17:48'!
test19ElevatorHasToEnterEmergencyIfDoorClosedSensorTurnsOnWhenClosed

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	self 
		should: [elevatorController cabinDoorClosed.]
		raise: ElevatorEmergency 
		withExceptionDo: [ :elevatorEmergency | self assert: elevatorEmergency messageText = 'Sensor de puerta desincronizado'. ]! !

!ElevatorTest methodsFor: 'tests 4' stamp: 'HernanWilkinson 7/10/2011 17:49'!
test20ElevatorHasToEnterEmergencyIfDoorClosesWhenOpening
	| elevatorController |
	elevatorController := ElevatorController new.
		
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.
	self 
		should: [elevatorController cabinDoorClosed.]
		raise: ElevatorEmergency 
		withExceptionDo: [ :elevatorEmergency | self assert: elevatorEmergency messageText = 'Sensor de puerta desincronizado'.]! !


!ElevatorTest methodsFor: 'tests 2' stamp: 'HernanWilkinson 7/10/2011 17:35'!
test06DoorKeepsOpenedWhenOpeningIsRequested

	| elevatorController |
	elevatorController := ElevatorController new.
	
	self assert: elevatorController isCabinDoorOpened.
	
	elevatorController openCabinDoor.

	self assert: elevatorController isCabinDoorOpened.! !

!ElevatorTest methodsFor: 'tests 2' stamp: 'HernanWilkinson 6/16/2014 13:24'!
test07DoorMustBeOpenedWhenCabinIsStoppedAndClosingDoors

	| elevatorController |
	elevatorController := ElevatorController new.

	elevatorController goUpPushedFromFloor:1.
		
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorClosing.
		
	elevatorController openCabinDoor.
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.
! !

!ElevatorTest methodsFor: 'tests 2' stamp: 'HernanWilkinson 7/10/2011 17:36'!
test08CanNotOpenDoorWhenCabinIsMoving

	| elevatorController |
	elevatorController := ElevatorController new.

	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinMoving.
	self assert: elevatorController isCabinDoorClosed.

	elevatorController openCabinDoor.
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinMoving.
	self assert: elevatorController isCabinDoorClosed.! !

!ElevatorTest methodsFor: 'tests 2' stamp: 'HernanWilkinson 7/10/2011 17:51'!
test09DoorKeepsOpeneingWhenItIsOpeneing

	| elevatorController |
	elevatorController := ElevatorController new.

	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.

	elevatorController openCabinDoor.
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.! !


!ElevatorTest methodsFor: 'tests 5' stamp: 'HernanWilkinson 7/10/2011 17:50'!
test21CabinHasToStopOnTheFloorsOnItsWay
	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinOnFloor:1.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.! !

!ElevatorTest methodsFor: 'tests 5' stamp: 'HernanWilkinson 7/10/2011 17:50'!
test22ElevatorCompletesAllTheRequests
	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinOnFloor:1.
	elevatorController cabinDoorOpened.
	elevatorController waitForPeopleTimedOut.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:2.
	
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.! !

!ElevatorTest methodsFor: 'tests 5' stamp: 'HernanWilkinson 7/10/2011 17:50'!
test23CabinHasToStopOnFloorsOnItsWayNoMatterHowTheyWellCalled

	| elevatorController |
	elevatorController := ElevatorController new.
		
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinDoorClosed.
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinOnFloor:1.
		
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.! !

!ElevatorTest methodsFor: 'tests 5' stamp: 'HernanWilkinson 7/10/2011 17:51'!
test24CabinHasToStopAndWaitForPeopleOnFloorsOnItsWayNoMatterHowTheyWellCalled

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinDoorClosed.
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinOnFloor:1.
	elevatorController cabinDoorOpened.
	elevatorController waitForPeopleTimedOut.
	
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorClosing.! !


!ElevatorTest methodsFor: 'tests 1' stamp: 'HernanWilkinson 7/10/2011 17:33'!
test01ElevatorStartsIdleWithDoorOpenOnFloorZero

	| elevatorController |
		
	elevatorController := ElevatorController new.
		
	self assert: elevatorController isIdle.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpened.
	self assert: elevatorController cabinFloorNumber = 0
! !

!ElevatorTest methodsFor: 'tests 1' stamp: 'HernanWilkinson 7/15/2011 17:53'!
test02CabinDoorStartsClosingWhenElevatorGetsCalled

	| elevatorController |
	elevatorController := ElevatorController new.

	elevatorController goUpPushedFromFloor: 1.
	
	self deny: elevatorController isIdle.
	self assert: elevatorController isWorking.
	
	self assert: elevatorController isCabinStopped.
	self deny: elevatorController isCabinMoving.
	
	self deny: elevatorController isCabinDoorOpened.
	self deny: elevatorController isCabinDoorOpening.
	self assert: elevatorController isCabinDoorClosing.
	self deny: elevatorController isCabinDoorClosed.! !

!ElevatorTest methodsFor: 'tests 1' stamp: 'HernanWilkinson 7/15/2011 17:57'!
test03CabinStartsMovingWhenDoorGetsClosed

	| elevatorController |
	elevatorController := ElevatorController new.

	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	
	self deny: elevatorController isIdle.
	self assert: elevatorController isWorking.

	self deny: elevatorController isCabinStopped.
	self assert: elevatorController isCabinMoving.
	
	self deny: elevatorController isCabinDoorOpened.
	self deny: elevatorController isCabinDoorOpening.
	self deny: elevatorController isCabinDoorClosing.
	self assert: elevatorController isCabinDoorClosed.! !

!ElevatorTest methodsFor: 'tests 1' stamp: 'HernanWilkinson 7/15/2011 18:00'!
test04CabinStopsAndStartsOpeningDoorWhenGetsToDestination

	| elevatorController |
	elevatorController := ElevatorController new.

	elevatorController goUpPushedFromFloor: 1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor: 1.

	self deny: elevatorController isIdle.
	self assert: elevatorController isWorking.
	
	self assert: elevatorController isCabinStopped.
	self deny: elevatorController isCabinMoving.
			
	self deny: elevatorController isCabinDoorOpened.
	self assert: elevatorController isCabinDoorOpening.
	self deny: elevatorController isCabinDoorClosing.
	self deny: elevatorController isCabinDoorClosed.

	self assert: elevatorController cabinFloorNumber = 1
! !

!ElevatorTest methodsFor: 'tests 1' stamp: 'HernanWilkinson 7/15/2011 18:00'!
test05ElevatorGetsIdleWhenDoorGetOpened

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor: 1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor: 1.
	elevatorController cabinDoorOpened.
		
	self assert: elevatorController isIdle.
	self deny: elevatorController isWorking.
		
	self assert: elevatorController isCabinStopped.
	self deny: elevatorController isCabinMoving.

	self assert: elevatorController isCabinDoorOpened.
	self deny: elevatorController isCabinDoorOpening.
	self deny: elevatorController isCabinDoorClosing.
	self deny: elevatorController isCabinDoorClosed.
		
	self assert: elevatorController cabinFloorNumber = 1! !


!classDefinition: #ElevatorCabin category: #'Elevator-Ejercicio'!
Object subclass: #ElevatorCabin
	instanceVariableNames: 'isStopped isMoving'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorCabin methodsFor: 'as yet unclassified' stamp: 'Ji 10/2/2017 18:46:35'!
initialize
	isStopped _ true.
	isMoving _ false.! !

!ElevatorCabin methodsFor: 'as yet unclassified' stamp: 'Ji 10/2/2017 18:46:08'!
isMoving
	^ isMoving! !

!ElevatorCabin methodsFor: 'as yet unclassified' stamp: 'Ji 10/2/2017 18:45:52'!
isStopped
	^ isStopped! !

!ElevatorCabin methodsFor: 'as yet unclassified' stamp: 'Ji 10/2/2017 18:53:49'!
setAllFalse
	isMoving _ false.
	isStopped _ false.! !

!ElevatorCabin methodsFor: 'as yet unclassified' stamp: 'Ji 10/2/2017 18:53:35'!
startMoving
	self setAllFalse.
	isMoving _ true.! !

!ElevatorCabin methodsFor: 'as yet unclassified' stamp: 'Ji 10/2/2017 18:56:19'!
stop
	self setAllFalse .
	isStopped _ true.! !


!classDefinition: #ElevatorController category: #'Elevator-Ejercicio'!
Object subclass: #ElevatorController
	instanceVariableNames: 'elevatorIsIdle elevatorDoor elevatorCabin isIdle currentFloorNumber floorQueue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'Ji 10/2/2017 19:59:05'!
cabinDoorClosed
	elevatorDoor close.
	elevatorCabin startMoving.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'Ji 10/2/2017 20:36:16'!
cabinDoorOpened
	elevatorDoor open.
	
	(floorQueue isEmpty ) 
		ifTrue: [
			isIdle _ true.
			]
		ifFalse: [
			]
! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'Ji 10/2/2017 18:57:27'!
cabinFloorNumber
	^ currentFloorNumber ! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'Ji 10/2/2017 18:56:50'!
cabinOnFloor: aFloorNumber
	currentFloorNumber _ aFloorNumber .
	
	elevatorCabin stop.
	elevatorDoor startOpening.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'Ji 10/2/2017 20:41:46'!
goUpPushedFromFloor: aFloorNumber
	
	(floorQueue isEmpty and:[ isIdle ] ) 
		ifTrue: [
			elevatorIsIdle _ false.
			isIdle _ false.
			elevatorDoor startClosing. ] 
		ifFalse: [
			floorQueue add: aFloorNumber.].
	
	
	
	! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'Ji 10/2/2017 20:17:04'!
initialize
	elevatorDoor _ ElevatorDoor new.
	elevatorCabin _ ElevatorCabin new.
	isIdle _ true.
	currentFloorNumber _ 0.
	floorQueue _ OrderedCollection new.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'Ji 10/2/2017 18:37:27'!
isCabinDoorClosed
	^ elevatorDoor isClosed! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'Ji 10/2/2017 18:49:08'!
isCabinDoorClosing
	^elevatorDoor isClosing ! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'Ji 10/2/2017 19:32:14'!
isCabinDoorOpened
	^ elevatorDoor isOpen! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'Ji 10/2/2017 18:49:37'!
isCabinDoorOpening
	^ elevatorDoor isOpening ! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'Ji 10/2/2017 18:49:53'!
isCabinMoving
	^elevatorCabin isMoving ! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'Ji 10/2/2017 18:46:48'!
isCabinStopped
	^ elevatorCabin isStopped ! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'Ji 10/2/2017 20:42:05'!
isCabinWaitingForPeople
	^true! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'Ji 10/2/2017 18:35:19'!
isIdle
	^ isIdle! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'Ji 10/2/2017 18:07:10'!
isWorking
	^ self isIdle not! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'Ji 10/2/2017 20:09:38'!
openCabinDoor
	(self isCabinMoving ) ifFalse: [ elevatorDoor startOpening ]! !


!classDefinition: #ElevatorDoor category: #'Elevator-Ejercicio'!
Object subclass: #ElevatorDoor
	instanceVariableNames: 'doorState'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorDoor methodsFor: 'as yet unclassified' stamp: 'Ji 10/2/2017 19:58:58'!
close
	doorState _ ElevatorDoorIsClosed new.! !

!ElevatorDoor methodsFor: 'as yet unclassified' stamp: 'Ji 10/2/2017 19:40:34'!
initialize
	doorState _ ElevatorDoorIsOpen new.! !

!ElevatorDoor methodsFor: 'as yet unclassified' stamp: 'Ji 10/2/2017 19:42:48'!
isClosed
	^ doorState isClosed.! !

!ElevatorDoor methodsFor: 'as yet unclassified' stamp: 'Ji 10/2/2017 19:43:09'!
isClosing
	^ doorState isClosing.! !

!ElevatorDoor methodsFor: 'as yet unclassified' stamp: 'Ji 10/2/2017 19:42:23'!
isOpen
	^ doorState  isOpen.! !

!ElevatorDoor methodsFor: 'as yet unclassified' stamp: 'Ji 10/2/2017 19:43:19'!
isOpening
	^ doorState isOpening.! !

!ElevatorDoor methodsFor: 'as yet unclassified' stamp: 'Ji 10/2/2017 19:47:30'!
open
	doorState _ ElevatorDoorIsOpen new.! !

!ElevatorDoor methodsFor: 'as yet unclassified' stamp: 'Ji 10/2/2017 19:44:34'!
startClosing
	doorState _ ElevatorDoorIsClosing new.! !

!ElevatorDoor methodsFor: 'as yet unclassified' stamp: 'Ji 10/2/2017 20:04:28'!
startOpening
	(doorState isKindOf: ElevatorDoorIsOpen ) 
		ifFalse: [ doorState _ ElevatorDoorIsOpening new. ]! !


!classDefinition: #ElevatorDoorState category: #'Elevator-Ejercicio'!
Object subclass: #ElevatorDoorState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorDoorState methodsFor: 'as yet unclassified' stamp: 'Ji 10/2/2017 19:44:14'!
close
	self shouldBeImplemented.! !

!ElevatorDoorState methodsFor: 'as yet unclassified' stamp: 'JI 10/2/2017 19:23:32'!
isClosed
	^ false ! !

!ElevatorDoorState methodsFor: 'as yet unclassified' stamp: 'JI 10/2/2017 19:23:36'!
isClosing
	^ false ! !

!ElevatorDoorState methodsFor: 'as yet unclassified' stamp: 'Ji 10/2/2017 19:31:59'!
isOpen
	^ false! !

!ElevatorDoorState methodsFor: 'as yet unclassified' stamp: 'JI 10/2/2017 19:23:45'!
isOpening
	^ false ! !


!classDefinition: #ElevatorDoorIsClosed category: #'Elevator-Ejercicio'!
ElevatorDoorState subclass: #ElevatorDoorIsClosed
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorDoorIsClosed methodsFor: 'as yet unclassified' stamp: 'Ji 10/2/2017 19:29:35'!
initialize! !

!ElevatorDoorIsClosed methodsFor: 'as yet unclassified' stamp: 'JI 10/2/2017 19:22:57'!
isClosed
	^ true! !


!classDefinition: #ElevatorDoorIsClosing category: #'Elevator-Ejercicio'!
ElevatorDoorState subclass: #ElevatorDoorIsClosing
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorDoorIsClosing methodsFor: 'as yet unclassified' stamp: 'Ji 10/2/2017 19:29:40'!
initialize! !

!ElevatorDoorIsClosing methodsFor: 'as yet unclassified' stamp: 'JI 10/2/2017 19:23:15'!
isClosing
	^ true! !


!classDefinition: #ElevatorDoorIsOpen category: #'Elevator-Ejercicio'!
ElevatorDoorState subclass: #ElevatorDoorIsOpen
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorDoorIsOpen methodsFor: 'as yet unclassified' stamp: 'Ji 10/2/2017 19:29:42'!
initialize! !

!ElevatorDoorIsOpen methodsFor: 'as yet unclassified' stamp: 'Ji 10/2/2017 19:06:00'!
isOpen
	^ true! !


!classDefinition: #ElevatorDoorIsOpening category: #'Elevator-Ejercicio'!
ElevatorDoorState subclass: #ElevatorDoorIsOpening
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorDoorIsOpening methodsFor: 'as yet unclassified' stamp: 'Ji 10/2/2017 19:29:45'!
initialize! !

!ElevatorDoorIsOpening methodsFor: 'as yet unclassified' stamp: 'JI 10/2/2017 19:22:09'!
isOpening
	^ true! !
