!classDefinition: #TestTusLibros category: #'TusLibros-Solution'!
TestCase subclass: #TestTusLibros
	instanceVariableNames: 'shoppingCartWithEmptyCatalog anIsbnBook anIsbnBook2 catalog1 catalog2 shoppingCartWithCatalog1 shoppingCartWithCatalog2 aCashier shoppingCartWithCatalog1Price shoppingCartWithCatalog2Price aCashier2 aCard1 today aCard2 nameOfOwner numberOfPlastic numberOfPlastic2 aSalesBook1 salesBookEmpty aSalesBook2 merchantProcessor owner3 aCard3 merchantProcessor2 aCashier3 factoryCard card card2 userValid passwordValid userPass interfaceSimulator merchantProcessor3 aCartId dateAndTime3 dateAndTime2 dateAndTime4 dateAndTime1 aCard4 accountsInfo accountsInfo1 accountsInfo2 anExactSalesBook1 anExactSalesBook2'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!TestTusLibros methodsFor: 'Testing Cashier' stamp: 'JI 6/27/2017 17:00:33'!
test009aCashierCanNotCheckOutEmptyCart
	
	|balance uses|
	
	balance _ merchantProcessor balanceOfCard: aCard1 .
	uses  _ merchantProcessor uses .
	
	self should: [ aCashier checkOut: shoppingCartWithEmptyCatalog  withCard: aCard1 asTodayBeing: today withSalesBook: aSalesBook1 .]  
		raise: Error  
		withExceptionDo: [ :anError | self assert: anError messageText equals: 'No se puede hacer checkout de un carrito vacio'.
			self assert: salesBookEmpty isEmpty.
			self assert: balance = (merchantProcessor balanceOfCard: aCard1) .
			self assert: uses = merchantProcessor uses.
			]! !

!TestTusLibros methodsFor: 'Testing Cashier' stamp: 'Ji 10/26/2017 18:53:34'!
test010aCashierChecksOutAnItem
	| total balance uses |
	balance _ merchantProcessor balanceOfCard: aCard1.
	uses _ merchantProcessor uses.
	total _ aCashier
		checkOut: shoppingCartWithCatalog1
		withCard: aCard1
		asTodayBeing: today
		withSalesBook: aSalesBook1.
	self assert: total = shoppingCartWithCatalog1Price.
	self assert: aSalesBook1 = anExactSalesBook1.
	self assert: balance - total = (merchantProcessor balanceOfCard: aCard1).
	self assert: uses + 1 = merchantProcessor uses.! !

!TestTusLibros methodsFor: 'Testing Cashier' stamp: 'Ji 10/26/2017 18:53:58'!
test011aCashierChecksOutItems
	| total balance uses |
	balance _ merchantProcessor2 balanceOfCard: aCard1.
	uses _ merchantProcessor2 uses.
	total _ aCashier2
		checkOut: shoppingCartWithCatalog2
		withCard: aCard1
		asTodayBeing: today
		withSalesBook: aSalesBook2.
	self assert: total = shoppingCartWithCatalog2Price.
	self assert: aSalesBook2 = anExactSalesBook2.
	self assert: balance - total = (merchantProcessor2 balanceOfCard: aCard1).
	self assert: uses + 1 = merchantProcessor2 uses.! !

!TestTusLibros methodsFor: 'Testing Cashier' stamp: 'Ji 10/26/2017 18:53:58'!
test012aCashierCanUseNotDatedCard
	| balance total uses |
	balance _ merchantProcessor2 balanceOfCard: aCard1.
	uses _ merchantProcessor2 uses.
	total _ aCashier2
		checkOut: shoppingCartWithCatalog2
		withCard: aCard1
		asTodayBeing: today
		withSalesBook: aSalesBook2.
	self assert: total = shoppingCartWithCatalog2Price.
	self assert: aSalesBook2 = anExactSalesBook2.
	self assert: balance - total = (merchantProcessor2 balanceOfCard: aCard1).
	self assert: uses + 1 = merchantProcessor2 uses.! !

!TestTusLibros methodsFor: 'Testing Cashier' stamp: 'JI 6/27/2017 17:08:45'!
test013aCashierCantUseDatedCard
	
	| balance uses |
	
	balance _ merchantProcessor2 balanceOfCard: aCard2 .
	uses  _ merchantProcessor2 uses .
		
	self should: [aCashier2 checkOut: shoppingCartWithCatalog2 withCard: aCard2 asTodayBeing: today withSalesBook: aSalesBook2]
	raise: Error
	withExceptionDo: [ :anError | self assert: anError messageText = 'La tarjeta esta vencida'.
		self assert: aSalesBook2 isEmpty.
		self assert: balance   = (merchantProcessor2 balanceOfCard: aCard2).
		self assert: uses = merchantProcessor2 uses.
		]! !

!TestTusLibros methodsFor: 'Testing Cashier' stamp: 'JI 6/27/2017 17:09:08'!
test014aCashierCantChargeIfNotEnoughMoneyInBank
	
	| balance uses |
	
	balance _ merchantProcessor balanceOfCard: aCard1.
	uses  _ merchantProcessor uses .
		
	self should: [aCashier3 checkOut: shoppingCartWithCatalog2 withCard: aCard1 asTodayBeing: today withSalesBook: aSalesBook2]
	raise: Error
	withExceptionDo: [ :anError | self assert: anError messageText =  'No hay suficiente dinero en el banco'.
		self assert: aSalesBook2 isEmpty.
		self assert: balance  = (merchantProcessor balanceOfCard: aCard1).
		self assert: uses + 1 = merchantProcessor uses.
		]! !


!TestTusLibros methodsFor: 'Testing Shopping Cart' stamp: 'Ji 10/26/2017 19:08:09'!
test001aNewShoppingCartIsEmpty
	self assert: shoppingCartWithEmptyCatalog isEmpty.! !

!TestTusLibros methodsFor: 'Testing Shopping Cart' stamp: 'Ji 10/26/2017 19:09:21'!
test002aShoppingCartIsNotEmptyWhenABookIsAdded
	self deny: shoppingCartWithCatalog1 isEmpty.! !

