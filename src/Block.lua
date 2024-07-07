Block = Class{}

local DOWN_SPEED = 4

function Block:init(def)
    self.blockType = def.blockType or self:getRandomBlock()
    self.color = def.color or self:getRandomColor()
    self.isSample = def.isSample or false 
    self.board = def.board
    self.tiles = def.tiles or BlockBuilder.buildBlock(self.blockType, self.color)
    self.inGame = true
    self.timer = 0
    self.downCounter = 0
end

function Block:getRandomBlock()
    return math.random(#BLOCK_TYPES)
end

function Block:getRandomColor()
    return math.random(#gFrames['tiles'])
end

function Block:update(dt, fallRate)
    self.timer = self.timer + dt
    if love.keyboard.wasPressed('right') then
        self:moveRight()
        gSounds['moveBlock']:play()
    elseif love.keyboard.wasPressed('left') then
        self:moveLeft()
        gSounds['moveBlock']:play()
    end
    if love.keyboard.wasPressed('space') then
        self.tiles = self:getFinalPosition().tiles
    elseif love.keyboard.isDown('down') then
        self.downCounter = self.downCounter + DOWN_SPEED
        if self.downCounter >= TILE_SIZE then
            self:moveDown()
            self.downCounter = self.downCounter % TILE_SIZE
        end
        self.timer = 0
    elseif self.timer >= fallRate then
        self.timer = self.timer % fallRate
        self:moveDown()
    end
    if love.keyboard.wasPressed('up') then
        self:rotate()
        gSounds['moveBlock']:play()
    end
end

function Block:moveDown()
    for _, tile in pairs(self.tiles) do
        tile.y = tile.y + TILE_SIZE
    end
end

function Block:moveUp()
    for _, tile in pairs(self.tiles) do
        tile.y = tile.y - TILE_SIZE
    end
end

function Block:moveLeft()
    for _, tile in pairs(self.tiles) do
        tile.x = tile.x - TILE_SIZE
    end
end

function Block:moveRight()
    for _, tile in pairs(self.tiles) do
        tile.x = tile.x + TILE_SIZE
    end 
end

function Block:rotate()
    local backupBlock = self:makeCopy()
    local pivotTile = self:getPivotTile()

    if not pivotTile then
        return
    end
  
    for _, tile in pairs(self.tiles) do
        local x, y = tile.x - pivotTile.x, tile.y - pivotTile.y
        tile.x = -y + pivotTile.x
        tile.y = x + pivotTile.y
    end

    if not Collision.checkValidRotation(self.board, self) then
        self.tiles = backupBlock.tiles
    end
end

function Block:getPivotTile()
    for _, tile in pairs(self.tiles) do
        if tile.isPivot then
            return tile
        end
    end
    return nil
end

function Block:getFinalPosition()
    local finalPosition = self:makeCopy()
    while not Collision.checkBoardBlockFloorCollision(self.board, finalPosition) do
        finalPosition:moveDown()
    end
    finalPosition:moveUp()
    return finalPosition
end

function Block:makeCopy()
    other = {
        blockType = self.blockType,
        color = self.color,
        tiles = {},
        isSample = true
    }
    for _, tile in pairs(self.tiles) do
        table.insert(other.tiles, Tile {
            x = tile.x,
            y = tile.y,
            color = self.color,
            isPivot = tile.isPivot
        })
    end
    return Block(other)
end

function Block:render(offsetX, offsetY)
    if self.isSample then
        love.graphics.setColor(1, 1, 1, 0.2)
    end
    for _, tile in pairs(self.tiles) do
        tile:render(offsetX, offsetY)
    end
    love.graphics.setColor(1, 1, 1, 1)
end