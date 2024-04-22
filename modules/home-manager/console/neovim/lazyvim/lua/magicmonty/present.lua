local M = {}

M.enable = function()
  vim.g.miniindentscope_disable = 1
  vim.cmd.IBLDisableScope()
  vim.cmd.IBLDisable()
  vim.opt.number = false
  vim.opt.relativenumber = false
  vim.opt.laststatus = 0
  vim.opt.showtabline = 0
  vim.opt.list = false
  vim.opt.colorcolumn = ""
  vim.opt.cursorline = false
  vim.diagnostic.disable()

  vim.keymap.set("n", "<leader><right>", ":bn<cr>", { silent = true, remap = false })
  vim.keymap.set("n", "<leader><left>", ":bp<cr>", { silent = true, remap = false })
end

return M
