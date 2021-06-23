local sti = require 'lib.sti.init'
local Manager = require 'framework.gamemanager'
local Player = require 'entities.player'
local Wall = require 'entities.wall'
local Enemy = require 'entities.enemy'
local game = {}

function game:enter()
  Logger.trace('Entrando al juego')

  Logger.trace('Añadiendo el manejador del juego')
  self.manager = Manager()

  Logger.trace('Añadiendo al jugador')
  self.player = Player(32, 32)
  self.manager:addEntity(self.player)

  Logger.trace('Cargando el mapa y ajustando el tamaño de la ventana al mapa')
  self.map = sti('maps/test.lua')
  love.window.setMode(self.map.width * self.map.tilewidth, self.map.height * self.map.tileheight)

  Logger.trace('Añadiendo entidad enemiga')
  self.manager:addEntity(Enemy(128, 128))

  Logger.trace('Añadiendo entidades de tipo muro')
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
  love.graphics.setFont(love.graphics.newFont(18))
  love.graphics.print(self.player.health, 0, 0)
end

function game:keypressed(key, scancode, isrepeat)
  if key == 'r' then
    StateManager.switch(Game)
  end
end

return game
