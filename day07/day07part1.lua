local cardOrder = {}
do
  local chars = "23456789TJQKA"
  for i = 1, #chars do
    cardOrder[chars:sub(i, i)] = i
  end
end

local function handType(hand)
  local lookup = {}
  for c in hand:gmatch(".") do
    lookup[c] = (lookup[c] or 0) + 1
  end
  local counts = {}
  for c, n in pairs(lookup) do
    table.insert(counts, n)
  end
  table.sort(counts, function(a, b) return a > b end)
  if counts[1] == 5 then
    -- five of a kind
    return 7
  elseif counts[1] == 4 then
    -- four of a kind
    return 6
  elseif counts[1] == 3 and counts[2] == 2 then
    -- full house
    return 5
  elseif counts[1] == 3 and counts[2] == 1 then
    -- three of a kind
    return 4
  elseif counts[1] == 2 and counts[2] == 2 then
    -- two pair
    return 3
  elseif counts[1] == 2 and counts[2] == 1 then
    -- one pair
    return 2
  else
    -- high card
    return 1
  end
end

-- returns whether a is stronger than b
local function compareCards(a, b)
  local ha, hb = handType(a), handType(b)
  if ha == hb then
    for i = 1, 5 do
      local oa = cardOrder[a:sub(i, i)]
      local ob = cardOrder[b:sub(i, i)]
      if oa > ob then
        return true
      elseif oa < ob then
        return false
      end
    end
  end
  return ha > hb
end

local hands = {}

for l in io.lines("input") do
  local hand, bid = l:match("(.....) (%d+)")
  local index = #hands + 1
  for i, other in ipairs(hands) do
    if compareCards(hand, other.hand) then
      index = i
      break
    end
  end
  table.insert(hands, index, {hand = hand, bid = bid})
end

local sum = 0

for i, h in ipairs(hands) do
  sum = sum + h.bid * (#hands - i + 1)
end

print(sum)
