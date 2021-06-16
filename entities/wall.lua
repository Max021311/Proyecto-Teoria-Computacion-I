local Entity = require 'framework.entity'
local Hitbox = require 'framework.hitbox'
local Class = require 'lib.hump.class'

---@class Wall :Entity
---@field public hitbox Hitbox
local Wall =
  Class {
  __includes = Entity
}

---@param x number Position in x
---@param y number Position in y
---@param w number Width
---@param h number Height
function Wall:init(x, y, w, h)
  Entity.init(self, x, y)
  self.type = 'wall'
  self.w = w
  self.h = h
end

function Wall:registerCollision(collider)
  local x, y = self.position:unpack()
  self.hitbox = Hitbox(self, collider, x, y, self.w, self.h, true)
end

function Wall:draw()
  if Debug then
    self.hitbox:draw()
  end
end

return Wall
