local sum = 0

for l in io.lines("input", "*l") do
  local first = l:match(".-(%d).*")
  local last = l:match(".*(%d).-")
  sum = sum + tonumber(first .. last)
end

print(sum)
