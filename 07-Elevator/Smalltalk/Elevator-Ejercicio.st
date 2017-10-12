!classDefinition: #ElevatorEmergency category: #'Elevator-Ejercicio'!
Error subclass: #ElevatorEmergency
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ElevatorEmergency class' category: #'Elevator-Ejercicio'!
ElevatorEmergency class
	instanceVariableNames: ''!

!ElevatorEmergency class methodsFor: 'as yet unclassified' stamp: 'JI 10/11/2017 00:05:58'!
desincronizedDoorError
	self signal: 'Sensor de puerta desincronizado'! !

!ElevatorEmergency class methodsFor: 'as yet unclassified' stamp: 'JI 10/11/2017 00:05:29'!
desincronizedFloorError
	self signal: 'Sensor de cabina desincronizado'! !


!classDefinition: #ElevatorTest category: #'Elevator-Ejercicio'!
TestCase subclass: #ElevatorTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

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


!classDefinition: #Cabin category: #'Elevator-Ejercicio'!
Object subclass: #Cabin
	instanceVariableNames: 'cabinState'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!Cabin methodsFor: 'inspecting' stamp: 'JI 10/11/2017 20:34:59'!
doorIsClosed
		
	^ cabinState doorIsClosed! !

!Cabin methodsFor: 'inspecting' stamp: 'JI 10/11/2017 20:35:09'!
doorIsClosing
		
	^ cabinState doorIsClosing ! !

!Cabin methodsFor: 'inspecting' stamp: 'JI 10/11/2017 20:35:18'!
doorIsOpen
	^ cabinState doorIsOpen! !

!Cabin methodsFor: 'inspecting' stamp: 'JI 10/11/2017 20:35:28'!
doorIsOpening
	^ cabinState doorIsOpening ! !

!Cabin methodsFor: 'inspecting' stamp: 'JI 10/11/2017 20:23:01'!
isMoving
	^ cabinState isMoving 
	! !

!Cabin methodsFor: 'inspecting' stamp: 'JI 10/11/2017 20:35:44'!
isStopped
	^ cabinState isStopped ! !


!Cabin methodsFor: 'action' stamp: 'JI 10/11/2017 20:46:42'!
closeDoor
	cabinState _ cabinState closeDoor! !

!Cabin methodsFor: 'action' stamp: 'JI 10/11/2017 20:35:57'!
openDoor
	cabinState openDoor ! !

!Cabin methodsFor: 'action' stamp: 'JI 10/11/2017 20:36:10'!
startClosingDoor
	
	cabinState startClosingDoor ! !

!Cabin methodsFor: 'action' stamp: 'JI 10/11/2017 20:36:23'!
startOpeningDoor
	cabinState startOpeningDoor ! !

!Cabin methodsFor: 'action' stamp: 'JI 10/11/2017 20:48:13'!
stop
	
	cabinState _ cabinState stop! !


!Cabin methodsFor: 'initialization' stamp: 'JI 10/11/2017 20:59:13'!
initialize
	cabinState _ CabinNotWorking new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cabin class' category: #'Elevator-Ejercicio'!
Cabin class
	instanceVariableNames: ''!

!Cabin class methodsFor: 'as yet unclassified' stamp: 'JI 10/11/2017 20:18:37'!
with: doorState 

	^self new initializeWith: doorState ! !


!classDefinition: #CabinDoor category: #'Elevator-Ejercicio'!
Object subclass: #CabinDoor
	instanceVariableNames: 'doorState'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!CabinDoor methodsFor: 'inspecting' stamp: 'Ji 10/2/2017 19:42:48'!
isClosed
	^ doorState isClosed.! !

!CabinDoor methodsFor: 'inspecting' stamp: 'Ji 10/2/2017 19:43:09'!
isClosing
	^ doorState isClosing.! !

!CabinDoor methodsFor: 'inspecting' stamp: 'Ji 10/2/2017 19:42:23'!
isOpen
	^ doorState  isOpen.! !

!CabinDoor methodsFor: 'inspecting' stamp: 'Ji 10/2/2017 19:43:19'!
isOpening
	^ doorState isOpening.! !


!CabinDoor methodsFor: 'initialization' stamp: 'JI 10/11/2017 21:00:35'!
initialize
	doorState _ CabinDoorIsOpen new.! !


!CabinDoor methodsFor: 'actions' stamp: 'JI 10/11/2017 19:39:36'!
close
	doorState _ doorState endClosing .! !

!CabinDoor methodsFor: 'actions' stamp: 'JI 10/11/2017 01:54:25'!
open
	doorState _ doorState endOpening .! !

