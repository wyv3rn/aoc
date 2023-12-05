local M = {}

function M.open_puzzle_input(arg, debug)
    local filename = "input/" .. arg[0]:gsub("%.lua", "")
    if debug then
        filename = filename .. "-debug"
    end
    filename = filename .. ".txt"
    print("Loading puzzle input:", filename)
    local file = assert(io.open(filename, "r"))
    return file
end

function M.array_to_str(array)
    local str = ""
    for i, val in ipairs(array) do
        str = str .. val
        if i ~= #array then
            str = str .. ", "
        end
    end
    return str
end

return M
