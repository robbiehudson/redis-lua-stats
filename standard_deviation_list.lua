-- Calculate the SD of a list of integers
local type = redis("type", KEYS[1])
if type.ok ~= 'list' then return {err= "This operation requires a list as it\'s first key"} end
local sum = 0
local len = redis('llen', KEYS[1])
for i=0, len-1 do
   sum = sum + redis('lindex', KEYS[1], i)
end

local mean = tostring(sum / len)

-- now calculate the sum of deviation from the mean
sum = 0
for i=0, len-1 do
   sum = tostring(math.pow(redis('lindex', KEYS[1], i)-tonumber(mean), 2) + tonumber(sum))
end
if ARGV[1] == "population" then
	return tostring(math.sqrt(tonumber(sum) / len))
else
	return tostring(math.sqrt(tonumber(sum) / (len -1)))
end
