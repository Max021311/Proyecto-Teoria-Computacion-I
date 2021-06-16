local Entity = require 'framework.entity'
local Class = require 'lib.hump.class'
local Hitbox = require 'framework.hitbox'

---@class Player :Entity
local Player =
  Class {
  __includes = Entity
}

function Player:init(x, y)
  Entity.init(self, x, y)
  self.type = 'player'
  self.lives = 3
  self.speed = 300
end

function Player:registerCollision(collider)
  local x, y = self.position:unpack()

  self.hitbox = Hitbox(self, collider, x, y, 32, 32, true)
end

function Player:draw()
  if self.hitbox and Debug then
    self.hitbox:draw()
  end
  love.graphics.circle('line', self.position.x + 16, self.position.y + 16, 16)
end

function Player:update(dt)
  local desiredDirection = Vector(0, 0)

  if love.keyboard.isDown('w', 'up') then
    desiredDirection.y = -(self.speed * dt)
  end
  if love.keyboard.isDown('s', 'down') then
    desiredDirection.y = self.speed * dt
  end
  if love.keyboard.isDown('d', 'right') then
    desiredDirection.x = self.speed * dt
  end
  if love.keyboard.isDown('a', 'left') then
    desiredDirection.x = -(self.speed * dt)
  end

  self:move(desiredDirection)
end

return Player
