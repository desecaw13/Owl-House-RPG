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
	--love.graphics.print()
	-- make a table of all objects that should be rendered and go through it drawing them
	love.graphics.draw(player.image,player.trans)
end

mx,my = 0,0
function love.update(dt)
	if love.mouse.isDown(1) then
		mx,my = love.mouse.getPosition()
	end
	move(player,mx,my)
	-- calculate route (use love.physics for obstacles) between player starting point and ending point
end

function move(obj,x,y)
	if not (compare(x,obj.body:getX()) and compare(y,obj.body:getY())) then
		run = x - obj.body:getX()
		rise = y - obj.body:getY()
		mag = math.sqrt((rise^2) + (run^2))
		vx = run / mag
		vy = rise / mag
		
		obj.body:setX(obj.body:getX() + vx)
		obj.body:setY(obj.body:getY() + vy)
	
		obj.trans = love.math.newTransform(obj.body:getX() - obj.image:getWidth()/2, obj.body:getY() - obj.image:getHeight()/2)
	end
end

function compare(n1,n2)
	return (n1 < n2 + 0.5) and (n1 > n2 - 0.5)
end
