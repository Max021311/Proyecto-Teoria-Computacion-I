Class = require('lib.hump.class')
Vector = require('lib.hump.vector')

---@class Entity
---@field public new "function(x, y) return Entity"
---@field public drawOrder number|nil
---@field public isDestroyed boolean
Entity =
  Class {
  init = function(self, x, y)
    self.position = Vector(x, y)
    self.manager = nil
  end
}

Entity.isDestroyed = false
Entity.hitbox = nil
Entity.destroyCallback = nil

function Entity:move(vector)
  self.position = self.position + vector

  if self.hitbox then
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
