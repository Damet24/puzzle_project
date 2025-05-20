local Sprite = {}
Sprite.__index = Sprite

function Sprite.new(filename, opts)
    if type(filename) ~= 'string' then
        error("filename debe ser una cadena")
    end
    if #filename == 0 then
        error("filename no tiene contenido")
    end
    local instance = setmetatable({}, Sprite)
    instance.options = opts or nil
    instance.image = love.graphics.newImage(filename)
    return instance
end

function Sprite:draw(pos_x, pos_y)
    if self.options ~= nil then
        local quad = love.graphics.newQuad(self.options.x, self.options.y, self.options.width, self.options.height,
            self.image:getWidth(), self.image:getHeight())
        love.graphics.draw(self.image, quad, pos_x, pos_y)
    else
        love.graphics.draw(self.image, pos_x, pos_y)
    end
end

return Sprite
