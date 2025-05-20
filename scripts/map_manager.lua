local sti = require 'libs.sti'
local MapManager = {}
MapManager.__index = MapManager

local maps_path = 'assets/maps/'

function MapManager.new(maps)
    local instance = setmetatable({}, MapManager)
    instance.layers = { 'floor', 'wall', 'decoration', 'door', 'item' }
    instance.maps = {}

    for i, v in pairs(love.filesystem.getDirectoryItems(maps_path)) do
        if string.find(v, '.lua') then
            instance.maps[v] = sti(maps_path .. v)
        end
    end
    instance.current_map = 'map_01.lua'

    return instance
end

function MapManager:setMap(map)
    self.current_map = map
end

function MapManager:draw()
    local current_map = self.maps[self.current_map]

    for _, value in pairs(self.layers) do
        if current_map.layers[value] then
            current_map:drawLayer(current_map.layers[value])
        end
    end
end

return MapManager
