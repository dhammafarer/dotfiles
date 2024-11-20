local gs = require('gitsigns')

M = {}

M.hunks_to_loclist = function()
  gs.setqflist("attached", { use_location_list = true, open = true })
end

M.toggle_git_status = function(action, toggle, float, position, git_base)
  if git_base == nil then
    git_base = vim.g.git_base
  end

  require('neo-tree.command').execute({
    action = action,
    position = position,
    toggle = toggle,
    float = float,
    source = "git_status",
    git_base = git_base
  })
end

M.set_base_branch = function(git_base, action)
  if git_base == nil then
    git_base = vim.g.git_base
  else
    vim.g.git_base = git_base
  end

  gs.change_base(git_base, true)

  M.toggle_git_status(action, false, true, "float", git_base)
end

M.prev_hunk = function() gs.nav_hunk("prev", { preview = false, wrap = true }) end
M.next_hunk = function() gs.nav_hunk("next", { preview = false, wrap = true }) end

return M
