local nextLine = io.lines("input")

local time = tonumber(nextLine():gsub(" ", ""):match("%d+"))
local distance = tonumber(nextLine():gsub(" ", ""):match("%d+"))

local ways = 0

for t = time - 1, 1, -1 do
	local reached = t * (time - t)
	if reached > distance then
		ways = ways + 1
	elseif ways > 0 then
		break
	end
end

print(ways)