!CabinDoor methodsFor: 'actions' stamp: 'JI 10/11/2017 01:54:40'!
startClosing
	doorState _ doorState startClosing .! !

!CabinDoor methodsFor: 'actions' stamp: 'JI 10/11/2017 01:54:54'!
startOpening
	doorState  _ doorState startOpening ! !


!classDefinition: #CabinDoorState category: #'Elevator-Ejercicio'!
Object subclass: #CabinDoorState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!CabinDoorState methodsFor: 'actions' stamp: 'JI 10/11/2017 16:19:29'!
endClosing

	self desincronizedDoorError.! !

!CabinDoorState methodsFor: 'actions' stamp: 'JI 10/11/2017 01:48:28'!
endOpening

	! !

!CabinDoorState methodsFor: 'actions' stamp: 'JI 10/11/2017 16:44:54'!
startClosing
	
	! !

!CabinDoorState methodsFor: 'actions' stamp: 'JI 10/11/2017 01:48:12'!
startOpening
	! !


!CabinDoorState methodsFor: 'inspecting' stamp: 'JI 10/2/2017 19:23:32'!
isClosed
	^ false ! !

!CabinDoorState methodsFor: 'inspecting' stamp: 'JI 10/2/2017 19:23:36'!
isClosing
	^ false ! !

!CabinDoorState methodsFor: 'inspecting' stamp: 'Ji 10/2/2017 19:31:59'!
isOpen
	^ false! !

!CabinDoorState methodsFor: 'inspecting' stamp: 'JI 10/2/2017 19:23:45'!
isOpening
	^ false ! !


!CabinDoorState methodsFor: 'error handling' stamp: 'JI 10/11/2017 16:21:02'!
desincronizedDoorError
	ElevatorEmergency desincronizedDoorError ! !


!classDefinition: #CabinDoorIsClosed category: #'Elevator-Ejercicio'!
CabinDoorState subclass: #CabinDoorIsClosed
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!CabinDoorIsClosed methodsFor: 'inspecting' stamp: 'JI 10/2/2017 19:22:57'!
isClosed
	^ true! !


!CabinDoorIsClosed methodsFor: 'actions' stamp: 'JI 10/11/2017 21:00:27'!
startOpening
	^ CabinDoorIsOpening new.! !


!classDefinition: #CabinDoorIsClosing category: #'Elevator-Ejercicio'!
CabinDoorState subclass: #CabinDoorIsClosing
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!CabinDoorIsClosing methodsFor: 'inspecting' stamp: 'JI 10/2/2017 19:23:15'!
isClosing
	^ true! !


!CabinDoorIsClosing methodsFor: 'actions' stamp: 'JI 10/11/2017 20:59:51'!
endClosing
	^ CabinDoorIsClosed new.! !

!CabinDoorIsClosing methodsFor: 'actions' stamp: 'JI 10/11/2017 21:00:27'!
startOpening
	^ CabinDoorIsOpening new.! !


!classDefinition: #CabinDoorIsOpen category: #'Elevator-Ejercicio'!
CabinDoorState subclass: #CabinDoorIsOpen
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!CabinDoorIsOpen methodsFor: 'inspecting' stamp: 'Ji 10/2/2017 19:06:00'!
isOpen
	^ true! !


!CabinDoorIsOpen methodsFor: 'actions' stamp: 'JI 10/11/2017 21:00:08'!
startClosing
	^ CabinDoorIsClosing new.! !


!classDefinition: #CabinDoorIsOpening category: #'Elevator-Ejercicio'!
CabinDoorState subclass: #CabinDoorIsOpening
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!CabinDoorIsOpening methodsFor: 'inspecting' stamp: 'JI 10/2/2017 19:22:09'!
isOpening
	^ true! !


!CabinDoorIsOpening methodsFor: 'actions' stamp: 'JI 10/11/2017 21:00:35'!
endOpening
	^ CabinDoorIsOpen new.! !


!classDefinition: #CabinState category: #'Elevator-Ejercicio'!
Object subclass: #CabinState
	instanceVariableNames: 'doorState'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!CabinState methodsFor: 'inspecting' stamp: 'JI 10/11/2017 16:39:32'!
doorIsClosed
		
	^ doorState isClosed! !

!CabinState methodsFor: 'inspecting' stamp: 'JI 10/11/2017 16:39:36'!
doorIsClosing
		
	^doorState isClosing! !

!CabinState methodsFor: 'inspecting' stamp: 'JI 10/11/2017 16:38:48'!
doorIsOpen
	^ doorState isOpen ! !

