local sti = require 'lib.sti.init'
local Manager = require 'framework.gamemanager'
local game = {
  map = {}
}

function game:enter()
  love.window.setTitle('Game')
  self.map = sti('maps/test.lua')
  Logger.info('Entrando al juego')
  self.manager = Manager()
end

function game:draw()
  self.map:draw()
  for k, v in pairs(self.map.layers.Entities.objects) do
    if v.type == 'Player' then
    end
    if v.type == 'Enemy' then
    end
  end
end

return game
