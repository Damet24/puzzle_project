
local GameObject = require 'scripts.game_object'

local CollisionGameObject = setmetatable({}, {__index = GameObject})
CollisionGameObject.__index = CollisionGameObject

function CollisionGameObject.new(world, _type, width, height, pos_x, pos_y)
    local instance = GameObject.new(pos_x, pos_y)
    setmetatable(instance, CollisionGameObject)

    instance.collider = {}

    instance.collider.body = love.physics.newBody(world, instance.position.x, instance.position.y, _type)
    instance.collider.shape = love.physics.newRectangleShape(width/2, height/2, width, height, 0)
    instance.collider.fixture = love.physics.newFixture(instance.collider.body, instance.collider.shape)

    return instance
end

function CollisionGameObject:setVelocity(value)
    self.collider.body:setLinearVelocity(value, 0)
end

function CollisionGameObject:setPosition(x, y)
    self.collider.body:setPosition(x, y)
end

function CollisionGameObject:getPosition()
    return self.collider.body:getX(), self.collider.body:getY()
end

return CollisionGameObject