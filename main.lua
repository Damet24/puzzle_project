local GameControl = require 'scripts.game_control'
local game_control = GameControl.new()

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    game_control:load()
end

function love.update(delta_time)
    game_control:update(delta_time)
end

function love.draw()
    game_control:draw()
end
