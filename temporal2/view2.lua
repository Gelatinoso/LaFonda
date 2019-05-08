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
local nPedidos = 0
local txtY = 90
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	
	tabBar.isVisible=true

	local backgroundTab = display.newRect(display.contentCenterX, 38, display.contentWidth, 50)

	local background = display.newRect( display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
	background:setFillColor( 1 )	-- white

	local txtPedidos = display.newText("Pedidos totales:", 79, 45, native.systemFont, 16)
	txtPedidos:setFillColor(1)

	local numPedidos = display.newText(nPedidos, 180, 45, native.systemFont, 16)
	numPedidos:setFillColor(1)

	local function onRowRender(event) --Función usada para agregar columnas a tableView
		local row = event.row
		local params = event.row.params
	
    	-- Cache the row "contentWidth" and "contentHeight" because the row bounds can change as children objects are added
    	local rowHeight = row.contentHeight 
    	local rowWidth = row.contentWidth
	
		local function iterarProductos(productos)
			local posDesfase = 70
			for i = 1, #productos do
				local cantidadProducto = display.newText(row, productos[i].Available.."x", 0, 0, nil, 18)
				cantidadProducto.anchorX = 0
				cantidadProducto.x = 10
				cantidadProducto.y = posDesfase
				cantidadProducto:setFillColor(0)

    			local nomProducto = display.newText( row, productos[i].Name, 0, 0, nil, 18 )
				nomProducto.anchorX = 0
				nomProducto.x = 35
				nomProducto.y = cantidadProducto.y 
				nomProducto:setFillColor( 0 )		

				local precioProducto = display.newText( row, "$"..productos[i].Price, 0, 0, nil, 14 )
				precioProducto.anchorX = 0
				precioProducto.x = 20
				precioProducto.y = nomProducto.y + 30
				precioProducto:setFillColor( 0 )

				local descProducto = display.newText( row, productos[i].Description, 0, 0, nil, 14 )
				descProducto.anchorX = 0
				descProducto.x = 20
				descProducto.y = precioProducto.y + 30
				descProducto:setFillColor( 0 )	

				posDesfase = posDesfase + 130
			end
		end

		iterarProductos(params.Products)

		local nomCliente = display.newText( row, params.Client.Name.." "..params.Client.Firstname.." "..params.Client.Lastname, 0, 0, nil, 18)
		nomCliente.anchorX = 0
		nomCliente.x = 10
		nomCliente.y = 30
		nomCliente:setFillColor(0)

		local btnAcceptPedido = widget.newButton({
			row,
			id = "btnAccept",
			label = "Aceptar",
			width = 150,
			height = 90,
			fontSize = 13,
			shape = "roundedRect",
			labelColor = {default={color.hex("FFFFFF")}, over={color.hex("FFFFFF")}},
			fillColor = { default={ color.hex("E4640D") }, over={ color.hex("fcb280") } },
			onEvent = handleButtonEvent
		})  

		btnAcceptPedido.y = rowHeight - (btnAcceptPedido.height )

		row:insert(btnAcceptPedido)

		btnAcceptPedido.anchorX = 0
		btnAcceptPedido.x = 800

		backgroundTab:setFillColor(color.hex("E4640D"))
	end

	local tableView = widget.newTableView( --Se crea nuevo table view
		{
			left = 8,
			top = 64,
			height = 435,
			width = 1008,
			onRowRender = onRowRender,
			onRowTouch = onRowTouch,
			backgroundColor = {0.0, 0.0, 0.0, 0.0},
			listener = scrollListener,
			isBounceEnabled = false
		}
	)

	local function cargarInfo()
		
		Ordenes = LaFonda.getResponse()
		if (ResponseTime == nil) then
			ResponseTime = 0
		end
		if (Ordenes == nil) then
			ResponseTime = ResponseTime + 1
			print("Response time: "..ResponseTime)
			if (ResponseTime < 200) then
				timer.performWithDelay( 1, cargarInfo)
			else
				ResponseTime = nil
				print("Tiempo de respuesta excedido.")
			end
		else
			if (Ordenes.Error == false or Ordenes.Error == nil) then --
				print(inspect(Ordenes))
				for i=1,#Ordenes do		
					local rowHeight = 160 * #Ordenes[i].Products	
							
					tableView:insertRow{rowHeight=rowHeight, params=Ordenes[i]}
				end			
			else
				if(Ordenes.Message == "ELEMENT NOT FOUND") then
					print("Elemento no encontrado")
				end
			end			
		end
	end

	

	LaFonda.getOrdersProcess()
	cargarInfo()


	-- all objects must be added to group (e.g. self.view)
	sceneGroup:insert( background )
	sceneGroup:insert(backgroundTab)
	sceneGroup:insert(txtPedidos)
	sceneGroup:insert(numPedidos)
	sceneGroup:insert(tableView)
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene