
local GameObject = {
    position = {
        x = 0,
        y = 0
    }
}
GameObject.__index = GameObject

function GameObject.new(x, y)
    local instance = setmetatable({}, GameObject)
    instance.position.x = x or 0
    instance.position.y = y or 0
    return instance
end

return GameObject