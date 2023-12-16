local function dk(dx, dy)
  return dy * 3 + dx
end

local mirrors = {
  ["/"] = function(dx, dy)
    if dx == 1 then
      return 0, -1
    elseif dx == -1 then
      return 0, 1
    elseif dy == 1 then
      return -1, 0
    else
      return 1, 0
    end
  end,
  ["\\"] = function(dx, dy)
    if dx == 1 then
      return 0, 1
    elseif dx == -1 then
      return 0, -1
    elseif dy == 1 then
      return 1, 0
    else
      return -1, 0
    end
  end,
}

local splitters = {
  ["-"] = function(dx, dy)
    if dy ~= 0 then
      return 1, 0, -1, 0
    end
  end,
  ["|"] = function(dx, dy)
    if dx ~= 0 then
      return 0, 1, 0, -1
    end
  end,
}

local width, height
local map = {}

local function at(x, y)
  return y * width + x
end

local function inside(x, y)
  return x >= 0 and x < width and y >= 0 and y < height
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
      x = x + 1
    end
    y = y + 1
  end
  height = y
end

local eCount = 0
local eMap = {}
local dirMap = {}
for y = 0, height - 1 do
  for x = 0, width - 1 do
    dirMap[at(x, y)] = {}
  end
end

local beams = {
  {x = -1, y = 0, dx = 1, dy = 0}
}

while #beams > 0 do
  for i = #beams, 1, -1 do
    local b = beams[i]
    b.x = b.x + b.dx
    b.y = b.y + b.dy
    if inside(b.x, b.y) then
      local a = at(b.x, b.y)
      if dirMap[a][dk(b.dx, b.dy)] then
        table.remove(beams, i)
        goto visited
      end
      if not eMap[a] then
        eMap[a] = true
        eCount = eCount + 1
        dirMap[a][dk(b.dx, b.dy)] = true
      end
      local t = map[a]
      if t ~= "." then
        if mirrors[t] then
          b.dx, b.dy = mirrors[t](b.dx, b.dy)
        elseif splitters[t] then
          local dx1, dy1, dx2, dy2 = splitters[t](b.dx, b.dy)
          if dx1 then
            b.dx, b.dy = dx1, dy1
            table.insert(beams, {
              x = b.x,
              y = b.y,
              dx = dx2,
              dy = dy2
            })
          end
        end
      end
    else
      table.remove(beams, i)
    end
    ::visited::
  end
end

print(eCount)
