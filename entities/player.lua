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
  self.speed = 225
  self.width = 32
  self.height = 32
  self.invincible = false
end

function Player:registerCollision(collider)
  local x, y = self.position:unpack()

  self.hitbox = Hitbox(self, collider, x, y, self.width, self.height, true)
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

function Player:onCollide(otherEntity)
  if otherEntity.type == 'attack' and not self.invincible then
    Hits = Hits + 1
    self.invincible = true
    Timer.after(
      2,
      function()
        self.invincible = false
      end
    )
  end
end

return Player
