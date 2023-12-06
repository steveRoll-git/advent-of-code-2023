local function listToTable(l)
	local t = {}
	for n in l:gmatch("%d+") do
		t[n] = true
	end
	return t
end

local sum = 0

local copies = {}

for l in io.lines("input", "*l") do
	local id, winningNumbers, myNumbers = l:match("Card%s*(%d+): (.+) | (.+)")
	id = tonumber(id)
	winningNumbers = listToTable(winningNumbers)
	myNumbers = listToTable(myNumbers)
	local total = 0
	for n in pairs(myNumbers) do
		if winningNumbers[n] then
			total = total + 1
		end
	end
	for i = 1, total do
		local n = id + i
		copies[n] = (copies[n] or 0) + 1 + (copies[id] or 0)
	end
	sum = sum + 1 + (copies[id] or 0)
end

print(sum)
