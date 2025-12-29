-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
OBSIDIAN_PATH = os.getenv("OBSIDIAN_PATH")
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = true
vim.opt.list = true
vim.opt.timeoutlen = 5000
vim.opt.listchars = "tab:>-,trail:."
vim.opt.spelllang = "en_us"
vim.g.mapleader = "\\"
-- vim.g.lazyvim_python_lsp = "basedpyright"

-- LSP logging configuration (prevent memory leaks from verbose logging)
vim.lsp.set_log_level("ERROR") -- Only log errors, not every keystroke
