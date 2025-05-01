return {
  {
    "tpope/vim-fugitive",
    cmd = {
      "G",
      "Git",
      "Gdiffsplit",
      "Gread",
      "Gwrite",
      "Ggrep",
      "GMove",
      "GDelete",
      "GBrowse",
      "GRemove",
      "GRename",
      "Glgrep",
      "Gedit",
    },
    ft = { "fugitive" },
  },
  {
    "jacqueswww/vim-vyper",
  },
  -- {
  --   "ray-x/go.nvim",
  --   dependencies = { -- optional packages
  --     "ray-x/guihua.lua",
  --     "neovim/nvim-lspconfig",
  --     "nvim-treesitter/nvim-treesitter",
  --   },
  --   config = function()
  --     require("go").setup()
  --   end,
  --   event = { "CmdlineEnter" },
  --   ft = { "go", "gomod" },
  --   build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  -- },
  -- {
  --   "leoluz/nvim-dap-go",
  --   ft = "go",
  --   dependencies = { "mfussenegger/nvim-dap" },
  --   config = function()
  --     require("dap-go").setup()
  --   end,
  -- },
  -- {
  --   "kelly-lin/telescope-ag",
  --   dependencies = { "nvim-telescope/telescope.nvim" },
  -- },
  {
    "epwalsh/obsidian.nvim",
    config = function()
      vim.wo.conceallevel = 2
      require("obsidian").setup({
        dir = OBSIDIAN_PATH,
        notes_subdir = "Notes",
      })
    end,
  },
  -- {
  --   "lancekrogers/kanban.nvim",
  --   config = function()
  --     require("kanban").setup({
  --       markdown = {
  --         description_folder = "./tasks/", -- Path to save the file corresponding to the task.
  --         list_head = "## ",
  --       },
  --     })
  --   end,
  -- },
  {
    "lancekrogers/vim-log-highlighting",
  },
  -- {
  --   "airblade/vim-gitgutter",
  -- },
  {
    "mbbill/undotree",
  },
  -- {
  --   "andrewferrier/wrapping.nvim",
  --   config = function()
  --     require("wrapping").setup()
  --   end,
  -- },
  -- {
  --   "tiagovla/scope.nvim",
  --   config = function()
  --     require("scope").setup({
  --       restore_state = false, -- experimental
  --     })
  --   end,
  -- },
  {
    "hudclark/grpc-nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "vhyrro/luarocks.nvim",
    priority = 1000,
    config = true,
    opts = {
      rocks = { "lua-curl", "nvim-nio", "mimetypes", "xml2lua" },
    },
  },
  {
    "Blockhead-Consulting/rest.nvim",
    ft = "http",
    dependencies = { "luarocks.nvim" },
    config = function()
      require("rest-nvim").setup()
    end,
  },
  -- {
  --   "wojciech-kulik/xcodebuild.nvim",
  --   dependencies = {
  --     "nvim-telescope/telescope.nvim",
  --     "MunifTanjim/nui.nvim",
  --     "nvim-tree/nvim-tree.lua", -- (optional) to manage project files
  --     "stevearc/oil.nvim", -- (optional) to manage project files
  --     "nvim-treesitter/nvim-treesitter", -- (optional) for Quick tests support (required Swift parser)
  --   },
  --   config = function()
  --     require("xcodebuild").setup({
  --       -- put some options here or leave it empty to use default settings
  --     })
  --   end,
  -- },
  -- { "ellisonleao/glow.nvim", config = true, cmd = "Glow" },
  -- {
  --   "rmagatti/goto-preview",
  --   config = function()
  --     require("goto-preview").setup({
  --       width = 120, -- Width of the floating window
  --       height = 25, -- Height of the floating window
  --       default_mappings = true, -- Bind default mappings
  --       opacity = 0, -- 0-100 opacity level of the floating window where 100 is fully transparent.
  --       dismiss_on_move = false,
  --     })
  --   end,
  -- },

  {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "mfussenegger/nvim-dap",
      "mfussenegger/nvim-dap-python",
      branch = "regexp",
      { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
    },
    lazy = false,
    branch = "regexp", -- This is the regexp branch, use this for the new version
    config = function()
      require("venv-selector").setup({})
    end,
    keys = {
      { ",v", "<cmd>VenvSelect<cr>" },
    },
  },
  -- { "dhruvasagar/vim-table-mode" },
  { "chrisbra/csv.vim" },
  -- {
  --   'stevearc/oil.nvim',
  --   opts = {},
  --   -- Optional dependencies
  --   dependencies = { "echasnovski/mini.icons" },
  --   -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  -- },
  -- -- lazy.nvim
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  -- { "tiagovla/scope.nvim" },
  {
    "folke/noice.nvim",
    enabled = false,
  },
}
