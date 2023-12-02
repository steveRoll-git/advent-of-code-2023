local sum = 0

for l in io.lines("input") do
	local id, bags = l:match("Game (%d+): (.*)")
	local maximums = {red = 0, green = 0, blue = 0}
	for bag in bags:gmatch("[^;]+") do
		for amount, color in bag:gmatch("(%d+) (%w+)") do
			amount = tonumber(amount)
			maximums[color] = math.max(maximums[color], amount)
		end
	end
	sum = sum + maximums.red * maximums.green * maximums.blue
end

print(sum)