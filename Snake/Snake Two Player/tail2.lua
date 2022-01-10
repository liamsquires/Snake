
tail2 = {}
tailList2 = {}
function tail2:new (o)
	
	o = o or {}
      setmetatable(o, self)
      self.__index = self
	self.speed = players[1].speed
      return o
      
end

function tail2:pos (x,y,dir, identity)
	self.x = x
	self.y = y
	self.direction = dir
	self.posHelpY = 0
	self.posHelpX = 0
	self.identity = identity
end
function tail2:turnInitialize( ... )
	self.timer = {}
	self.eventualDirectionUpdate = {}
	self.timerInstance = 1
	self.timer[1] = -2
end

function tail2:turnSet (timer, dir)
	self.timer[self.timerInstance] = timer
	self.eventualDirectionUpdate[self.timerInstance] = dir
	self.timerInstance = self.timerInstance + 1
end

function tail2:turnUpdate ()
	for i=1,table.getn(self.timer) do
	 	self.timer[i] = self.timer[i] - 1
	 
	if self.timer[i] == 0 or (self.timer[i] < 0 and self.timer[i] > -1) then
		self.direction = self.direction + 90*self.eventualDirectionUpdate[i]
	end
	end
end

function addTail( ... )
	tailList2[tails+1]=tail:new()
	tailList2[tails+1]:pos(tailList2[tails].x+(20*tailList2[tails].posHelpX), tailList2[tails].y+(20*tailList2[tails].posHelpY), tailList2[tails].direction)
	tailList2[tails+1]:turnInitialize()
	for i=1, table.getn(tailList2[tails].timer) do
		if tailList2[tails].timer[i] >= 0 then
			tailList2[tails+1]:turnSet(tailList2[tails].timer[i]+4, tailList2[tails].eventualDirectionUpdate[i])
		end
	end
	tails2 = tails2 + 1
end
