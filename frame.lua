loveframes = require('loveframes')

function love.load()
	species = {human = 'HUMAN', witch = 'WITCH', demon = 'DEMON'} -- TODO with inheritance

	person = { -- TODO make person an inherited class of entity and then player a special instance of person.
		name = 'Player',
		gender = 'Joke',
		species = species.human, -- TODO
		pn = {case1 = 'ur', case2 = 'mom'}, -- TODO handle proper grammer

		level = 1,
		health = 1,
		mana = 1,
		vitality = 1,
		essence = 1,
		agility = 1,
		luck = 1,

		id = '1',
		body = 'PHYSICS', -- necessary?
		sprite = love.graphics.newImage('tmpluz.png')
	}

	loveframes.load()
end

function loveframes.load()
	loveframes.SetActiveSkin('Dark red') -- TODO move things

	local f = loveframes.Create('frame')
	f:SetSize(love.graphics.getDimensions())
	f:SetName('Stats: '..person.id)
	f:SetDraggable(false):SetScreenLocked(true)
	--f:MakeTop():SetModal(true)

	function newStat(txt, val, x, y, p)
		local elmt = {}

		elmt.txt = loveframes.Create('text', p):SetText(txt..': '):SetPos(x, y)
		elmt.but = loveframes.Create('button', p):SetText(val):SetPos(x + elmt.txt:GetWidth(), y + (elmt.txt:GetHeight() - 20) / 2 + 1):SetHeight(20)

		elmt.but.OnClick = function ()
			openInput(txt) -- tmp input
		end

		return elmt
	end
	function newPBS(txt, val, x, y, p)
		local elmt = {}

		elmt.txt = loveframes.Create('text', p):SetText(txt..': '):SetPos(x, y)
		elmt.pb = loveframes.Create('progressbar', p):SetValue(val):SetPos(x + elmt.txt:GetWidth(), y):SetSize(100, 15)

		-- ? tmp editing and functions ?

		return elmt
	end

	-- no for loop for initialization; use makeStat()
	-- instead of local put them in a table?

	local infoP = loveframes.Create('panel', f)
	infoP:SetPos(45, 50):SetSize(250, 165)
	local nameE = newStat('Name', person.name, 40, 20, infoP)
	local genderE = newStat('Gender', person.gender, 40, 55, infoP)
	local speciesE = newStat('Species', person.species, 40, 90, infoP)
	local pnE = {}
	pnE.txt = loveframes.Create('text', infoP):SetText('Pronouns: '):SetPos(40, 125)
	pnE.lst = loveframes.Create('button', infoP):SetText(person.pn.case1..'/'..person.pn.case2):SetPos(40 + pnE.txt:GetWidth(), 125 + (pnE.txt:GetHeight() - 20) / 2 + 1):SetHeight(20) -- TODO tmp
	-- tmp edit function?

	local statP = loveframes.Create('panel', f)
	statP:SetPos(45, 350):SetSize(500, 200)
	local vitalityE = newStat('Vitality', person.vitality, 40, 15, statP)
	local vDesc = loveframes.Create('text', statP):SetText('description'):SetPos(240, 15)

	local essenceE = newStat('Essence', person.essence, 40, 65, statP)
	local eDesc = loveframes.Create('text', statP):SetText('description'):SetPos(240, 65)

	local agilityE = newStat('Agility', person.agility, 40, 115, statP)
	local aDesc = loveframes.Create('text', statP):SetText('description'):SetPos(240, 115)

	local luckE = newStat('Luck', person.luck, 40, 165, statP)
	local lDesc = loveframes.Create('text', statP):SetText('description'):SetPos(240, 165)

	local imgP = loveframes.Create('panel', f)
	imgP:SetPos(565, 50):SetSize(200, 300)
	local img = loveframes.Create('image', imgP):SetImage(person.sprite) -- placeholder

	local barP = loveframes.Create('panel', f)
	barP:SetPos(320, 50):SetSize(210, 130)
	local lb = newPBS('Level', person.level, 35, 20, barP)
	lb.but = loveframes.Create('button', barP):SetText(person.level):SetPos(10, 20 + (lb.txt:GetHeight() - 20) / 2 + 1):SetSize(20, 20)

	local hb = newPBS('Health', person.health, 35, 55, barP)

	local mb = newPBS('Mana', person.mana, 35, 90, barP)
end

function alterStat(stat, value)
	if person[stat] == nil then
		stat = stat:sub(1,1):lower()..stat:sub(2)
		if person[stat] == nil then
			error('The stat "'..stat..'"'..' is not in table person.') -- TODO better handle for all types
		end
	end

	person[stat] = value

	-- how to change text too
end

function openInput(stat) -- tmp
	local ti = loveframes.Create("textinput"):SetSize(320,240):Center()

	ti.OnEnter = function(obj, text)
		if text == '' or text == nil then
			alterStat(stat, person[stat])
		else
			alterStat(stat, text)
		end
		ti:Remove()
	end
end

function love.draw()
	loveframes.draw()
end
function love.update(dt)
	loveframes.update(dt)
end
function love.mousepressed(x, y, button)
	loveframes.mousepressed(x, y, button)
end
function love.mousereleased(x, y, button)
	loveframes.mousereleased(x, y, button)
end
function love.keypressed(key, scancode, isrepeat)
	loveframes.keypressed(key, isrepeat)
end
function love.keyreleased(key)
	loveframes.keyreleased(key)
end
function love.textinput(text)
	loveframes.textinput(text)
end
