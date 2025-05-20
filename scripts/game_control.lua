local Camera = require 'libs.hump.camera'
local MapManager = require 'scripts.map_manager'
local CollisionGameObject = require 'scripts.collision_game_object'
local Player = require 'scripts.player'
local input = require 'libs.input.input'
local color_utils = require 'scripts.utils.color'
local C = require 'scripts.constants'
local MenuManager = require 'scripts.menu_manager'

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

    instance.objects.player = Player.new(0, 0, instance.world)

    instance.menu_manager = MenuManager.new(menus, 'main_menu')
    instance.show_menu = false

    return instance
end

function GameControl:load()
    self.input.bind_callbacks()
end

function GameControl:update(delta_time)
    if self.input.sequence({ 'lalt', 'return' }) then
        if self.fullscreen then
            self.fullscreen = false
        else
            self.fullscreen = true
        end
        love.window.setFullscreen(self.fullscreen)

    end
    self.objects.player:update(delta_time)

    if self.input.pressed('d') then
        if self.debug then
            self.debug = false
        else
            self.debug = true
        end
    end

    if self.input.pressed('escape') then
        self.show_menu = not self.show_menu
    end

    if self.show_menu then
        self:control_menu()
    end
end

function GameControl:control_menu()
    
end

function GameControl:draw()
    self.camera:attach()
    self.map_manager:draw()

    for i, obj in pairs(self.objects) do
        obj:draw()
    end

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
        self.menu_manager:draw_current_menu()
    end
end

return GameControl
