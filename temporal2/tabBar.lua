local composer = require "composer"
local widget = require "widget"
local color = require "convertcolor"


-- event listeners for tab buttons:
local function onFirstView( event )
	composer.gotoScene( "view1" )
end

local function onSecondView( event )
	composer.gotoScene("view2")
end

local function onThirdView(event)
	composer.gotoScene("about")
end

-- create a tabBar widget with two buttons at the bottom of the screen

local tabButtons = {
	{
		label="",
		labelColor = { default = { color.hex("FFFFFF") }, over = { color.hex("000000") } },
		labelYOffset = 1,
		defaultFile="inbound.png",
		overFile="inbound.png",
		width = 32,
		height = 32,
		onPress=onFirstView,
		selected=true
	},
	{
		label="",
		labelColor = { default = { color.hex("FFFFFF") }, over = { color.hex("000000") } },
		labelYOffset = 1,
		defaultFile="outbound.png",
		overFile="outbound.png",
		width = 32,
		height = 32,
		onPress=onSecondView,
	},
	{
		label="",
		labelColor = { default = { color.hex("FFFFFF") }, over = { color.hex("000000") } },
		labelYOffset = 1,
		defaultFile="info.png",
		overFile="info.png",
		width = 32,
		height = 32,
		onPress=onThirdView,
	}
}

-- create the actual tabBar widget
local tabBar = widget.newTabBar{
	top = display.contentHeight - 50,
	height = 50,
	backgroundFile = "tabBar.png",
	tabSelectedLeftFile = "tabBarSelected.png",
	tabSelectedRightFile = "tabBarSelected.png",
	tabSelectedMiddleFile = "tabBarSelected.png",
	tabSelectedFrameWidth = 40,
	tabSelectedFrameHeight = 120,
	buttons = tabButtons
}

return tabBar