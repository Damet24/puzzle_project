return {
    main_menu = {
        align_y = 'center',
        items = {
            {
                label = 'play',
                align_label = 'center',
                action = function(mm)
                end
            },
            {
                label = 'snttings',
                align_label = 'center',
                action = function(mm)
                    mm:go_to_menu('setting_menu')
                end
            },
            {
                label = 'exit',
                align_label = 'center',
                action = function()
                    love.event.quit()
                end
            }
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
                    local fun = function()
                        local dw = love.graphics.getWidth()
                        local dh = love.graphics.getHeight()
                        return dw * (20 / 100), dh * (20 / 100), dw * (60 / 100), dh * (60 / 100)
                    end
                    mm:set_limits(fun())
                    mm:set_computed_limits(fun)
                    mm:go_to_menu('audio_menu')
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
                action = function()
                    love.event.quit()
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
                align_label = 'center_right',
                align_value = 'center_left',
                action = function(mm)
                    mm:set_value()
                end
            },
            {
                label = 'monitor',
                value = 1,
                align_label = 'center_right',
                align_value = 'center_left',
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
                action = function()
                    love.event.quit()
                end
            }
        }
    },
    audio_menu = {
        align_y = 'center',
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
                align_label = 'center_right',
                align_value = 'center_left',
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
                align_label = 'center_right',
                align_value = 'center_left',
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
                align_label = 'center_right',
                align_value = 'center_left',
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
                align_label = 'center',
                action = function(mm)
                    mm:remove_limits()
                    mm:back_on_menu()
                end
            },
            {
                label = 'exit',
                align_label = 'center',
                action = function()
                    love.event.quit()
                end
            }
        }
    }
}
