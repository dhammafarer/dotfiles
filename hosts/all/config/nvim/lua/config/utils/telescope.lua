local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local previewers = require "telescope.previewers"
local make_entry = require "telescope.make_entry"
local entry_display = require "telescope.pickers.entry_display"
local builtin = require 'telescope.builtin'

local git_utils = require('config.utils.git')

M = {}

local delta = previewers.new_termopen_previewer {
  get_command = function(entry)
    local base_branch = vim.g.git_base or "master"

    return { 'git', '--no-pager', 'diff', '--unified=0', base_branch .. '..HEAD', entry.value }
  end
}

M.search_tags = function()
  builtin.tags({
    fname_width = 60,
    show_line = false,
    only_sort_tags = true,
    default_text = vim.fn.expand("<cword>")
  })
end

M.lsp_references = function()
  builtin.lsp_references({
    include_declaration = true,
    fname_width = 60,
    show_line = false,
    trim_text = false
  })
end

-- search in files that have changed since a particular commit (base branch)
M.changed_files = function(opts)
  local base_branch = vim.g.git_base or "master"
  local command = "git diff --name-only $(git merge-base HEAD " .. base_branch .. " )"

  local handle = assert(io.popen(command))
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
      results = files,
      entry_maker = make_entry.gen_from_file(opts)
    },
    previewer = delta,
    sorter = conf.generic_sorter(opts),
  }):find()
end

local gen_from_git_commits = function(opts)
  opts = opts or {}

  local displayer = entry_display.create {
    separator = " ",
    items = {
      { width = 10 },
      { width = 10 },
      { width = 21 },
      { remaining = true },
    },
  }

  local make_display = function(entry)
    return displayer {
      { entry.value,  "TelescopeResultsComment" },
      { entry.date,   "TelescopePreviewDate" },
      { entry.author, "TelescopePreviewUser" },
      { entry.msg,    "TelescopePreviewMessage" }
    }
  end

  return function(entry)
    if entry == "" then
      return nil
    end

    local sha, date_, time, _, rest = string.match(entry, "([^ ]+) ([^ ]+) ([^ ]+) ([^ ]+) (.*)")
    local author = string.sub(rest, 1, 21)
    local msg = string.gsub(string.sub(rest, 22), "^%s+", "")

    local date
    if date_ == os.date("%Y-%m-%d") then
      date = time
    else
      date = date_
    end

    return make_entry.set_default_entry_mt({
      value = sha,
      ordinal = sha .. " " .. date .. " " .. author .. " " .. msg,
      date = date,
      author = author,
      msg = msg,
      display = make_display,
      current_file = opts.current_file,
    }, opts)
  end
end

-- list "PR commits", i.e. commits that are present on current branch
-- but absent on the base branch
M.git_commits = function(opts)
  local base_branch = os.getenv("GIT_BASE") or "master"

  local command = "git log --pretty=format:'%h %ai %<(20)%an %s' HEAD ^" .. base_branch

  local handle = assert(io.popen(command))
  local result = handle:read("*a")
  handle:close()

  local files = {}
  for token in string.gmatch(result, "[^\n]+") do
    table.insert(files, token)
  end

  opts = {
    attach_mappings = function(prompt_bufnr, _)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        local git_base = selection.value

        git_utils.set_base_branch(git_base)
      end)
      return true
    end
  }

  pickers.new(opts, {
    prompt_title = "PR Commits",
    finder = finders.new_table {
      results = files,
      entry_maker = gen_from_git_commits(opts)
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
