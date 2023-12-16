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

local boxes = {}
for i = 0, 255 do
  boxes[i] = {}
end

for label, op, n in input:gmatch("(%w+)([%=%-])(%d?)") do
  n = tonumber(n)
  local box = boxes[hash(label)]
  if op == "=" then
    for i, l in ipairs(box) do
      if l[1] == label then
        l[2] = n
        goto foundLens
      end
    end
    table.insert(box, {label, n})
    ::foundLens::
  elseif op == "-" then
    for i, l in ipairs(box) do
      if l[1] == label then
        table.remove(box, i)
        break
      end
    end
  end
end

local sum = 0

for i = 0, 255 do
  local box = boxes[i]
  for j, l in ipairs(box) do
    sum = sum + (i + 1) * j * l[2]
  end
end

print(sum)
