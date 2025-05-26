return {
  "neovim/nvim-lspconfig",
  opts = {
    setup = {
      -- disable stock pyright
      pyright = function()
        return true
      end,
    },
    servers = {
      pyright = nil, -- nuke it
      basedpyright = {
        cmd_env = {
          -- inherit the vars direnv.vim just injected
          VIRTUAL_ENV = vim.env.VIRTUAL_ENV,
          PATH = vim.env.PATH,
          PYTHONPATH = vim.env.PYTHONPATH or "",
        },
        settings = {
          basedpyright = {
            typeCheckingMode = "basic",
            pythonVersion = "3.11",
            diagnosticMode = "workspace",
          },
        },
      },
    },
  },
}
