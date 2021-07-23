local oop = {} -- contains classes, not instances

oop.map = setmetatable({
	name = 'PLACE'
}, {
	__call = function(self, o) return setmetatable(o or {}, {__index = self}) end
})

oop.entity = setmetatable({
	name = 'THING',
	pn = 'it/its',-- todo with actual grammer
	x = 0, y = 0,

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
oop.entity.teleport = function(self, x, y)
	self.x = x
	self.y = y
	self.sprite:SetPos(x, y)
end
oop.entity.setImage = function(self, filename)
	local img = loveframes.Create('image'):SetImage(filename)
	local m = loveframes.Create('menu') -- todo how to make menu diffrent for each entity
	m:AddOption('Move to', false, function() mx=img:GetX()+img:GetWidth()/2 my=img:GetY()+img:GetHeight()/2 there=false end) -- this is bad code i know
	m:AddOption('Interact', false, function() print(self,self.name) end) -- might become a submenu
	--m:AddOption('text', false, function(self, text) end)
	m:SetVisible(false)
	--m.owner = self
	img.menu = m
	self.sprite = img
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
function oop.person.damage(self, n)
-- check if can attack, then agility vs [spell's OR self's] to-hit(?)
-- if can attack then do
	self.health = self.health - n
end

return oop