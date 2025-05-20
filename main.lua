local GameControl = require 'scripts.game_control'
local game_control = GameControl.new()
local color_utils = require 'scripts.utils.color'

local menus = {
    main_menu = {
        {
            label = 'play',
            action = function(mm)
            end
        },
        {
            label = 'snttings',
            action = function(mm)
                mm:go_to_menu('setting_menu')
            end
        },
        {
            label = 'exit',
            action = function()
                love.event.quit()
            end
        }
    },
    setting_menu = {
        {
            label = 'display',
            action = function(mm)
                mm:go_to_menu('display_menu')
            end
        },
        {
            label = 'audio',
            action = function(mm)
                mm:go_to_menu('audio_menu')
            end
        },
        {
            label = 'back',
            action = function(mm)
                mm:back_on_menu()
            end
        },
        {
            label = 'exit',
            action = function()
                love.event.quit()
            end
        }
    },
    display_menu = {
        {
            label = 'fullscreen',
            value = false,
            action = function(mm)
                mm:setValue()
            end
        },
        {
            label = 'back',
            action = function(mm)
                mm:back_on_menu()
            end
        },
        {
            label = 'exit',
            action = function()
                love.event.quit()
            end
        }
    },
    audio_menu = {
        {
            label = 'master',
            action = function(mm)
            end,
            value = 100,
            mod = function(mm, type)
                if type == 'left' then
                    mm:setValue(-1)
                elseif type == 'right' then
                    mm:setValue(1)
                end
            end
        },
        {
            label = 'music',
            action = function(mm)
            end,
            value = 100,
            mod = function(mm, type)
                if type == 'left' then
                    mm:setValue(-1)
                elseif type == 'right' then
                    mm:setValue(1)
                end
            end
        },
        {
            label = 'sfx',
            action = function(mm)
            end,
            value = 100,
            mod = function(mm, type)
                if type == 'left' then
                    mm:setValue(-1)
                elseif type == 'right' then
                    mm:setValue(1)
                end
            end
        },
        {
            label = 'back',
            action = function(mm)
                mm:back_on_menu()
            end
        },
        {
            label = 'exit',
            action = function()
                love.event.quit()
            end
        }
    }
}

local MenuManager = require 'scripts.menu_manager'
local mm = MenuManager.new(menus)
local dw = love.graphics.getWidth()
local dh = love.graphics.getHeight()
local x= dw*(20/100)
local y= dh*(20/100)
local w= dw*(60/100)
local h= dh*(60/100)


function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    game_control:load()
    print(x, y, w, h)
end

function love.update(delta_time)
    game_control:update(delta_time)

    mm:setLimits(x, y, w, h)
end

function love.keypressed(k, a, b)
    if k == 'up' then
        mm:up()
    end

    if k == 'down' then
        mm:down()
    end

    if k == 'left' then
        mm:mod('left')
    end
    if k == 'right' then
        mm:mod('right')
    end

    if k == 'return' or k == 'space' then
        mm:action()
    end
end

function love.draw()
    game_control:draw()
    mm:draw_current_menu()
end
