local sti = require 'lib.sti.init'
local Manager = require 'framework.gamemanager'
local Player = require 'entities.player'
local Wall = require 'entities.wall'
local Enemy = require 'entities.enemy'
local game = {}

function game:enter()
  love.window.setTitle('Game')
  Logger.info('Entrando al juego')
  self.manager = Manager()
  self.player = Player(32, 32)
  self.map = sti('maps/test.lua')
  self.manager:addEntity(self.player)
  self.manager:addEntity(Enemy(128, 128))
  for k, v in ipairs(self.map.layers.Wall.objects) do
    self.manager:addEntity(Wall(v.x, v.y, v.width, v.height, true))
  end
end

function game:update(dt)
  self.manager:update(dt)
end

function game:draw()
  self.map:draw()
  self.manager:draw()
end

return game
