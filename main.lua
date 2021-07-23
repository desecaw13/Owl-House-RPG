loveframes = require('loveframes')
gui = require('gui')
oop = require('oop')

function love.load()
	paused = false

	player = oop.person()
	player:setImage('tmpluz.png')--TODO images in sprite (batch thing)

	--ent = oop.entity{x=100, y=100}
	--ent:teleport(ent.x, ent.y)
	npc = oop.person{x=100, y=100}
	npc:setImage('devTexture.png')
	npc:teleport(npc.x, npc.y)

	loveframes.SetActiveSkin('Dark red')
end

function love.draw()
	loveframes.draw()
end

mx, my = 0, 0 --how to better?
function love.update(dt)
	if love.mouse.isDown(1) and not paused and not loveframes.hoverobject then
		mx, my = love.mouse.getPosition()
		there = false
	end
	if not there and not paused then
		there = player:move(mx, my) -- make "there" a prop of player/entity ?
	end
	loveframes.update(dt)
end

function love.mousepressed(x, y, button)

	loveframes.mousepressed(x, y, button)
	
	local menu = loveframes.hoverobject and loveframes.hoverobject.menu
	if menu and button == 2 then
		menu:SetPos(x, y)
		menu:SetVisible(true)
		menu:MoveToTop()
	end
end

function love.mousereleased(x, y, button)
	loveframes.mousereleased(x, y, button)
end

function love.keypressed(key, scancode, isrepeat)
	if key == 'e' and not gui.isOpen then
		paused = true
		gui.openStat(player)
	elseif key == 'e' then
		paused = false
		gui.isOpen:Remove()
		gui.isOpen = false
	end

	loveframes.keypressed(key, isrepeat)
end

function love.keyreleased(key)
	loveframes.keyreleased(key)
end

function love.textinput(text)
	loveframes.textinput(text)
end

function compare(n1, n2, margin)
	return (n1 < n2 + 0.5 * margin) and (n1 > n2 - 0.5 * margin)
end
