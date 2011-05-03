-- Command to compute the mean of a list of integers
local type = redis("type", KEYS[1])
if type.ok ~= 'list' then return {err= "This operation requires a list as it\'s first key"} end
local sum = 0
local len = redis('llen', KEYS[1])
for i=0, len-1 do
   sum = sum + redis('lindex', KEYS[1], i)
end
return tostring(sum / len)
