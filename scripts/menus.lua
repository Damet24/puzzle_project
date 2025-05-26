local C = require 'scripts.constants'

return {
    main_menu = {
        x = 16,
        y = 16,
        w = 200,
        h = 200,
        dynamic_size = function()
            local dw = love.graphics.getWidth()
            local dh = love.graphics.getHeight()
            return dw * (20 / 100), dh * (20 / 100), dw * (60 / 100), dh * (60 / 100)
        end,
        draw_bg = true,
        draw_window = true,
        title = 'main menu',
        align_x = 'center',
        align_y = 'center',
        item_align_x = 'center',
        items = {
            {
                label = 'play',
                action = function(mm)
                end
            },
            {
                label = 'snttings',
                action = function(mm)
                end
            },
            {
                label = 'exit',
                action = function(mm)
                end
            }
        }
    },
    test = {
        x = 16,
        y = 16,
        w = 350,
        h = 200,
        title = 'test menu',
        align_x = 'center',
        -- align_y = 'right',
        draw_bg = true,
        draw_window = true,
        type = C.menu.direction.horizontal,
        dynamic_size = function()
            local dw = love.graphics.getWidth()
            local dh = love.graphics.getHeight()
            return dw * (30 / 100), dh * (30 / 100), dw * (50 / 100), dh * (30 / 100)
        end,
        items = {
            {
                label = 'item 1',
                value = 10,
                action = function(mm) end
            },
            {
                label = 'item 2',
                value = 10,
                action = function(mm) end
            },
            {
                label = 'item 3',
                value = 10,
                action = function(mm) end
            },
            {
                label = 'item 4',
                value = 10,
                action = function(mm) end
            },
            {
                label = 'item 5',
                value = 10,
                action = function(mm) end
            },
            {
                label = 'item 6',
                value = 10,
                action = function(mm) end
            },
            {
                label = 'item 7',
                value = 10,
                action = function(mm) end
            },
            {
                label = 'item 8',
                value = 10,
                action = function(mm) end
            },
            {
                label = 'item 9',
                value = 10,
                action = function(mm) end
            },
            {
                label = 'item 10',
                value = 10,
                action = function(mm) end
            },
            {
                label = 'item 11',
                value = 10,
                action = function(mm) end
            },
            {
                label = 'item 12',
                value = 10,
                action = function(mm) end
            },
            {
                label = 'item 13',
                value = 10,
                action = function(mm) end
            },
            {
                label = 'item 14',
                value = 10,
                action = function(mm) end
            },
            {
                label = 'item 15',
                value = 10,
                action = function(mm) end
            },
            {
                label = 'item 16',
                value = 10,
                action = function(mm) end
            },
            {
                label = 'item 17',
                value = 10,
                action = function(mm) end
            },
            {
                label = 'item 18',
                value = 10,
                action = function(mm) end
            },
            {
                label = 'item 19',
                value = 10,
                action = function(mm) end
            },
            {
                label = 'item 20',
                value = 10,
                action = function(mm) end
            },
        }
    },
    setting_menu = {
        align_y = 'center',
        items = {
            {
                label = 'display',
                align_label = 'center',
                action = function(mm)
                    mm:go_to_menu('display_menu')
                end
            },
            {
                label = 'audio',
                align_label = 'center',
                action = function(mm)
                    mm:go_to_menu('audio_menu')
                end
            },
            {
                label = 'back',
                align_label = 'center',
                action = function(mm)
                    mm:remove_limits()
                    mm:back_on_menu()
                end
            },
            {
                label = 'exit',
                align_label = 'center',
                action = function(mm)
                    mm:go_to_menu('confirm_exit')
                end
            }
        }
    },
    display_menu = {
        align_y = 'center',
        items =
        {
            {
                label = 'fullscreen',
                value = false,
                align_label = 'left',
                align_value = 'right',
                action = function(mm)
                    mm:set_value()
                end
            },
            {
                label = 'monitor',
                value = 1,
                align_label = 'left',
                align_value = 'right',
                action = function(mm)
                    -- mm:set_value()
                end
            },
            {
                label = 'back',
                align_label = 'center',
                action = function(mm)
                    mm:back_on_menu()
                end
            },
            {
                label = 'exit',
                align_label = 'center',
                action = function(mm)
                    mm:go_to_menu('confirm_exit')
                end
            }
        }
    },
    audio_menu = {
        x = 16,
        y = 16,
        w = 200,
        h = 200,

        draw_bg = true,
        draw_window = true,
        title = 'main menu',
        align_x = 'center',
        align_y = 'center',
        item_align_x = 'center',
        items =
        {
            {
                label = 'master',
                action = function(mm)
                    if mm:get_value() >= 100 then
                        mm:set_value(0)
                    elseif mm:get_value() <= 0 then
                        mm:set_value(100)
                    end
                end,
                value = 100,

                mod = function(mm, type)
                    if type == 'left' then
                        mm:set_value(-2)
                    elseif type == 'right' then
                        mm:set_value(2)
                    end
                end
            },
            {
                label = 'music',
                value = 100,

                mod = function(mm, type)
                    if type == 'left' then
                        mm:set_value(-2)
                    elseif type == 'right' then
                        mm:set_value(2)
                    end
                end
            },
            {
                label = 'sfx',
                value = 100,

                mod = function(mm, type)
                    if type == 'left' then
                        mm:set_value(-2)
                    elseif type == 'right' then
                        mm:set_value(2)
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
                action = function(mm)
                    mm:go_to_menu('confirm_exit')
                end
            }
        }
    },
    confirm_exit = {
        title = 'confirm menu',
        message = 'Are you sure you want to quit the game?',
        align_y = 'center',
        items = {
            {
                label = 'yes',
                action = function()
                    love.event.quit()
                end
            },
            {
                label = 'no',
                action = function(mm)
                    mm:back_on_menu()
                end
            }
        }
    }
}
