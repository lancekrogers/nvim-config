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
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("dap-go").setup()
    end,
  },
  {
    "kelly-lin/telescope-ag",
    dependencies = { "nvim-telescope/telescope.nvim" },
  },
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
  {
    "mbbill/undotree",
  },
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
  { "chrisbra/csv.vim" },
  {
    "folke/noice.nvim",
    enabled = false,
  },
}