!CabinState methodsFor: 'inspecting' stamp: 'JI 10/11/2017 16:39:41'!
doorIsOpening
	^doorState isOpening .! !

!CabinState methodsFor: 'inspecting' stamp: 'JI 10/11/2017 16:39:50'!
isMoving
		self subclassResponsibility .
	! !

!CabinState methodsFor: 'inspecting' stamp: 'JI 10/11/2017 16:39:57'!
isStopped
	^ self isMoving not! !


!CabinState methodsFor: 'action' stamp: 'JI 10/11/2017 20:59:29'!
closeDoor
	doorState close.
	^ CabinWorking with: doorState.! !

!CabinState methodsFor: 'action' stamp: 'JI 10/11/2017 16:36:29'!
openDoor
	
		self subclassResponsibility .! !

!CabinState methodsFor: 'action' stamp: 'JI 10/11/2017 19:49:52'!
startClosingDoor
	
	"Do nothing unless child class override it"! !

!CabinState methodsFor: 'action' stamp: 'JI 10/11/2017 19:50:51'!
startOpeningDoor
	
		"Do nothing unless child class override it"! !

!CabinState methodsFor: 'action' stamp: 'JI 10/11/2017 19:50:58'!
stop
	
		"Do nothing unless child class override it"! !


!CabinState methodsFor: 'initialization' stamp: 'JI 10/11/2017 22:37:50'!
initialize
	doorState _ CabinDoor new.! !

!CabinState methodsFor: 'initialization' stamp: 'JI 10/11/2017 16:58:46'!
initializeWith: anElevatorDoor 
	doorState _ anElevatorDoor copy! !


!CabinState methodsFor: 'error' stamp: 'JI 10/11/2017 16:39:26'!
desincronizedDoorError
		
	ElevatorEmergency desincronizedDoorError! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CabinState class' category: #'Elevator-Ejercicio'!
CabinState class
	instanceVariableNames: ''!

!CabinState class methodsFor: 'as yet unclassified' stamp: 'JI 10/11/2017 16:58:22'!
with: doorState 

	^self new initializeWith: doorState ! !


!classDefinition: #CabinNotWorking category: #'Elevator-Ejercicio'!
CabinState subclass: #CabinNotWorking
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!CabinNotWorking methodsFor: 'action' stamp: 'JI 10/11/2017 16:34:42'!
openDoor
	doorState open! !

!CabinNotWorking methodsFor: 'action' stamp: 'JI 10/11/2017 20:45:03'!
startClosingDoor
	doorState startClosing
	
	
! !

!CabinNotWorking methodsFor: 'action' stamp: 'JI 10/11/2017 17:03:37'!
startOpeningDoor
	doorState startOpening! !


!CabinNotWorking methodsFor: 'inspecting' stamp: 'JI 10/11/2017 16:41:49'!
isMoving
	^false! !


!classDefinition: #CabinWorking category: #'Elevator-Ejercicio'!
CabinState subclass: #CabinWorking
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!CabinWorking methodsFor: 'inspecting' stamp: 'JI 10/11/2017 16:56:53'!
isMoving
	^true! !


!CabinWorking methodsFor: 'action' stamp: 'JI 10/11/2017 20:59:13'!
stop
	^ CabinNotWorking with: doorState.! !


!classDefinition: #ElevatorController category: #'Elevator-Ejercicio'!
Object subclass: #ElevatorController
	instanceVariableNames: 'elevatorCabin currentFloorNumber floorQueue elevatorState'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorController methodsFor: 'cabin' stamp: 'JI 10/11/2017 21:35:52'!
cabinOnFloor: aFloorNumber
	"Estos ifs no puedo sacarlos porque tienen dominio de numeros"
	(aFloorNumber  - currentFloorNumber  = 1) ifFalse: [ self desincronizedFloorError]   .
	floorQueue remove: aFloorNumber ifAbsent: [^self].
	
	currentFloorNumber _ aFloorNumber .
	elevatorCabin stop.
	elevatorCabin startOpeningDoor.
	! !

!ElevatorController methodsFor: 'cabin' stamp: 'JI 10/11/2017 22:08:36'!
goUpPushedFromFloor: aFloorNumber
	floorQueue add: aFloorNumber.
	
	elevatorState _ ElevatorIsNotIdle new.
	elevatorCabin startClosingDoor.
		
	
	
	
	! !

!ElevatorController methodsFor: 'cabin' stamp: 'Ji 10/2/2017 18:49:53'!
isCabinMoving
	^elevatorCabin isMoving ! !

