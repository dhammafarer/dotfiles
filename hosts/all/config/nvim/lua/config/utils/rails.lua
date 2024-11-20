local telescope_builtin = require 'telescope.builtin'

M = {}

-- tries to locate files which rendere the template in current buffer
M.find_template_render = function()
  local filename = vim.fn.expand("%:t:r:r"):gsub("^_", "")
  local regex = "(render|partial:)[\\s(]?[\'\"][^\\s]*" .. filename .. "[\'\"]\\B"

  telescope_builtin.grep_string(
    {
      search_dirs = { "app" },
      search = regex,
      use_regex = true
    }
  )
end

-- list templates with file names matching the string under cursor
M.find_template = function()
  telescope_builtin.find_files(
    {
      search_dirs = { "app/views" },
      search_file = vim.fn.expand("<cword>")
    }
  )
end

return M
