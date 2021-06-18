local Class = require 'lib.hump.class'
local Entity = require 'framework.entity'
local Hitbox = require 'framework.hitbox'

---@class Enemy :Entity
local Enemy =
  Class {
  __includes = Entity
}

function Enemy:init(x, y)
  Entity.init(self, x, y)
  self.type = 'enemy'
  self.speed = 250
end

function Enemy:registerCollision(collider)
  local x, y = self.position:unpack()
  self.hitbox = Hitbox(self, collider, x, y, 32, 32, true)
end

function Enemy:draw()
  if self.hitbox and Debug then
    self.hitbox:draw()
  end
  love.graphics.rectangle('line', self.position.x, self.position.y, 32, 32)
end

function Enemy:update(dt)
end

return Enemy