!TestTusLibros methodsFor: 'Testing Shopping Cart' stamp: 'JI 6/15/2017 14:31:32'!
test004canListTheElementsAddedToTheCart
	
	|contentsOfShoppingCart |
	
	contentsOfShoppingCart := shoppingCartWithCatalog2 contents.
	
	self assert: (contentsOfShoppingCart includes: anIsbnBook ).
	self assert: (contentsOfShoppingCart includes: anIsbnBook2 ).! !

!TestTusLibros methodsFor: 'Testing Shopping Cart' stamp: 'JI 6/15/2017 14:31:53'!
test005canAddTheSameBookTwiceToTheShoppingCartAndKnowTheQuantiy


	self assert: ((shoppingCartWithCatalog2 quantity: anIsbnBook2) = 2).
! !

!TestTusLibros methodsFor: 'Testing Shopping Cart' stamp: 'JI 6/15/2017 14:32:39'!
test006addLessThanOneBookRaiseError

	self 
		should: [ shoppingCartWithEmptyCatalog add: anIsbnBook withQuantity: 0. ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: ShoppingCart canNotAddLessThanOneBook.
			self assert: shoppingCartWithEmptyCatalog isEmpty ]
! !

!TestTusLibros methodsFor: 'Testing Shopping Cart' stamp: 'JI 6/15/2017 14:33:04'!
test007cannotAddABookThatIsNotInTheCatalog
	
	self should: [ shoppingCartWithEmptyCatalog add: anIsbnBook2] 
		raise: Error  
		withExceptionDo: [ :anError | self assert: anError messageText equals: 'No se puede agregar libro'.
				self assert: shoppingCartWithEmptyCatalog isEmpty.]! !

!TestTusLibros methodsFor: 'Testing Shopping Cart' stamp: 'JI 6/15/2017 14:41:54'!
test008cannotAddABookWithANonIntegerAmount
	
	self should: [ shoppingCartWithCatalog1 add: anIsbnBook withQuantity: 2/3] 
		raise: Error  
		withExceptionDo: [ :anError | self assert: anError messageText equals: 'No se puede agregar una cantidad no entera de libros'.
				self assert: (shoppingCartWithCatalog1 occurrencesOf: anIsbnBook) = 1 .]! !


!TestTusLibros methodsFor: 'Testing Credit Card' stamp: 'JAK 6/17/2017 19:34:52'!
test012CreditCardCanNotInitializeWithEmptyOwner
	
	self should: [CreditCard initializeForOwner: '' withNumber: 1234123412341234 expiredAt: (Month month: 1 year: 2020)]
	raise: Error
	withExceptionDo: [ :anError | self assert: anError messageText = 'El nombre no puede ser vacio']! !

!TestTusLibros methodsFor: 'Testing Credit Card' stamp: 'JAK 6/17/2017 19:36:34'!
test012CreditCardCanNotInitializeWithLessOrMoreThan16Digits
	
	self should: [CreditCard initializeForOwner: 'Nombre del titular' withNumber: 14 expiredAt: (Month month: 1 year: 2020)]
	raise: Error
	withExceptionDo: [ :anError | self assert: anError messageText = 'Los digitos deben ser 16 exactos'].
	
	
	self should: [CreditCard initializeForOwner: 'Nombre del titular' withNumber: 123413132131223412341234 expiredAt: (Month month: 1 year: 2020)]
	raise: Error
	withExceptionDo: [ :anError | self assert: anError messageText = 'Los digitos deben ser 16 exactos']! !


!TestTusLibros methodsFor: 'setUp' stamp: 'JI 6/27/2017 16:31:15'!
cardSetUp

	today _ Month month: 10 year: 2017.
	nameOfOwner _ 'John Kaplan'.
	numberOfPlastic _ 1234567812345678.
	numberOfPlastic2 _ 4321567812345678.
	owner3 _ 'abcdefghijklmnopqrstuvwxyzzzzzzzzzzzzzzzzzzzz'.
	
	aCard1 _ CreditCard initializeForOwner: nameOfOwner withNumber: numberOfPlastic expiredAt: (Month month: 1 year: 2020).
	aCard2 _ CreditCard initializeForOwner: nameOfOwner withNumber: numberOfPlastic expiredAt:(Month month: 6 year: 2010).
	aCard3 _ CreditCard initializeForOwner: owner3 withNumber: numberOfPlastic expiredAt: (Month month: 1 year: 2020).
	aCard4 _ CreditCard initializeForOwner: 'Unknown' withNumber: 1234567812345677 expiredAt: (Month month: 1 year: 2020).! !

!TestTusLibros methodsFor: 'setUp' stamp: 'JI 6/22/2017 17:10:32'!
cashierSetUp
	aCashier _ Cashier initializeWithCatalog: catalog1 withMerchantProcessorSimulator: merchantProcessor.
	aCashier2 _ Cashier initializeWithCatalog: catalog2 withMerchantProcessorSimulator: merchantProcessor2 .
	aCashier3 _ Cashier initializeWithCatalog: catalog2 withMerchantProcessorSimulator: merchantProcessor .
! !

!TestTusLibros methodsFor: 'setUp' stamp: 'Ji 6/15/2017 19:12:26'!
catalogSetUp
	
	catalog1 _ Dictionary new.
	catalog1 at: anIsbnBook put: 10.
	catalog2 _ Dictionary new.
	catalog2 at: anIsbnBook put: 10.
	catalog2 at: anIsbnBook2 put: 20.
	! !

