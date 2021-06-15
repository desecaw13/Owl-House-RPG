loveframes = require('loveframes')
gui = require('gui')
oop = require('oop')

function love.load()
	player = oop.person{
		sprite = oop.newImage('tmpluz.png')--TODO images in sprite (batch thing)
	}

	ent = oop.entity{x=100, y=100}
	ent.sprite:SetPos(ent.x, ent.y)
	-- TODO figure out how to have imgBut move better

	loveframes.SetActiveSkin('Dark red')
end

function love.draw()
	loveframes.draw()
end

mx, my = 0, 0 --how to better?
function love.update(dt)
	if love.mouse.isDown(1) then
		mx, my = love.mouse.getPosition()
	end
	move(player, mx, my) --TODO don't call every frame, only when moveing ?
	player.sprite:SetPos(player.x - player.sprite:GetWidth() / 2, player.y - player.sprite:GetHeight() / 2)--move to move()?
	-- calculate route, around obstacles, between player starting point and ending point

	loveframes.update(dt)
end

function love.mousepressed(x, y, button)
	loveframes.mousepressed(x, y, button)
end

function love.mousereleased(x, y, button)
	loveframes.mousereleased(x, y, button)
end

function love.keypressed(key, scancode, isrepeat)
	if key == 'e' and not gui.isOpen then
		gui.openStat(player)
	end

	loveframes.keypressed(key, isrepeat)
end

function love.keyreleased(key)
	loveframes.keyreleased(key)
end

function love.textinput(text)
	loveframes.textinput(text)
end

function move(obj, x, y)
	if not (compare(x, obj.x, obj.speed) and compare(y, obj.y, obj.speed)) then
		run = x - obj.x
		rise = y - obj.y
		mag = math.sqrt((rise ^ 2) + (run ^ 2))
		vx = run / mag
		vy = rise / mag

		obj.x = obj.x + vx * obj.speed
		obj.y = obj.y + vy * obj.speed
    end
end

function compare(n1, n2, margin)
	return (n1 < n2 + 0.5 * margin) and (n1 > n2 - 0.5 * margin)
end
