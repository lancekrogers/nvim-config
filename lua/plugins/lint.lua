-- ~/.config/nvim/lua/plugins/lint.lua
return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters = {
        markdownlint = {
          args = { "--disable", "MD013", "--" },
        },
        ["markdownlint-cli2"] = {
          args = { "--disable", "MD013", "--", "--config", "../../.markdownlint-cli2.yaml", "--" },
        },
      },
    },
  },
}
