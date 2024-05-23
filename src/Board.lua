Board = Class{}

ROWS = 20
COLUMNS = 10

function Board:init(x, y)
    self.x = x
    self.y = y
    self.width = COLUMNS * TILE_SIZE
    self.height = ROWS * TILE_SIZE 
    self.tiles = {}
    self:setTiles()
end

function Board:update(dt)
    local rowsMatched = self:resolveMatches()
    
    
end

function Board:setTiles()
    for y = 1, ROWS do
        self.tiles[y] = {}
        self:resetRow(y)
    end
end

function Board:resolveMatches()
    self.tilesToFall = {}
    local countRowsMatched = 0
    for y = ROWS, 1, -1 do
        if self:checkMatch(y) then
            countRowsMatched = countRowsMatched + 1
            self:resetRow(y)
            self:shiftTilesDown(y)
            y = y + 1
        end
    end

    Timer.tween(0.25, self.tilesToFall)

    return countRowsMatched
end

function Board:checkMatch(row)
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
            if curTile then 
                self.tiles[row + 1][column] = curTile
                self.tiles[row][column] = nil
                self.tilesToFall[curTile] = {y = ((row + 1) - 1) * TILE_SIZE}
            end
        end
    end
end

function Board:appendBlock(block)
    for _, tile in pairs(block.tiles) do
        self.tiles[math.floor(tile.y / TILE_SIZE) + 1][math.floor(tile.x / TILE_SIZE) + 1] = tile
    end
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