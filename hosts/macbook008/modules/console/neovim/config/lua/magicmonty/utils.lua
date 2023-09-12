local M = {}

M.isTTY = function() 
  local term = os.getenv("TERM")
  if vim.fn.has("gui_running") == 1 then
    return false
  end

  return term == "linux" or term == "linux-16color"
end

return M
