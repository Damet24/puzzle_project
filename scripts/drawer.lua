local M = {
    debug = true
}

function M.draw_windor(x, y, w, h)
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle('fill', x - 4, y - 4, w + 8, h + 8)
    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle('fill', x, y, w, h)
    love.graphics.setColor(1, 1, 1)

    if M.debug then
        love.graphics.line(x, y + h / 2, x + w, y + h / 2)
        love.graphics.line(x + w / 2, y, x + w / 2, y + h)
    end
end

return M