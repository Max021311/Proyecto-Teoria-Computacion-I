local Class = require 'lib.hump.class'
local Entity = require 'framework.entity'
local Hitbox = require 'framework.hitbox'
local FSM = require 'machine.enemy-fsm'
local Attack = require 'entities.attack'

---@class Enemy :Entity
local Enemy =
  Class {
  __includes = Entity
}

function Enemy:init(x, y)
  Entity.init(self, x, y)
  self.type = 'enemy'
  self.speed = 175
  ---@type EnemyFSM
  self.fsm = FSM
  self.width = 32
  self.height = 32
  self.inDelay = false
  self.delay = 0.5
end

function Enemy:registerCollision(collider)
  local x, y = self.position:unpack()
  self.hitbox = Hitbox(self, collider, x, y, self.width, self.height, true)
end

function Enemy:draw()
  if self.hitbox and Debug then
    self.hitbox:draw()
  end
  love.graphics.rectangle('line', self.position.x, self.position.y, 32, 32)
end

function Enemy:update(dt)
  if Debug then
    Logger.debug(self.fsm.current)
  end

  local player = nil
  local distInX = 0
  local distInY = 0

  if self.manager.player then
    player = self.manager.player
    distInX = math.abs((self.position.x + self.width / 2) - (player.position.x + player.width / 2))
    distInY = math.abs((self.position.y + self.height / 2) - (player.position.y + player.height / 2))
  end

  if self.fsm:is('waiting') then
    if player then
      if distInX <= 38 and distInY <= 38 then
        self.fsm:a()
      else
        self.fsm:b()
      end
    else
      self:destroy()
    end
  elseif self.fsm:is('attacking') then
    if distInX <= 40 and distInY <= 40 and not self.inDelay then
      self.manager:addEntity(Attack(player.position.x, player.position.y))
      self.inDelay = true
      Timer.after(
        self.delay,
        function()
          self.inDelay = false
        end
      )
    else
      self.fsm:b()
    end
  elseif self.fsm:is('moving') then
    if not player then
      self.fsm:b()
    else
      local x, y = 0, 0

      if self.position.x < player.position.x and distInX > 4 and distInX ~= 32 then
        x = self.speed * dt
      elseif self.position.x > player.position.x and distInX > 4 and distInX ~= 32 then
        x = -self.speed * dt
      end

      if self.position.y < player.position.y and distInY > 4 and distInY ~= 32 then
        y = self.speed * dt
      elseif self.position.y > player.position.y and distInY > 4 and distInY ~= 32 then
        y = -self.speed * dt
      end

      if x == 0 and y == 0 then
        self.fsm:a()
      end

      self:move(Vector(x, y))
    end
  end
end

return Enemy
