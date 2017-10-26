!classDefinition: #Tests category: #'Mars-Rover'!
TestCase subclass: #Tests
	instanceVariableNames: 'marsrover validInitialPosition leftOrder rightOrder forwardOrder backwardsOrder north west south east'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover'!

!Tests methodsFor: 'testing' stamp: 'Ji 10/23/2017 19:55:53'!
setUp

	validInitialPosition _ Point x: 6 y: 9.
	marsrover _ Robot landAt: validInitialPosition.
	
	leftOrder _ 'l'.
	rightOrder _ 'r'.
	forwardOrder _ 'f'.
	backwardsOrder _ 'b'.
	
	north _ CardinalPoint headingNorth.
	south _ CardinalPoint headingSouth.
	east _ CardinalPoint headingEast.
	west _ CardinalPoint headingWest .! !

!Tests methodsFor: 'testing' stamp: 'Ji 10/23/2017 20:03:01'!
test01MarsRoverSpawnsInMap
	

	self assert: marsrover position = validInitialPosition.
	self assert: marsrover direction = north . "Lo agregue despues esto, no en el primer test"! !

!Tests methodsFor: 'testing' stamp: 'Ji 10/23/2017 19:07:13'!
test02LeftAndRightDoesNotChangePosition
	
	marsrover order: leftOrder.
	self assert: marsrover position = validInitialPosition .
	
	marsrover order: rightOrder.
	self assert: marsrover position = validInitialPosition .! !

!Tests methodsFor: 'testing' stamp: 'Ji 10/23/2017 19:42:09'!
test03ChangeToLeftAfterTurningLeft

	self assert: north = marsrover direction.
	
	marsrover order: leftOrder.
	self assert: west = marsrover direction.
	
	marsrover order: leftOrder.
	self assert: south = marsrover direction.
	
	marsrover order: leftOrder.
	self assert: east = marsrover direction.
	
	marsrover order: leftOrder.
	self assert: north = marsrover direction.
	! !

!Tests methodsFor: 'testing' stamp: 'Ji 10/23/2017 19:43:48'!
test04ChangeToRightAfterTurningRight

	self assert: north = marsrover direction.
	
	marsrover order: rightOrder .
	self assert: east = marsrover direction.
	
	marsrover order: rightOrder .
	self assert: south = marsrover direction.
	
	marsrover order: rightOrder .
	self assert: west = marsrover direction.
	
	marsrover order: rightOrder .
	self assert: north = marsrover direction.
	! !

!Tests methodsFor: 'testing' stamp: 'Ji 10/23/2017 19:44:16'!
test05MovesForwardsWhileHeadingNorth
	
	marsrover order: forwardOrder.
	self assert:  marsrover position = (Point x:7 y:9).
	self assert: north = marsrover direction .
	! !

!Tests methodsFor: 'testing' stamp: 'Ji 10/23/2017 19:45:09'!
test06MovesForwardsInAllDirections
	
	marsrover order: forwardOrder.
	self assert:  marsrover position = (Point x:7 y:9).
	self assert: marsrover direction = north.
	
	marsrover order: leftOrder.
	marsrover order: forwardOrder .
	self assert:  marsrover position = (Point x:7 y:8).
	self assert: marsrover direction = west .

	marsrover order: leftOrder.
	marsrover order: forwardOrder .
	self assert:  marsrover position = (Point x:6 y:8).
	self assert: marsrover direction = south .
	
	marsrover order: leftOrder.
	marsrover order: forwardOrder .
	self assert:  marsrover position = (Point x:6 y:9).
	self assert: marsrover direction = east .
	
	marsrover order: leftOrder.
	marsrover order: forwardOrder .
	self assert:  marsrover position = (Point x:7 y:9).
	self assert: marsrover direction = north.! !

!Tests methodsFor: 'testing' stamp: 'Ji 10/23/2017 19:46:56'!
test07MovesBackwardsInAllDirections
	marsrover order: backwardsOrder.
	self assert: marsrover position =	(Point x: 5 y: 9).
	self assert: marsrover direction = north.

	marsrover order: leftOrder.
	marsrover order: backwardsOrder.
	self assert: marsrover position =	(Point x: 5 y: 10).
	self assert: marsrover direction = west .
	
	marsrover order: leftOrder.
	marsrover order: backwardsOrder.
	self assert: marsrover position = 	(Point x: 6 y: 10).
	self assert: marsrover direction = south .
	
	marsrover order: leftOrder.
	marsrover order: backwardsOrder.
	self assert: marsrover position = (Point x: 6 y: 9).
	self assert: marsrover direction = east .
	
	marsrover order: leftOrder.
	marsrover order: backwardsOrder.
	self assert: marsrover position = (Point x: 5 y: 9).
	self assert: marsrover direction = north .! !

!Tests methodsFor: 'testing' stamp: 'Ji 10/23/2017 19:47:19'!
test08ReceivesMultipleOrdersInOneString

	marsrover order: 'fflfrfrb'.
	
	self assert: marsrover position = (9@7).
	self assert: marsrover direction = east .! !

!Tests methodsFor: 'testing' stamp: 'Ji 10/23/2017 20:31:57'!
todo

	"falta el comando vacio que loverifique que no cuelgue,es un caso mas simple encima"
	"hacer que la direccion inicial sea un parametro, es mas lindo y correcto porque si no sale de la nadaque empezamos desde el norte cuando assertamos las direcciones al movefrnos"
	"test de order: 'asdads' casos invalidos con comandos que nada que ver"! !


