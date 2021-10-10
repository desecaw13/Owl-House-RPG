local gui = {}
--todo: loveframes' state system
gui.isOpen = false

gui.openStart = function()
	local f = loveframes.Create('frame')
	f:SetName('Start')
	f:SetSize(love.graphics.getDimensions())
	f:SetDraggable(false):SetScreenLocked(true)
	f:MakeTop():SetModal(true)
	f:ShowCloseButton(false)

	local title = loveframes.Create('text', f):SetText('Owl House'):SetFont(love.graphics.newFont(24))
	title:SetPos(400-title:GetWidth()/2, 60)

	local gb = loveframes.Create('button', f):SetText('Play Game'):SetSize(120, 60):SetPos(340, 180)
	local cb = loveframes.Create('button', f):SetText('Credits'):SetSize(120, 60):SetPos(340, 320)
	local qb = loveframes.Create('button', f):SetText('Quit'):SetSize(120, 60):SetPos(340, 450)

	gb.OnClick = function() gui.openPlay(); f:Remove() end
	cb.OnClick = function() gui.openCredits(); f:Remove() end
	qb.OnClick = function() love.event.quit(); f:Remove() end

	gui.isOpen = f
end

gui.openPlay = function()
	local f = loveframes.Create('frame')
	f:SetName('Play')
	f:SetSize(love.graphics.getDimensions())
	f:SetDraggable(false):SetScreenLocked(true)
	f:MakeTop():SetModal(true)
	f:ShowCloseButton(false)

	local function newOption(txt, val, x, y, p)
		local elmt = {}

		elmt.txt = loveframes.Create('text', p):SetText(txt):SetPos(x, y)
		elmt.but = loveframes.Create('button', p):SetText(val):SetPos(x + elmt.txt:GetWidth(), y + (elmt.txt:GetHeight() - 20) / 2 + 1):SetHeight(20)

		return elmt
	end

	local nb = loveframes.Create('button', f):SetText('New Game'):SetSize(100, 50)
	nb:SetPos(400-nb:GetWidth()/2, 75)
	nb.OnClick = function() gui.isOpen = false; f:Remove() end --todo: start a new game

	local p = loveframes.Create('panel', f):SetSize(680, 330):SetPos(60, 170)

	--todo: list saves

	local bb = loveframes.Create('button', f):SetText('Back')
	bb:SetPos(800-bb:GetWidth()-60, 600-60)
	bb.OnClick = function() gui.openStart(); f:Remove() end

	gui.isOpen = f
end

gui.openCredits = function()
	local f = loveframes.Create('frame')
	f:SetName('Credits')
	f:SetSize(love.graphics.getDimensions())
	f:SetDraggable(false):SetScreenLocked(true)
	f:MakeTop():SetModal(true)
	f:ShowCloseButton(false)

	local p = loveframes.Create('list', f):SetSize(680, 425):SetPos(60, 75)
	p:SetPadding(30):SetSpacing(30)

	ct = {
		{
			name = 'LÖVE',
			desc = 'For the engine, its documentation, and its forum',
			url = 'https://love2d.org/',
			image = nil
		},
		{
			name = 'Dana Terrace and The Owl House crew',
			desc = 'For making an amazing show and world',
			url = nil,
			image = nil
		},
		{
			name = 'Lua',
			desc = 'The language and its documentation',
			url = 'https://www.lua.org/',
			image = nil
		},
		{
			name = 'Kenny Shields and contributors',
			desc = 'For the GUI LoveFrames',
			url = 'fork?',
			image = nil
		},
		{
			name = 'StackOverflow',
			desc = '[Closed]',
			url = 'https://stackoverflow.com/',
			image = nil
		},
		{
			name = 'name',
			desc = 'desc',
			url = 'https://example.com/',
			image = 'devTexture.png'
		},
		--[[{
			name = '',
			desc = '',
			image = nil
			url = '',
		},]]
	}

	local function newCredit(name, desc, url, image, x, y)
		local elmt = {}

		elmt.p = loveframes.Create('panel'):SetSize(620, 60):SetPos(x, y)

		elmt.name = loveframes.Create('text', elmt.p):SetText(name):SetFont(love.graphics.newFont(14))
		elmt.desc = loveframes.Create('text', elmt.p):SetText(desc)
		elmt.url = loveframes.Create('text', elmt.p):SetLinksEnabled(true):SetDetectLinks(true)
		elmt.url:SetText(url)
		elmt.url.OnClickLink = function(obj, url) love.system.openURL(url) --[[todo: error message]] end

		local taken = elmt.name:GetWidth() + elmt.desc:GetWidth() + elmt.url:GetWidth()
		local size = 4
		local buff = 30
		if image then
			size = size + 1
			buff = 0
			elmt.image = loveframes.Create('image', elmt.p):SetImage(image)
			elmt.image:SetSize(30, 30)
			taken = taken + elmt.image:GetWidth()
			elmt.image:SetPos(30, 30-elmt.image:GetHeight()/2)
		end
		
		local totalpad = elmt.p:GetWidth() - taken
		local padding = totalpad / (size - 1)

		elmt.name:SetPos(elmt.image and (elmt.image:GetStaticX()+elmt.image:GetWidth()+padding/2) or 30, 30-elmt.name:GetHeight()/2)
		elmt.desc:SetPos(elmt.name:GetStaticX()+elmt.name:GetWidth()+padding, 30-elmt.desc:GetHeight()/2)
		elmt.url:SetPos(elmt.desc:GetStaticX()+elmt.desc:GetWidth()+padding, 30-elmt.url:GetHeight()/2)

		return elmt
	end

	for i, c in ipairs(ct) do
		local e = newCredit(c.name, c.desc, c.url, c.image, 30, (90*(i-1))+25)
		p:AddItem(e.p)
	end

	local bb = loveframes.Create('button', f):SetText('Back')
	bb:SetPos(800-bb:GetWidth()-60, 600-60)
	bb.OnClick = function() gui.openStart(); f:Remove() end

	gui.isOpen = f
