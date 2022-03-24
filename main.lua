local lf = require('external.loveframes')
local view = require('view')
local logic = require('logic')

function love.load()
	lf.SetActiveSkin('Dark red')
end

function love.draw()
	lf.draw()
end

function love.update(dt)
	lf.update(dt)
end

function love.mousepressed(x, y, button)
	lf.mousepressed(x, y, button)
	
	-- fix for lf menus
	local menu = lf.hoverobject and lf.hoverobject.menu
	if menu and button == 2 then
		menu:SetPos(x, y)
		menu:SetVisible(true)
		menu:MoveToTop()
	end
end

function love.mousereleased(x, y, button)
	lf.mousereleased(x, y, button)
end

function love.keypressed(key, scancode, isrepeat)
	lf.keypressed(key, isrepeat)
end

function love.keyreleased(key)
	lf.keyreleased(key)
end

function love.textinput(text)
	lf.textinput(text)
end

function love.wheelmoved(x, y)
	lf.wheelmoved(x, y)
end
