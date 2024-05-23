PlayState = Class{__includes = BaseState}

function PlayState:enter(params)
    self.board = params.board or Board(233, 16)
    self.currentBlock = params.block or nil
    self.nextBlock = Block({
        board = self.board
    })
end

function PlayState:update(dt)
    self.board:update(dt)
    if self.currentBlock and self.currentBlock.inGame then
        self.currentBlock:update(dt)
        Collision.BoardBlockCollision(self.board, self.currentBlock)
    else
        self.currentBlock = self.nextBlock
        self.nextBlock = Block({
            board = self.board
        })
    end
end

function PlayState:render()
    love.graphics.clear(1, 1, 1, 1)
    self.board:render()
    self:renderNextBlock()
    self.currentBlock:render(self.board.x, self.board.y)
    self.currentBlock:getFinalPosition():render(self.board.x, self.board.y)
end

function PlayState:renderNextBlock()
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.rectangle('line', VIRTUAL_WIDTH - 120, 100, 16 * 6, 16 * 6)
    love.graphics.setColor(1, 1, 1, 1)
    local offsetY = self.nextBlock.type == 'i_shape' and 16 or 32
    self.nextBlock:render((VIRTUAL_WIDTH - 120) + 16, 100 + 32)
end