PauseState = Class{__includes = BaseState}

function PauseState:enter(params)
    gSounds.music:pause()

    self.board = params.board
    self.score = params.score
    self.level = params.level
    self.timer = params.timer
    self.goalScore = params.goalScore
    self.timeSinceLastMatch = params.timeSinceLastMatch    
end

function PauseState:update(dt)
    if love.keyboard.wasPressed('p') or love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('play', {
            board = self.board,
            score = self.score,
            level = self.level,
            timer = self.timer,
            goalScore = self.goalScore,
            timeSinceLastMatch = self.timeSinceLastMatch 
        })
    end
end

function PauseState:render()
    love.graphics.setColor(0, 0, 0, 0.7)
    love.graphics.rectangle('fill', 40, 16, 160, 128, 4)
    love.graphics.setColor(1, 1, 1, 1)

    love.graphics.setFont(gFonts.small)
    printWithShadow('Level: ' .. tostring(self.level), 45, 20, 155, 'center')
    printWithShadow('Goal Score: ' .. tostring(self.goalScore), 45, 56, 155, 'center')
    printWithShadow('Score: ' .. tostring(self.score), 45, 92, 155, 'center')
    printWithShadow('Time Left: ' .. tostring(self.timer), 45, 124, 155, 'center')
    
    self.board:render()
end

function PauseState:exit()
    gSounds.music:play()
end