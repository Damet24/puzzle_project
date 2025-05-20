return {
    main_menu = {
        items = {
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
        }
    },
    setting_menu = {
        items = {
            {
                label = 'display',
                action = function(mm)
                    mm:go_to_menu('display_menu')
                end
            },
            {
                label = 'audio',
                action = function(mm)
                    local dw = love.graphics.getWidth()
                    local dh = love.graphics.getHeight()

                    local x = dw * (20 / 100)
                    local y = dh * (20 / 100)
                    local w = dw * (60 / 100)
                    local h = dh * (60 / 100)
                    mm:set_limits(x, y, w, h)
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
        }
    },
    display_menu = {
        items =
        {
            {
                label = 'fullscreen',
                value = false,
                align_value = 'center_left',
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
        }
    },
    audio_menu = {
        items =
        {
            {
                label = 'master',
                action = function(mm)
                end,
                value = 100,
                align_label = 'left',
                align_value = 'center',
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
                align_label = 'left',
                align_value = 'center',
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
                align_label = 'left',
                align_value = 'center',
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
                    mm:remove_limits()
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
    },
    inventory = {
        x = 0,
        y = 0,
        items = {
            {
                label = 'apple',
                value = 3,
                align_value = 'right',
                mod = function(mm, type)
                    if type == 'left' then
                        mm:setValue(-1)
                    elseif type == 'right' then
                        mm:setValue(1)
                    end
                end
            },
            {
                label = 'normal shield',
                value = 2,
                align_value = 'right',
                mod = function(mm, type)
                    if type == 'left' then
                        mm:setValue(-1)
                    elseif type == 'right' then
                        mm:setValue(1)
                    end
                end
            },
            {
                label = 'normal shield',
                value = 2,
                align_value = 'right',
                mod = function(mm, type)
                    if type == 'left' then
                        mm:setValue(-1)
                    elseif type == 'right' then
                        mm:setValue(1)
                    end
                end
            }
            ,
            {
                label = 'normal shield',
                value = false,
                align_value = 'right',
                mod = function(mm)
                    mm:setValue()
                end
            }
            ,
            {
                label = 'normal shield',
                value = true,
                align_value = 'right',
                mod = function(mm)
                    mm:setValue()
                end
            },
            {
                label = 'normal shield',
                value = 2,
                align_value = 'right',
                mod = function(mm, type)
                    if type == 'left' then
                        mm:setValue(-1)
                    elseif type == 'right' then
                        mm:setValue(1)
                    end
                end
            },
            {
                label = 'normal shield',
                value = 2,
                align_value = 'right',
                mod = function(mm, type)
                    if type == 'left' then
                        mm:setValue(-1)
                    elseif type == 'right' then
                        mm:setValue(1)
                    end
                end
            },
            {
                label = 'normal shield',
                value = 2,
                align_value = 'right',
                mod = function(mm, type)
                    if type == 'left' then
                        mm:setValue(-1)
                    elseif type == 'right' then
                        mm:setValue(1)
                    end
                end
            },
            {
                label = 'normal shield',
                value = 2,
                align_value = 'right',
                mod = function(mm, type)
                    if type == 'left' then
                        mm:setValue(-1)
                    elseif type == 'right' then
                        mm:setValue(1)
                    end
                end
            },
            {
                label = 'normal shield',
                value = 2,
                align_value = 'right',
                mod = function(mm, type)
                    if type == 'left' then
                        mm:setValue(-1)
                    elseif type == 'right' then
                        mm:setValue(1)
                    end
                end
            },
            {
                label = 'normal shield',
                value = 2,
                align_value = 'right',
                mod = function(mm, type)
                    if type == 'left' then
                        mm:setValue(-1)
                    elseif type == 'right' then
                        mm:setValue(1)
                    end
                end
            }
        }
    }
}
