return {
  "Vigemus/iron.nvim",
  config = function()
    local iron = require("iron.core")

    iron.setup({
      config = {
        repl_definition = {
          python = {
            command = { "ipython" },
          },
        },
        repl_open_cmd = require("iron.view").split.vertical.botright(0.4),
      },
      keymaps = {
        send_motion = "<leader>sc",
        visual_send = "<leader>sc",
        send_file = "<leader>sf",
        send_line = "<leader>sl",
        interrupt = "<leader>s<space>",
        exit = "<leader>sq",
        clear = "<leader>cl",
      },
    })
  end,
}
