Collision = Class{}

function Collision.BoardBlockCollision(board, block)
    if love.keyboard.wasPressed('right') and Collision.checkBoardBlockRightCollision(board, block) then
        block:moveLeft()
    elseif love.keyboard.wasPressed('left') and Collision.checkBoardBlockLeftCollision(board, block) then
        block:moveRight()
    end
    
    if love.keyboard.wasPressed('space') then
        board:appendBlock(block)
        block.inGame = false
    elseif Collision.checkBoardBlockFloorCollision(board, block) then
        block:moveUp()
        board:appendBlock(block)
        block.inGame = false
    end
end

function Collision.checkBoardBlockRightCollision(board, block)
    for _, tile in pairs(block.tiles) do
        local blockAtCoordinate = board:coordinateToTile(tile.x, tile.y)
        if tile.x > board.width - TILE_SIZE or blockAtCoordinate then
            return true
        end
    end
    return false
end

function Collision.checkBoardBlockLeftCollision(board, block)
    for _, tile in pairs(block.tiles) do
        local blockAtCoordinate = board:coordinateToTile(tile.x, tile.y)
        if tile.x < 0 or blockAtCoordinate then
            return true
        end
    end
    return false
end

function Collision.checkBoardBlockFloorCollision(board, block)
    for _, tile in pairs(block.tiles) do
        local blockAtCoordinate = board:coordinateToTile(tile.x, tile.y)
        if tile.y > board.height - TILE_SIZE or blockAtCoordinate then
            return true
        end
    end
    return false
end

function Collision.checkValidRotation(board, block)
    putBlockInBoardBoundaries(board, block)

    for _, tile in pairs(block.tiles) do
        local blockAtCoordinate = board:coordinateToTile(tile.x, tile.y)
        if blockAtCoordinate then
            return false
        end
    end
    return true
end

function putBlockInBoardBoundaries(board, block)
    for _, tile in pairs(block.tiles) do
        if tile.x < 0 then
            block:moveRight()
        elseif tile.x > board.width - TILE_SIZE then
            block:moveLeft()
        end

        if tile.y < 0 then
            block:moveDown()
        elseif tile.y > board.height - TILE_SIZE then
            block:moveUp()
        end
    end
end