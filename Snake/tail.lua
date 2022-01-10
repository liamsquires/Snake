
tail = {}
tailList = {}
function tail:new (o)
	
	o = o or {}
      setmetatable(o, self)
      self.__index = self
	self.speed = player.speed
      return o
      
end

function tail:pos (x,y,dir)
	self.x = x
	self.y = y
	self.direction = dir
	self.posHelpY = 0
	self.posHelpX = 0
end
function tail:turnInitialize( ... )
	self.timer = {}
	self.eventualDirectionUpdate = {}
	self.timerInstance = 1
	self.timer[1] = -2
end

function tail:turnSet (timer, dir)
	self.timer[self.timerInstance] = timer
	self.eventualDirectionUpdate[self.timerInstance] = dir
	self.timerInstance = self.timerInstance + 1
end

function tail:turnUpdate ()
	for i=1,table.getn(self.timer) do
	 	self.timer[i] = self.timer[i] - 1
	 
	if self.timer[i] == 0 or (self.timer[i] < 0 and self.timer[i] > -1) then
		self.direction = self.direction + 90*self.eventualDirectionUpdate[i]
	end
	end
end

function addTail( ... )
	tailList[tails+1]=tail:new()
	tailList[tails+1]:pos(tailList[tails].x+(20*tailList[tails].posHelpX), tailList[tails].y+(20*tailList[tails].posHelpY), tailList[tails].direction)
	tailList[tails+1]:turnInitialize()
	for i=1, table.getn(tailList[tails].timer) do
		if tailList[tails].timer[i] >= 0 then
			tailList[tails+1]:turnSet(tailList[tails].timer[i]+4, tailList[tails].eventualDirectionUpdate[i])
		end
	end
	tails = tails + 1
end
