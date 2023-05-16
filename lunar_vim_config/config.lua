-- vim options
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = true
vim.opt.list = true
vim.opt.listchars = "tab:>-,trail:."
vim.keymap.set('n', '<F5>', vim.cmd.UndotreeToggle)

-- general
lvim.log.level = "info"
lvim.format_on_save = {
  enabled = true,
  pattern = "*.lua",
  timeout = 1000,
}

-- keymappings <https://www.lunarvim.org/docs/configuration/keybindings>
lvim.leader = "\\"
-- add your own keymapping
--
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["//"] = ":Ag<SPACE>"
lvim.keys.normal_mode["<C-w>"] = ":WinResizerStartResize<cr>"
-- lvim.keys.normal_mode["///"] = ":AgJS<SPACE>"
lvim.builtin.nvimtree.setup.view.relativenumber = true
lvim.builtin.terminal.open_mapping = "<c-t>"
-- lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
-- lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

-- -- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["W"] = { "<cmd>noautocmd w<cr>", "Save without formatting" }
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["jf"] = { ":%!jq .<cr>", "Format JSON" }
-- -- Change theme settings
-- lvim.colorscheme = "lunar"

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true

-- -- Additional Plugins <https://www.lunarvim.org/docs/plugins#user-plugins>
lvim.plugins = {
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
      "Gedit"
    },
    ft = { "fugitive" }
  },
  {
    "pwntester/octo.nvim",
    config = function()
      require("octo").setup()
    end,
  },
  {
    "jacqueswww/vim-vyper"
  },
  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function()
          require('go.format').goimport()
        end,
        group = format_sync_grp,
      })
      require("go").setup()
    end
  },
  {
    "pwntester/octo.nvim",
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      -- 'kyazdani42/nvim-web-devicons',
    },
    config = function()
      require("octo").setup()
    end,
  },
  {
    'kelly-lin/telescope-ag',
    dependencies = { "nvim-telescope/telescope.nvim" },
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "VeryLazy",
    config = function()
      vim.g.copilot_assume_mapped = true
    end,

  },
  {
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end,
  },
  {
    'xolox/vim-notes',
    dependencies = {
      'xolox/vim-misc'
    },
    config = function()
      vim.g.notes_directories = { "~Desktop/Notes" }
      vim.g.notes_suffix = ".txt"
    end,
  },
  {
    "arakkkkk/kanban.nvim",
    config = function()
      require("kanban").setup({
        markdown = {
          description_folder = "./tasks/", -- Path to save the file corresponding to the task.
          list_head = "## ",
        }
      })
    end,
  },
  {
    'simeji/winresizer'
  },
  {
    'karb94/neoscroll.nvim',
    config = function()
      require('neoscroll').setup()
    end,
  },
  {
    "lancekrogers/vim-log-highlighting",
  },
  {
    "lancekrogers/vimscript-config",
  },
  {
    'airblade/vim-gitgutter'
  },
  {
    'mbbill/undotree'
  },
  {
    'simeji/winresizer'
  },
}

lvim.builtin.telescope.on_config_done = function(telescope)
  pcall(telescope.load_extension, "ag")
end


local ok, copilot = pcall(require, "copilot")
if not ok then
  return
end

copilot.setup {
  suggestion = {
    enabled = true,
    keymap = {
      accept = "<c-l>",
      next = "<c-j>",
      prev = "<c-k>",
      dismiss = "<c-h>",
    },
  },
  filetypes = {
    markdown = true,
    yaml = true,
  },
  panel = {
    auto_refresh = true,
  }
}
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<c-s>", "<cmd>lua require('copilot.suggestion').toggle_auto_trigger()<CR>", opts)

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup { { name = "black" }, }
lvim.format_on_save.enabled = true
lvim.format_on_save.pattern = { "*.py" }
