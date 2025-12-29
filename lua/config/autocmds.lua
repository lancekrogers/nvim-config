-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.py", "*.vy" },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.colorcolumn = "80"
    vim.opt_local.textwidth = 79
  end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.ts", "*.js", "*.html", "*.css", "*.jsx", "*.sql", "*.sol", "*.lua" },
  callback = function()
    vim.opt_local.colorcolumn = "100"
    vim.opt_local.textwidth = 99
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "markdown", "gitcommit", "text", "tex" },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = { "en_us" }
  end,
})

-- LSP log rotation (prevent logs from growing to 691MB and causing memory leaks)
vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup("lsp_log_rotation", { clear = true }),
  callback = function()
    local log_path = vim.fn.stdpath("log") .. "/lsp.log"
    local max_size = 50 * 1024 * 1024 -- 50MB max

    local stat = vim.loop.fs_stat(log_path)
    if stat and stat.size > max_size then
      -- Backup old log
      vim.loop.fs_rename(log_path, log_path .. ".old")
      -- Old backup will be overwritten next time
      vim.notify("LSP log rotated (was " .. math.floor(stat.size / 1024 / 1024) .. "MB)", vim.log.levels.INFO)
    end
  end,
})
