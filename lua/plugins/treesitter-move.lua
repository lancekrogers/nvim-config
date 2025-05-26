return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    ------------------------------------------------------------------
    -- 1. Register the parser ---------------------------------------
    ------------------------------------------------------------------
    local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

    parser_config.move = { -- the new language key
      install_info = {
        url = "https://github.com/tree-sitter-grammars/tree-sitter-move",
        files = { "src/parser.c" }, -- both must exist
        branch = "saving",
        -- the grammar repo uses `grammar.js`, so the installer will
        -- build the C sources automatically; no Node/npm needed.
      },
      filetype = "move",
    }

    ------------------------------------------------------------------
    -- 2. Ask LazyVim to install it ----------------------------------
    ------------------------------------------------------------------
    opts.ensure_installed = opts.ensure_installed or {}
    table.insert(opts.ensure_installed, "move")
  end,
}
