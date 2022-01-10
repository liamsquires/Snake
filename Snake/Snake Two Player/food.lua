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
	for i=1, 2 do	
		while self.x+15 >= players[i].x and self.x < players[i].x+20 and self.y+15 >= players[i].y and self.y <= players[i].y+20 do
			self.x = love.math.random(0, love.graphics.getWidth()-15)
			self.y = love.math.random(0, love.graphics.getHeight()-15)
		end
	end
		for i=1, table.getn(tailList) do
				if self.x+15 >= tailList[i].x and self.x < tailList[i].x+18 and self.y+15 >= tailList[i].y and self.y <= tailList[i].y+18 then
					self.x = love.math.random(0, love.graphics.getWidth()-15)
					self.y = love.math.random(0, love.graphics.getHeight()-15)
				end
		end
	
end

function food:eat ( ... )
	for i=1, 2 do
		if self.x+15 >= players[i].x and self.x < players[i].x+20 and self.y+15 >= players[i].y and self.y <= players[i].y+20 then
			if i == 1 then
				addTail()
			end
			if i ==2 then
				addTail2()
			end
			actualFood:pos()
		end
	end
end