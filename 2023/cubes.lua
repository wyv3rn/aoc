-- Day 2
local tools = require("tools")

local BAG_CONTENT = {
    red = 12,
    green = 13,
    blue = 14,
}

local function parse_game(line)
    local game = {}
    local _, _, id, tail = line:find("Game (%d+): (.+)")
    game.id = id
    game.draws = {}
    for draw_str in tail:gmatch("([^;]+)") do
        local draw = {}
        for balls_str in draw_str:gmatch("([^,]+)") do
            local _, _, amount, color = balls_str:find("(%d+) (%a+)")
            draw[color] = tonumber(amount)
        end
        table.insert(game.draws, draw)
    end
    return game
end

local function is_possible(game, bag_content)
    for _, draw in ipairs(game.draws) do
        for color, amount in pairs(draw) do
            if bag_content[color] < amount then
                return false
            end
        end
    end
    return true
end

local function min_bag_content(game)
    local bag_content = {}
    for _, draw in ipairs(game.draws) do
        for color, amount in pairs(draw) do
            if not bag_content[color] then
                bag_content[color] = amount
            else
                bag_content[color] = math.max(bag_content[color], amount)
            end
        end
    end
    return bag_content
end

local function set_power(bag_content)
    local power = 1
    for _, amount in pairs(bag_content) do
        power = power * amount
    end
    return power
end

local file = tools.open_puzzle_input(arg, false)
local possible_id_sum = 0
local power_sum = 0

for line in file:lines() do
    local game = parse_game(line)
    local check = is_possible(game, BAG_CONTENT)
    local power = set_power(min_bag_content(game))
    print(line, check, power)
    if check then
        possible_id_sum = possible_id_sum + game.id
    end
    power_sum = power_sum + power
end

print("And the answer is:", possible_id_sum)
print("And the second answer is:", power_sum)
