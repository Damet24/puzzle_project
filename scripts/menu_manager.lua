local C = require 'scripts.constants'

local MenuManager = {}
MenuManager.__index = MenuManager

function MenuManager.new(menus, default_menu)
    local instance = setmetatable({}, MenuManager)

    instance.cursor = love.graphics.newImage('assets/cursor.png')
    instance.cursor_w = instance.cursor:getWidth()
    instance.cursor_h = instance.cursor:getHeight()

    instance.navidation = true
    instance.font = love.graphics.newFont('assets/fonts/main.ttf', 24)
    instance.menus = menus
    instance.in_menory_menu = nil

    instance.cursor_pos = 1
    instance.menu_history = {}
    instance.current_menu = default_menu or 'main_menu'
    instance.current_menu_size = #instance.menus[instance.current_menu].items

    instance.option = {
        menu_position_x = love.graphics.getWidth() / 2,
        menu_position_y = 0,
        item_gap = 24,
        item_margin = 8
    }

    instance.menu_percentage = nil
    instance.limits = nil
    instance.compute_limits_function = nil
    instance.display_w = love.graphics.getWidth()
    instance.display_h = love.graphics.getHeight()

    return instance
end

function MenuManager:update()
    self.display_w = love.graphics.getWidth()
    self.display_h = love.graphics.getHeight()
    self:compute_limits()
    -- if self.menu_percentage ~= nil then
    --     self:set_limit_percentage(
    --         self.menu_percentage.per_x,
    --         self.menu_percentage.per_y,
    --         self.menu_percentage.per_x2,
    --         self.menu_percentage.per_y2
    --     )
    -- end
end

