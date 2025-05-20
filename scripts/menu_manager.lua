local color_utils = require 'scripts.utils.color'

local MenuManager = {}
MenuManager.__index = MenuManager

function MenuManager.new(menus)
    local instance = setmetatable({}, MenuManager)

    instance.cursor = love.graphics.newImage('assets/cursor.png')
    instance.cursor_w = instance.cursor:getWidth()
    instance.cursor_h = instance.cursor:getHeight()

    instance.disable_goto = false
    instance.font = love.graphics.newFont('assets/fonts/main.ttf', 24)
    instance.menus = menus

    instance.cursor_pos = 1
    instance.menu_history = {}
    instance.current_menu = 'main_menu'
    instance.current_menu_size = #instance.menus[instance.current_menu]

    instance.option = {
        menu_position_x = love.graphics.getWidth() / 2,
        menu_position_y = 0,
        item_gap = 24,
        item_margin = 8
    }

    instance.limits = nil

    return instance
end

function MenuManager:back_on_menu()
    if self.disable_goto then
        self.current_menu = self.menu_history[#self.menu_history]
        table.remove(self.menu_history, #self.menu_history)
        self.current_menu_size = #self.menus[self.current_menu]
        self.cursor_pos = 1
    end
end

function MenuManager:setLimits(x, y, w, h)
    self.limits = {
        x = x, y = y, w = w, h = h
    }
end

function MenuManager:go_to_menu(new_menu)
    if self.disable_goto then
        self.menu_history[#self.menu_history + 1] = self.current_menu
        self.current_menu = new_menu
        self.cursor_pos = 1
        self.current_menu_size = #self.menus[self.current_menu]
    end
end

function MenuManager:getFullLabel(i)
    local label = self.menus[self.current_menu][i].label
    local value = ''

    if self.menus[self.current_menu][i].value ~= nil then
        if self.menus[self.current_menu][i].value and type(self.menus[self.current_menu][i].value) ~= 'boolean' then
            value = self.menus[self.current_menu][i].value
        else
            if self.menus[self.current_menu][i].value then
                value = 'on'
            else
                value = 'off'
            end
        end
    end

    return label .. '\t\t' .. value
end

function MenuManager:draw_cursor()
    local pos_x = (self.option.menu_position_x - self.cursor_w / 2) - self.option.item_gap / 2
    local pos_y = (self.option.menu_position_y - self.cursor_h / 2) + self.option.item_gap / 2 +
        (self.option.item_gap * (self.cursor_pos - 1))

    love.graphics.draw(self.cursor, pos_x, pos_y)
end

function MenuManager:centerText(text, align_x, align_y)
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
        local dw = love.graphics.getWidth()
        local dh = love.graphics.getHeight()

        if align_x == 'center_left' then
            final_x = (dw / 2) + self.option.item_margin
        elseif align_x == 'center_right' then
            final_x = ((dw / 2) - w) - self.option.item_margin
        elseif align_x == 'center' then
            final_x = ((dw / 2) - (w / 2))
        elseif align_x == 'left' then
            final_x = self.option.item_margin
        elseif align_x == 'right' then
            final_x = dw - (w + self.option.item_margin)
        end

        if align_y == 'top' then
            final_y = self.option.item_margin
        elseif align_y == 'center' then
            final_y = (dh / 2) - (self.current_menu_size * self.option.item_gap) / 2
        elseif align_y == 'bottom' then
            final_y = dh - (self.current_menu_size * self.option.item_gap)
        end
    end


    return final_x, final_y
end

function MenuManager:draw_current_menu()
    if self.limits ~= nil then
        love.graphics.rectangle('line', self.limits.x, self.limits.y, self.limits.w, self.limits.h)

        love.graphics.line(
            self.limits.x,
            self.limits.y + self.limits.h / 2,
            self.limits.w + self.limits.x,
            self.limits.y + self.limits.h / 2
        )
        love.graphics.line(
            self.limits.x + self.limits.w / 2,
            self.limits.y,
            self.limits.x + self.limits.w / 2,
            self.limits.y + self.limits.h
        )
    end

    love.graphics.setFont(self.font)
    self.disable_goto = true
    -- self:draw_cursor()
    for i, v in pairs(self.menus[self.current_menu]) do
        if i == self.cursor_pos then
            love.graphics.setColor(color_utils.toRGB(252, 207, 3))
        end
        local x, y = self:centerText(self.menus[self.current_menu][i].label)
        local text = self:getFullLabel(i)
        love.graphics.print(text, x,
            y + (self.option.item_gap * (i - 1)))
        love.graphics.setColor(1, 1, 1)
    end
end

function MenuManager:draw_menu(menu)
    love.graphics.setFont(self.font)
    for i, v in pairs(self.menus[menu]) do
        if i == self.cursor_pos then
            love.graphics.setColor(color_utils.toRGB(252, 207, 3))
        end
        local x, y = self:centerText(self.menus[menu][i].label)
        local text = self:getFullLabel(i)
        love.graphics.print(text, x,
            y + (self.option.item_gap * (i - 1)))
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
    local action = self.menus[self.current_menu][self.cursor_pos].action
    if action then
        action(self)
    end
end

function MenuManager:mod(type)
    local mod = self.menus[self.current_menu][self.cursor_pos].mod
    if mod then
        mod(self, type)
    end
end

function MenuManager:setValue(value)
    if value then
        local _value = self.menus[self.current_menu][self.cursor_pos].value
        self.menus[self.current_menu][self.cursor_pos].value = _value + value
    else
        local _value = self.menus[self.current_menu][self.cursor_pos].value
        self.menus[self.current_menu][self.cursor_pos].value = not _value
    end
end

return MenuManager