!TestTusLibros methodsFor: 'setUp' stamp: 'JI 6/27/2017 15:19:43'!
interfaceCartsetUp

	userValid _ 'bobby32'.
	passwordValid _ 'qwerty01'.
	userPass _ Dictionary new.
	userPass at:userValid put:passwordValid .
	interfaceSimulator _ InterfaceSimulator initializeWithUserAndPassword: userPass andCatalog: catalog2 andCreditCard: aCard1 andMerchantProcessor: merchantProcessor2 withSalesBook: aSalesBook2 withCashier: aCashier2 asToday: today .
	
	dateAndTime1 _ DateAndTime date: (Date year: 2017 month: 6 day: 1) time: (Time hour: 12 minute: 0 second: 0).
	dateAndTime2 _ DateAndTime date: (Date year: 2017 month: 6 day: 1) time: (Time hour: 12 minute: 15 second: 0).
	dateAndTime3 _ DateAndTime date: (Date year: 2017 month: 6 day: 1) time: (Time hour: 12 minute: 30 second: 0).	
	dateAndTime4 _ DateAndTime date: (Date year: 2017 month: 6 day: 1) time: (Time hour: 12 minute: 45 second: 0).
	aCartId _ interfaceSimulator createCartForClientId: userValid withPassword: passwordValid atMoment: dateAndTime1 .
	
! !

!TestTusLibros methodsFor: 'setUp' stamp: 'Ji 6/15/2017 19:12:07'!
isbnSetUp
	
	anIsbnBook _ 123123.
	anIsbnBook2 := 321321.
	! !

!TestTusLibros methodsFor: 'setUp' stamp: 'Ji 10/26/2017 18:55:42'!
merchantProcessorSetUp
	accountsInfo1 _ Dictionary new.
	accountsInfo1
		at: aCard1
		put: 10.
	accountsInfo2 _ Dictionary new.
	accountsInfo2
		at: aCard1
		put: 50.
	accountsInfo2
		at: aCard2
		put: 60.
	accountsInfo2
		at: aCard3
		put: 70.
	merchantProcessor _ MerchantProcessorSimulator initializeWithBankInfo: accountsInfo1.
	merchantProcessor2 _ MerchantProcessorSimulator initializeWithBankInfo: accountsInfo2.! !

!TestTusLibros methodsFor: 'setUp' stamp: 'Ji 10/26/2017 18:53:58'!
salesBookSetup
	salesBookEmpty _ SalesBook createSalesBook.
	aSalesBook1 _ SalesBook createSalesBook.
	anExactSalesBook1 _ SalesBook createSalesBook.
	anExactSalesBook1
		add: anIsbnBook
		withAmount: 1
		eachWithPrice: 10.
	aSalesBook2 _ SalesBook createSalesBook.
	anExactSalesBook2 _ SalesBook createSalesBook.
	anExactSalesBook2
		add: anIsbnBook
		withAmount: 1
		eachWithPrice: 10.
	anExactSalesBook2
		add: anIsbnBook2
		withAmount: 2
		eachWithPrice: 20.! !

!TestTusLibros methodsFor: 'setUp' stamp: 'Ji 10/26/2017 18:55:42'!
setUp
	self cardSetUp.
	self merchantProcessorSetUp.
	self isbnSetUp.
	self catalogSetUp.
	self shoppingCartsetUp.
	self cashierSetUp.
	self salesBookSetup.
	self interfaceCartsetUp.! !

!TestTusLibros methodsFor: 'setUp' stamp: 'Ji 6/15/2017 19:49:19'!
shoppingCartsetUp
	shoppingCartWithEmptyCatalog _ ShoppingCart initializeWithCatalog: Dictionary new.
	
	shoppingCartWithCatalog1 _ ShoppingCart initializeWithCatalog: catalog1.
	shoppingCartWithCatalog1 add: anIsbnBook.
	shoppingCartWithCatalog1Price _ 10.
	
	shoppingCartWithCatalog2 _ ShoppingCart initializeWithCatalog: catalog2.
	shoppingCartWithCatalog2 add: anIsbnBook .
	shoppingCartWithCatalog2 add: anIsbnBook2 withQuantity:2. 
	shoppingCartWithCatalog2Price _ 50.
! !


!TestTusLibros methodsFor: 'Testing MPSimulator' stamp: 'JI 6/27/2017 17:13:57'!
test014CantChargeIfThePersonDoesntOwnTheCard

	|balance uses |
	balance _ merchantProcessor balanceOfCard: aCard1 .
	uses _ merchantProcessor uses.
	self should: [merchantProcessor charge: 30 to: 'aGhost'  withCard: aCard1 atDate: today]
	raise: Error
	withExceptionDo: [ :anError | self assert: anError messageText = 'La persona no es dueña de la tarjeta'.
		self assert: balance = (merchantProcessor balanceOfCard: aCard1).
		self assert: uses = merchantProcessor uses.
		].! !

!TestTusLibros methodsFor: 'Testing MPSimulator' stamp: 'JI 6/27/2017 17:15:27'!
test015NameCantBeMoreThan30CharLong

	|balance uses |
	balance _ merchantProcessor2 balanceOfCard: aCard3.
	uses _ merchantProcessor2 uses.
	
	self should: [merchantProcessor2 charge: 30 to: owner3  withCard: aCard3  atDate: today ]
	raise: Error
	withExceptionDo: [ :anError | self assert: anError messageText = 'El nombre es demasiado largo'.
		self assert: balance = (merchantProcessor2 balanceOfCard: aCard3).
		self assert: uses  = merchantProcessor2 uses.
		 ].! !

!TestTusLibros methodsFor: 'Testing MPSimulator' stamp: 'JI 6/27/2017 17:15:48'!
test016CardCannotBeDated

	|balance uses |
	balance _ merchantProcessor2 balanceOfCard: aCard2.
	uses _ merchantProcessor uses.
	
	self should: [merchantProcessor2 charge: 30 to: nameOfOwner  withCard: aCard2  atDate: today ]
	raise: Error
	withExceptionDo: [ :anError | self assert: anError messageText = 'La tarjeta esta vencida'.
		self assert: balance = (merchantProcessor2 balanceOfCard: aCard2).
		self assert: uses = merchantProcessor2 uses.
		 ].! !

