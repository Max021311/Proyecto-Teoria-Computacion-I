---@param cond boolean Condition of ternary operator
---@param T any Return this if the condition is True
---@param F any Return this if the condition is False
---@return any
return function(cond, T, F)
  if cond then
    return T
  else
    return F
  end
end
