function generateQuads(atlas, tileWidth, tileHeight)
    local tiles = {}
    local horizontalTiles = atlas:getWidth() / tileWidth
    local verticalTiles = atlas:getHeight() / tileHeight
    for y = 0, verticalTiles - 1 do
        for x = 0, horizontalTiles - 1 do 
            table.insert(tiles, love.graphics.newQuad(x*tileWidth, y*tileHeight, tileWidth, tileHeight, atlas))
        end
    end
    return tiles
end