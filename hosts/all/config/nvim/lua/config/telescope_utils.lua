local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local previewers = require "telescope.previewers"
local make_entry = require "telescope.make_entry"
local entry_display = require "telescope.pickers.entry_display"
local gs = require('gitsigns')

M = {}

M.changed_files = function(opts)
	local base_branch = vim.g.git_base or "master"
	local command = "git diff --name-only $(git merge-base HEAD " .. base_branch .. " )"
    -- git diff --name-status HEAD ^master | grep -v '^D'

	local handle = io.popen(command)
    if handle == nil then return end

	local result = handle:read("*a")
	handle:close()

	local files = {}
	for token in string.gmatch(result, "[^%s]+") do
	   table.insert(files, token)
	end

	opts = opts or {}

	pickers.new(opts, {
		prompt_title = "changed files",
		finder = finders.new_table {
			results = files
		},
		sorter = conf.generic_sorter(opts),
	}):find()
end

local gen_from_git_commits = function (opts)
  opts = opts or {}

  local displayer = entry_display.create {
    separator = " ",
    items = {
      { width = 8 },
      { width = 10 },
      { remaining = true },
    },
  }

  local make_display = function(entry)
    return displayer {
      { entry.value, "TelescopeResultsIdentifier" },
      entry.date,
      entry.msg,
    }
  end

  return function(entry)
    if entry == "" then
      return nil
    end

    local sha, date, msg = string.match(entry, "([^ ]+) ([^ ]+) (.+)")

    return make_entry.set_default_entry_mt({
      value = sha,
      ordinal = sha .. " " .. date .. " " .. msg,
      date = date,
      msg = msg,
      display = make_display,
      current_file = opts.current_file,
    }, opts)
  end
end


M.git_commits = function(opts)
	local base_branch = vim.g.git_base or "master"
	--local command = "git log --pretty=format:'%h %as %<(16)%an %s' HEAD ^" .. base_branch
	local command = "git log --pretty=format:'%h %as %<(16)%an %s' HEAD ^" .. base_branch

	local handle = io.popen(command)
    if handle == nil then return end

	local result = handle:read("*a")
	handle:close()

	local files = {}
	for token in string.gmatch(result, "[^\n]+") do
	    table.insert(files, token)
	end

	opts = {
      attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          local git_base = selection.value
          vim.g.git_base = git_base
          gs.change_base(git_base, true)
        end)
        return true
      end
    }

	pickers.new(opts, {
		prompt_title = "PR Commits",
		finder = finders.new_table {
			results = files,
            entry_maker = gen_from_git_commits(opts),
            -- entry_maker = function(line)
            --   print(line)
            --   return make_entry.set_default_entry_mt({
            --     value = string.match(line, "[^%s]+"),
            --     ordinal = line,
            --     display = line,
            --   }, {})
            -- end,
		},
        previewer = {
          previewers.git_commit_diff_to_parent.new(opts),
          previewers.git_commit_diff_to_head.new(opts),
          previewers.git_commit_diff_as_was.new(opts),
          previewers.git_commit_message.new(opts),
        },
		sorter = conf.generic_sorter(opts),
	}):find()
end

return M
