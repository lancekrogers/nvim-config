require("lancekrogers.remap")
require("lancekrogers.set")
require("lancekrogers.lspconfig")
require('neoscroll').setup()
local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
end)
-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
lsp.setup()
require("kanban").setup({
  markdown = {
    description_folder = "./tasks/", -- Path to save the file corresponding to the task.
    list_head = "## ",
  }
})
