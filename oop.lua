local oop = {} -- contains classes, not instances

oop.entity = {
	name = 'THING',
	pn = 'it/its',--{}
	--id = --generate for each instance ?
	x = 0, y = 0,
	sprite = 'image'--default is [?]
}
setmetatable(oop.entity, {
	__call = function (self, o) return setmetatable(o or {}, {__index = self}) end,
	__index = oop.entity
	})

oop.person = oop.entity{
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
}
setmetatable(oop.person, {
	__call = function (self, o) return setmetatable(o or entity(), {__index = self}) end,
	__index = oop.person
	})

return oop