local conf = {
	red = 12,
	green = 13,
	blue = 14
}

local sum = 0

for l in io.lines("input") do
	local id, bags = l:match("Game (%d+): (.*)")
	local possible = true
	for bag in bags:gmatch("[^;]+") do
		for amount, color in bag:gmatch("(%d+) (%w+)") do
			amount = tonumber(amount)
			if amount > conf[color] then
				possible = false
				break
			end
			if not possible then
				break
			end
		end
	end
	if possible then
		sum = sum + id
	end
end

print(sum)