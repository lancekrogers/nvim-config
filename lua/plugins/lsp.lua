return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      basedpyright = {
        mason = false, -- Let Mason handle the installation
        settings = {
          basedpyright = {
            analysis = {
              typeCheckingMode = "basic",
              diagnosticMode = "workspace",
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
            },
          },
        },
      },
    },
    setup = {
      basedpyright = function(_, opts)
        -- Ensure direnv environment variables are passed
        opts.cmd_env = {
          VIRTUAL_ENV = vim.env.VIRTUAL_ENV,
          PATH = vim.env.PATH,
          PYTHONPATH = vim.env.PYTHONPATH or "",
        }
      end,
    },
  },
}
