Logger = require('lib.logger')
StateManager = require 'lib.hump.gamestate'
Game = require 'states.game'

if os.getenv('LOCAL_LUA_DEBUGGER_VSCODE') == '1' then
  require('lldebugger').start()
end

function love.load(args)
  Logger.info('Inicializando el juego')
  StateManager.switch(Game)
end

function love.update(dt)
  StateManager.update(dt)
end

function love.draw()
  StateManager.draw()
end
