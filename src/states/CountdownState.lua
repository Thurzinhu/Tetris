CountdownState = Class{__includes = BaseState}

local COUNTDOWN_TIME = 0.75

function CountdownState:init()
    self.timer = 0
    self.count = 3
end

function CountdownState:enter(params)
    self.board = params.board or Board(233, 16)
    self.currentBlock = params.currentBlock
    self.nextBlock = params.nextBlock
    self.score = params.score
    self.level = params.level
    self.timer = params.timer
end

function CountdownState:update(dt)
    self.timer = self.timer + dt

    if self.timer >= COUNTDOWN_TIME then
        self.timer = self.timer % COUNTDOWN_TIME
        self.count = self.count - 1
        gSounds['tick']:play()

        if self.count == 0 then
            gStateMachine:change('play', {
                board = self.board,
                score = self.score,
                level = self.level,
                timer = self.timer,
                currentBlock = self.currentBlock,
                nextBlock = self.nextBlock
            })
        end
    end
end

function CountdownState:render()
    love.graphics.clear(1, 1, 1, 1)
    self:renderStats()
    self.board:render()
    self:renderNextBlockBox()
    self:renderDarkBackground()
    love.graphics.setFont(gFonts.medium)
    printWithShadow('Get Ready', VIRTUAL_WIDTH / 2 - 50, 80, 100, 'center')
    love.graphics.setFont(gFonts.huge)
    printWithShadow(tostring(self.count), VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 2 - 20, 100, 'center')
end
