local function getReflection(lines)
  for i = 1, #lines - 1 do
    if lines[i] == lines[i + 1] then
      for j = 1, math.min(i - 1, #lines - i - 1) do
        if lines[i - j] ~= lines[i + j + 1] then
          goto wrong
        end
      end
      return i
    end
    ::wrong::
  end
end

local function rotate(lines)
  local columns = {}
  for i = 1, #lines[1] do
    columns[i] = ""
  end
  for i, l in ipairs(lines) do
    for j = 1, #l do
      columns[j] = columns[j] .. l:sub(j, j)
    end
  end
  return columns 
end

local function printLines(lines)
  for _, l in ipairs(lines) do
    print(l)
  end
  print()
end

local sum = 0

local nextLine = io.lines("input")
local l = nextLine()
while l do
  local lines = {}
  while l and #l > 0 do
    table.insert(lines, l)
    l = nextLine()
  end
  local rowReflection = getReflection(lines)
  if rowReflection then
    sum = sum + rowReflection * 100
  else
    local columns = rotate(lines)
    sum = sum + getReflection(columns)
  end
  if l then
    l = nextLine()
  end
end

print(sum)