function MenuManager:back_on_menu()
    if not self.navidation then return end
    self.current_menu = self.menu_history[#self.menu_history]
    table.remove(self.menu_history, #self.menu_history)
    self.current_menu_size = #self.menus[self.current_menu].items
    self.cursor_pos = 1
end

function MenuManager:set_limits(x, y, w, h)
    self.limits = {
        x = x, y = y, w = w, h = h
    }
end

function MenuManager:compute_limits()
    if self.compute_limits_function ~= nil then
        local x, y, w, h = self.compute_limits_function()
        self.limits = {
            x = x, y = y, w = w, h = h
        }
    end
end

function MenuManager:set_computed_limits(func)
    self.compute_limits_function = func
end

function MenuManager:remove_limits()
    self.limits = nil
    self.menu_percentage = nil
    self.compute_limits_function = nil
end

function MenuManager:go_to_menu(new_menu)
    if not self.navidation then return end
    self.menu_history[#self.menu_history + 1] = self.current_menu
    self.current_menu = new_menu
    self.cursor_pos = 1
    self.current_menu_size = #self.menus[self.current_menu].items
end

function MenuManager:get_item_value(value)
    local _value = ''
    if value ~= nil then
        if value and type(value) ~= 'boolean' then
            _value = value
        else
            if value then _value = 'on' else _value = 'off' end
        end
    end

    return _value
end

function MenuManager:draw_cursor()
    local pos_x = (self.option.menu_position_x - self.cursor_w / 2) - self.option.item_gap / 2
    local pos_y = (self.option.menu_position_y - self.cursor_h / 2) + self.option.item_gap / 2 +
        (self.option.item_gap * (self.cursor_pos - 1))

    love.graphics.draw(self.cursor, pos_x, pos_y)
end

function MenuManager:draw_window(x, y, w, h)
    love.graphics.rectangle('fill', x - 4, y - 4, w + 8, h + 8)
    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle('fill', x, y, w, h)
    love.graphics.setColor(1, 1, 1)
end

function MenuManager:draw_background(draw)
    draw = draw or false
    if draw then
        love.graphics.setColor(0, 0, 0, .4)
        love.graphics.rectangle('fill', 0, 0, self.display_w, self.display_h)
        love.graphics.setColor(1, 1, 1)
    end
end

function MenuManager:center_text(text, align_x, align_y)
    local final_x = 0
    local final_y = 0
    local w = self.font:getWidth(text)
    local h = self.font:getHeight()
    align_x = align_x or 'left'
    align_y = align_y or 'top'

    if self.limits ~= nil then
        local dw = self.limits.w
        local dh = self.limits.h

        if align_x == 'center_left' then
            final_x = self.limits.x + (dw / 2) + self.option.item_margin
        elseif align_x == 'center_right' then
            final_x = self.limits.x + ((dw / 2) - w) - self.option.item_margin
        elseif align_x == 'center' then
            final_x = self.limits.x + ((dw / 2) - (w / 2))
        elseif align_x == 'left' then
            final_x = self.limits.x + self.option.item_margin
        elseif align_x == 'right' then
            final_x = self.limits.x + dw - (w + self.option.item_margin)
        end

        if align_y == 'top' then
            final_y = self.limits.y + self.option.item_margin
        elseif align_y == 'center' then
            final_y = self.limits.y + (dh / 2) - (self.current_menu_size * self.option.item_gap) / 2
        elseif align_y == 'bottom' then
            final_y = self.limits.y + dh - (self.current_menu_size * self.option.item_gap)
        end
    else
        if align_x == 'center_left' then
            final_x = (self.display_w / 2) + self.option.item_margin
        elseif align_x == 'center_right' then
            final_x = ((self.display_w / 2) - w) - self.option.item_margin
        elseif align_x == 'center' then
            final_x = ((self.display_w / 2) - (w / 2))
        elseif align_x == 'left' then
            final_x = self.option.item_margin
        elseif align_x == 'right' then
            final_x = self.display_w - (w + self.option.item_margin)
        end

        if align_y == 'top' then
            final_y = self.option.item_margin
        elseif align_y == 'center' then
            final_y = (self.display_h / 2) - (self.current_menu_size * self.option.item_gap) / 2
        elseif align_y == 'bottom' then
            final_y = self.display_h - (self.current_menu_size * self.option.item_gap)
        end
    end


    return final_x, final_y
end

function MenuManager:draw_current_menu(draw_bg)
    self:draw_background(draw_bg)
    if self.limits ~= nil then
        self:draw_window(self.limits.x, self.limits.y, self.limits.w, self.limits.h)
    end

    love.graphics.setFont(self.font)
    for i, v in pairs(self.menus[self.current_menu].items) do
        if i == self.cursor_pos then
            love.graphics.setColor(C.bg_color())
        end

        local menu = self.menus[self.current_menu].items

        local label = menu[i].label
        local value = self:get_item_value(menu[i].value)
        local lx, ly = self:center_text(label, menu[i].align_label, self.menus[self.current_menu].align_y)
        local vx, vy = self:center_text(value, menu[i].align_value, self.menus[self.current_menu].align_y)

        love.graphics.print(label, lx,
            ly + (self.option.item_gap * (i - 1)))

        love.graphics.print(value, vx,
            vy + (self.option.item_gap * (i - 1)))

        love.graphics.setColor(1, 1, 1)
    end
end

function MenuManager:draw_menu(menu, draw_bg)
    self:draw_background(draw_bg)
    self.in_menory_menu = menu
    self.navidation = false
    self.current_menu_size = #menu.items
    if self.limits ~= nil then
        self:draw_window(self.limits.x, self.limits.y, self.limits.w, self.limits.h)
    end

    love.graphics.setFont(self.font)
    for i, v in pairs(menu.items) do
        if i == self.cursor_pos then
            love.graphics.setColor(C.bg_color())
        end

        local label = menu.items[i].label
        local value = self:get_value(menu.items[i].value)
        local lx, ly = self:center_text(label, menu.items[i].align_label, menu.align_y)
        local vx, vy = self:center_text(value, menu.items[i].align_value, menu.align_y)

        love.graphics.print(label, lx,
            ly + (self.option.item_gap * (i - 1)))

        love.graphics.print(value, vx,
            vy + (self.option.item_gap * (i - 1)))

        love.graphics.setColor(1, 1, 1)
    end
end

function MenuManager:up()
    if self.cursor_pos == 1 then
        self.cursor_pos = self.current_menu_size
    else
        self.cursor_pos = self.cursor_pos - 1
    end
end

function MenuManager:updateOption(key, value)
    self.option[key] = value
end

function MenuManager:down()
    if self.cursor_pos == self.current_menu_size then
        self.cursor_pos = 1
    else
        self.cursor_pos = self.cursor_pos + 1
    end
end

function MenuManager:action()
    local action = nil
    if self.in_menory_menu ~= nil then
        action = self.in_menory_menu.items[self.cursor_pos].action
    else
        action = self.menus[self.current_menu].items[self.cursor_pos].action
    end
    if action then
        action(self)
    end
end

function MenuManager:mod(type)
    local mod = nil
    if self.in_menory_menu ~= nil then
        mod = self.in_menory_menu.items[self.cursor_pos].mod
    else
        mod = self.menus[self.current_menu].items[self.cursor_pos].mod
    end
    if mod then
        mod(self, type)
    end
end

function MenuManager:set_value(value)
    if self.in_menory_menu ~= nil then
        local _value = self.in_menory_menu.items[self.cursor_pos].value
        if value then
            self.in_menory_menu.items[self.cursor_pos].value = _value + value
        else
            self.in_menory_menu.items[self.cursor_pos].value = not _value
        end
    else
        local _value = self.menus[self.current_menu].items[self.cursor_pos].value
        if value then
            self.menus[self.current_menu].items[self.cursor_pos].value = _value + value
        else
            self.menus[self.current_menu].items[self.cursor_pos].value = not _value
        end
    end
end

function MenuManager:get_value()
    if self.in_menory_menu ~= nil then
        return self.in_menory_menu.items[self.cursor_pos].value
    else
        return self.menus[self.current_menu].items[self.cursor_pos].value
    end
end

return MenuManager
