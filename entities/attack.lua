local Class = require 'lib.hump.class'
local Entity = require 'framework.entity'
local Hitbox = require 'framework.hitbox'

---@class Attack :Entity
local Attack =
  Class {
  __includes = Entity
}

---@param x number @Coordinate in x
---@param y number @Coordinate in y
function Attack:init(x, y)
  Entity.init(self, x, y)
  self.type = 'attack'
  self.width = 16
  self.height = self.width
end

function Attack:registerCollision(collider)
  local x, y = self.position:unpack()
  self.hitbox = Hitbox(self, collider, x + self.width / 2, y + self.height / 2, self.width, self.height, true)
  Timer.script(
    function(wait)
      wait(1)
      self.position.x = self.position.x + self.width / 2
      self.position.y = self.position.y + self.height / 2
      self.width = self.width / 2
      self.height = self.width
      wait(1)
      self:destroy()
    end
  )
end

function Attack:draw()
  if Debug then
    self.hitbox:draw()
  end
  love.graphics.setColor(255, 0, 0)
  love.graphics.circle('line', self.position.x + self.width, self.position.y + self.height, self.width / 2)
  love.graphics.setColor(255, 255, 255)
end

return Attack
