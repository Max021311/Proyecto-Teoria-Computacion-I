local sti = require 'lib.sti.init'
local Manager = require 'framework.gamemanager'
local Player = require 'entities.player'
local Wall = require 'entities.wall'
local game = {}

function game:enter()
  love.window.setTitle('Game')
  Logger.info('Entrando al juego')
  self.manager = Manager()
  self.player = Player(32, 32)
  self.map = sti('maps/test.lua')
  self.manager:addEntity(self.player)
  self.manager:addEntity(Wall(0, 0, 26, 128))
  self.manager:addEntity(Wall(0, 0, 128, 16))
end

function game:update(dt)
  self.manager:update(dt)
end

function game:draw()
  self.map:draw()
  self.manager:draw()
end

return game
