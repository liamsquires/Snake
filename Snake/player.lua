player = {}

function player:new (o)
	o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function player:pos ()
	self.x = love.graphics.getWidth() / 4
	self.y = love.graphics.getHeight() / 2
	self.direction = 0
	self.speed = 5
end

