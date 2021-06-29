local oop = {} -- contains classes, not instances

oop.newImage = function (filename) return loveframes.Create('imagebutton'):SetImage(filename):SetText(''):SizeToImage() end -- move to gui ?

oop.map = setmetatable({
	name = 'PLACE'
}, {
	__call = function (self, o) return setmetatable(o or {}, {__index = self}) end
})

oop.entity = setmetatable({
	name = 'THING',
	pn = 'it/its',-- todo with actual grammer
	x = 0, y = 0,
	sprite = oop.newImage('devTexture.png')
	
}, {
	__call = function (self, o) return setmetatable(o or {}, {__index = self}) end
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
    end
	
	self.sprite:SetPos(self.x - self.sprite:GetWidth() / 2, self.y - self.sprite:GetHeight() / 2)
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
	__call = function (self, o) return setmetatable(oop.entity(o), {__index = self}) end,
	__index = oop.entity
	})

return oop