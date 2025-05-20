
local GameState = {}
GameState.__index = GameState

function GameState.new()
    local instance = setmetatable({}, GameState)
    return instance
end

return GameState