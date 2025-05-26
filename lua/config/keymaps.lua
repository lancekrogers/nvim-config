-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    if opts.desc then
      opts.desc = "keymaps.lua: " .. opts.desc
    end
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- Keymaps from previous setups
vim.keymap.set("n", "<F5>", vim.cmd.UndotreeToggle)
vim.keymap.set("n", "<F1>", "<Plug>RestNvim")
vim.keymap.set("n", "<F2>", "<Plug>RestNvimPreview")
vim.keymap.set("n", "<F3>", "<Plug>RestNvimLast")
-- vim.keymap.set("n", "tt", ":bnext<CR>")
-- vim.keymap.set("n", "tT", ":bprev<CR>")
vim.keymap.set("n", "tt", ":BufferLineCycleNext<CR>")
vim.keymap.set("n", "tT", ":BufferLineCyclePrev<CR>")
vim.keymap.set("n", "tp", ":BufferLinePick<CR>")
-- vim.keymap.set("n", "ttt", ":BufferLinePick<CR>")
vim.keymap.set("n", "<leader>jf", ":%!jq .<cr>", { desc = "Format JSON" })
vim.keymap.set("n", "//", ":Ag<SPACE>", { desc = "Silver Search" })
vim.keymap.set("v", "<leader>mc", "!mdtable2csv<cr>")
-- map("n", "<leader>c", "<cmd>:bd<cr>", { desc = "Delete Buffer", opts = "buffer" })
--vim.keymap.set("t", "<C-q>", "<C-\\><C-n>:q<CR>", { desc = "Quit terminal split" })

vim.cmd([[
  tnoremap jk <C-\><C-n>
]])

-- AstroNvim-like buffer selection
map("n", "<LEADER>bb", function()
  require("bufferline").pick()
end, { desc = "Select Buffer" })

-- Block indentation via tab and shift/tab
map("v", "<TAB>", ">gv")
map("v", "<S-TAB>", "<gv")

-- Map <leader>j to the jump_to_index function
-- vim.api.nvim_set_keymap("n", "<leader>j", ":lua Jump_to_index()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>j", "<Cmd>Telescope jumplist<CR>", { noremap = true, silent = true })
