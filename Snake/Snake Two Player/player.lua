player = {}
players = {}

function player:new ()
	o = {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function player:pos (x,y,dir)
	self.x = love.graphics.getWidth() / x
	self.y = love.graphics.getHeight() / y
	self.direction = dir
	self.speed = 5
end