!ElevatorController methodsFor: 'cabin' stamp: 'Ji 10/2/2017 18:46:48'!
isCabinStopped
	^ elevatorCabin isStopped ! !

!ElevatorController methodsFor: 'cabin' stamp: 'JI 10/11/2017 01:36:39'!
isCabinWaitingForPeople
	^self isCabinDoorOpened ! !

!ElevatorController methodsFor: 'cabin' stamp: 'JI 10/11/2017 12:51:08'!
waitForPeopleTimedOut
	
	elevatorCabin startClosingDoor ! !


!ElevatorController methodsFor: 'initialization' stamp: 'JI 10/11/2017 22:08:48'!
initialize
	elevatorCabin _ Cabin new.
	elevatorState _ ElevatorIsIdle new.
	currentFloorNumber _ 0.
	floorQueue _ OrderedCollection new.! !


!ElevatorController methodsFor: 'cabin door' stamp: 'JI 10/11/2017 20:39:07'!
cabinDoorClosed
	elevatorCabin closeDoor.! !

!ElevatorController methodsFor: 'cabin door' stamp: 'JI 10/11/2017 22:07:54'!
cabinDoorOpened
	elevatorCabin openDoor.
	floorQueue isEmpty ifTrue: [
		elevatorState _ ElevatorIsIdle new.
		].
! !

!ElevatorController methodsFor: 'cabin door' stamp: 'JI 10/11/2017 22:27:56'!
closeCabinDoor
	elevatorState startClosingDoorOf: elevatorCabin 
			
			! !

!ElevatorController methodsFor: 'cabin door' stamp: 'JI 10/11/2017 12:47:53'!
isCabinDoorClosed
	^ elevatorCabin doorIsClosed! !

!ElevatorController methodsFor: 'cabin door' stamp: 'JI 10/11/2017 12:46:08'!
isCabinDoorClosing
	^ elevatorCabin doorIsClosing.! !

!ElevatorController methodsFor: 'cabin door' stamp: 'JI 10/11/2017 12:45:18'!
isCabinDoorOpened
	^ elevatorCabin doorIsOpen! !

!ElevatorController methodsFor: 'cabin door' stamp: 'JI 10/11/2017 12:42:40'!
isCabinDoorOpening
	^ elevatorCabin doorIsOpening! !

!ElevatorController methodsFor: 'cabin door' stamp: 'JI 10/11/2017 13:05:48'!
openCabinDoor
	elevatorCabin startOpeningDoor .! !


!ElevatorController methodsFor: 'inspecting' stamp: 'Ji 10/2/2017 18:57:27'!
cabinFloorNumber
	^ currentFloorNumber ! !

!ElevatorController methodsFor: 'inspecting' stamp: 'JI 10/11/2017 22:09:14'!
isIdle
	^ elevatorState isIdle! !

!ElevatorController methodsFor: 'inspecting' stamp: 'JI 10/10/2017 23:52:37'!
isWorking
	^ self isIdle not! !


!ElevatorController methodsFor: 'error handling' stamp: 'JI 10/11/2017 22:36:09'!
desincronizedFloorError

	ElevatorEmergency desincronizedFloorError.! !


!classDefinition: #ElevatorState category: #'Elevator-Ejercicio'!
Object subclass: #ElevatorState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorState methodsFor: 'inspecting' stamp: 'JI 10/11/2017 22:10:45'!
isIdle
	self subclassResponsibility .! !


!ElevatorState methodsFor: 'action' stamp: 'JI 10/11/2017 22:28:13'!
startClosingDoorOf: aCabin 
	self subclassResponsibility ! !


!classDefinition: #ElevatorIsIdle category: #'Elevator-Ejercicio'!
ElevatorState subclass: #ElevatorIsIdle
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorIsIdle methodsFor: 'inspecting' stamp: 'JI 10/11/2017 22:11:18'!
isIdle
	^ true! !


!ElevatorIsIdle methodsFor: 'action' stamp: 'JI 10/11/2017 22:33:20'!
startClosingDoorOf: aCabin 
	"does nothing"! !


!classDefinition: #ElevatorIsNotIdle category: #'Elevator-Ejercicio'!
ElevatorState subclass: #ElevatorIsNotIdle
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorIsNotIdle methodsFor: 'inspecting' stamp: 'JI 10/11/2017 22:11:24'!
isIdle
	^ false! !


!ElevatorIsNotIdle methodsFor: 'action' stamp: 'JI 10/11/2017 22:32:26'!
startClosingDoorOf: aCabin 
	aCabin startClosingDoor "does nothing"! !
