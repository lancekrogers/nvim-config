return {
  "lancekrogers/algo-scales-vim",
  config = function()
    -- Configure AlgoScales
    vim.g.algo_scales_path = "algo-scales" -- or full path if not in PATH
    vim.g.algo_scales_language = "go" -- 'go', 'python', or 'javascript'
    vim.g.algo_scales_auto_test = 1 -- Auto-test on save
  end,
  cmd = {
    "AlgoScalesStart",
    "AlgoScalesList",
    "AlgoScalesDaily",
    "AlgoScalesTest",
    "AlgoScalesHint",
    "AlgoScalesAIHint",
    "AlgoScalesAIChat",
    "AlgoScalesComplete",
  },
  keys = {
    { "<leader>as", "<cmd>AlgoScalesStart<cr>", desc = "Start AlgoScales session" },
    { "<leader>at", "<cmd>AlgoScalesTest<cr>", desc = "Run tests" },
    { "<leader>ah", "<cmd>AlgoScalesHint<cr>", desc = "Show hint" },
    { "<leader>aH", "<cmd>AlgoScalesAIHint<cr>", desc = "AI hint" },
    { "<leader>aC", "<cmd>AlgoScalesAIChat<cr>", desc = "AI chat" },
    { "<leader>al", "<cmd>AlgoScalesList<cr>", desc = "List problems" },
    { "<leader>ad", "<cmd>AlgoScalesDaily<cr>", desc = "Daily practice" },
    { "<leader>ac", "<cmd>AlgoScalesComplete<cr>", desc = "Complete session" },
  },
}
