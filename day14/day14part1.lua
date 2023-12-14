local width, height
local function at(x, y)
  return y * width + x
end

local map = {}
local rocks = {}

local function isSolid(x, y)
  local m = map[at(x, y)]
  return y < 0 or m == "#" or m == "O"
end

do
  local y = 0
  for l in io.lines("input") do
    if not width then
      width = #l
    end
    local x = 0
    for c in l:gmatch(".") do
      map[at(x, y)] = c
      if c == "O" then
        table.insert(rocks, {x = x, y = y})
      end
      x = x + 1
    end
    y = y + 1
  end
  height = y
end

table.sort(rocks, function(a, b) return a.y < b.y end)

local sum = 0

for _, r in ipairs(rocks) do
  while not isSolid(r.x, r.y - 1) do
    map[at(r.x, r.y)] = "."
    r.y = r.y - 1
    map[at(r.x, r.y)] = "O"
  end

  sum = sum + (height - r.y)
end

print(sum)
