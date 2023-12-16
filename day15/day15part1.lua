local function hash(str)
  local value = 0
  for c in str:gmatch(".") do
    value = ((value + c:byte()) * 17) % 256
  end
  return value
end

local file = io.open("input")
local input = file:read("*a")
file:close()

local sum = 0

for s in input:gmatch("[^%,\n]+") do
  sum = sum + hash(s)
end

print(sum)
