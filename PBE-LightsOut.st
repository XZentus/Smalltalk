SimpleSwitchMorph subclass: #LOCell
	instanceVariableNames: 'mouseAction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PBE-LightsOut'!
!LOCell commentStamp: 'Nex 7/18/2017 11:26' prior: 0!
Simple Cell class

    Instance Variables
	mouseAction:		<Object>


    Implementation Points!


!LOCell methodsFor: 'accessing' stamp: 'Nex 7/18/2017 15:14'!
mouseAction: aBlock
	^ mouseAction := aBlock! !


!LOCell methodsFor: 'initialization' stamp: 'Nex 7/18/2017 11:36'!
initialize
	super initialize .
	self label: '' .
	self borderWidth: 2 .
	bounds := 0 @ 0 corner: 16 @ 16 .
	offColor := Color paleYellow .
	onColor := Color paleBlue darker .
	self useSquareCorners .
	self turnOff! !


!LOCell methodsFor: 'event handling' stamp: 'Nex 7/18/2017 15:15'!
mouseUp: anEvent
	mouseAction value! !

!LOCell methodsFor: 'event handling' stamp: 'Nex 7/18/2017 16:38'!
mouseMove: anEvent! !


BorderedMorph subclass: #LOGame
	instanceVariableNames: 'cells'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PBE-LightsOut'!
!LOGame commentStamp: 'Nex 7/18/2017 12:51' prior: 0!
Main game class!


!LOGame methodsFor: 'accessing' stamp: 'Nex 7/18/2017 12:48'!
cellPerSide
	"The number of cell along each side of the game"
	^ 10! !


!LOGame methodsFor: 'instance creation' stamp: 'Nex 7/18/2017 16:22'!
newCellAt: i at: j
	"Create a cell for position (i,j) and add it to my on-screen
		representation at the appropriate screen position. Answer the
		new cell"

	| c origin |
	c := LOCell new .
	origin := self innerBounds origin .
	self addMorph: c .
	c position: ((i - 1) * c width) @ ((j - 1) * c height) + origin .
	c mouseAction: [ self toggleNeighboursOfCellAt: i at: j ] .
	^ c! !


!LOGame methodsFor: 'game logic' stamp: 'Nex 7/18/2017 15:05'!
toggleNeighboursOfCellAt: i at: j
	i > 1
		ifTrue: [ (cells at: i - 1 at: j) toggleState ] .
	i < self cellPerSide 
		ifTrue: [ (cells at: i + 1 at: j) toggleState ] .
	j > 1
		ifTrue: [ (cells at: i at: j - 1) toggleState ] .
	j < self cellPerSide
		ifTrue: [ (cells at: i at: j + 1) toggleState ]! !


!LOGame methodsFor: 'initialization' stamp: 'Nex 7/18/2017 15:12'!
initialize
	| sampleCell width height n |
	super initialize .
	n := self cellPerSide .
	sampleCell := LOCell new .
	width := sampleCell width .
	height := sampleCell height .
	self bounds: ( 5 @ 5 extent: (width * n) @ (height * n) + (2 * self borderWidth)) .
	cells := Matrix new: n tabulate: [ :i :j | self newCellAt: i at: j ]! !
