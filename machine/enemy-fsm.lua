local Machine = require 'lib.statemachine'
local ternary = require 'common.ternary'

---@class EnemyFSM
---@field public current string @Contains the current state
---@field public currentTransitionEvent string @Contains the current that is in transition
---@field public is fun(state:string) @Return true if the state is the current state
---@field public can fun(event:string):boolean @Return true if the event can  be fired
---@field public cannot fun(event:string):boolean @Return true if the event cannot be fired
---@field public attack fun():boolean @Fire the event and change the state if is posible. Return true if event change state
---@field public move fun():boolean @Fire the event and change the state if is posible. Return true if event change state
---@field public wait fun():boolean @Fire the event and change the state if is posible. Return true if event change state
local fsm =
  Machine.create(
  {
    initial = 'waiting',
    events = {
      {name = 'a', from = {'waiting', 'moving'}, to = 'attacking'},
      {name = 'a', from = 'attacking', to = 'waiting'},
      {name = 'b', from = {'waiting', 'attacking'}, to = 'moving'},
      {name = 'b', from = 'moving', to = 'waiting'}
    },
    callbacks = {
      onstatechange = function(self, event, from, to, msg)
        print(
          string.format('Event: %s. Changing from "%s" to "%s". Msg: %s', event, from, to, ternary(msg, msg, 'None'))
        )
      end
    }
  }
)

return fsm
