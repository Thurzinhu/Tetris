BlockBuilder = Class{}

function BlockBuilder.buildBlock(blockType, color)
    local blockBuilders = {
        ['o_shape'] = BlockBuilder.buildOShapeBlock,
        ['i_shape'] = BlockBuilder.buildIShapeBlock,
        ['l_shape'] = BlockBuilder.buildLShapedBlock,
        ['j_shape'] = BlockBuilder.buildJShapedBlock,
        ['z_shape'] = BlockBuilder.buildZShapedBlock,
        ['s_shape'] = BlockBuilder.buildSShapedBlock,
        ['t_shape'] = BlockBuilder.buildTShapeBlock
    }

    return BlockBuilder.shiftBlockPosition((blockBuilders[BLOCK_TYPES[blockType]])(color), blockType)
end

function BlockBuilder.shiftBlockPosition(tiles, blockType)
    local shift = (BLOCK_TYPES[blockType] == 'i_shape') and 3 or 4
    for i = 1, shift do
        for _, tile in pairs(tiles) do
            tile.x = tile.x + TILE_SIZE
        end
    end
    return tiles
end

function BlockBuilder.buildOShapeBlock(color)
    local tileX, tileY = 0, 0
    local tiles = {}
    for y = 1, 2 do
        tileY = (y - 1) * TILE_SIZE
        for x = 1, 2 do
            tileX = (x - 1) * TILE_SIZE
            table.insert(tiles, Tile({
                x = tileX,
                y = tileY,
                color = color
            }))
        end
    end
    return tiles
end

function BlockBuilder.buildIShapeBlock(color)
    local tileX, tileY = 0, 0
    local tiles = {}
    for x = 1, 4 do
        tileX = (x - 1) * TILE_SIZE
        table.insert(tiles, Tile({
            x = tileX,
            y = tileY,
            color = color
        }))
    end
    return tiles
end

function BlockBuilder.buildJShapedBlock(color)
    local tileX, tileY = 0, 0
    local tiles = {}
    table.insert(tiles, Tile({
        x = tileX,
        y = tileY,
        color = color
    }))
    tileY = TILE_SIZE
    for x = 1, 3 do
        tileX = (x - 1) * TILE_SIZE
        table.insert(tiles, Tile(Tile({
            x = tileX,
            y = tileY,
            color = color
        })))
    end
    return tiles
end

function BlockBuilder.buildLShapedBlock(color)
    local tileX, tileY = TILE_SIZE * 2, 0
    local tiles = {}
    table.insert(tiles, Tile({
        x = tileX,
        y = tileY,
        color = color
    }))
    tileY = TILE_SIZE
    for x = 1, 3 do
        tileX = (x - 1) * TILE_SIZE
        table.insert(tiles, Tile(Tile({
            x = tileX,
            y = tileY,
            color = color
        })))
    end
    return tiles
end

function BlockBuilder.buildZShapedBlock(color)
    local tileX, tileY = 0, 0
    local tiles = {}
    for y = 1, 2 do
        tileY = (y - 1) * TILE_SIZE
        for x = 1, 2 do
            tileX = (x - 1 + y - 1) * TILE_SIZE
            table.insert(tiles, Tile({
                x = tileX,
                y = tileY,
                color = color
            }))
        end
    end
    return tiles
end

function BlockBuilder.buildSShapedBlock(color)
    local tileX, tileY = 0, 0
    local tiles = {}
    for y = 1, 2 do
        tileY = (y - 1) * TILE_SIZE
        for x = 1, 2 do
            tileX = (x - 1 + (y == 1 and 1 or 0)) * TILE_SIZE
            table.insert(tiles, Tile({
                x = tileX,
                y = tileY,
                color = color
            }))
        end
    end
    return tiles
end

function BlockBuilder.buildTShapeBlock(color)
    local tileX, tileY = TILE_SIZE, 0
    local tiles = {}
    table.insert(tiles, Tile({
        x = tileX,
        y = tileY,
        color = color
    }))
    tileY = TILE_SIZE
    for x = 1, 3 do
        tileX = (x - 1) * TILE_SIZE
        table.insert(tiles, Tile({
            x = tileX,
            y = tileY,
            color = color
        }))
    end
    return tiles
end