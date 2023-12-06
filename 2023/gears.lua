-- Day 3
local tools = require("tools")

local file = tools.open_puzzle_input(arg, false)

local part_number_sum = 0

local lines = {}
for line in file:lines() do
    table.insert(lines, line)
end

local maybe_gears = {}

for line_number, line in ipairs(lines) do
    local truncated_line = line
    local truncated_chars = 0
    while true do
        local i, j = truncated_line:find("%d+")
        if i == nil then
            break
        end

        local number = truncated_line:sub(i, j)
        local start_idx = i + truncated_chars
        local end_idx = j + truncated_chars

        truncated_chars = truncated_chars + j
        truncated_line = truncated_line:sub(j + 1)

        local x_start = math.max(start_idx - 1, 1)
        local x_end = math.min(end_idx + 1, #line)
        local y_start = math.max(line_number - 1, 1)
        local y_end = math.min(line_number + 1, #lines)

        local is_partnumber = false
        for y = y_start, y_end do
            for x = x_start, x_end do
                if lines[y]:sub(x, x):match("[^%d%.]") then
                    is_partnumber = true
                end
                if lines[y]:sub(x, x):match("[%*]") then
                    local position_str = tostring(x) .. "," .. tostring(y)
                    if not maybe_gears[position_str] then
                        maybe_gears[position_str] = { number }
                    else
                        table.insert(maybe_gears[position_str], number)
                    end
                end
            end
        end

        print(number, is_partnumber)

        if is_partnumber then
            part_number_sum = part_number_sum + number
        end
    end
end

local gear_ratio_sum = 0
for _, maybe_gear in pairs(maybe_gears) do
    if #maybe_gear == 2 then
        gear_ratio_sum = gear_ratio_sum + maybe_gear[1] * maybe_gear[2]
    end
end

print("And the answer is", part_number_sum)
print("And the second answer is", gear_ratio_sum)
