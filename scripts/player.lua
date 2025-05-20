local CollisionGameObject = require 'scripts.collision_game_object'
local AnimationSprite = require 'scripts.animation_sprite'
local Input = require 'libs.input.input'

local player = {
    position = {
        x = 0,
        y = 0
    },
    speed = 16
}
player.__index = player

player.new = function(x, y, world)
    local instance = setmetatable({}, player)
    instance.position.x = x or 0
    instance.position.y = y or 0

    instance.collider = CollisionGameObject.new(world, 'dynamic', 16, 16, x, y)
    instance.sprite = AnimationSprite.new('assets/priest_anim.png', {
        default = 'idle',
        animations = {
            idle = {
                frames = '1-4',
                row = 1,
                duration = 0.2
            }
        }
    })
    return instance
end

function player:update(delta_time)
    self.sprite:update(delta_time)

    local x, y = self.collider:getPosition()
    if Input.pressed('right') then
        self.collider:setPosition(x + 16, y)
    elseif Input.pressed('left') then
        self.collider:setPosition(x - 16, y)
    end
end

function player:draw()
    self.sprite:draw(self.collider:getPosition())
end

return player
