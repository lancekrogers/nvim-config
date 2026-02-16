return {
  "alexpasmantier/tv.nvim",
  config = function()
    require("tv").setup({
      channels = {
        files = { keybinding = "<C-p>" },
        text = { keybinding = "<leader><leader>" },
        ["git-branch"] = { keybinding = "<leader>gb" },
        ["git-log"] = { keybinding = "<leader>gl" },
      },
    })
  end,
}
