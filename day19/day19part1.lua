local load = load or loadstring
local workflows = {}
local parts = {}

local nextLine = io.lines("input")

local l = nextLine()
while #l > 0 do
  local name, rulesStr = l:match("(%w+){([^}]+)}")
  local rules = {}
  for r in rulesStr:gmatch("[^%,]+") do
    local prop, op, param, target = r:match("(.)([><])(%d+):(%w+)")
    if prop then
      local func = load(([[
      return function(part)
        return part[%q] %s %d
      end
      ]]):format(prop, op, param))()
      table.insert(rules, {func = func, target = target})
    else
      table.insert(rules, r)
    end
  end
  workflows[name] = rules
  l = nextLine()
end

l = nextLine()

local sum = 0

while l do
  local part = load("return " .. l)()
  local wf = "in"
  while wf ~= "A" and wf ~= "R" do
    for _, rule in ipairs(workflows[wf]) do
      if type(rule) == "string" then
        wf = rule
      else
        if rule.func(part) then
          wf = rule.target
          break
        end
      end
    end
  end
  if wf == "A" then
    sum = sum + part.x + part.m + part.a + part.s
  end
  l = nextLine()
end

print(sum)