!TestTusLibros methodsFor: 'Testing MPSimulator' stamp: 'JI 6/27/2017 17:15:57'!
test017CardIsOk

	|balance uses |
	balance _ merchantProcessor2 balanceOfCard: aCard1.
	uses _ merchantProcessor2 uses.
	merchantProcessor2 charge: 30 to: nameOfOwner  withCard: aCard1  atDate: today.
	self assert: balance - 30 = (merchantProcessor2 balanceOfCard: aCard1) .
	self assert: uses + 1 = merchantProcessor2 uses.
! !

!TestTusLibros methodsFor: 'Testing MPSimulator' stamp: 'JI 6/27/2017 17:18:18'!
test017CardIsOkCantChargeIfCardIsInvalid

	| uses |
	
	uses _ merchantProcessor2 uses.

	self should: [merchantProcessor2 charge: 30 to: 'Unknown'  withCard: aCard4  atDate: today.]
	raise: Error
	withExceptionDo: [ :anError | self assert: anError messageText = 'Tarjeta invalida'.
		self assert: uses + 1 = merchantProcessor2 uses.
		] .

	
! !


!TestTusLibros methodsFor: 'Testing Interface' stamp: 'JI 6/27/2017 15:22:11'!
test17CanCreateAnEmptyCart
	| aCartId contentsOfACart |
	aCartId _ interfaceSimulator createCartForClientId: userValid withPassword: passwordValid atMoment: dateAndTime1.
	contentsOfACart _ interfaceSimulator listCart: aCartId atMoment: dateAndTime2.
	self assert: contentsOfACart size = 0.! !

!TestTusLibros methodsFor: 'Testing Interface' stamp: 'JI 6/27/2017 15:22:26'!
test18CanNotCreateAnEmptyCartWithUserOrPasswordInvalid
	| aCartId|
	
	self should: [aCartId _ interfaceSimulator createCartForClientId: 'usuarioNoExite' withPassword: passwordValid atMoment: dateAndTime1 ]
	raise: Error
	withExceptionDo: [ :anError | self assert: anError messageText = 'Usuario inexistente'. 
									self assert: aCartId = nil.
						].
	
	self should: [aCartId _ interfaceSimulator createCartForClientId: userValid withPassword: 'passwordIncorrecta'  atMoment: dateAndTime1]
	raise: Error
	withExceptionDo: [ :anError | self assert: anError messageText = 'Contraseña incorrecta'. 
									self assert: aCartId = nil.
						].
! !

!TestTusLibros methodsFor: 'Testing Interface' stamp: 'JI 6/27/2017 15:23:58'!
test19CanNotListACartWithInvalidId
	| aCartId|
	aCartId _ interfaceSimulator createCartForClientId: userValid withPassword: passwordValid atMoment: dateAndTime1.
	
	self should: [ interfaceSimulator listCart: 'Manteca' atMoment: dateAndTime2]
	raise: Error
	withExceptionDo: [ :anError | self assert: anError messageText = 'Id de carrito inexistente'. ].! !

!TestTusLibros methodsFor: 'Testing Interface' stamp: 'JI 6/27/2017 15:24:25'!
test20CanAddABookToAnEmptyCart
	| aCartId contentsOfShoppingCart |
	aCartId _ interfaceSimulator createCartForClientId: userValid withPassword: passwordValid atMoment: dateAndTime1 .
	interfaceSimulator addToCart: aCartId withBook: anIsbnBook  withQuantity: 1 atMoment: dateAndTime2 .
	contentsOfShoppingCart := interfaceSimulator listCart: aCartId atMoment: dateAndTime2.
	self assert: (contentsOfShoppingCart includes: anIsbnBook) .! !

!TestTusLibros methodsFor: 'Testing Interface' stamp: 'JI 6/27/2017 15:24:58'!
test21CanNotAddABookToANonExistentCart
	| aCartId |
	aCartId _ interfaceSimulator createCartForClientId: userValid withPassword: passwordValid atMoment: dateAndTime1 .
	
	self should: [ interfaceSimulator addToCart: 'Manteca' withBook: anIsbnBook withQuantity: 2 atMoment: dateAndTime2]
	raise: Error
	withExceptionDo: [ :anError | self assert: anError messageText = 'Id de carrito inexistente'. ].! !

!TestTusLibros methodsFor: 'Testing Interface' stamp: 'Ji 10/26/2017 18:53:58'!
test22CheckOutCart
	| aCartId |
	aCartId _ interfaceSimulator
		createCartForClientId: userValid
		withPassword: passwordValid
		atMoment: dateAndTime1.
	interfaceSimulator
		addToCart: aCartId
		withBook: anIsbnBook
		withQuantity: 1
		atMoment: dateAndTime2.
	interfaceSimulator
		addToCart: aCartId
		withBook: anIsbnBook2
		withQuantity: 2
		atMoment: dateAndTime2.
	interfaceSimulator
		checkOutCart: aCartId
		creditNumber: aCard1 number
		expireAt: '012020'
		from: aCard1 owner
		atMoment: dateAndTime2.
	self assert: aSalesBook2 = anExactSalesBook2.! !

!TestTusLibros methodsFor: 'Testing Interface' stamp: 'JI 6/27/2017 15:26:51'!
test23CanNotCheckOutCartTwiceOrMore
	| aCartId |
	aCartId _ interfaceSimulator createCartForClientId: userValid withPassword: passwordValid atMoment: dateAndTime1.
	interfaceSimulator addToCart: aCartId withBook: anIsbnBook  withQuantity: 1 atMoment: dateAndTime2.
	interfaceSimulator addToCart: aCartId withBook: anIsbnBook2  withQuantity: 2 atMoment: dateAndTime2.
	interfaceSimulator checkOutCart: aCartId creditNumber: (aCard1 number) expireAt: '012020' from: (aCard1 owner) atMoment: dateAndTime2.
	
	self should: [ interfaceSimulator checkOutCart: aCartId creditNumber: (aCard1 number) expireAt: '012020' from: (aCard1 owner) atMoment: dateAndTime2]
	raise: Error
	withExceptionDo: [ :anError | self assert: anError messageText = 'Id de carrito inexistente'. ].
! !

