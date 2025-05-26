local MenuRenderer = require 'scripts.menu_renderer'
local Input = require 'libs.input.input'
local C = require 'scripts.constants'

local Figth = {}
Figth.__index = Figth


local menus = {
    main = {
        -- x = 16,
        -- y = 16,
        -- w = 200,
        -- h = 200,
        direction = C.menu.direction.horizontal,
        dynamic_size = function()
            local dw = love.graphics.getWidth()
            local dh = love.graphics.getHeight()
            return dw * (5 / 100), dh * (70 / 100), dw * (90 / 100), dh * (25 / 100)
        end,
        draw_bg = true,
        draw_window = true,
        title = 'Fight',
        align_x = 'left',
        align_y = 'top',
        item_align_x = 'left',
        items = {
            {
                label = 'attack',
                action = 'attack'
            },
            {
                label = 'use item',
                action = 'use_items'
            },
            {
                label = 'escape',
                action = function(mm)
                end
            }
        }
    },
    attack_menu = {
        -- draw_bg = true,
        draw_window = true,
        title = 'Attack',
        align_x = 'left',
        align_y = 'top',
        item_align_x = 'left',
        dynamic_size = function()
            local dw = love.graphics.getWidth()
            local dh = love.graphics.getHeight()
            return dw * (5 / 100), dh * (70 / 100), dw * (90 / 100), dh * (25 / 100)
        end,
        items = {
            {
                label = 'attack 1',
            },
            {
                label = 'attack 2',
            },
            {
                label = 'attack 3',
            },
            {
                label = 'attack 4',
            }
        }
    },
    items = {
        -- x = 16,
        -- y = 16,
        -- w = 200,
        -- h = 200,
        dynamic_size = function()
            local dw = love.graphics.getWidth()
            local dh = love.graphics.getHeight()
            return dw * (30 / 100), dh * (30 / 100), dw * (40 / 100), dh * (40 / 100)
        end,
        draw_bg = true,
        draw_window = true,
        title = 'Items',
        align_x = 'left',
        align_y = 'top',
        item_align_x = 'left',
        items = {
            {
                label = 'bottle health',
                value = 13,
                action = function(mm)
                end
            },
            {
                label = 'sword',
                value = 1,
                action = function(mm)
                end
            },
            {
                label = 'shovel',
                value = 1,
                action = function(mm)
                end
            },
            {
                label = 'apple',
                value = 4,
                action = function(mm)
                end
            },
            {
                label = 'arrow',
                value = 1,
                action = function(mm)
                end
            },
            {
                label = 'hammer',
                value = 1,
                action = function(mm)
                end
            }
        }
    },
}


function Figth.new()
    local instancen = setmetatable({}, Figth)
    instancen.menu_renderer = MenuRenderer.new()
    instancen.menu_renderer:add_menu_layer(menus.main)
    -- instancen.menu_renderer:add_menu_layer(menus.items)
    return instancen
end

function Figth:load()
    Input.bind_callbacks()
end

function Figth:update()
    if Input.pressed('up') then
        self.menu_renderer:up()
    end

    if Input.pressed('down') then
        self.menu_renderer:down()
    end

    if Input.pressed('space') then
        local action = self.menu_renderer:action()
        local actions = {
            use_items = function()
                self.menu_renderer:add_menu_layer(menus.items)
            end,
            attack = function()
                self.menu_renderer:add_menu_layer(menus.attack_menu)
            end
        }
        local fun = actions[action] or function()

        end
        fun()
    end

    if Input.pressed('escape') then
        if #self.menu_renderer.layers > 1 then
            self.menu_renderer:remove_last_layers()
        end
    end
end

function Figth:draw()
    self.menu_renderer:draw()
end

return Figth
