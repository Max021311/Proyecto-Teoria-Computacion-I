Logger = require('lib.logger')

if os.getenv('LOCAL_LUA_DEBUGGER_VSCODE') == '1' then
  require('lldebugger').start()
end

function love.load(args)
  Message = 'Hello world'
end

function love.update(dt)
end

function love.draw()
  love.graphics.print(Message, 0, 0)
  Logger.warn({error = 500, msg = 'Error 500'})
end
