-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
vim.keymap.set("n", "<F5>", vim.cmd.UndotreeToggle)
vim.keymap.set("n", "<F1>", "<Plug>RestNvim")
vim.keymap.set("n", "<F2>", "<Plug>RestNvimPreview")
vim.keymap.set("n", "<F3>", "<Plug>RestNvimLast")
vim.keymap.set("n", "tt", ":bnext<CR>")
vim.keymap.set("n", "tT", ":bprev<CR>")
vim.keymap.set("n", "<leader>jf", ":%!jq .<cr>", { desc = "Format JSON" })
vim.keymap.set("n", "//", ":Ag<SPACE>", { desc = "Silver Search" })
vim.keymap.set("v", "<leader>mc", "!mdtable2csv<cr>")
