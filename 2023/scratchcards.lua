-- Day 4
local tools = require("tools")

local function parse_card(card_str)
    local _, _, card_id_str, winners_str, own_numbers_str = card_str:find("Card +(%d+)%: ([%d ]+) %| ([%d ]+)")
    local winners = {}
    local own_numbers = {}
    for winner_str in winners_str:gmatch("(%d+)") do
        winners[tonumber(winner_str)] = true
    end
    for own_number_str in own_numbers_str:gmatch("(%d+)") do
        own_numbers[tonumber(own_number_str)] = true
    end

    local card = {}
    card.id = tonumber(card_id_str)
    card.winners = winners
    card.own_numbers = own_numbers
    return card
end

local function count_winners(card)
    local count = 0
    for number, _ in pairs(card.own_numbers) do
        if card.winners[number] then
            count = count + 1
        end
    end
    return count
end

-- Part 1
local file = tools.open_puzzle_input(arg)
local total_points = 0
for line in file:lines() do
    local card = parse_card(line)
    local winner_count = count_winners(card)
    if winner_count > 0 then
        total_points = total_points + math.floor(2 ^ (winner_count - 1))
    end
end

print("And the answer is:", total_points)

-- Part 2
file = tools.open_puzzle_input(arg)
local og_cards = {}
local card_queue = {}
local card_counter = 0
for line in file:lines() do
    local card = parse_card(line)
    og_cards[card.id] = card
    table.insert(card_queue, card)
    card_counter = card_counter + 1
end

while #card_queue > 0 do
    local current_card = table.remove(card_queue)
    local winner_count = count_winners(current_card)
    for duplicate_id = current_card.id + 1, current_card.id + winner_count do
        local duplicate = og_cards[duplicate_id]
        table.insert(card_queue, duplicate)
        card_counter = card_counter + 1
    end
end

print("And the second answer is:", card_counter)
