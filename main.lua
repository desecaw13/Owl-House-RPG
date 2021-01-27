player = {}

function love.load()
	world = love.physics.newWorld()
	player = {
		body = love.physics.newBody(world, 0, 0, "dynamic"),
		trans = love.math.newTransform(0,0),
		image = love.graphics.newImage("img.png")
	}
end

function love.draw()
	love.graphics.draw(player.image,player.trans)
	-- make a table of all objects that should be rendered and go through it drawing them
	love.graphics.print("player: "..player.body:getX().." "..player.body:getY())
	love.graphics.print("mouse: "..love.mouse.getX().." "..love.mouse.getY(),0,10)
	love.graphics.print(vx.." "..vy.." L "..limit,0,20)
end

function love.update(dt)
	rDown = love.mouse.isDown(1)
	if rDown then
		mx,my = love.mouse.getPosition()
		move(player,mx,my)
		-- have a speed, calculate route (use love.physics for obstacles) between player starting point and ending point, move player from the start to end.
	end
end

vx,vy,limit = 0,0,0
function move(obj,x,y)
	--move body towards position(x,y):
	--get vector = (x,y)-(body x,y)
	--add (vector * speed) to body.position
	
	vx = x /2 - obj.body:getX() /2
	vy = y /2 - obj.body:getY() /2
	
	obj.body:setX(obj.body:getX() + vx)
	obj.body:setY(obj.body:getY() + vy)
	
	--[[
	limit = 0
	while limit < 10 or (vx ~= 0 and vy ~= 0) do-- why no work? 
		obj.body:setX(obj.body:getX() + vx)
		obj.body:setY(obj.body:getY() + vy)
		limit = limit + 1
	end
	for limit = 1,10 do-- idk any more
		if (vx ~= 0 and vy ~= 0) then
			obj.body:setX(obj.body:getX() + vx)
			obj.body:setY(obj.body:getY() + vy)
		else
			break;
		end
	end]]
	
	obj.trans = love.math.newTransform(obj.body:getX() - obj.image:getWidth() / 2, obj.body:getY() - obj.image:getHeight() / 2)
end
