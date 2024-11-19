M = {}

local function get_file_name()
    local file_name = vim.fn.expand("%")
    assert(file_name ~= "", "Not a valid file.")

    return file_name
end

local function run_command(command)
    local handle = assert(io.popen(command))

    local result = handle:read("*a")
    handle:close()
    return result
end

local function get_repo()
	local repo_out = run_command("git remote -v 2>/dev/null")
    assert(repo_out ~= "", "Not a git repository or no remote set.")

    local repo = string.match(repo_out, "github%.com.([^ ]+)")
    assert(repo, "Remote not hosted on GitHub")

    return string.gsub(repo, ".git", "")
end

local function get_hash()
    return run_command("git log -n 1 --pretty=format:'%H'")
end

local function get_hash_from_blame(file_name, line_number)
    local output = run_command("git blame -L " .. line_number .. ",+1 -l " .. file_name)
    return string.match(output, "[^ ]+")
end

local function get_file_hash(file_name)
	local file_hash_out = run_command("echo -n " .. file_name .. " | sha256sum")
    return string.match(file_hash_out, "%w+")
end


M.copy_file_url = function()
    local repo = get_repo()
    local file_name = get_file_name()

    local line_number = vim.api.nvim_win_get_cursor(0)[1]
	local hash = get_hash()

    local url = "https://github.com/" .. repo .. "/blob/" .. hash .. "/" .. file_name .. "#L" .. line_number

    print(url)

    vim.fn.setreg("+", url)
end

M.copy_diff_url = function()
    local repo = get_repo()
    local file_name = get_file_name()

    local line_number = vim.api.nvim_win_get_cursor(0)[1]
	local hash = get_hash_from_blame(file_name, line_number)
    local file_hash = get_file_hash(file_name)

    local url = "https://github.com/" .. repo .. "/commit/" .. hash .. "/#diff-" .. file_hash .. "R" .. line_number

    print(url)

    vim.fn.setreg("+", url)
end

return M
