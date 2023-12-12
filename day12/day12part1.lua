do -- string index hack 
  local mt = getmetatable("")
  local orig = mt.__index
  mt.__index = function(s, k)
    if type(k) == "number" then
      return s:sub(k, k)
    else
      return orig[k]
    end
  end
end

local function isArrangementValid(line, groups)
  local currGroup = 1
  local i = 1
  while i <= #line do
    if line[i] == "#" then
      if currGroup > #groups then
        return false
      end
      local count = 0
      while line[i] == "#" and i <= #line do
        count = count + 1
        i = i + 1
        if line[i] == "?" then
          return "maybe"
        end
      end
      if count ~= groups[currGroup] then
        return false
      end 
      currGroup = currGroup + 1
    elseif line[i] == "?" then
      return "maybe"
    end
    i = i + 1
  end
  return currGroup == #groups + 1
end

local function getArrangements(line, groups)
  local isValid = isArrangementValid(line, groups)
  if not isValid then
    return 0
  elseif isValid == true then
    return 1
  elseif isValid == "maybe" then
    return
      getArrangements(line:gsub("%?", ".", 1), groups) +
      getArrangements(line:gsub("%?", "#", 1), groups)
  end 
end

local function parseLine(s)
  local line, g = s:match("(%S+) (.+)")
  local groups = {}
  for n in g:gmatch("%d+") do
    table.insert(groups, tonumber(n))
  end
  return line, groups
end

local sum = 0

for l in io.lines("input") do
  local line, groups = parseLine(l)
  sum = sum + getArrangements(line, groups)
end

print(sum)
