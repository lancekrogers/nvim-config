return {
  "lancekrogers/algo-scales-nvim",
  dependencies = {
    "nvim-lua/plenary.nvim", -- Required for async operations
  },
  config = function()
    require("algo-scales").setup({
      -- Optional configuration
      algo_scales_path = "algo-scales", -- Path to algo-scales binary
      default_language = "go", -- Default language for solutions
      keymaps = {
        submit = "<leader>as",
        hint = "<leader>ah",
        ai_hint = "<leader>aH", -- AI-powered hints
        ai_review = "<leader>ar", -- AI code review
        ai_chat = "<leader>ac", -- AI chat mode
        solution = "<leader>av",
        list = "<leader>al",
        start = "<leader>ap",
      },
    })
  end,
}
