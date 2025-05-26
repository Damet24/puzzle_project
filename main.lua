local C = require 'scripts.constants'

local Figth = require 'scripts.figth'
local figth = Figth.new()

function love.load()
    figth:load()
end

function love.update(dt)
    figth:update()
end

function love.draw()
    love.graphics.setBackgroundColor(C.bg_color())
    figth:draw()
end

-- local GameControl = require 'scripts.game_control'
-- local game_control = GameControl.new()
-- local bump = require 'libs.bump.bump'
-- local bump_debug = require 'libs.bump.bump_debug'
-- local Input = require 'libs.input.input'

-- local TILE_SIZE = 32

-- local player = {
--     x = 1,
--     y = 1,
--     px = 0 * TILE_SIZE,
--     py = 0 * TILE_SIZE,
--     speed = 4 * TILE_SIZE,
--     moving = false,
--     dirX = 0,
--     dirY = 0
-- }

-- local map = {
--     { 0, 0, 0, 0, 0 },
--     { 0, 1, 1, 1, 0 },
--     { 0, 0, 0, 1, 0 },
--     { 0, 1, 0, 0, 0 },
--     { 0, 0, 0, 0, 0 }
-- }

-- function tryMove(dx, dy)
--     if player.moving then return end

--     local tx = player.x + dx
--     local ty = player.y + dy

--     if map[ty] and map[ty][tx] and map[ty][tx] == 0 then
--         player.x = tx
--         player.y = ty
--         player.dirX = dx
--         player.dirY = dy
--         player.moving = true
--     end
-- end

-- function love.load()
--     -- Input.bind_callbacks()
-- end

-- function love.update(dt)
--     if Input.pressed('up') then
--         tryMove(0, -1)
--     elseif Input.pressed('down') then
--         tryMove(0, 1)
--     elseif Input.pressed('left') then
--         tryMove(-1, 0)
--     elseif Input.pressed('right') then
--         tryMove(1, 0)
--     end

--     if player.moving then
--         local targetPx = (player.x - 1) * TILE_SIZE
--         local targetPy = (player.y - 1) * TILE_SIZE

--         local dx = targetPx - player.px
--         local dy = targetPy - player.py
--         local dist = math.sqrt(dx * dx + dy * dy)

--         if dist < player.speed * dt then
--             player.px = targetPx
--             player.py = targetPy
--             player.moving = false
--         else
--             player.px = player.px + player.dirX * player.speed * dt
--             player.py = player.py + player.dirY * player.speed * dt
--         end
--     end
-- end

-- function love.draw()
--     for y = 1, #map do
--         for x = 1, #map[y] do
--             if map[y][x] == 1 then
--                 love.graphics.setColor(0.5, 0.5, 0.5)
--             else
--                 love.graphics.setColor(1, 1, 1)
--             end
--             love.graphics.rectangle("fill", (x - 1) * TILE_SIZE, (y - 1) * TILE_SIZE, TILE_SIZE, TILE_SIZE)
--         end
--     end

--     love.graphics.setColor(1, 0, 0)
--     love.graphics.rectangle("fill", player.px, player.py, TILE_SIZE, TILE_SIZE)
-- end
