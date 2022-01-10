require 'tail'
require 'food'
require 'player'

function hitDetection( ... )
	if player.x < -2 or player.x > love.graphics.getWidth()-18 or player.y < -2 or player.y > love.graphics.getHeight()-18 then 
		dead = true
		player.speed = 0
		for i=1, table.getn(tailList) do
			tailList[i].speed = 0
		end
	end
	for i=2, table.getn(tailList) do
			if player.x+18 >= tailList[i].x and player.x < tailList[i].x+18 and player.y+18 >= tailList[i].y and player.y <= tailList[i].y+18 then
				dead = true
				player.speed = 0
				for i=1, table.getn(tailList) do
					tailList[i].speed = 0
				end
			end
	end
end

function love.load ( ... )
	love.window.setMode(400, 400) --{fullscreen=true, fullscreentype="desktop"})
	love.window.setTitle("Snake")
	dead = false

	player:pos()
	movementLockD = 0
	movementLock = 0
	lockTime = 10

	tailTurnConstant = 4.5
	tails = 2

	isItDone = "Not yet"

	for i=1, tails do
		tailList[i] = tail:new()
		tailList[i]:pos(player.x+1-20*i, player.y+1, player.direction)
		tailList[i]:turnInitialize()
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
		player.direction = player.direction + 90
		movementLock = lockTime	
		for i=1, table.getn(tailList) do
			tailList[i]:turnSet((i-1)*4+tailTurnConstant, 1)
		end
		isItDone = "Yes"

	end

	if love.keyboard.isDown('d') and movementLockD <= 0 then
		player.direction = player.direction - 90
		movementLockD = lockTime
		for i=1, table.getn(tailList) do
			tailList[i]:turnSet((i-1)*4+tailTurnConstant, -1)

		end
		isItDone = "Yes"
	end

	movementLock = movementLock - 1
	movementLockD = movementLockD - 1

	--movement
	if player.direction == -90 then
		player.direction = 270
	end

	if player.direction == 360 then
		player.direction = 0
	end

	if player.direction == 0 then
		player.x = player.x + player.speed
		
	end

	if player.direction == 90 then
		player.y = player.y - player.speed
		
	end

	if player.direction == 180 then
		player.x = player.x - player.speed
		
	end

	if player.direction == 270 then
		player.y = player.y + player.speed
		
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
		player = {}
		tailList = {}
		
		dead = false

		player.x = love.graphics.getWidth() / 4
		player.y = love.graphics.getHeight() / 2
		player.speed = 5
		player.direction = 0
		movementLockD = 0
		movementLock = 0
		lockTime = 8

		tailTurnConstant = 4.5
		tails = 2

		isItDone = "Not yet"

		for i=1, tails do
			tailList[i] = tail:new()
			tailList[i]:pos(player.x+1-20*i, player.y+1, player.direction)
			tailList[i]:turnInitialize()
		end
		

		actualFood = food:new()
		actualFood:pos()
	end

end

function love.draw( ... )

	love.graphics.setColor(255, 255, 0)
	love.graphics.rectangle("line",player.x, player.y, 20, 20)

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