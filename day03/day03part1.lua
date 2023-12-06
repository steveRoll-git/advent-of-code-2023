local sum = 0

local symbols = {}
local numbers = {}

local width

local function at(x, y)
	return y * width + x
end

do
	local y = 0
	for l in io.lines("input", "*l") do
		if not width then
			width = #l
		end
		local x = 0
		local number
		for c in l:gmatch(".") do
			if c:find("[^%.%d]") then
				table.insert(symbols, { x = x, y = y })
			end
			if c:find("%d") then
				if not number then
					number = { value = "" }
				end
				number.value = number.value .. c
				numbers[at(x, y)] = number
			elseif number then
				number.value = tonumber(number.value)
				number = nil
			end
			x = x + 1
		end
		y = y + 1
	end
end

local offsets = {
	{ x = 1,  y = 0 },
	{ x = -1, y = 0 },
	{ x = 1,  y = 1 },
	{ x = -1, y = 1 },
	{ x = 1,  y = -1 },
	{ x = -1, y = -1 },
	{ x = 0,  y = 1 },
	{ x = 0,  y = -1 },
}

for i, s in ipairs(symbols) do
	local touched = {}
	for _, o in ipairs(offsets) do
		local x, y = s.x + o.x, s.y + o.y
		local n = numbers[at(x, y)]
		if n and not touched[n] then
			sum = sum + n.value
			touched[n] = true
		end
	end
end

print(sum)
