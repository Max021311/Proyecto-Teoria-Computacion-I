Class = require 'lib.hump.class'
Vector = require 'lib.hump.vector'

function round(num, idp)
	local mult = 10 ^ (idp or 0)
	return math.floor(num * mult + 0.5) / mult
end

---@class Hitbox
Hitbox = Class {}

---@param entity Entity
---@param collider Collider
---@param l number Coordinate in X
---@param t number Coordinate in y
---@param w number width
---@param h number height
---@param centered boolean If true, center hitbox
function Hitbox:init(entity, collider, l, t, w, h, centered)
	self.entity = entity
	self.enabled = true
	if centered then
		self.l = l
		self.t = t
		self.w = w
		self.h = h
	else
		self.l = l - w / 2
		self.t = t - w / 2
		self.w = w
		self.h = h
	end
	self.removed = false
	self.collider = collider
	collider:add(self, l, t, w, h)
end

function Hitbox:move(v)
	if not self.removed then
		self.l = self.l + v.x
		self.t = self.t + v.y

		local actualX, actualY, collisions, len =
			self.collider:move(
			self,
			self.l,
			self.t,
			function(item, other)
				if other.entity.type == 'wall' then
					return 'slide'
				end
				if item.entity.type == 'enemy' and other.entity.type == 'player' then
					return 'slide'
				end
				if item.entity.type == 'player' and other.entity.type == 'enemy' then
					return 'slide'
				end
				if item.entity.type == 'player' and other.entity.type == 'attack' then
					return 'cross'
				end
			end
		)

		for _, col in ipairs(collisions) do
			if
				(not col.other.entity.isDestroyed and not col.item.entity.isDestroyed) and
					(col.item.entity.type ~= 'wall' and col.other.entity.type ~= 'wall')
			 then
				col.item.entity:onCollide(col.other.entity, col.item, col.other)
				col.other.entity:onCollide(col.item.entity, col.other, col.item)
			end
		end

		self.l = actualX
		self.t = actualY
		self.entity.position = Vector(actualX, actualY)
	end
end

function Hitbox:destroy()
	if not self.removed then
		self.removed = true
		self.collider:remove(self)
	end
end

function Hitbox:draw()
	if self.entity.type == 'wall' then
		love.graphics.setColor(255, 0, 0)
		love.graphics.rectangle('line', math.floor(self.l), math.floor(self.t), self.w, self.h)
		love.graphics.setColor(255, 255, 255)
	else
		love.graphics.setColor(255, 255, 255)
		love.graphics.rectangle('line', math.floor(self.l), math.floor(self.t), self.w, self.h)
	end
end

return Hitbox
