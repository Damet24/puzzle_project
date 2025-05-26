local color_utils = require 'scripts.utils.color'

return {
    physics = {
        static = 'static',
        dynamic = 'dynamic',
        kinematic = 'kinematic'
    },
    game_states = {
        pause = 1,
        in_game = 2,
    },
    camera = {
        zoom = 4
    },
    bg_color = function () return color_utils.toRGB(37, 18, 26) end,
    colors = {
        red = function () return color_utils.toRGB(255, 0, 0) end
    },
    menu = {
        direction = {
            horizontal = 'horizontal',
            vertical = 'horizontal'
        }
    }
}