!TestTusLibros methodsFor: 'Testing Interface' stamp: 'JI 6/27/2017 15:27:05'!
test24CheckOutCartAndListPurchases
	| aCartId contentsOfPurchases |
	aCartId _ interfaceSimulator createCartForClientId: userValid withPassword: passwordValid atMoment: dateAndTime1.
	interfaceSimulator addToCart: aCartId withBook: anIsbnBook  withQuantity: 1 atMoment: dateAndTime2.
	interfaceSimulator addToCart: aCartId withBook: anIsbnBook2  withQuantity: 2 atMoment: dateAndTime2.
	interfaceSimulator checkOutCart: aCartId creditNumber: (aCard1 number) expireAt: '012020' from: (aCard1 owner) atMoment: dateAndTime2.
	
	contentsOfPurchases _ interfaceSimulator listPurchases: aCartId clientId: userValid withPassword: passwordValid atMoment: dateAndTime2.
	
	self assert: (contentsOfPurchases includes: anIsbnBook ).
	self assert: (contentsOfPurchases includes: anIsbnBook2 ).
! !

!TestTusLibros methodsFor: 'Testing Interface' stamp: 'JI 6/27/2017 15:43:31'!
test25CantUseCartAfter30MinutosOfNotUsingIt
		
	self should: [interfaceSimulator listCart: aCartId atMoment: dateAndTime3] 
	raise: Error
	withExceptionDo: [ :anError | self assert: anError messageText = 'Carrito invalido por no usarlo en 30 minutos'.].
	
	self should: [interfaceSimulator addToCart: aCartId withBook: anIsbnBook  withQuantity: 1 atMoment: dateAndTime3] 
	raise: Error
	withExceptionDo: [ :anError | self assert: anError messageText = 'Carrito invalido por no usarlo en 30 minutos'.].
	
	self should: [interfaceSimulator checkOutCart: aCartId creditNumber: (aCard1 number) expireAt: '012020' from: (aCard1 owner) atMoment: dateAndTime3] 
	raise: Error
	withExceptionDo: [ :anError | self assert: anError messageText = 'Carrito invalido por no usarlo en 30 minutos'.].
	
	interfaceSimulator createCartForClientId: userValid withPassword: passwordValid atMoment: dateAndTime1 .
	interfaceSimulator addToCart: aCartId withBook: anIsbnBook  withQuantity: 1 atMoment: dateAndTime2.
	self shouldnt: [interfaceSimulator addToCart: aCartId withBook: anIsbnBook  withQuantity: 1 atMoment: dateAndTime3.] raise: Error.
	self shouldnt: [interfaceSimulator listCart: aCartId atMoment: dateAndTime3.] raise: Error.
	self shouldnt: [interfaceSimulator checkOutCart: aCartId creditNumber: (aCard1 number) expireAt: '012020' from: (aCard1 owner) atMoment: dateAndTime3.] raise: Error.
	
	interfaceSimulator createCartForClientId: userValid withPassword: passwordValid atMoment: dateAndTime1 .
	interfaceSimulator addToCart: aCartId withBook: anIsbnBook  withQuantity: 1 atMoment: dateAndTime2.
	self should: [interfaceSimulator checkOutCart: aCartId creditNumber: (aCard1 number) expireAt: '012020' from: (aCard1 owner) atMoment: dateAndTime4.] 
	raise: Error
	withExceptionDo: [ :anError | self assert: anError messageText = 'Carrito invalido por no usarlo en 30 minutos'.].



! !


!classDefinition: #Cashier category: #'TusLibros-Solution'!
Object subclass: #Cashier
	instanceVariableNames: 'catalog merchantProcessorSimulator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!Cashier methodsFor: 'initialization' stamp: 'JI 6/15/2017 14:12:16'!
initializeWithCatalog: aCatalog
	 catalog _ aCatalog! !

!Cashier methodsFor: 'initialization' stamp: 'JI 6/22/2017 16:36:19'!
initializeWithCatalog: aCatalog withMerchantProcessorSimulator: merchantProcessor
	catalog _ aCatalog.
	merchantProcessorSimulator _ merchantProcessor .! !


!Cashier methodsFor: 'checkOut' stamp: 'JI 6/15/2017 14:30:07'!
checkOut: aShoppingCart
	| total |
	aShoppingCart isEmpty ifTrue: [self error: (self class cannotCheckOutEmptyCart)].
	
	total _ 0.
	aShoppingCart contents do: [ :aBook | total _ total + (self checkoutItem: aBook)].
	
	^total.! !

!Cashier methodsFor: 'checkOut' stamp: 'JAK 6/17/2017 19:07:20'!
checkOut: aShoppingCart withCard: aCard asTodayBeing: aDate
	
	(aCard isNotExpiredAt: aDate)
	ifTrue:[	^self checkOut: aShoppingCart ] ifFalse:[self error: self class cannotCheckOutWithDatedCard].
	! !

!Cashier methodsFor: 'checkOut' stamp: 'JI 6/22/2017 17:11:57'!
checkOut: aShoppingCart withCard: aCreditCard asTodayBeing: aDate withSalesBook: aSalesBook 
	
	|total|
	total _ self checkOut: aShoppingCart withCard: aCreditCard  asTodayBeing: aDate .
	merchantProcessorSimulator charge: total to: aCreditCard owner withCard: aCreditCard  atDate: aDate.
	aShoppingCart contents do: [ :anItem | aSalesBook addItem: anItem withPrice: (catalog at: anItem )].
	^total! !

!Cashier methodsFor: 'checkOut' stamp: 'JI 6/15/2017 14:30:42'!
checkoutItem: aBook 
	
	^self checkoutItem: aBook withAmount: 1! !

!Cashier methodsFor: 'checkOut' stamp: 'JI 6/15/2017 14:10:34'!
checkoutItem: aBook withAmount: anAmount
	
	^ (catalog at: aBook) * anAmount ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #'TusLibros-Solution'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'errors' stamp: 'Ji 6/13/2017 21:47:39'!
