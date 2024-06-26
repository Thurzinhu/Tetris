Button = Class{}

local highlightColor = {255/255, 255/255, 80/255, 1}

function Button:init(def)
    self.x = def.x
    self.y = def.y
    self.width = def.width
    self.height = def.height
    self.text = def.text
    self.isSelected = def.isSelected or false
end

function Button:wasPressed(mouse)
    return self.isSelected and love.mouse.wasPressed(1)
end

function Button:update(dt)
    local mouseX, mouseY = push:toGame(love.mouse.getPosition())

    self.isSelected = mouseX and mouseY and
    mouseX > self.x and mouseX < self.x + self.width and
    mouseY > self.y and mouseY < self.y + self.height 
end

function Button:render()
    printWithShadow(self.text, 0, self.y + self.height / 2 - 8, VIRTUAL_WIDTH, 'center', self.isSelected and highlightColor)
end