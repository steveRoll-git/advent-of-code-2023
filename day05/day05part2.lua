local numMaps = 7

local nextLine = io.lines("input")

local function parseMap()
	local map = {}
	
	local l = nextLine()
	while l and #l > 0 do
		local destination, source, length = l:match("(%d+) (%d+) (%d+)")
		table.insert(map, {
			d = tonumber(destination),
			s = tonumber(source),
			l = tonumber(length)
		})
		l = nextLine()
	end

	return map
end

local seedRanges = {}
for start, length in nextLine():gmatch("(%d+) (%d+)") do
	start = tonumber(start)
	length = tonumber(length)
	table.insert(seedRanges, {start, length})
end

nextLine()

local maps = {}

for i = 1, numMaps do
	nextLine()
	table.insert(maps, parseMap())
end

local function findLocation(seed)
	local n = seed
	for i, map in ipairs(maps) do
		for _, range in ipairs(map) do
			if n >= range.s and n < range.s + range.l then
				n = n - range.s + range.d
				break
			end
		end
	end
	return n
end

local lowest = math.huge

for _, range in ipairs(seedRanges) do
	for seed = range[1], range[1] + range[2] - 1 do
		lowest = math.min(lowest, findLocation(seed))
	end
end

print(lowest)