cannotCheckOutEmptyCart
	^'No se puede hacer checkout de un carrito vacio'! !

!Cashier class methodsFor: 'errors' stamp: 'Ji 6/15/2017 19:46:39'!
cannotCheckOutWithDatedCard
	^'La tarjeta esta vencida'! !


!Cashier class methodsFor: 'initialization' stamp: 'JI 6/15/2017 14:11:38'!
initializeWithCatalog: aCatalog 
	^self new initializeWithCatalog: aCatalog ! !

!Cashier class methodsFor: 'initialization' stamp: 'JI 6/22/2017 16:34:46'!
initializeWithCatalog: aCatalog withMerchantProcessorSimulator: merchantProcessor.
	^self new initializeWithCatalog: aCatalog withMerchantProcessorSimulator: merchantProcessor.! !


!classDefinition: #CreditCard category: #'TusLibros-Solution'!
Object subclass: #CreditCard
	instanceVariableNames: 'nameInTheCard numberInTheCard expiredAt'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!CreditCard methodsFor: 'initialization' stamp: 'JAK 6/17/2017 19:41:55'!
initializeForOwner: nameOfOwner withNumber: numberOfPlastic expiredAt: expiredDate
	
	(nameOfOwner size) = 0 ifTrue: [self error: (self class canNotCreateCreditCardWithoutOwner)].
	(numberOfPlastic printString size) ~= 16 ifTrue: [self error: (self class digitsMustBeExactly16)].
	nameInTheCard _ nameOfOwner .
	numberInTheCard _ numberOfPlastic .
	expiredAt _ expiredDate .! !


!CreditCard methodsFor: 'inspecting' stamp: 'JAK 6/17/2017 19:10:39'!
isNotExpiredAt: aDate

	^ (expiredAt yearNumber > aDate yearNumber) or: [(expiredAt yearNumber = aDate yearNumber) and: [expiredAt monthIndex >= aDate monthIndex] ]
	! !

!CreditCard methodsFor: 'inspecting' stamp: 'JAK 6/26/2017 23:55:03'!
number
	^numberInTheCard ! !

!CreditCard methodsFor: 'inspecting' stamp: 'JI 6/20/2017 17:19:33'!
owner
	^nameInTheCard ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #'TusLibros-Solution'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'initialization' stamp: 'JAK 6/17/2017 19:39:16'!
initializeForOwner: nameOfOwner withNumber: numberOfPlastic expiredAt: expiredDate

	^self new initializeForOwner: nameOfOwner withNumber: numberOfPlastic expiredAt: expiredDate.! !


!CreditCard class methodsFor: 'errors' stamp: 'JAK 6/17/2017 19:31:36'!
canNotCreateCreditCardWithoutOwner
	^'El nombre no puede ser vacio'! !

!CreditCard class methodsFor: 'errors' stamp: 'JAK 6/17/2017 19:32:01'!
digitsMustBeExactly16
	^'Los digitos deben ser 16 exactos'! !


!classDefinition: #InterfaceSimulator category: #'TusLibros-Solution'!
Object subclass: #InterfaceSimulator
	instanceVariableNames: 'users catalog merchant listOfCarts salesBook cashier today credit listOfFinishedCarts timeOfCarts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!InterfaceSimulator methodsFor: 'operating' stamp: 'JI 6/27/2017 15:37:04'!
addToCart: anIdCart withBook: anIsbnBook withQuantity: quantity atMoment: aMoment

	| aCart |
	aCart _ self getCartOrRaiseError: anIdCart.
	self raiseErrorIfTimedOutCart: anIdCart atMoment: aMoment .
	self restartCart: anIdCart toMoment: aMoment .
	aCart add: anIsbnBook withQuantity: quantity .! !

!InterfaceSimulator methodsFor: 'operating' stamp: 'JI 6/27/2017 15:37:35'!
checkOutCart: anIdCart creditNumber: creditNumber expireAt: expirationDate from: owner atMoment: aMoment

	| aCart |
	aCart _ self getCartOrRaiseError: anIdCart.
	self raiseErrorIfTimedOutCart: anIdCart atMoment: aMoment .
	self restartCart: anIdCart toMoment: aMoment .
	listOfFinishedCarts at:anIdCart put: aCart.
	cashier checkOut: aCart withCard: credit asTodayBeing: today withSalesBook: salesBook .
	listOfCarts removeKey: anIdCart .! !

!InterfaceSimulator methodsFor: 'operating' stamp: 'JI 6/27/2017 15:04:35'!
createCartForClientId: aClientId withPassword: aPassword atMoment: aMoment

	self validateUser: aClientId withPassword: aPassword.
	listOfCarts at: aClientId put: (ShoppingCart initializeWithCatalog: catalog).
	timeOfCarts at: aClientId put: aMoment .
	^ aClientId .! !

!InterfaceSimulator methodsFor: 'operating' stamp: 'JI 6/27/2017 15:37:56'!
listCart: anIdCart atMoment: aMoment

	| aCart |
	
	aCart _ self getCartOrRaiseError: anIdCart.
	self raiseErrorIfTimedOutCart: anIdCart atMoment: aMoment .
	self restartCart: anIdCart toMoment: aMoment .
	^aCart contents copy.! !

!InterfaceSimulator methodsFor: 'operating' stamp: 'JI 6/27/2017 15:38:01'!
listPurchases: anIdCart clientId: aClientId withPassword: aPassword atMoment: aMoment
	| aCart |
	
	self validateUser: aClientId withPassword: aPassword.
	aCart _ self getFinishedCartOrRaiseError: anIdCart .
	self raiseErrorIfTimedOutCart: anIdCart atMoment: aMoment .
	self restartCart: anIdCart toMoment: aMoment .
	^aCart contents copy.! !

!InterfaceSimulator methodsFor: 'operating' stamp: 'JI 6/27/2017 15:37:24'!
restartCart: anIdCart toMoment: aMoment 

	timeOfCarts at: anIdCart put: aMoment .! !


