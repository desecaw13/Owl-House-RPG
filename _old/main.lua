local loveframes = require('external.loveframes')
local gui = require('view.gui')
local oop = require('logic.oop')

local ents = {} -- entities

function love.load()
	gui.init(loveframes)
	gui.openStart() -- creates and displays main menu
	
	oop.init(loveframes)

	local p = oop.person()
	p:setImage('res/tmpluz.png')--TODO images in sprite (batch thing)
	ents.player = p

	local ent = oop.entity{x=100, y=100}
	ent:setImage('res/devTexture.png')
	ents.thing = ent

	local npc = oop.person{x=200, y=200}
	npc:setImage('res/devTexture.png')
	ents.npc = npc

	loveframes.SetActiveSkin('Dark red')
end

function love.draw()
	loveframes.draw()
end

mx, my = 0, 0 --how to better? put in class? make them local
there = nil

function love.update(dt)
	if love.mouse.isDown(1) and not gui.isOpen and not loveframes.hoverobject then
		mx, my = love.mouse.getPosition()
		there = false
	end
	if not there and not gui.isOpen then
		there = ents.player:move(mx, my) -- make `there` a prop of player/entity ?
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

local paused = nil

function love.keypressed(key, scancode, isrepeat)
	if key == 'e' and not gui.isOpen then
		paused = true
		gui.openStat(ents.player)
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

function love.wheelmoved(x, y)
	loveframes.wheelmoved(x, y)
end
