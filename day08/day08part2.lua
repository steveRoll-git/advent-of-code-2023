local nextLine = io.lines("input")

local steps = nextLine()

nextLine()

local nodes = {}
local searchers = {}

do
  local line = nextLine()
  while line do
    local node, l, r = line:match("(...) = %((...), (...)%)")
    nodes[node] = { L = l, R = r }
    if node:sub(3, 3) == "A" then
      table.insert(searchers, node)
    end
    line = nextLine()
  end
end

local currentStep = 1
local count = 0

while true do
  local reached = true
  for i, node in ipairs(searchers) do
    searchers[i] = nodes[node][steps:sub(currentStep, currentStep)]
    if searchers[i]:sub(3, 3) ~= "Z" then
      reached = false
    end
  end

  count = count + 1
  currentStep = currentStep + 1
  if currentStep > #steps then
    currentStep = 1
  end
  if reached then
    break
  end
end

print(count)
