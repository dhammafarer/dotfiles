M = {}

local function run_command(command)
    local handle = io.popen(command)
    -- TODO handle the error case better 
    if handle == nil then return "" end

    local result = handle:read("*a")
    handle:close()
    return result
end

local function get_repo()
	local repo_out = run_command("git remote -v")
    return string.gsub(string.match(repo_out, "github%.com.([^ ]+)"), ".git", "")
end

local function get_hash()
    return run_command("git log -n 1 --pretty=format:'%H'")
end

local function get_file_hash(file_name)
	local file_hash_out = run_command("echo -n " .. file_name .. " | sha256sum")
    return string.match(file_hash_out, "%w+")
end


M.copy_file_url = function()
    local file_name = vim.fn.expand("%")
    local line_number = vim.api.nvim_win_get_cursor(0)[1]
	local hash = get_hash()
    local repo = get_repo()

    local url = "https://github.com/" .. repo .. "/blob/" .. hash .. "/" .. file_name .. "#L" .. line_number

    print(url)

    vim.fn.setreg("+", url)
end

M.copy_diff_url = function()
    local file_name = vim.fn.expand("%")
    local line_number = vim.api.nvim_win_get_cursor(0)[1]
	local hash = get_hash()
    local repo = get_repo()
    local file_hash = get_file_hash(file_name)

    local url = "https://github.com/" .. repo .. "/commit/" .. hash .. "/#diff-" .. file_hash .. "R" .. line_number

    print(url)

    vim.fn.setreg("+", url)
end

return M
