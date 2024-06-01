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
require 'src/states/TitleScreenState'
require 'src/states/PlayState'
require 'src/states/CountdownState'
require 'src/states/PauseState'
require 'src/states/GameOverState'

gTextures = {
    ['tiles'] = love.graphics.newImage('graphics/tiles.png'),
}

gFrames = {
    ['tiles'] = generateQuads(gTextures['tiles'], TILE_SIZE, TILE_SIZE)
}

gFonts = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 24),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 32),
    ['huge'] = love.graphics.newFont('fonts/font.ttf', 64),
}

gSounds = {
    ['music'] = love.audio.newSource('sounds/music.mp3', 'static'),
    ['gameOver'] = love.audio.newSource('sounds/gameOver.mp3', 'static'),
    ['appendBlock'] = love.audio.newSource('sounds/appendBlock.wav', 'static'),
    ['moveBlock'] = love.audio.newSource('sounds/moveBlock.wav', 'static'),
    ['lineCleared'] = love.audio.newSource('sounds/lineCleared.ogg', 'static'),
    ['tick'] = love.audio.newSource('sounds/tick.wav', 'static'),
    ['nextLevel'] = love.audio.newSource('sounds/nextLevel.mp3', 'static'),
}
gSounds['music']:setLooping(true)
gSounds['music']:setVolume(0.3)
gSounds['nextLevel']:setVolume(0.3)

gStateMachine = StateMachine {
    ['title'] = function() return TitleScreenState() end, 
    ['play'] = function() return PlayState() end,
    ['countdown'] = function() return CountdownState() end,
    ['pause'] = function() return PauseState() end,
    ['gameOver'] = function() return GameOverState() end
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