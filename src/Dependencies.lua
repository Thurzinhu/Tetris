push = require 'lib/push'
Class = require 'lib/class'
Timer = require 'lib/knife/timer'

require 'src/constants'
require 'src/Util'
require 'src/Board'
require 'src/Tile'
require 'src/Block'
require 'src/BlockBuilder'
require 'src/StateMachine'
require 'src/Collision'
require 'src/Button'

require 'src/states/BaseState'
require 'src/states/PlayState'

gTextures = {
    ['tiles'] = love.graphics.newImage('graphics/tiles.png')
}

gFrames = {
    ['tiles'] = generateQuads(gTextures['tiles'], TILE_SIZE, TILE_SIZE)
}

gStateMachine = StateMachine {
    ['play'] = function() return PlayState() end,
}

BLOCK_TYPES = {
    "o_shape", 
    "i_shape", 
    "l_shape", 
    "j_shape",
    "z_shape",
    "s_shape",
    "t_shape",
}