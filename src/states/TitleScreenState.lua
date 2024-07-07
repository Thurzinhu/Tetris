TitleScreenState = Class{__includes = BaseState}

function TitleScreenState:init()
    self.startButton = Button({
        x = VIRTUAL_WIDTH / 2 - 55,
        y = VIRTUAL_HEIGHT / 2 + 20,
        text = "Start",
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
    self.board = Board(233, 16)
    self.board:generateSample()
    Timer.after(1, 
        function()
            self.board:update(dt)
        end
    )
end

function TitleScreenState:enter()

end

function TitleScreenState:update(dt)
    self.startButton:update(dt)
    self.quitButton:update(dt)
    if self.startButton:wasPressed() or love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown', {
            score = 0,
            level = 1,
            timer = 0
        })
    elseif self.quitButton:wasPressed() then
        love.event.quit()
    end
end

function TitleScreenState:render()
    love.graphics.clear(1, 1, 1, 1)
    self:renderSampleBoard()
    self:renderTitle()
    self:renderOptions()
end

function TitleScreenState:renderSampleBoard()
    love.graphics.setColor(1, 1, 1, 0.2)
    self.board:render()
    love.graphics.setColor(1, 1, 1, 1)
end

function TitleScreenState:renderTitle()
    love.graphics.setColor(0.5, 0.5, 0.5, 0.9)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 100, VIRTUAL_HEIGHT / 2 - 120, 200, 100, 6)
    
    love.graphics.setFont(gFonts.huge)
    printWithShadow('Tetris', 0, VIRTUAL_HEIGHT / 2 - 105, VIRTUAL_WIDTH, 'center')
end

function TitleScreenState:renderOptions()
    love.graphics.setColor(0.5, 0.5, 0.5, 0.9)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 75, VIRTUAL_HEIGHT / 2 + 20, 150, 70, 6)
    
    love.graphics.setFont(gFonts.small)
    self.startButton:render()
    self.quitButton:render()
end