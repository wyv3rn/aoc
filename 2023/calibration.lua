-- Day 1
local tools = require("tools")

local file = tools.open_puzzle_input(arg)
local spelled_out = {
    "one",
    "two",
    "three",
    "four",
    "five",
    "six",
    "seven",
    "eight",
    "nine",
}

local sum = 0

for line in file:lines() do
    local parsed = line

    while true do
        local leftmost_idx, leftmost_as_str, leftmost_as_int = 1024 * 1024, nil, nil

        for as_int, as_str in ipairs(spelled_out) do
            local i, _ = parsed:find(as_str)
            if i ~= nil and i < leftmost_idx then
                leftmost_idx, leftmost_as_str, leftmost_as_int = i, as_str, as_int
            end
        end
        if leftmost_as_str == nil then
            break
        end
        parsed = parsed:gsub(leftmost_as_str, leftmost_as_int, 1)
    end

    local digits = {}
    for digit in parsed:gmatch("%d") do
        table.insert(digits, digit)
    end
    if #digits == 1 then
        table.insert(digits, digits[1])
    end
    print(line, parsed, digits[1], digits[#digits])
    sum = sum + digits[1] * 10 + digits[#digits]
end

print("And the answer is:", sum)
