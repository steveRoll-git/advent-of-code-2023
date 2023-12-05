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

local seeds = {}
for n in nextLine():gmatch("%d+") do
	table.insert(seeds, tonumber(n))
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

for _, seed in ipairs(seeds) do
	lowest = math.min(lowest, findLocation(seed))
end

print(lowest)