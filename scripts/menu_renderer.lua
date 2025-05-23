local C = require 'scripts.constants'

local MenuRenderer = {}
MenuRenderer.__index = MenuRenderer

function MenuRenderer.new()
    local instance = setmetatable({}, MenuRenderer)

    instance.option = {
        item_gap = 20,
        item_margin = 8,
        title_margin_bottom = 2
    }

    instance.navidation = true
    instance.font = love.graphics.newFont('assets/fonts/main.ttf', instance.option.item_gap)

    instance.current_menu_size = 1

    instance.limits = nil
    instance.layers = {}
    instance.debug = false

    return instance
end

function MenuRenderer:add_menu_layer(menu)
    menu.cursor_pos = 1
    menu.scroll_offset  = 0
    self.cursor_pos = 1
    self.current_menu_size = #menu.items
    self.layers[#self.layers + 1] = menu
end

function MenuRenderer:remove_last_layers()
    table.remove(self.layers, #self.layers)
    if #self.layers > 0 then
        self.cursor_pos = 1
        self.current_menu_size = self.layers[#self.layers]
    end
end

function MenuRenderer:remove_menu_layer(index)
    table.remove(self.layers, index)
    if #self.layers > 0 then
        self.cursor_pos = 1
        self.current_menu_size = self.layers[#self.layers]
    end
end

function MenuRenderer:remove_all_layers()
    self.layers = {}
end

function MenuRenderer:get_menu_window_size(menu)
    if menu.draw_window then
        if menu.dynamic_size ~= nil then
            return menu.dynamic_size()
        else
            return menu.x, menu.y, menu.w, menu.h
        end
    end
end

function MenuRenderer:draw_layers()
    for i, menu in pairs(self.layers) do
        if menu.draw_bg then
            self:draw_background()
        end
        self:draw_window(self:get_menu_window_size(menu))
        self:draw_menu_elemets(menu, i)
    end
end

function MenuRenderer:get_menu_limits(menu)
    if menu.dynamic_size ~= nil then
        local x, y, w, h = menu.dynamic_size()
        return { x = x, y = y, w = w, h = h }
    else
        return { x = menu.x, y = menu.y, w = menu.w, h = menu.h }
    end
end

function MenuRenderer:get_menu_title(menu)
    if menu.title ~= nil then
        return menu.title
    else
        return ''
    end
end

function MenuRenderer:get_menu_size(layer)
    return #self.layers[layer].items
end

function MenuRenderer:get_title_position(menu, layer)
    local align_x = menu.align_x or 'left'
    local limits = self:get_menu_limits(menu)
    local text = self:get_menu_title(menu)
    local text_w = self.font:getWidth(text)
    local text_h = self.font:getHeight()
    local align_y = menu.align_y or 'top'
    local final_align = align_x .. '_' .. align_y

    local alignments = {
        left_ = function()
            return limits.x + self.option.item_margin, limits.y + self.option.item_margin
        end,
        center_ = function()
            local x = limits.x + (limits.w / 2) - (text_w / 2)
            local y = limits.y + self.option.item_margin
            return x, y
        end,
        right_ = function()
            local x = limits.x + limits.w - ((text_w + self.option.item_margin))
            local y = limits.y + self.option.item_margin
            return x, y
        end,
        right_center = function()
            local x = limits.x + limits.w - ((text_w + self.option.item_margin))
            local y = limits.y + limits.h / 2 -
                ((self:get_menu_size(layer) + self.option.title_margin_bottom) * self.option.item_gap) / 2
            return x, y
        end,
        right_top = function()
            local x = limits.x + limits.w - ((text_w + self.option.item_margin))
            local y = limits.y + self.option.item_margin
            return x, y
        end,
        center_center = function()
            local x = limits.x + (limits.w / 2) - (text_w / 2)
            local y = limits.y + limits.h / 2 -
                ((self:get_menu_size(layer) + self.option.title_margin_bottom) * self.option.item_gap) / 2
            return x, y
        end,
        center_top = function()
            local x = limits.x + (limits.w / 2) - (text_w / 2)
            local y = limits.y + self.option.item_margin
            return x, y
        end,
        left_center = function()
            local y = limits.y + limits.h / 2 -
                ((self:get_menu_size(layer) + self.option.title_margin_bottom) * self.option.item_gap) / 2
            return limits.x + self.option.item_margin, y
        end,
        left_top = function()
            local y = limits.y + self.option.item_margin
            return limits.x + self.option.item_margin, y
        end,
    }

    local fun = alignments[final_align] or alignments['left_']
    return fun()
end

function MenuRenderer:get_text_position(menu, layer, limits, limits_y, item_align_x)
    local align_x = item_align_x
    local justify = menu.justify or 'space_between'

    local x = limits.x + self.option.item_margin

    if menu.value ~= nil then
        local alignments = {
            space_between = function()
                return x, limits_y, x + limits.w - (self.option.item_margin * 2) - self.font:getWidth(menu.value),
                    limits_y
            end,
            center_right = function()
                return x + limits.w / 2 - self.option.item_margin - self.font:getWidth(menu.label) / 2, limits_y,
                    x + limits.w - (self.option.item_margin * 2) - self.font:getWidth(menu.value), limits_y
            end,
            left_center = function()
                return x, limits_y,
                    x + limits.w / 2 - self.option.item_margin - self.font:getWidth(menu.value) / 2, limits_y
            end,
            center = function()
                return x + limits.w / 2 - self.option.item_margin - self.font:getWidth(menu.label) -
                    self.option.item_margin, limits_y,
                    x + limits.w / 2 + self.option.item_margin + self.font:getWidth(menu.value) +
                    self.option.item_margin, limits_y
            end
        }
        local fun = alignments[justify]
        return fun()
    else
        local alignments = {
            left = function()
                return x, limits_y, nil, nil
            end,
            center = function()
                return x + limits.w / 2 - self.option.item_margin - self.font:getWidth(menu.label) / 2, limits_y, nil,
                    nil
            end,
            right = function()
                return x + limits.w - (self.option.item_margin * 2) - self.font:getWidth(menu.label), limits_y, nil, nil
            end,
        }
        local fun = alignments[align_x] or alignments['left']
        return fun()
    end
end

function MenuRenderer:get_max_visible_items(menu)
    local limits = self:get_menu_limits(menu)
    local total_space = limits.h

    local g = function(value)
        if value == 0 then
            return 0
        elseif value > 0 then
            return 1
        end
    end

    local title_height = (self.font:getHeight() + self.option.title_margin_bottom) * g(#self:get_menu_title(menu))
    total_space = total_space - (title_height * 2)
    local item_space = self.option.item_gap
    return math.floor(total_space / item_space)
end

function MenuRenderer:draw_menu_elemets(menu, layer)
    love.graphics.setFont(self.font)

    local limits = self:get_menu_limits(menu)
    local draw_y_position = 0

    local menu_title = self:get_menu_title(menu)
    local title_bottom_position = 0
    if #menu_title > 0 then
        local x, y = self:get_title_position(menu, layer)
        title_bottom_position = y
        love.graphics.print(menu_title, x, y)
        draw_y_position = draw_y_position + self.option.title_margin_bottom
    else
        title_bottom_position = limits.y + self.option.title_margin_bottom
    end

    local max_visible = self:get_max_visible_items(menu)
    local start_index = menu.scroll_offset + 1
    local end_index = math.min(start_index + max_visible - 1, #menu.items)

    for i = start_index, end_index do
        local v = menu.items[i]
        if i == menu.cursor_pos and layer == #self.layers then
            love.graphics.setColor(C.colors.red())
        end

        local limit_y = title_bottom_position + (draw_y_position * self.option.item_gap)
        if v.value == nil then
            local x, y = self:get_text_position(v, layer, limits, limit_y, menu.item_align_x)
            love.graphics.print(v.label, x, y)
        else
            local lx, ly, vx, vy = self:get_text_position(v, layer, limits, limit_y, menu.item_align_x)
            love.graphics.print(v.label, lx, ly)
            love.graphics.print(v.value, vx, vy)
        end

        love.graphics.setColor(1, 1, 1)
        draw_y_position = draw_y_position + 1
    end
end

function MenuRenderer:get_item_value(value)
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

function MenuRenderer:draw_window(x, y, w, h)
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle('fill', x - 4, y - 4, w + 8, h + 8)
    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle('fill', x, y, w, h)
    love.graphics.setColor(1, 1, 1)

    if self.debug then
        love.graphics.line(x, y + h / 2, x + w, y + h / 2)
        love.graphics.line(x + w / 2, y, x + w / 2, y + h)
    end
end

function MenuRenderer:draw_background()
    love.graphics.setColor(0, 0, 0, .4)
    love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    love.graphics.setColor(1, 1, 1)
end

function MenuRenderer:draw()
    if #self.layers > 0 then
        self:draw_layers()
    end
end

function MenuRenderer:up()
    if #self.layers > 0 then
        local menu = self.layers[#self.layers]
        local max_visible = self:get_max_visible_items(menu)

        if menu.cursor_pos == 1 then
            menu.cursor_pos = #menu.items
            menu.scroll_offset = math.max(0, #menu.items - max_visible)
        else
            menu.cursor_pos = menu.cursor_pos - 1
            if menu.cursor_pos <= menu.scroll_offset then
                menu.scroll_offset = menu.scroll_offset - 1
            end
        end
    end
end

function MenuRenderer:down()
    if #self.layers > 0 then
        local menu = self.layers[#self.layers]
        local max_visible = self:get_max_visible_items(menu)

        if menu.cursor_pos == #menu.items then
            menu.cursor_pos = 1
            menu.scroll_offset = 0
        else
            menu.cursor_pos = menu.cursor_pos + 1
            if menu.cursor_pos > menu.scroll_offset + max_visible then
                menu.scroll_offset = menu.scroll_offset + 1
            end
        end
    end
end

return MenuRenderer
