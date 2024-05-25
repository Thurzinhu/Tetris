GameOverState = Class{__includes = BaseState}

function GameOverState:enter(params)
    gSounds['music']:stop()
    gSounds['gameOver']:play()
    self.returnTitleButton = Button({
        x = VIRTUAL_WIDTH / 2 - 55,
        y = VIRTUAL_HEIGHT / 2 + 20,
        text = "Title Screen",
        width = 120,
        height = 30
    })
    self.quitButton = Button({
        x = VIRTUAL_WIDTH / 2 - 55,
        y = VIRTUAL_HEIGHT / 2 + 50,
        text = "Quit",
        width = 120,
        height = 30
    })
    self.board = params.board
    self.score = params.score
end

function GameOverState:update(dt)
    self.returnTitleButton:update(dt)
    self.quitButton:update(dt)
    if self.returnTitleButton:wasPressed() or love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('title')
    elseif self.quitButton:wasPressed() then
        love.event.quit()
    end
end

function GameOverState:render()
    love.graphics.clear(1, 1, 1, 1)
    self.board:render()
    self:renderTitle()
    self:renderOptions()
end

function GameOverState:exit()
    gSounds['music']:play()
end

function GameOverState:renderTitle()
    love.graphics.setColor(0.5, 0.5, 0.5, 0.9)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 150, VIRTUAL_HEIGHT / 2 - 120, 295, 100, 6)
    
    love.graphics.setFont(gFonts.huge)
    printWithShadow('Game Over', 0, VIRTUAL_HEIGHT / 2 - 105, VIRTUAL_WIDTH, 'center')
end

function GameOverState:renderOptions()
    love.graphics.setColor(0.5, 0.5, 0.5, 0.9)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 75, VIRTUAL_HEIGHT / 2 + 20, 150, 70, 6)
    
    love.graphics.setFont(gFonts.small)
    self.returnTitleButton:render()
    self.quitButton:render()
end