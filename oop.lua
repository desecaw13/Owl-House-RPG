local oop = {} -- contains classes, not instances

oop.newImage = function(filename)
	local img = loveframes.Create('image'):SetImage(filename)
	local m = loveframes.Create('menu')
	m:AddOption('Move to', false, function() mx=m:GetX() my=m:GetY() there=false end) -- this is bad code i know
	m:AddOption('text', false, function() end)
	m:SetVisible(false)
	img.menu = m
	return img
end

oop.map = setmetatable({
	name = 'PLACE'
}, {
	__call = function(self, o) return setmetatable(o or {}, {__index = self}) end
})

oop.entity = setmetatable({
	name = 'THING',
	pn = 'it/its',-- todo with actual grammer
	x = 0, y = 0,
	sprite = oop.newImage('devTexture.png')
	
}, {
	__call = function(self, o) return setmetatable(o or {}, {__index = self}) end
	})
function oop.entity.move(self, x, y)
	if not (compare(x, self.x, self.speed) and compare(y, self.y, self.speed)) then
		run = x - self.x
		rise = y - self.y
		mag = math.sqrt((rise ^ 2) + (run ^ 2))
		vx = run / mag
		vy = rise / mag

		self.x = self.x + vx * self.speed
		self.y = self.y + vy * self.speed
		
		self.sprite:SetPos(self.x - self.sprite:GetWidth() / 2, self.y - self.sprite:GetHeight() / 2)
		self.sprite.menu:SetPos(self.x, self.y)
	else
		return true
    end
end
--oop.entity.teleport(self, x, y)
function oop.entity.damage(self, n)
	self.health = self.health - n
end

oop.person = setmetatable({
	name = 'NAME',
	pn = 'they/them',--{}
	gender = 'DEFAULT',
	species = 'tmp',--todo
	level = 1,
	health = 1,
	mana = 1,
	vitality = 1,
	essence = 1,
	agility = 1,
	luck = 1,
	speed = 2
}, {
	__call = function(self, o) return setmetatable(oop.entity(o), {__index = self}) end,
	__index = oop.entity
	})
function oop.person.attack(self, target) -- tmp because of spells
	-- check if can attack, then agility vs [spell's OR self's] to-hit(?)
	-- if can attack then do
	target:damage(5)
end

return oop