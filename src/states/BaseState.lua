BaseState = Class{}

function BaseState:init() end
function BaseState:enter() end
function BaseState:update(dt) end
function BaseState:exit() end
function BaseState:render() end

function BaseState:renderStats()
    love.graphics.setColor(0, 0, 0, 0.7)
    love.graphics.rectangle('fill', 40, 16, 160, 128, 4)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(gFonts.small)
    printWithShadow('Level: ' .. tostring(self.level), 45, 40, 155, 'center')
    printWithShadow('Score: ' .. tostring(self.score), 45, 92, 155, 'center')
end

function BaseState:renderNextBlockBox()
    local box = {
        x = 426,
        y = TILE_SIZE,
        width = TILE_SIZE * 6,
        height = TILE_SIZE * 6
    }
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.rectangle('line', box.x, box.y, box.width, box.height)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(gFonts.small)
    printWithShadow('Next', VIRTUAL_WIDTH / 2 + 32, box.y + box.height + 2, VIRTUAL_WIDTH / 4, 'right', {153/255, 153/255, 255/255, 1})
    love.graphics.setColor(1, 1, 1, 1)
    if self.nextBlock then
        self:renderNextBlock(box)
    end
end

function BaseState:renderNextBlock(box)
    local blockType = BLOCK_TYPES[self.nextBlock.blockType] 
    if blockType == 'i_shape' then
        self.nextBlock:render(box.x - 32, box.y + 40)
    elseif blockType == 'o_shape' then
        self.nextBlock:render(box.x - 32, box.y + 32)
    else
        self.nextBlock:render(box.x - 40, box.y + 32)
    end
end

function BaseState:renderDarkBackground()
    love.graphics.setColor(0, 0, 0, 0.95)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    love.graphics.setColor(1, 1, 1, 1)
end