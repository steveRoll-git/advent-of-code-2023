local function listToTable(l)
	local t = {}
	for n in l:gmatch("%d+") do
		t[n] = true
	end
	return t
end

local sum = 0

for l in io.lines("input", "*l") do
	local id, winningNumbers, myNumbers = l:match("Card%s*(%d+): (.+) | (.+)")
	winningNumbers = listToTable(winningNumbers)
	myNumbers = listToTable(myNumbers)
	local total
	for n in pairs(myNumbers) do
		if winningNumbers[n] then
			total = total and total * 2 or 1
		end
	end
	sum = sum + (total or 0)
end

print(sum)