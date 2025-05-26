local Camera = require 'libs.hump.camera'
local MapManager = require 'scripts.map_manager'
local CollisionGameObject = require 'scripts.collision_game_object'
local Player = require 'scripts.player'
local input = require 'libs.input.input'
local color_utils = require 'scripts.utils.color'
local C = require 'scripts.constants'
local MenuRenderer = require 'scripts.menu_renderer'


local menus = require 'scripts.menus'

local GameControl = {}
GameControl.__index = GameControl

local GameStates = {
    uno = 1
}

local function config_camera(camera)
    local baseWidth, baseHeight = 320, 180
    local actualWidth, actualHeight = love.graphics.getDimensions()

    local zoom = math.floor(math.min(actualWidth / baseWidth, actualHeight / baseHeight))
    camera:zoom(zoom)
end


GameControl.new = function()
    local instance = setmetatable({}, GameControl)

    instance.debug = false
    instance.fullscreen = false


    instance.objects = {}
    instance.state = GameStates.uno

    local w = love.graphics.getWidth()
    local h = love.graphics.getHeight()
    instance.camera = Camera(w / 4, h / 4)

    config_camera(instance.camera)

    instance.map_manager = MapManager.new()

    instance.input = input
    instance.world = love.physics.newWorld(0, 0)

    CollisionGameObject.new(instance.world, 'static', 32, 32, 16, 16)

    instance.menu_renderer = MenuRenderer.new()
    instance.show_menu = false

    instance.objects = {

    }

    -- instance.player = Player.new(0, 0, instance.world)

    return instance
end

function GameControl:load()
    self.input.bind_callbacks()
    self.menu_renderer:add_menu_layer(menus.main_menu)
end

function GameControl:update(delta_time)
    if self.input.sequence({ 'lalt', 'return' }) then
        if self.fullscreen then
            self.fullscreen = false
        else
            self.fullscreen = true
        end
        love.window.setFullscreen(self.fullscreen)
        -- self.menu_manager:update()
    end

    -- self.player:update(delta_time)

    if self.input.pressed('d') then
        if self.debug then
            self.debug = false
        else
            self.debug = true
        end
    end

    if self.input.pressed('a') then
        self.menu_renderer:add_menu_layer(menus.test)
    end

    if self.input.pressed('r') then
        self.menu_renderer:add_menu_layer(menus.audio_menu)
    end
    if self.input.pressed('s') then
        self.menu_renderer:remove_last_layers()
    end

    if self.input.pressed('escape') then
        self.show_menu = not self.show_menu
    end

    if self.show_menu then
        -- self.menu_manager:update()
        self:control_menu()
    end
end

function GameControl:control_menu()
    local delay, interval = 0, 0.2
    if self.input.down('up', delay, interval) then
        self.menu_renderer:up()
    end
    if self.input.down('down', delay, interval) then
        self.menu_renderer:down()
    end

    -- if self.input.down('left', delay, interval) then
    --     self.menu_manager:mod('left')
    -- end

    -- if self.input.down('right', delay, interval) then
    --     self.menu_manager:mod('right')
    -- end

    -- if self.input.pressed('space') or self.input.pressed('return') then
    --     self.menu_manager:action()
    -- end
end

function GameControl:add_object(obj, layer)
    layer = layer or 1

    local value = {
        layer = layer,
        object = obj
    }
    table.insert(self.objects, #self.objects, value)
end

function GameControl:draw()
    self.camera:attach()

    -- self.player:draw()

    if self.debug then
        if debug and self.world then
            for _, body in pairs(self.world:getBodies()) do
                for _, fixture in pairs(body:getFixtures()) do
                    local shape = fixture:getShape()

                    if shape:typeOf("CircleShape") then
                        local cx, cy = body:getWorldPoints(shape:getPoint())
                        love.graphics.circle("line", cx, cy, shape:getRadius())
                    elseif shape:typeOf("PolygonShape") then
                        love.graphics.polygon("line", body:getWorldPoints(shape:getPoints()))
                    else
                        love.graphics.line(body:getWorldPoints(shape:getPoints()))
                    end
                end
            end
        end
    end
    self.camera:detach()
    love.graphics.setBackgroundColor(color_utils.toRGB(37, 18, 26))

    if self.show_menu then
        self.menu_renderer:draw()
    end
end

return GameControl
