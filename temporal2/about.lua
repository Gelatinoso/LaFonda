
-----------------------------------------------------------------------------------------
--
-- view1.lua
--
-----------------------------------------------------------------------------------------

local composer = require "composer" 
local tabBar = require "tabBar"
local widget = require "widget"
local color = require "convertcolor"
local LaFonda = require "APIConsumer"
local inspect = require "inspect"
local globalVariables = require "globalVariables"
local scene = composer.newScene()



function scene:create( event )
	local sceneGroup = self.view
	
	tabBar.isVisible=true

	local sceneGroup = self.view

    tabBar.isVisible = true

    local backgroundTab = display.newRect(display.contentCenterX, 38, display.contentWidth, 50)
    backgroundTab:setFillColor(color.hex("E4640D"))

    local background = display.newRect( display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
    background:setFillColor( 1 )
    
    local nombre = display.newText("Nombre de establecimiento: "..globalVariables.Establishment.Name,12, display.contentCenterY - 80, native.systemFont, 16)
    nombre:setFillColor(0)

    local telefono = display.newText("Número de telefono: "..globalVariables.Establishment.PhoneNumber,12, nombre.y + 30, native.systemFont, 16)
    telefono:setFillColor(0)

    local direccion = display.newText("Dirección: "..globalVariables.Establishment.Address,12, telefono.y + 30, native.systemFont, 16)
    direccion:setFillColor(0)

    local descripcion = display.newText("Información: "..globalVariables.Establishment.Description,12, direccion.y + 30, native.systemFont, 16)
    descripcion:setFillColor(0)

    local version = display.newText("Versión de software 1.00(Beta)",12, display.contentCenterY + 120, native.systemFont, 16)
    descripcion:setFillColor(0)
    
    local disclaimer = display.newText("©2019 LaFonda.com All Rights Reserved",12, 490, native.systemFont, 14)
    disclaimer:setFillColor(color.hex("999999"))
    
    local acercaDe = display.newText("Acerca de...",12, 45, native.systemFont, 40)
    acercaDe:setFillColor(1)


    nombre.anchorX = 0
    telefono.anchorX = 0
    direccion.anchorX = 0
    descripcion.anchorX = 0
    version.anchorX = 0
    disclaimer.anchorX = 0
    acercaDe.anchorX = 0

    sceneGroup:insert(background)
    sceneGroup:insert(backgroundTab)
    sceneGroup:insert(nombre)
    sceneGroup:insert(telefono)
    sceneGroup:insert(direccion)
    sceneGroup:insert(descripcion)
    sceneGroup:insert(version)
    sceneGroup:insert(acercaDe)
    sceneGroup:insert(disclaimer)

end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
	
	elseif phase == "did" then
		
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
	
	elseif phase == "did" then
		
	end
end

function scene:destroy( event )
	local sceneGroup = self.view

end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene