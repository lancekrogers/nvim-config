-- lua/plugins/mermaider.lua
-- Example LazyVim plugin configuration for testing local mermaider.nvim
-- Copy this to your ~/.config/nvim/lua/plugins/mermaider.lua

return {
  {
    "lancekrogers/mermaider.nvim",
    -- Use local development version instead of GitHub
    -- dir = "/Users/lancerogers/Dev/open_source/nvim_plugins/mermaider.nvim",
    dependencies = {
      {
        "3rd/image.nvim",
        -- IMPORTANT: image.nvim requires ImageMagick to be installed
        -- Install with: brew install imagemagick (macOS)
        -- or: sudo apt-get install imagemagick (Ubuntu/Debian)
        -- or: sudo pacman -S imagemagick (Arch)
        opts = {
          backend = "kitty", -- Explicitly set to kitty
          integrations = {
            markdown = {
              enabled = true,
              clear_in_insert_mode = false,
              download_remote_images = true,
              only_render_image_at_cursor = false,
              filetypes = { "markdown", "vimwiki" },
            },
          },
          max_width = nil,
          max_height = nil,
          max_width_window_percentage = nil,
          max_height_window_percentage = 50,
          kitty_method = "normal",
        },
      },
    },
    ft = { "mmd", "mermaid", "markdown", "md" },
    config = function()
      require("mermaider").setup({
        auto_render = true,
        auto_render_on_open = true,
        auto_preview = true,
        theme = "forest",
        background_color = "#1e1e2e",
        inline_render = true,
        max_width_window_percentage = 80,
        max_height_window_percentage = 80,
      })
    end,
  },
}
