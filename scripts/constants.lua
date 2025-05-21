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
    bg_color = function () return color_utils.toRGB(252, 207, 3) end
}
