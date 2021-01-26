player = {}

function love.load()
	player = {
		speed = 10,
		trans = love.math.newTransform(0,0),
		image = love.graphics.newImage("img.png")
	}
end

function love.draw()
	love.graphics.draw(player.image,player.trans)
	-- make a table of all objects that should be rendered and go through it drawing them
	love.graphics.print(x,y)
end

function love.update(dt)
	rDown = love.mouse.isDown(1)
	if rDown then
		mx,my = love.mouse.getPosition()
		move(player,mx,my)
		-- have a speed, calculate route between player starting point and ending point, move player from the start to end.
	end
end

function move(obj,x,y)
	obj.trans = love.math.newTransform(x - obj.image:getWidth() / 2, y - obj.image:getHeight() / 2)
end
