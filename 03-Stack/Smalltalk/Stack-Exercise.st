!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:31'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/8/2012 08:20'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:33'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'First'.
	secondPushedObject := 'Second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:35'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:36'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'JI 5/7/2017 14:29:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'contents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'as yet unclassified' stamp: 'JI 9/16/2017 14:38:15'!
isEmpty
	^ self size  = 0! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'JI 9/16/2017 14:49:47'!
pop
	| lastElement |
	lastElement  _ self top .
	contents removeLast.
	^ lastElement.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'JI 9/16/2017 14:59:30'!
push: anElement
	contents addLast: (StackFrameWithPushedObject with: anElement).! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'JI 9/16/2017 14:39:51'!
size
	^ contents size - 1.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'JI 9/16/2017 14:49:29'!
top
	^ contents last element.! !


!OOStack methodsFor: 'initialization' stamp: 'JI 9/16/2017 15:00:00'!
initialize
	contents _ OrderedCollection new.
	contents add: StackFrameWithoutPushedObject new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #StackFrame category: #'Stack-Exercise'!
Object subclass: #StackFrame
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackFrame methodsFor: 'elementObtainer' stamp: 'JI 9/16/2017 15:06:44'!
element
	^self subclassResponsibility ! !


!classDefinition: #StackFrameWithPushedObject category: #'Stack-Exercise'!
StackFrame subclass: #StackFrameWithPushedObject
	instanceVariableNames: 'element'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackFrameWithPushedObject methodsFor: 'initialization' stamp: 'JI 9/16/2017 14:29:42'!
with: anObject

	element _ anObject ! !


!StackFrameWithPushedObject methodsFor: 'elementObtainer' stamp: 'JI 5/8/2017 15:25:26'!
element
	^element ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StackFrameWithPushedObject class' category: #'Stack-Exercise'!
StackFrameWithPushedObject class
	instanceVariableNames: ''!

!StackFrameWithPushedObject class methodsFor: 'instance creation' stamp: 'JI 9/16/2017 14:30:36'!
with: anObject

	^self new with: anObject 
	! !


!classDefinition: #StackFrameWithoutPushedObject category: #'Stack-Exercise'!
StackFrame subclass: #StackFrameWithoutPushedObject
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackFrameWithoutPushedObject methodsFor: 'elementObtainer' stamp: 'JI 9/16/2017 14:37:42'!
element

	self error: self class  stackEmptyErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StackFrameWithoutPushedObject class' category: #'Stack-Exercise'!
StackFrameWithoutPushedObject class
	instanceVariableNames: ''!

!StackFrameWithoutPushedObject class methodsFor: 'error handling' stamp: 'JI 5/8/2017 15:48:10'!
stackEmptyErrorDescription

	^OOStack stackEmptyErrorDescription! !
