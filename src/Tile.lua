Tile = Class{}

function Tile:init(def)
    self.x = def.x
    self.y = def.y
    self.color = def.color
    self.isPivot = def.isPivot or false
end

function Tile:update(dt)
end

function Tile:render(offsetX, offsetY)
    love.graphics.draw(gTextures['tiles'], gFrames['tiles'][self.color],self.x + offsetX, self.y + offsetY)
end