
local CollisionGameObject = {}
CollisionGameObject.__index = CollisionGameObject

function CollisionGameObject.new(map, pos_x, pos_y)
    local instance = setmetatable({}, CollisionGameObject)

    instance.map = map
    instance.pos_x = pos_x
    instance.pos_y = pos_y

    return instance
end

function CollisionGameObject:setPosition(x, y)
    self.pos_x = x
    self.pos_y = y
end

function CollisionGameObject:getPosition()
    return self.pos_x, self.pos_y
end

return CollisionGameObject
