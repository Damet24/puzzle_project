local Sprite = require 'scripts.sprite'
local anim8 = require 'libs.anim8.anim8'

local AnimationSprite = setmetatable({}, { __index = Sprite })
AnimationSprite.__index = AnimationSprite

function AnimationSprite.new(filename, options)
    local instance = Sprite.new(filename)
    setmetatable(instance, AnimationSprite)
    instance.grid = anim8.newGrid(16, 16, instance.image:getWidth(), instance.image:getHeight())
    instance.animations = {}
    for i, t in pairs(options.animations) do
        instance.animations[i] = anim8.newAnimation(instance.grid(t.frames, t.row), t.duration)
    end
    instance.current_animation = options.default
    return instance
end

function AnimationSprite:update(dt)
    self.animations[self.current_animation]:update(dt)
end

function AnimationSprite:play(animation_name)
    self.current_animation = animation_name
end

function AnimationSprite:draw(pos_x, pos_y)
    self.animations[self.current_animation]:draw(self.image, pos_x, pos_y)
end

return AnimationSprite
