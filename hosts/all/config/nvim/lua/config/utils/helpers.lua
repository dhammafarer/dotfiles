M = {}

M.toggle_quickfix = function()
  for _, win in pairs(vim.fn.getwininfo()) do
    if win["quickfix"] == 1 then
      vim.cmd "cclose"
    else
      vim.cmd "copen"
    end
  end
end

M.open_on_line = function()
  local str = vim.fn.getreg("+")

  if str then
    local pattern = ":(%d+)"
    local path = str:match("(%.?[%a%/%_]+%.[%a%._-]+)")
    local line_number = str:match(pattern)

    local cmd

    if line_number then
      cmd = string.format("e +%s %s", line_number, path)
    else
      cmd = 'e ' .. path
    end

    vim.cmd(cmd)
  end
end

return M
