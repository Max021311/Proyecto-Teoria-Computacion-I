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
  self.health = 10
  self.speed = 225
  self.width = 32
  self.height = 32
  self.invincible = false
  self.removing = false
end

function Player:registerCollision(collider)
  local x, y = self.position:unpack()

  self.hitbox = Hitbox(self, collider, x, y, self.width, self.height, true)
end

function Player:draw()
  if self.hitbox and Debug then
    self.hitbox:draw()
  end
  love.graphics.circle('line', self.position.x + self.width / 2, self.position.y + self.height / 2, self.width / 2)
end

function Player:update(dt)
  if love.keyboard.isDown('escape') or self.health <= 0 then
    self.health = 0
    if not self.removing then
      Timer.script(
        function(wait)
          self.removing = true
          wait(1)
          self.position.x = self.position.x + self.width / 4
          self.position.y = self.position.y + self.height / 4
          self.width = self.width / 2
          self.height = self.height / 2
          wait(1)
          self.position.x = self.position.x - (self.width / 2)
          self.position.y = self.position.y - (self.height / 2)
          self.width = self.width * 2
          self.height = self.height * 2
          wait(1)
          self:destroy()
          self.manager.player = nil
        end
      )
    end
    return
  end

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
    self.health = self.health - otherEntity.damage
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
