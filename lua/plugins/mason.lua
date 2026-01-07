-- Mason and mason-lspconfig configuration
-- Using latest versions (2.0+) which are now compatible with LazyVim
return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensured_installed = {
        "basedpyright",
      },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    servers = {
      harper = {
        filetypes = { "markdown" },
      },
      pyright = nil,
      basedpyright = {
        settings = {
          typeCheckingMode = "basic",
          pythonVersion = "3.13",
          diagnosticMode = "workspace",
        },
      },
    },
  },
}