!InterfaceSimulator methodsFor: 'initialization' stamp: 'JI 6/27/2017 15:11:12'!
initializeWithUserAndPassword: userPassDict andCatalog: aCatalog andCreditCard: creditCard andMerchantProcessor: aMerchant withSalesBook: aSalesBook withCashier: aCashier asToday: now
	users _ userPassDict .
	catalog _ aCatalog .
	merchant _ aMerchant .
	salesBook _ aSalesBook .
	cashier _ aCashier .
	today _ now.
	credit _ creditCard .
	listOfCarts _ Dictionary new.
	listOfFinishedCarts _ Dictionary new.
	timeOfCarts _ Dictionary new.! !


!InterfaceSimulator methodsFor: 'data validation' stamp: 'JAK 6/26/2017 23:51:51'!
getCartOrRaiseError: anIdCart
	
	| aCart |
	aCart _ listOfCarts at: anIdCart ifAbsent: [self error: self class cartIdDoesNotExist] .
	^aCart.! !

!InterfaceSimulator methodsFor: 'data validation' stamp: 'JAK 6/27/2017 00:29:38'!
getFinishedCartOrRaiseError: anIdCart
	
	| aCart |
	aCart _ listOfFinishedCarts at: anIdCart ifAbsent: [self error: self class cartIdDoesNotExist] .
	^aCart.! !

!InterfaceSimulator methodsFor: 'data validation' stamp: 'JI 6/27/2017 15:18:30'!
raiseErrorIfTimedOutCart: anIdCart atMoment: aMoment 

	(aMoment -(timeOfCarts at: anIdCart) >= (Duration minutes: 30) ) ifTrue: [ ^self error: 'Carrito invalido por no usarlo en 30 minutos'].
	! !

!InterfaceSimulator methodsFor: 'data validation' stamp: 'JAK 6/27/2017 00:23:27'!
validateUser: aClientId withPassword: aPassword
	
	| password |
	password _ users at: aClientId ifAbsent: [self error: self class userDoesNotExist].
	password = aPassword ifFalse: [self error: self class passwordDoesNotMatch].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InterfaceSimulator class' category: #'TusLibros-Solution'!
InterfaceSimulator class
	instanceVariableNames: ''!

!InterfaceSimulator class methodsFor: 'class initialization' stamp: 'JAK 6/27/2017 00:11:22'!
initializeWithUserAndPassword: userPassDict andCatalog: aCatalog andCreditCard: creditCard andMerchantProcessor: aMerchant withSalesBook: aSalesBook withCashier: aCashier asToday: now
	^self new initializeWithUserAndPassword: userPassDict andCatalog: aCatalog andCreditCard: creditCard andMerchantProcessor: aMerchant withSalesBook: aSalesBook withCashier: aCashier asToday: now! !


!InterfaceSimulator class methodsFor: 'errors' stamp: 'JAK 6/26/2017 23:25:05'!
cartIdDoesNotExist
	^'Id de carrito inexistente'! !

!InterfaceSimulator class methodsFor: 'errors' stamp: 'JAK 6/26/2017 23:12:44'!
passwordDoesNotMatch
	^'Contraseña incorrecta'! !

!InterfaceSimulator class methodsFor: 'errors' stamp: 'JAK 6/26/2017 23:11:34'!
userDoesNotExist
	^'Usuario inexistente'! !


!classDefinition: #MerchantProcessorSimulator category: #'TusLibros-Solution'!
Object subclass: #MerchantProcessorSimulator
	instanceVariableNames: 'uses validCards invalidCards listOfValidCreditCards'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!MerchantProcessorSimulator methodsFor: 'operating' stamp: 'JI 6/27/2017 16:47:32'!
charge: anAmount to: anOwner withCard: aCreditCard atDate: aDate
	
	self checkOwnerNameSize: anOwner .
	self checkOwner: anOwner toOwn: aCreditCard .
	self checkCardIsNotDated: aCreditCard atDate: aDate.
	self increaseUses.
	self chargeAmount: anAmount toCard: aCreditCard .! !

!MerchantProcessorSimulator methodsFor: 'operating' stamp: 'JI 6/27/2017 17:11:14'!
chargeAmount: anAmount toCard: aCreditCard
	
	| balance | 
	
	balance _ listOfValidCreditCards at: aCreditCard ifAbsent: [self error: 'Tarjeta invalida'].
	anAmount > balance  ifTrue: [ self error: 'No hay suficiente dinero en el banco'].
	listOfValidCreditCards at: aCreditCard put: balance - anAmount . ! !

!MerchantProcessorSimulator methodsFor: 'operating' stamp: 'JI 6/20/2017 17:30:18'!
checkCardIsNotDated: aCreditCard atDate: aDate

	(aCreditCard isNotExpiredAt: aDate) ifFalse: [ self error: 'La tarjeta esta vencida']! !

!MerchantProcessorSimulator methodsFor: 'operating' stamp: 'JI 6/20/2017 17:18:24'!
checkOwner: anOwner toOwn: aCreditCard 
	
	aCreditCard owner = anOwner ifFalse: [self error: 'La persona no es dueña de la tarjeta']! !

!MerchantProcessorSimulator methodsFor: 'operating' stamp: 'JI 6/20/2017 17:24:20'!
checkOwnerNameSize: anOwner

	anOwner size <= 30 ifFalse: [ self error: 'El nombre es demasiado largo']


! !


!MerchantProcessorSimulator methodsFor: 'internal behaviour for simulate' stamp: 'JI 6/27/2017 16:58:23'!
balanceOfCard: aCard
	
	^ listOfValidCreditCards at: aCard .! !

!MerchantProcessorSimulator methodsFor: 'internal behaviour for simulate' stamp: 'JI 6/22/2017 16:23:38'!
increaseUses

	uses _ uses +1.
	! !

!MerchantProcessorSimulator methodsFor: 'internal behaviour for simulate' stamp: 'JI 6/22/2017 16:24:55'!
uses 
	^uses! !