!classDefinition: #CardinalPoint category: #'Mars-Rover'!
Object subclass: #CardinalPoint
	instanceVariableNames: 'direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover'!

!CardinalPoint methodsFor: 'initialization' stamp: 'Ji 10/23/2017 19:41:10'!
initializeHeadingNorth
	direction _ 'N'.! !


!CardinalPoint methodsFor: 'as yet unclassified' stamp: 'Ji 10/23/2017 19:53:34'!
= anotherCardinalPoint

	^direction = anotherCardinalPoint direction.! !

!CardinalPoint methodsFor: 'as yet unclassified' stamp: 'Ji 10/23/2017 19:52:23'!
direction
	^direction ! !

!CardinalPoint methodsFor: 'as yet unclassified' stamp: 'Ji 10/23/2017 19:50:55'!
turnNinetyDegreeToTheLeft
direction = 'E'
		ifTrue: [ direction _ 'N' ]
		ifFalse: [
			direction = 'S'
				ifTrue: [ direction _ 'E' ]
				ifFalse: [
					direction = 'W'
						ifTrue: [ direction _ 'S' ]
						ifFalse: [
							direction = 'N' ifTrue: [ direction _ 'W' ]]]].! !

!CardinalPoint methodsFor: 'as yet unclassified' stamp: 'Ji 10/23/2017 19:49:48'!
turnNinetyDegreeToTheRight
	direction = 'E'
		ifTrue: [ direction _ 'S' ]
		ifFalse: [
			direction = 'S'
				ifTrue: [ direction _ 'W' ]
				ifFalse: [
					direction = 'W'
						ifTrue: [ direction _ 'N' ]
						ifFalse: [
							direction = 'N' ifTrue: [ direction _ 'E' ]]]].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CardinalPoint class' category: #'Mars-Rover'!
CardinalPoint class
	instanceVariableNames: ''!

!CardinalPoint class methodsFor: 'creation' stamp: 'Ji 10/23/2017 19:40:34'!
headingNorth
	^self new initializeHeadingNorth! !


!CardinalPoint class methodsFor: 'as yet unclassified' stamp: 'Ji 10/23/2017 19:54:01'!
headingEast
	^self headingNorth turnNinetyDegreeToTheRight ! !

!CardinalPoint class methodsFor: 'as yet unclassified' stamp: 'Ji 10/23/2017 19:54:22'!
headingSouth
	^ self headingNorth turnNinetyDegreeToTheLeft turnNinetyDegreeToTheLeft .! !

!CardinalPoint class methodsFor: 'as yet unclassified' stamp: 'Ji 10/23/2017 19:54:31'!
headingWest
	^self headingNorth turnNinetyDegreeToTheLeft ! !


!classDefinition: #Robot category: #'Mars-Rover'!
Object subclass: #Robot
	instanceVariableNames: 'direction currentPoint'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover'!

!Robot methodsFor: 'actions - private' stamp: 'Ji 10/23/2017 19:58:16'!
moveBackwards
	
	direction direction = 'N' ifTrue: [ currentPoint _ currentPoint - (1@0) ].
	direction direction = 'W' ifTrue: [ currentPoint _ currentPoint + (0@1) ].
	direction direction = 'S' ifTrue: [ currentPoint _ currentPoint + (1@0) ].
	direction direction = 'E' ifTrue: [ currentPoint _ currentPoint - (0@1) ].! !

!Robot methodsFor: 'actions - private' stamp: 'Ji 10/23/2017 19:57:59'!
moveForward
	
	direction direction = 'N' ifTrue: [ currentPoint _ currentPoint + (1@0) ].
	direction direction = 'W' ifTrue: [ currentPoint _ currentPoint - (0@1) ].
	direction direction = 'S' ifTrue: [ currentPoint _ currentPoint - (1@0) ].
	direction direction = 'E' ifTrue: [ currentPoint _ currentPoint + (0@1) ].! !

!Robot methodsFor: 'actions - private' stamp: 'Ji 10/23/2017 19:50:45'!
turnLeft
	direction turnNinetyDegreeToTheLeft! !

!Robot methodsFor: 'actions - private' stamp: 'Ji 10/23/2017 19:48:26'!
turnRight
	direction turnNinetyDegreeToTheRight.! !


!Robot methodsFor: 'initialization' stamp: 'Ji 10/23/2017 19:37:45'!
initializeLandingAt: aPoint
	currentPoint _ aPoint.
	direction _ CardinalPoint headingNorth.! !


!Robot methodsFor: 'accessing' stamp: 'Ji 10/23/2017 19:09:05'!
direction
	^ direction.! !

!Robot methodsFor: 'accessing' stamp: 'Ji 10/23/2017 19:09:38'!
position
	^ currentPoint.! !


!Robot methodsFor: 'actions' stamp: 'Ji 10/23/2017 19:30:46'!
order: aString

	aString do: [ :oneCharString | 
		oneCharString = ($l) ifTrue: [ self turnLeft ].
		oneCharString = ($r) ifTrue: [ self turnRight ].
		oneCharString = ($f) ifTrue: [ self moveForward ].
		oneCharString = ($b) ifTrue: [ self moveBackwards].
		].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Robot class' category: #'Mars-Rover'!
Robot class
	instanceVariableNames: ''!

!Robot class methodsFor: 'creation' stamp: 'Ji 10/23/2017 19:34:53'!
landAt: aPoint
	^ self new initializeLandingAt: aPoint.! !