end

gui.openStat = function(ent)
	local f = loveframes.Create('frame')
	f:SetSize(love.graphics.getDimensions())
	f:SetName('Stat Sheet')
	f:SetDraggable(false):SetScreenLocked(true)
	f:MakeTop()--:SetModal(true)
	f.OnClose = function(obj) gui.isOpen = false end

	local function newStat(txt, val, x, y, p)
		local elmt = {}

		elmt.txt = loveframes.Create('text', p):SetText(txt..': '):SetPos(x, y)
		elmt.but = loveframes.Create('button', p):SetText(val):SetPos(x + elmt.txt:GetWidth(), y + (elmt.txt:GetHeight() - 20) / 2 + 1):SetHeight(20)

		return elmt
	end
	local function newPBS(txt, val, x, y, p)
		local elmt = {}

		elmt.txt = loveframes.Create('text', p):SetText(txt..': '):SetPos(x, y)
		elmt.pb = loveframes.Create('progressbar', p):SetValue(val):SetPos(x + elmt.txt:GetWidth(), y):SetSize(100, 15)

		return elmt
	end

	-- instead of local put them in a table?

	local infoP = loveframes.Create('panel', f)
	infoP:SetPos(45, 50):SetSize(250, 165)
	local nameE = newStat('Name', ent.name, 40, 20, infoP)
	local genderE = newStat('Gender', ent.gender, 40, 55, infoP)
	local speciesE = newStat('Species', ent.species, 40, 90, infoP)
	--[[local pnE = {}
	pnE.txt = loveframes.Create('text', infoP):SetText('Pronouns: '):SetPos(40, 125)
	pnE.lst = loveframes.Create('button', infoP):SetText(ent.pn.case1..'/'..ent.pn.case2):SetPos(40 + pnE.txt:GetWidth(), 125 + (pnE.txt:GetHeight() - 20) / 2 + 1):SetHeight(20) --tmp
	]]
	local pnE newStat('Pronouns', ent.pn, 40, 125, infoP)

	local statP = loveframes.Create('panel', f) -- todo: descriptions are prewritten text that change based on the value of the stat
	statP:SetPos(45, 350):SetSize(500, 200)
	local vitalityE = newStat('Vitality', ent.vitality, 40, 15, statP)
	local vDesc = loveframes.Create('text', statP):SetText('description'):SetPos(240, 15)

	local essenceE = newStat('Essence', ent.essence, 40, 65, statP)
	local eDesc = loveframes.Create('text', statP):SetText('description'):SetPos(240, 65)

	local agilityE = newStat('Agility', ent.agility, 40, 115, statP)
	local aDesc = loveframes.Create('text', statP):SetText('description'):SetPos(240, 115)

	local luckE = newStat('Luck', ent.luck, 40, 165, statP)
	local lDesc = loveframes.Create('text', statP):SetText('description'):SetPos(240, 165)

	local imgP = loveframes.Create('panel', f)
	imgP:SetPos(565, 50):SetSize(200, 300)
	local img = loveframes.Create('image', imgP):SetImage(ent.sprite:GetImage()):Center() -- placeholder

	local barP = loveframes.Create('panel', f)
	barP:SetPos(320, 50):SetSize(210, 130)
	local lb = newPBS('Level', ent.level, 35, 20, barP)
	lb.but = loveframes.Create('button', barP):SetText(ent.level):SetPos(10, 20 + (lb.txt:GetHeight() - 20) / 2 + 1):SetSize(20, 20)

	local hb = newPBS('Health', ent.health, 35, 55, barP)

	local mb = newPBS('Mana', ent.mana, 35, 90, barP)

	gui.isOpen = f
end

--[[gui.openScreen = function()
	local f = loveframes.Create('frame')
	f:SetName('todo')
	f:SetSize(love.graphics.getDimensions())
	f:SetDraggable(false):SetScreenLocked(true)
	f:MakeTop()--:SetModal(true)
	f:ShowCloseButton(false)
	f.OnClose = function() gui.isOpen = false end

	local function newOption(txt, val, x, y, p)
		local elmt = {}

		elmt.txt = loveframes.Create('text', p):SetText(txt):SetPos(x, y)
		elmt.but = loveframes.Create('button', p):SetText(val):SetPos(x + elmt.txt:GetWidth(), y + (elmt.txt:GetHeight() - 20) / 2 + 1):SetHeight(20)

		return elmt
	end
	local function newProgBar(txt, val, x, y, p)
		local elmt = {}

		elmt.txt = loveframes.Create('text', p):SetText(txt..': '):SetPos(x, y)
		elmt.pb = loveframes.Create('progressbar', p):SetValue(val):SetPos(x + elmt.txt:GetWidth(), y):SetSize(100, 15)

		return elmt
	end

	--todo

	local bb = loveframes.Create('button', f):SetText('Back')
	bb:SetPos(800-bb:GetWidth()-60, 600-60)
	bb.OnClick = function() --[gui.openOther() OR gui.isOpen = false]; f:Remove() end

	gui.isOpen = f
end]]

return gui