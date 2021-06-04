local oop = {} -- contains classes, not instances

local mt = {
	--__name dosn't work (lua 5.1)
	__call = function (self, o) return setmetatable(o or {}, {__index = self}) end
}

local entity = {
	name = 'THING',
	pn = 'it/its',--{}
	--id = --generate for each instance ?
	x = 0, y = 0,
	sprite = 'image'--default is [?]
}
setmetatable(entity, mt)

local person = entity{
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
setmetatable(person, mt)

oop.entity = entity --hm, no likey

oop.person = person

return oop