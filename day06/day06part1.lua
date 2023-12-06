local nextLine = io.lines("input")

local races = {}

for t in nextLine():gmatch("%d+") do
	table.insert(races, {time = tonumber(t)})
end

do
	local i = 1
	for d in nextLine():gmatch("%d+") do
		races[i].distance = tonumber(d)
		i = i + 1
	end
end

local product = 1

for _, r in ipairs(races) do
	local ways = 0
	for t = r.time - 1, 1, -1 do
		local reached = t * (r.time - t)
		if reached > r.distance then
			ways = ways + 1
		end
	end
	product = product * ways
end

print(product)