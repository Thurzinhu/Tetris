PlayState = Class{__includes = BaseState}

function PlayState:enter(params)
    self.board = params.board or Board(233, 16)
    self.currentBlock = params.currentBlock or Block({
        board = self.board
    })
    self.nextBlock = params.nextBlock or Block({
        board = self.board
    })
    self.score = params.score
    self.level = params.level
    self.timer = params.timer
    self.goalScore = self.level == 1 and 300 or 300 + (self.level * 210)
    self.blockFallRate = params.blockFallRate or 1
end

function PlayState:update(dt)
    local points = self.board:update(dt)
    self.score = self.score + points

    if self:hasReachedGoalScore() then
        self:advanceToNextLevel()
    end

    if self.currentBlock and self.currentBlock.inGame then
        self.currentBlock:update(dt, self.blockFallRate)
        Collision.BoardBlockCollision(self.board, self.currentBlock)
    else
        self.currentBlock = self.nextBlock
        self.nextBlock = Block({
            board = self.board
        })
    end

    if self.board.isGameOver then
        gStateMachine:change('gameOver', {
            board = self.board,
            score = self.score
        })
    elseif love.keyboard.wasPressed('p') then
        gStateMachine:change('pause', {
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

function PlayState:render()
    love.graphics.clear(1, 1, 1, 1)
    self:renderStats()
    self.board:render()
    self:renderNextBlockBox()
    self.currentBlock:render(self.board.x, self.board.y)
    self.currentBlock:getFinalPosition():render(self.board.x, self.board.y)
end

function PlayState:hasReachedGoalScore()
    return self.score >= self.goalScore
end

function PlayState:advanceToNextLevel()
    local minimumFallRate = 0.05
    self.level = self.level + 1
    self.goalScore = 300 + (self.level * 210)
    self.blockFallRate = math.max(minimumFallRate, self.blockFallRate - 0.03)
    gSounds['nextLevel']:play()
end