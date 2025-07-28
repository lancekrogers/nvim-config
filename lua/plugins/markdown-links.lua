---@diagnostic disable: undefined-global
return {
  -- 1. plugin repo
  "Nedra1998/nvim-mdlink",

  -- 2. load only for Markdown files
  ft = { "markdown" },

  -- 3. main config
  config = function()
    require("nvim-mdlink").setup({
      -- use the plugin’s built-in keymaps
      keymap = true,

      -- register nvim-cmp completion source automatically
      cmp = true,

      -- optional ⟹ override/extend default keys
      mappings = {
        -- follow or create link
        follow_link = "<CR>",
        -- open http/https link in system browser
        open_in_browser = "gx",
        -- jump back after <CR>
        go_back = "<BS>",
      },
    })
  end,
}
