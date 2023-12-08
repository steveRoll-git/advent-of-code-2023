local nextLine = io.lines("input")

local steps = nextLine()

nextLine()

local nodes = {}

do
  local line = nextLine()
  while line do
    local node, l, r = line:match("(...) = %((...), (...)%)")
    nodes[node] = { L = l, R = r }
    line = nextLine()
  end
end

local currentNode = "AAA"
local currentStep = 1
local count = 0

while currentNode ~= "ZZZ" do
  currentNode = nodes[currentNode][steps:sub(currentStep, currentStep)]
  count = count + 1
  currentStep = currentStep + 1
  if currentStep > #steps then
    currentStep = 1
  end
end

print(count)
