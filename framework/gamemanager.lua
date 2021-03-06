Class = require('lib.hump.class')
Bump = require('lib.bump')
Timer = require 'lib.hump.timer'

---@class Manager
---@field private entities table Array with entities for manage
---@field private collider table Collider manager
---@field private count number
---@field public player Player|nil
Manager = Class {}

function Manager:init()
  self.entities = {}
  self.count = 0
  self.collider = Bump.newWorld()
  self.player = nil
end

---@param entity Entity
function Manager:addEntity(entity)
  entity.manager = self

  if not entity.drawOrder then
    entity.drawOrder = 3
  end

  if entity.registerCollision then
    entity:registerCollision(self.collider)
  end

  if entity.type == 'player' then
    self.player = entity
  end

  self.count = self.count + 1
  table.insert(self.entities, entity)
end

function Manager:update(dt)
  Timer.update(dt)
  local i = 1
  local entityTable = self.entities
  while i <= #entityTable do
    entityTable[i]:update(dt)
    if entityTable[i] and entityTable[i].isDestroyed then
      table.remove(self.entities, i)
      self.count = self.count - 1
    else
      i = i + 1
    end
  end
end

function Manager:draw()
  love.graphics.setColor(255, 255, 255)
  for i = 1, 5, 1 do
    for _, object in ipairs(self.entities) do
      if object.drawOrder == i then
        object:draw()
      end
    end
  end
end

function Manager:drawLayer(layerNo)
  love.graphics.setColor(255, 255, 255)
  for _, object in ipairs(self.entities) do
    if object.draworder == layerNo then
      object:draw()
    end
  end
end

function Manager:destroyAll(type)
  local i = 1
  local entityTable = self.entities
  while i <= #entityTable do
    if entityTable[i].type == type or not type then
      self.entities[i]:destroy()
      table.remove(self.entities, i)
      self.count = self.count - 1
    else
      i = i + 1
    end
  end
end

return Manager
