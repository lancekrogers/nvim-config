local function Toggle_venn()
  if vim.b.venn_enabled == nil then
    vim.b.venn_enabled = true
    vim.cmd("setlocal virtualedit=all")

    local opts = { noremap = true, silent = true }

    vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", opts)
    vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", opts)
    vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", opts)
    vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", opts)
    vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", opts)

    print("Venn enabled")
  else
    vim.cmd("setlocal virtualedit=")

    vim.api.nvim_buf_del_keymap(0, "n", "J")
    vim.api.nvim_buf_del_keymap(0, "n", "K")
    vim.api.nvim_buf_del_keymap(0, "n", "H")
    vim.api.nvim_buf_del_keymap(0, "n", "L")
    vim.api.nvim_buf_del_keymap(0, "v", "f")

    vim.b.venn_enabled = nil
    print("Venn disabled")
  end
end

return {
  "jbyuki/venn.nvim",
  keys = {
    {
      "<leader>dv",
      function()
        Toggle_venn()
      end,
      desc = "Toggle ASCII Diagram Mode (venn)",
      mode = "n",
    },
  },
}
