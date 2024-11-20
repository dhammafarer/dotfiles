M = {}

-- Tries to extract a filepath the system clipboard and open it in a buffer.
-- String can be either a GitHub file URL with possible line number,
-- or a string containing a file path relative to project root with line number.
M.open_on_line = function()
  local reg = vim.fn.getreg("+")
  assert(reg, "Clipboard is empty.")

  local str = reg:gsub("https://github.com/.+/blob/[^/]+/", "")

  local path = str:match("(%.?[%a%/%_]+%.[%a%._-]+)")

  local line_nr = str:match(":(%d+)") or str:match("#L(%d+)") or str:match("#(%d+)")

  local cmd = line_nr and string.format("e +%s %s", line_nr, path) or 'e ' .. path

  vim.cmd(cmd)
end

-- toggles quickfix window
M.toggle_quickfix = function()
  for _, win in pairs(vim.fn.getwininfo()) do
    if win["quickfix"] == 1 then
      vim.cmd "cclose"
    else
      vim.cmd "copen"
    end
  end
end

return M
