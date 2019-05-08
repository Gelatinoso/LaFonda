local M = {}
local JSON = require "json"
local Response
local Domain

local function setDomain(Name)
    Domain = Name
end

local function networkListener( event )
    if ( event.isError ) then
        Response = {Error = true, Message = event.response}
        print("API ERROR: "..event.response)
    else
        Response = JSON.decode(event.response)
        print("API Success: "..event.response)
    end
end

local function getEstablishment(ID, Password)
    network.request("http://"..Domain.."/fonda/api/getEstablishment.php?id="..ID.."&password="..Password,"GET", networkListener)
end

local function getResponse()
    if (Response == nil) then
        return nil
    else
        SendResponse = Response
        Response = nil
        return SendResponse
    end
end

local function getProducto()
    network.request("http://"..Domain.."/fonda/api/getProducto.php", "GET", networkListener)
end

local function getOrders()
    network.request("http://"..Domain.."/fonda/api/getOrders.php", "GET", networkListener)
end

local function getOrdersProcess()
    network.request("http://"..Domain.."/fonda/api/getOrdersProcess.php", "GET", networkListener)
end

M.setDomain = setDomain
M.getEstablishment = getEstablishment
M.getResponse = getResponse
M.getProducto = getProducto
M.getOrders = getOrders
M.getOrdersProcess = getOrdersProcess

return M