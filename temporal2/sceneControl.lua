local M = {}
local composer = require( "composer" )

local function setScene(newScene, options, destroy)
    composer.gotoScene(newScene, options)
    if (destroy ~= nil) then
        composer.removeScene(destroy)
    end
end

M.setScene = setScene

return M