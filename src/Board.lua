Board = Class{}

ROWS = 20
COLUMNS = 10

function Board:init(x, y)
    self.x = x
    self.y = y
    self.width = COLUMNS * TILE_SIZE
    self.height = ROWS * TILE_SIZE 
    self.tiles = {}
    self.isGameOver = false
    self:setTiles()
end

function Board:update(dt)
    local rowsCleared = self:resolveRowsCleared()
    local points = {
        [0] = 0,
        [1] = 100,
        [2] = 300,
        [3] = 500,
        [4] = 800
    }

    if rowsCleared > 0 then
        gSounds['lineCleared']:play()
    end

    return points[rowsCleared]
end

function Board:setTiles()
    for y = 1, ROWS do
        self.tiles[y] = {}
        self:resetRow(y)
    end
end

function Board:resolveRowsCleared()
    self.tilesToFall = {}
    local rowsCleared = 0
    for y = 1, ROWS do
        if self:isRowCleared(y) then
            rowsCleared = rowsCleared + 1
            self:resetRow(y)
            self:shiftTilesDown(y)
        end
    end

    Timer.tween(0.25, self.tilesToFall)

    return rowsCleared
end

function Board:isRowCleared(row)
    for x = 1, COLUMNS do
        local tile = self.tiles[row][x]
        if not tile then
            return false
        end
    end
    return true
end

function Board:resetRow(row)
    for x = 1, COLUMNS do
        self.tiles[row][x] = nil
    end
end

function Board:shiftTilesDown(matchedRow)
    for column = 1, COLUMNS do
        for row = matchedRow - 1, 1, -1 do
            local curTile = self.tiles[row][column]
            self.tiles[row + 1][column] = curTile
            self.tiles[row][column] = nil
            if curTile then 
                self.tilesToFall[curTile] = {y = ((row + 1) - 1) * TILE_SIZE}
            end
        end
    end
end

function Board:appendBlock(block)
    for _, tile in pairs(block.tiles) do
        if tile.y <= 0 then
            self.isGameOver = true
        end
        
        if tile.y >= 0 then
            self.tiles[math.floor(tile.y / TILE_SIZE) + 1][math.floor(tile.x / TILE_SIZE) + 1] = tile
        end
    end

    gSounds['appendBlock']:play()
end

function Board:coordinateToTile(x, y)
    if x < 0 or x > self.width - TILE_SIZE or y < 0 or y > self.height - TILE_SIZE then
        return nil
    end
    return self.tiles[math.floor(y / TILE_SIZE) + 1][math.floor(x / TILE_SIZE) + 1]
end

function Board:render()
    self:renderVerticalHorizontalLines()
    self:renderTiles()
end

function Board:renderVerticalHorizontalLines()
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
    love.graphics.setColor(0, 0, 0, 0.3)
    for y = 0, ROWS - 1 do
        if y < ROWS - 1 then
            love.graphics.line(self.x, self.y + (y + 1) * TILE_SIZE, self.x + self.width, self.y + (y + 1) * TILE_SIZE)
        end
    end    
    for x = 0, COLUMNS - 1 do
        if x < COLUMNS - 1 then
            love.graphics.line(self.x + (x + 1) * TILE_SIZE, self.y, self.x + (x + 1) * TILE_SIZE, self.y + self.height)
        end
    end
    love.graphics.setColor(1, 1, 1, 1)
end

function Board:renderTiles()
    for _, row in pairs(self.tiles) do
        for _, tile in pairs(row) do
            tile:render(self.x, self.y)
        end
    end
end

function Board:generateSample()
    for y = 1, ROWS do
        for x = 1, COLUMNS do
            if math.random(6) >= 2 then
                self.tiles[y][x] = Tile {
                    x = (x - 1) * TILE_SIZE,
                    y = (y - 1) * TILE_SIZE,
                    color = math.random(#gFrames['tiles'])
                }
            end
        end
    end
end