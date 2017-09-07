!classDefinition: #NotFound category: #'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #IdiomTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #IdiomTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!IdiomTest methodsFor: 'testing' stamp: 'JK 4/22/2017 16:09:46'!
assert: aBlock shouldNotTakeMoreThan: milliseconds

	| millisecondsBeforeRunning millisecondsAfterRunning |
	
	millisecondsBeforeRunning := Time millisecondClockValue.
	aBlock value.
	millisecondsAfterRunning := Time millisecondClockValue.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < milliseconds 
	
! !

!IdiomTest methodsFor: 'testing' stamp: 'ji 9/5/2017 17:31:57'!
assert: aBlock withError: anErrorType withBlockOfAssertions:  aBlockWithAssertions

	[ aBlock value. 
		self fail ]
		on: anErrorType
		do: aBlockWithAssertions
	
	
! !

!IdiomTest methodsFor: 'testing' stamp: 'ji 9/5/2017 18:00:38'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds
	| customerBook |
	customerBook _ CustomerBook new.
	self
		assert: [ customerBook addCustomerNamed: 'John Lennon' ]
		shouldNotTakeMoreThan: 50.! !

!IdiomTest methodsFor: 'testing' stamp: 'ji 9/5/2017 18:00:38'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds
	| customerBook paulMcCartney |
	customerBook _ CustomerBook new.
	paulMcCartney _ 'Paul McCartney'.
	customerBook addCustomerNamed: paulMcCartney.
	self
		assert: [ customerBook removeCustomerNamed: paulMcCartney ]
		shouldNotTakeMoreThan: 100.! !

!IdiomTest methodsFor: 'testing' stamp: 'ji 9/5/2017 18:00:38'!
test03CanNotAddACustomerWithEmptyName
	| customerBook |
	customerBook _ CustomerBook new.
	self
		assert: [ customerBook addCustomerNamed: '' ]
		withError: Error
		withBlockOfAssertions: [ :anError |
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ].! !

!IdiomTest methodsFor: 'testing' stamp: 'ji 9/5/2017 18:00:49'!
test04CanNotRemoveAnInvalidCustomer
	| customerBook johnLennon |
	customerBook _ CustomerBook new.
	johnLennon _ 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	self
		assert: [ customerBook removeCustomerNamed: 'Paul McCartney' ]
		withError: NotFound
		withBlockOfAssertions: [ :anError |
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ].! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'customers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:42'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(customers includes: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	customers add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:56'!
numberOfCustomers
	
	^customers size! !

!CustomerBook methodsFor: 'customer management' stamp: 'ji 9/5/2017 18:00:49'!
removeCustomerNamed: aName
	customers
		remove: aName
		ifAbsent: [ NotFound signal ].! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !


!CustomerBook methodsFor: 'testing' stamp: 'HernanWilkinson 7/6/2011 17:56'!
includesCustomerNamed: aName

	^customers includes: aName ! !

!CustomerBook methodsFor: 'testing' stamp: 'HernanWilkinson 7/6/2011 17:48'!
isEmpty
	
	^customers isEmpty  ! !


!CustomerBook methodsFor: 'initialization' stamp: 'HernanWilkinson 7/6/2011 17:42'!
initialize

	super initialize.
	customers := OrderedCollection new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/6/2011 17:57'!
customerAlreadyExistsErrorMessage

	^'Customer already exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/6/2011 17:53'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty'! !
