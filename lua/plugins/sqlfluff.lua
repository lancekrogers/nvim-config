-- lua/plugins/sqlfluff-format.lua
return {
  "stevearc/conform.nvim",
  opts = function(_, opts)
    opts.formatters = opts.formatters or {}

    opts.formatters.sqlfluff = {
      command = "sqlfluff",
      args = { "format", "--dialect", "postgres", "-" },
      stdin = true,
    }

    opts.formatters_by_ft = opts.formatters_by_ft or {}
    opts.formatters_by_ft.sql = { "sqlfluff" }
  end,
}
