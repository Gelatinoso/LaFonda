-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- show default status bar (iOS)
display.setStatusBar( display.DefaultStatusBar )
-- include Corona's "widget" library
local LaFonda = require "APIConsumer"
local composer = require "composer"
local tabBar = require "tabBar"

LaFonda.setDomain("localhost")
composer.gotoScene("login")