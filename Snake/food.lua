food = {}

function food:new (o)
	o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function food:pos ( ... )
	self.x = love.math.random(0, love.graphics.getWidth()-15)
	self.y = love.math.random(0, love.graphics.getHeight()-15)
	while self.x+15 >= player.x and self.x < player.x+20 and self.y+15 >= player.y and self.y <= player.y+20 do
		self.x = love.math.random(0, love.graphics.getWidth()-15)
		self.y = love.math.random(0, love.graphics.getHeight()-15)
	end
	for i=1, table.getn(tailList) do
			if self.x+15 >= tailList[i].x and self.x < tailList[i].x+18 and self.y+15 >= tailList[i].y and self.y <= tailList[i].y+18 then
				self.x = love.math.random(0, love.graphics.getWidth()-15)
				self.y = love.math.random(0, love.graphics.getHeight()-15)
			end
	end
end

function food:eat ( ... )
	if self.x+15 >= player.x and self.x < player.x+20 and self.y+15 >= player.y and self.y <= player.y+20 then
		addTail()
		actualFood:pos()
	end
end