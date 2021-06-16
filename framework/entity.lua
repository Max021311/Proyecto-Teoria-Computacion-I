Class = require('lib.hump.class')
Vector = require('lib.hump.vector')

---@class Entity
---@field public drawOrder number|nil @Default is 3
---@field public isDestroyed boolean @Default is false
local Entity = Class {}

---@param x number
---@param y number
function Entity:init(x, y)
  self.position = Vector(x, y)
  self.manager = nil
  self.hitbox = nil
  self.isDestroyed = false
  self.destroyCallback = nil
end

---@param vector Vector
function Entity:move(vector)
  if self.hitbox and not self.isWall then
    self.hitbox:move(vector)
  end
end

---@param collider table
function Entity:registerCollision(collider)
end

function Entity:onDestroy(fn)
  self.destroyCallback = fn
end

function Entity:onCollide(other)
end

function Entity:draw()
end

function Entity:destroy()
  self.isDestroyed = true
  if self.destroyCallback then
    self.destroyCallback()
  end

  if self.hitbox then
    self.hitbox:destroy()
  end
end

function Entity:update(dt)
end

return Entity
