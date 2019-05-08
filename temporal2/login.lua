-----------------------------------------------------------------------------------------
--
-- login.lua
--
-----------------------------------------------------------------------------------------
local color = require("convertcolor")
local composer = require( "composer" )
local tabBar = require("tabBar")
local widget = require("widget")
local composer = require ("composer")
local LaFonda = require ("APIConsumer")
local crypto = require ("crypto")
local sceneManager = require ("sceneControl")
local globalVariable = require "globalVariables"
local scene = composer.newScene()

function scene:create( event )
    local sceneGroup = self.view

    local image = display.newImageRect( "mosaic_wide.png", 1024, 552 )
    image.x = display.contentCenterX
    image.y = display.contentCenterY

    local AppLogo= display.newImage( "logo.png" )
    AppLogo.x = 287
    AppLogo.y = display.contentCenterY 

    tabBar.isVisible = false

    FieldName = native.newTextField( 800, display.contentCenterY -120, 350, 36 )
    FieldName.inputType = "default"

    FieldPass = native.newTextField( 800, display.contentCenterY , 350, 36 )
    FieldPass.inputType = "default"

    local txtUsuario = display.newText("Número de establecimiento", FieldName.x, FieldName.y -35, native.systemFont, 16 )
    txtUsuario:setFillColor(color.hex("ffffff"))

    local txtPass = display.newText("Contraseña", FieldPass.x, FieldPass.y -35, native.systemFont, 16)
    txtPass:setFillColor(color.hex("ffffff"))

    local txtStatus = display.newText(" ", FieldPass.x, FieldPass.y +90, native.systemFont, 16)
    txtStatus:setFillColor(color.hex("ffffff"))
    
    local disclaimer = display.newText("©2019 LaFonda.com All Rights Reserved",12, 490, native.systemFont, 14)
    disclaimer:setFillColor(color.hex("999999"))
    disclaimer.x = 800


    local function Login()
        Establishment = LaFonda.getResponse()
        if (Establishment == nil) then
           -- summary.text = "CARGANDO" -- Poner pantalla de carga aqui
            timer.performWithDelay( 1, Login)
        else
            if (Establishment.Error == false or Establishment.Error == nil) then
                globalVariable.Establishment = Establishment
                txtStatus.text = Establishment.Name -- Todo good
                sceneManager.setScene("view1", {effect = "slideUp", time=400}, "login")
            else
                if(Establishment.Message == "ELEMENT NOT FOUND") then
                    txtStatus.text = "Número y/o contraseña invalidos"
                end
            end
        end
    end

    local function handleButtonEvent(event)
        if("ended" == event.phase) then
            if(FieldName.text == "" or FieldPass.text == "") then
                txtStatus.text = "Usuario y/o contraseña vacio"
            else
               
                LaFonda.getEstablishment(FieldName.text, crypto.digest(crypto.sha256, FieldPass.text))
                Login()
            end
        end
    end

    local btnAccept = widget.newButton({
        id = "buttonAccept",
        label = "Iniciar sesión",
        left = FieldPass.x - 85,
        top = FieldPass.y +30,
        onEvent = handleButtonEvent
    })  

	-- all objects must be added to group (e.g. self.view)
    sceneGroup:insert( image )
    sceneGroup:insert( AppLogo )
    sceneGroup:insert( FieldName )
    sceneGroup:insert( FieldPass )
    sceneGroup:insert( txtUsuario )
    sceneGroup:insert( txtPass )
    sceneGroup:insert( txtStatus )
    sceneGroup:insert( btnAccept )
    sceneGroup:insert( disclaimer )
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
    
    FieldName:removeSelf()
    FieldPass:removeSelf()
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene