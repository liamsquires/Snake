require 'tail'
require 'food'
require 'player'

function hitDetection( ... )
	for i=1, 2 do
		if players[i].x < -2 or players[i].x > love.graphics.getWidth()-18 or players[i].y < -2 or players[i].y > love.graphics.getHeight()-18 then 
			dead = true
			players[1].speed = 0
			players[2].speed = 0
			for i=1, table.getn(tailList) do
				tailList[i].speed = 0
			end
			for i=1, table.getn(tailList2) do
						tailList2[i].speed = 0
					end
		end
		for i=2, table.getn(tailList) do
				if players[i].x+18 >= tailList[i].x and players[i].x < tailList[i].x+18 and players[i].y+18 >= tailList[i].y and players[i].y <= tailList[i].y+18 then
					dead = true
					players[1].speed = 0
					players[2].speed = 0
					for i=1, table.getn(tailList) do
						tailList[i].speed = 0
					end
					for i=1, table.getn(tailList2) do
						tailList2[i].speed = 0
					end
				end
		end
		for i=2, table.getn(tailList) do
				if players[i].x+18 >= tailList2[i].x and players[i].x < tailList2[i].x+18 and players[i].y+18 >= tailList2[i].y and players[i].y <= tailList2[i].y+18 then
					dead = true
					players[1].speed = 0
					players[2].speed = 0
					for i=1, table.getn(tailList2) do
						tailList2[i].speed = 0
					end
					for i=1, table.getn(tailList) do
					tailList[i].speed = 0
					end
				end
		end
	end
end

function love.load ( ... )
	love.window.setMode(1000, 1000) --{fullscreen=true, fullscreentype="desktop"})
	love.window.setTitle("Snake")
	dead = false

	players[1] = player:new()
	players[2] = player:new()
	players[1]:pos(5,1.3,90)
	players[2]:pos(1.3,1.3,90)
	movementLockD = 0
	movementLock = 0
	movementLockL = 0
	movementLockR = 0
	lockTime = 10

	tailTurnConstant = 4.5
	tails = 2
	tails2= 2

	isItDone = "Not yet"

	for i=1, tails do
		tailList[i] = tail:new()
		tailList[i]:pos(players[1].x+1, players[1].y+1+20*i, players[1].direction, 1)
		tailList[i]:turnInitialize()
		
	end
	for i=1, tails2 do
		tailList2[i] = tail:new()
		tailList2[i]:pos(players[2].x+1, players[2].y+1+20*i, players[2].direction, 2)
		tailList2[i]:turnInitialize()
		
	end

	actualFood = food:new()
	actualFood:pos()



end

function love.update ( dt )

	--inputs 

	if love.keyboard.isDown('escape') then
		love.event.push('quit')
	end

	if love.keyboard.isDown('a') and movementLock <= 0 then
		players[1].direction = players[1].direction + 90
		movementLock = lockTime	
		for i=1, table.getn(tailList) do
			if tailList[i].identity == 1 then
			tailList[i]:turnSet((i-1)*4+tailTurnConstant, 1)
			end
		end
		isItDone = "Yes"

	end

	if love.keyboard.isDown('d') and movementLockD <= 0 then
		players[1].direction = players[1].direction - 90
		movementLockD = lockTime
		for i=1, table.getn(tailList) do
			if tailList[i].identity == 1 then
				tailList[i]:turnSet((i-1)*4+tailTurnConstant, -1)
			end

		end
		isItDone = "Yes"
	end


	if love.keyboard.isDown('left') and movementLockL <= 0 then
		players[2].direction = players[2].direction + 90
		movementLockL = lockTime	
		for i=1, table.getn(tailList) do
			if tailList[i].identity == 2 then
				tailList[i]:turnSet((i-1)*4+tailTurnConstant, 1)
			end
		end
		isItDone = "Yes"

	end

	if love.keyboard.isDown('right') and movementLockR <= 0 then
		players[2].direction = players[2].direction - 90
		movementLockR = lockTime
		for i=1, table.getn(tailList) do
			if tailList[i].identity == 2 then
				tailList[i]:turnSet((i-1)*4+tailTurnConstant, -1)
			end

		end
		isItDone = "Yes"
	end

	movementLock = movementLock - 1
	movementLockD = movementLockD - 1
	movementLockR = movementLockR - 1
	movementLockL = movementLockL - 1

	--movement
	for i=1, 2 do
		if players[i].direction == -90 then
			players[i].direction = 270
		end

		if players[i].direction == 360 then
			players[i].direction = 0
		end

		if players[i].direction == 0 then
			players[i].x = players[i].x + players[i].speed
			
		end

		if players[i].direction == 90 then
			players[i].y = players[i].y - players[i].speed
			
		end

		if players[i].direction == 180 then
			players[i].x = players[i].x - players[i].speed
			
		end

		if players[i].direction == 270 then
			players[i].y = players[i].y + players[i].speed
			
		end
	end

	--tail movement
	if isItDone == "Yes" then
		for i=1, table.getn(tailList) do
			tailList[i]:turnUpdate()

		end
	end


	for i=1, table.getn(tailList) do
		if tailList[i].direction == -90 then
		tailList[i].direction = 270
		end

		if tailList[i].direction == 360 then
			tailList[i].direction = 0
		end

		if tailList[i].direction == 0 then
			tailList[i].x = tailList[i].x + tailList[i].speed
			tailList[i].posHelpY = 0
			tailList[i].posHelpX = -1
			
		end

		if tailList[i].direction == 90 then
			tailList[i].y = tailList[i].y - tailList[i].speed
			tailList[i].posHelpY = 1
			tailList[i].posHelpX = 0
			
		end

		if tailList[i].direction == 180 then
			tailList[i].x = tailList[i].x - tailList[i].speed
			tailList[i].posHelpY = 0
			tailList[i].posHelpX = 1
			
		end

		if tailList[i].direction == 270 then
			tailList[i].y = tailList[i].y + tailList[i].speed
			tailList[i].posHelpY = -1
			tailList[i].posHelpX = 0
		end
	end

	--Food
	actualFood:eat()

	--I think it's obvious
	hitDetection()

	--Restart
	if dead==true and love.mouse.isDown(1) then
		--Reset all important variables
		tailList = {}
		
		dead = false

		players[1] = player:new()
		players[2] = player:new()
		players[1]:pos(5,1.3,90)
		players[2]:pos(1.3,1.3,90)

		movementLockD = 0
		movementLock = 0
		lockTime = 8

		tailTurnConstant = 4.5
		tails = 2

		isItDone = "Not yet"

		for i=1, tails do
		tailList[i] = tail:new()
		for k=1, 2 do
			tailList[i]:pos(players[k].x+1, players[k].y+1+20*i, players[k].direction, k)
		end
		tailList[i]:turnInitialize()
	end
		

		actualFood = food:new()
		actualFood:pos()
	end

end

function love.draw( ... )

	love.graphics.setColor(255, 255, 0)
	love.graphics.rectangle("line",players[1].x, players[1].y, 20, 20)

	love.graphics.setColor(0, 255, 0)
	love.graphics.rectangle("line",players[2].x, players[2].y, 20, 20)

	for i=1, table.getn(tailList) do
		love.graphics.rectangle("line",tailList[i].x, tailList[i].y, 18, 18)
	end

	love.graphics.setColor(0, 230, 230)
	love.graphics.rectangle("line",actualFood.x,actualFood.y,15,15)

	if dead==true then
		love.graphics.setColor(200, 0, 200, 70)
		love.graphics.rectangle("fill",50,50,300,300)
		love.graphics.setColor(250, 150, 250, 70)
		love.graphics.rectangle("fill", 125, 250, 150, 60)
		love.graphics.setColor(255,255,255, 100)
		love.graphics.print("Game Over", 67, 75, 0, 4)
		love.graphics.print("Click to Restart", 130, 270, 0, 1.5)
		love.graphics.print(tails-2, 100, 155, 0, 3.3)
		love.graphics.print(" tails collected", 140, 160, 0, 2)

	end


end