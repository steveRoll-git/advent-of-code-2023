local width, height
local galaxies = {}
local xLookup = {}
local yLookup = {}

do
  local y = 0
  for l in io.lines("input") do
    if not width then
      width = #l
    end
    local x = 0
    for c in l:gmatch(".") do
      if c == "#" then
        xLookup[x] = true
        yLookup[y] = true
        table.insert(galaxies, {x = x, y = y})
      end
      x = x + 1
    end
    y = y + 1
    height = y
  end
end

for y = height, 1, -1 do
  if not yLookup[y] then
    for _, g in ipairs(galaxies) do
      if g.y > y then
        g.y = g.y + 999999
      end
    end
  end
end

for x = width, 1, -1 do
  if not xLookup[x] then
    for _, g in ipairs(galaxies) do
      if g.x > x then
        g.x = g.x + 999999
      end
    end
  end
end

local sum = 0

for i = 1, #galaxies do
  local a = galaxies[i]
  for j = i + 1, #galaxies do
    local b = galaxies[j]
    sum = sum + math.abs(a.x - b.x) + math.abs(a.y - b.y)
  end
end

print(sum)