!MerchantProcessorSimulator methodsFor: 'initialization' stamp: 'JI 6/27/2017 16:53:44'!
initializeWithBankInfo: accountsInfo
	
	uses _ 0.
	listOfValidCreditCards _ accountsInfo.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorSimulator class' category: #'TusLibros-Solution'!
MerchantProcessorSimulator class
	instanceVariableNames: ''!

!MerchantProcessorSimulator class methodsFor: 'class initialization' stamp: 'JI 6/27/2017 16:54:09'!
initializeWithBankInfo: accountsInfo
	^self new initializeWithBankInfo: accountsInfo ! !


!classDefinition: #SalesBook category: #'TusLibros-Solution'!
Object subclass: #SalesBook
	instanceVariableNames: 'books prices'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!SalesBook methodsFor: 'inspecting' stamp: 'JI 6/18/2017 22:21:38'!
books
	^ books copy! !

!SalesBook methodsFor: 'inspecting' stamp: 'JI 6/19/2017 00:29:09'!
isEmpty
	^ books size = 0! !

!SalesBook methodsFor: 'inspecting' stamp: 'JI 6/18/2017 22:21:50'!
prices
	^ prices copy! !


!SalesBook methodsFor: 'comparing' stamp: 'JI 6/19/2017 00:21:01'!
= anotherSalesBook

	| myBooks theirBooks myPrices theirPrices |

	myBooks _ books copy.
	theirBooks _ anotherSalesBook books.
	myPrices _ prices copy.
	theirPrices _ anotherSalesBook prices.
	
	myBooks size = theirBooks size ifFalse: [^false].
	
	
	(1 to: books size) do: [ :index | | myBook myAmount myPrice match matchIndex|
		myBook _ books at: index.
		myPrice _ prices at: index.
		match _ false.		
		
		(1 to: theirBooks size) do: [ :theirIndex | | theirBook theirAmount theirPrice|
			theirBook _ theirBooks at: theirIndex .
			
			theirPrice _ theirPrices at: theirIndex .
			
			(theirBook = myBook and: [  theirPrice = myPrice ] ) ifTrue: [
				match _ true.
				matchIndex _ theirIndex .
				]
			].
		match 
		ifTrue: [
			theirBooks	removeAt: matchIndex.
			theirPrices removeAt: matchIndex .
			]
		ifFalse: [^false].
		].
	
	^true.
	! !


!SalesBook methodsFor: 'adding' stamp: 'JI 6/19/2017 00:02:14'!
add: aBook withAmount: anAmount eachWithPrice: aPrice
	
	(1 to: anAmount) do: [ :i | self addItem: aBook withPrice: aPrice]
	! !

!SalesBook methodsFor: 'adding' stamp: 'JI 6/19/2017 00:19:58'!
addItem: anItem withPrice: aPrice

	books add: anItem.
	prices add: aPrice.! !


!SalesBook methodsFor: 'initialization' stamp: 'JI 6/19/2017 00:19:42'!
createSalesBook
	books _ OrderedCollection new.
	prices _ OrderedCollection new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SalesBook class' category: #'TusLibros-Solution'!
SalesBook class
	instanceVariableNames: ''!

!SalesBook class methodsFor: 'initialization' stamp: 'JI 6/18/2017 22:15:08'!
createSalesBook
	^self new createSalesBook! !


!classDefinition: #ShoppingCart category: #'TusLibros-Solution'!
Object subclass: #ShoppingCart
	instanceVariableNames: 'collectionOfElements catalogo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!ShoppingCart methodsFor: 'inspecting' stamp: 'Ji 6/13/2017 21:32:37'!
contents
	^collectionOfElements copy! !

!ShoppingCart methodsFor: 'inspecting' stamp: 'JAK 6/10/2017 19:04:20'!
isEmpty
	^collectionOfElements isEmpty .! !

!ShoppingCart methodsFor: 'inspecting' stamp: 'JI 6/15/2017 14:39:00'!
occurrencesOf: aBook 
	
^collectionOfElements contents at:aBook ifAbsent: [0]! !

!ShoppingCart methodsFor: 'inspecting' stamp: 'Ji 6/13/2017 21:33:49'!
quantity: anElement 

	^collectionOfElements occurrencesOf: anElement
! !


!ShoppingCart methodsFor: 'operating' stamp: 'JAK 6/10/2017 19:55:49'!
add: anElement
	self add: anElement withQuantity: 1.! !

!ShoppingCart methodsFor: 'operating' stamp: 'JI 6/15/2017 14:20:36'!
add: anElement withQuantity: quantity
	
	quantity isInteger ifFalse: [self error: (self class canNotAddNotIntegerQuantity) ].
	quantity < 1 ifTrue: [self error: (self class canNotAddLessThanOneBook )].
	(catalogo includesKey: anElement) ifFalse: [self error: (self class canNotAddABookThatIsNotInTheCatalog) ].
	
	collectionOfElements add: anElement withOccurrences: quantity .! !


!ShoppingCart methodsFor: 'initialization' stamp: 'Ji 6/13/2017 21:25:17'!
initializeWithCatalog: aCatalog 
	
	collectionOfElements _ Bag new.
	catalogo _ aCatalog.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ShoppingCart class' category: #'TusLibros-Solution'!
ShoppingCart class
	instanceVariableNames: ''!

!ShoppingCart class methodsFor: 'initialization' stamp: 'Ji 6/13/2017 21:24:50'!
initializeWithCatalog: aCatalog 
	
	^ self new initializeWithCatalog: aCatalog! !


!ShoppingCart class methodsFor: 'errors' stamp: 'Ji 6/13/2017 21:41:36'!
canNotAddABookThatIsNotInTheCatalog
	^'No se puede agregar libro'! !

!ShoppingCart class methodsFor: 'errors' stamp: 'jak 6/13/2017 16:23:03'!
canNotAddLessThanOneBook
	^'No se puede agregar menos de un libro'! !

!ShoppingCart class methodsFor: 'errors' stamp: 'Ji 6/13/2017 21:40:17'!
canNotAddNotIntegerQuantity
	^'No se puede agregar una cantidad no entera de libros'! !
