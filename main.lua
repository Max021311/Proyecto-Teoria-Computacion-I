Logger = require('lib.logger')
StateManager = require 'lib.hump.gamestate'
Game = require 'states.game'
Debug = false

if os.getenv('LOCAL_LUA_DEBUGGER_VSCODE') == '1' then
  require('lldebugger').start()
end

function love.load(args)
  for k, v in pairs(args) do
    if v == '-d' then
      Debug = true
    end
  end

  if Debug then
    Timer.every(
      2,
      function()
        Logger.debug(string.format('Memory used: %.2f MB', collectgarbage('count') / 1024))
      end
    )
  end

  Logger.trace('Iniciando el juego')
  StateManager.switch(Game)
end

function love.update(dt)
  StateManager.update(dt)
end

function love.draw()
  StateManager.draw()
end

function love.keypressed(key, scancode, isrepeat)
  StateManager.keypressed(key, scancode, isrepeat)
end
