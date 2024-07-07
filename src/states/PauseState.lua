PauseState = Class{__includes = BaseState}

-- TODO
-- Add button quit and continue game buttons

function PauseState:enter(params)
    gSounds.music:pause()
    self.board = params.board
    self.currentBlock = params.currentBlock
    self.nextBlock = params.nextBlock
    self.score = params.score
    self.level = params.level
    self.timer = params.timer
    self.blockFallRate = params.blockFallRate
end

function PauseState:update(dt)
    if love.keyboard.wasPressed('p') then
        gStateMachine:change('countdown', {
            board = self.board,
            score = self.score,
            level = self.level,
            timer = self.timer,
            currentBlock = self.currentBlock,
            nextBlock = self.nextBlock,
            blockFallRate = self.blockFallRate
        })
    end
end

function PauseState:render()
    love.graphics.clear(1, 1, 1, 1)
    self:renderStats()
    self.board:render()
    self:renderNextBlockBox()
    self.currentBlock:render(self.board.x, self.board.y)
    self.currentBlock:getFinalPosition():render(self.board.x, self.board.y)
    self:renderDarkBackground()
end

function PauseState:exit()
    gSounds.music:play()
end