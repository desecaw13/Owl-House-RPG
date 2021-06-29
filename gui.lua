local gui = {
	isOpen = false,

	openStat = function (ent)
		gui.isOpen = true

		local f = loveframes.Create('frame')
		f:SetSize(love.graphics.getDimensions())
		f:SetName('Stat Sheet')
		f:SetDraggable(false):SetScreenLocked(true)
		f:MakeTop()--:SetModal(true)
		
		f.OnClose = function(obj) gui.isOpen = false end

		function newStat(txt, val, x, y, p)
			local elmt = {}

			elmt.txt = loveframes.Create('text', p):SetText(txt..': '):SetPos(x, y)
			elmt.but = loveframes.Create('button', p):SetText(val):SetPos(x + elmt.txt:GetWidth(), y + (elmt.txt:GetHeight() - 20) / 2 + 1):SetHeight(20)

			return elmt
		end
		function newPBS(txt, val, x, y, p)
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

		local statP = loveframes.Create('panel', f) -- TODO descriptions are prewritten text that change based on the value of the stat
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
	end
}
return gui