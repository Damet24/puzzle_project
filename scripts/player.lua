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

    instance.is_moving = false
    instance.move_timer = 0
    instance.move_duration = 0.1
    instance.target_position = { x = x, y = y }
    return instance
end

function player:move_to(target_x, target_y)
    -- -- Chequeamos colisión ANTES de iniciar movimiento
    -- local actual_x, actual_y = self.collider:getPosition()

    -- -- Simulamos el movimiento
    -- local goal_x, goal_y = target_x, target_y
    -- local world = self.collider:getWorld()
    -- local col_x, col_y, collisions, len = world:check(self.collider, goal_x, goal_y)

    -- if len == 0 then
    --     -- No hay colisiones, mover
    --     self.is_moving = true
    --     self.move_timer = 0
    --     self.target_position.x = target_x
    --     self.target_position.y = target_y
    -- end
end

function player:update(dt)
    self.sprite:update(dt)

    local x, y = self.collider:getPosition()

    if self.is_moving then
        self.move_timer = self.move_timer + dt
        local t = math.min(self.move_timer / self.move_duration, 1)

        local new_x = x + (self.target_position.x - x) * t
        local new_y = y + (self.target_position.y - y) * t
        self.collider:setPosition(new_x, new_y)

        if self.move_timer >= self.move_duration then
            self.collider:setPosition(self.target_position.x, self.target_position.y)
            self.is_moving = false
        end

        return -- no aceptar input mientras se mueve
    end

    -- solo aceptar input si no se está moviendo
    if Input.down('right') then
        self:move_to(x + 16, y)
    elseif Input.down('left') then
        self:move_to(x - 16, y)
    elseif Input.down('up') then
        self:move_to(x, y - 16)
    elseif Input.down('down') then
        self:move_to(x, y + 16)
    end
end

function player:draw()
    self.sprite:draw(self.collider:getPosition())
end

return player
