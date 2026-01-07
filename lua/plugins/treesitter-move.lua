return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    ------------------------------------------------------------------
    -- 1. Register the parser (new nvim-treesitter API) -------------
    ------------------------------------------------------------------
    vim.api.nvim_create_autocmd("User", {
      pattern = "TSUpdate",
      callback = function()
        require("nvim-treesitter.parsers").move = {
          install_info = {
            url = "https://github.com/tree-sitter-grammars/tree-sitter-move",
            files = { "src/parser.c" },
            branch = "saving",
          },
        }
      end,
    })

    -- Register the parser with the move filetype
    vim.treesitter.language.register("move", "move")

    ------------------------------------------------------------------
    -- 2. Ask LazyVim to install it ----------------------------------
    ------------------------------------------------------------------
    opts.ensure_installed = opts.ensure_installed or {}
    table.insert(opts.ensure_installed, "move")
  end,
}
