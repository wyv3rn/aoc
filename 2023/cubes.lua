local tools = require("tools")

local file = tools.open_puzzle_input(arg, true)

for line in file:lines() do
    print(line)
end
