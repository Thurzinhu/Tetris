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
    self.fallRate = 1
end

function Block:getRandomBlock()
    return math.random(#BLOCK_TYPES)
end

function Block:getRandomColor()
    return math.random(#gFrames['tiles'])
end

function Block:update(dt)
    self.timer = self.timer + dt
    if love.keyboard.wasPressed('right') then
        self:moveRight()
        gSounds['moveBlock']:play()
    elseif love.keyboard.wasPressed('left') then
        self:moveLeft()
        gSounds['moveBlock']:play()
    end
    if love.keyboard.isDown('down') then
        self.downCounter = self.downCounter + DOWN_SPEED
        if self.downCounter >= TILE_SIZE then
            self:moveDown()
            self.downCounter = self.downCounter % TILE_SIZE
        end
        self.timer = 0
    elseif self.timer >= self.fallRate then
        self.timer = self.timer % self.fallRate
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

-- clockwise
-- rotation matriz

-- [xCos(90) - ySin(90)]
-- [xSen(90) + yCos(90)]
-- [-(y)]
-- [+(x)]
function Block:rotate()
    local tilesBackup = {}
    local minX, minY = self.board.width, self.board.height
    for _, tile in pairs(self.tiles) do
        minX = math.min(tile.x, minX)
        minY = math.min(tile.y, minY)
    end

    for _, tile in pairs(self.tiles) do
        local x, y = tile.x, tile.y
        tile.x = tile.x - minX
        tile.y = tile.y - minY
        table.insert(tilesBackup, Tile {
            x = x,
            y = y,
            color = self.color
        })
    end

    for _, tile in pairs(self.tiles) do
        local x, y = tile.x, tile.y
        tile.x = -y + minX
        tile.y = x + minY
    end

    if not Collision.checkValidRotation(self.board, self) then
        self.tiles = tilesBackup
    end
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
            color = self.color
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