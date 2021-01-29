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
	love.graphics.print("epoint: "..x.." "..y,0,10)
	love.graphics.print("mouse: "..love.mouse.getX().." "..love.mouse.getY(),0,20)
	love.graphics.print("vector: "..vx.." "..vy.."\n"..done,0,30)
end

done = 0
function love.update(dt)
	if love.mouse.isDown(1)then
		mx,my = love.mouse.getPosition()
		x,y= move(player,mx,my)--x,y output is for debuging only, remove soon
	end
	-- calculate route (use love.physics for obstacles) between player starting point and ending point
end

vx,vy,x,y=0,0,0,0
function move(obj,x,y)
	if (x~=obj.body:getX() and y~=obj.body:getY()) or (wx~=0 and wy ~= 0) then
		vx = x/2 - obj.body:getX()/2
		vy = y/2 - obj.body:getY()/2
		obj.body:setX(obj.body:getX() + vx)
		obj.body:setY(obj.body:getY() + vy)
		obj.trans = love.math.newTransform(obj.body:getX() - obj.image:getWidth() / 2, obj.body:getY() - obj.image:getHeight() / 2)
	else
		done = 1--why if no work? try repeat?
	end
	return x,y
end
