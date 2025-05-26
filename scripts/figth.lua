local MenuRenderer = require 'scripts.menu_renderer'
local Input = require 'libs.input.input'
local C = require 'scripts.constants'
local drawer = require 'scripts.drawer'

local Figth = {}
Figth.__index = Figth


local menus = {
    main = {
        -- x = 16,
        -- y = 16,
        -- w = 200,
        -- h = 200,
        -- direction = C.menu.direction.horizontal,
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
        },
        -- options = {
        --     {label = 'esc: to exit'}
        -- }
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

    instancen.init_turns = { 0, 1, 1, 0, 0, 1, 0 }

    instancen.current_turns = instancen.init_turns

    instancen.figthers = {
        player = {
            health = 10,
            attacks = {
                {
                    name = 'trompá',
                    damage = 2
                },
                {
                    name = 'patada al esófago',
                    damage = 3
                }
            },
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
        enemies = {
            {
                name = 'enemy 1',
                health = 7,
                attacks = {
                    {
                        name = 'mondacazo',
                        damage = 3
                    }
                }
            }
        }
    }

    return instancen
end

function Figth:load()
    Input.bind_callbacks()
end

function Figth:get_player_menu()
    return {

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
    }
end

function Figth:get_player_items()

end

function Figth:get_player_attacks()
    local items = {}
    for key, value in pairs(self.figthers.player.attacks) do
        table.insert(items, {
            label = value.name,
            value = key,
            action = function ()
                print('atack ' .. key)
            end
        })
    end
    return items
end

function Figth:get_attack_menu()
    return {
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
        items = self:get_player_attacks()
    }
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

        if type(action) == 'function' then
            action()
        else
            local actions = {
                use_items = function()
                    self.menu_renderer:add_menu_layer(menus.items)
                end,
                attack = function()
                    self.menu_renderer:add_menu_layer(self:get_attack_menu())
                end
            }
            local fun = actions[action] or function()
    
            end
            fun()
        end
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
