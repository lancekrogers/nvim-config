-- ~/.config/nvim/lua/plugins/neo-tree.lua
return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = function(_, keys)
      -- remove the default <leader>e mapping
      keys[#keys + 1] = { "<leader>e", false }

      local cmd = require("neo-tree.command")

      -- new lowercase mapping → CWD
      keys[#keys + 1] = {
        "<leader>e",
        function()
          cmd.execute({ toggle = true, dir = vim.uv.cwd() })
        end,
        desc = "Explorer NeoTree (cwd)",
      }

      -- optional: uppercase now opens project root
      keys[#keys + 1] = {
        "<leader>E",
        function()
          cmd.execute({ toggle = true, dir = require("lazyvim.util").root() })
        end,
        desc = "Explorer NeoTree (root)",
      }
    end,
    opts = {
      event_handlers = {
        {
          event = "neo_tree_buffer_enter",
          handler = function(arg)
            vim.cmd([[
              setlocal number
              setlocal relativenumber
            ]])
          end,
        },
      },
      filesystem = {
        filtered_items = {
          visible = false,
          hide_dotfiles = true,
          hide_gitignored = true,
        },
        commands = {
          scaffold = function(state)
            local node = state.tree:get_node()
            if not node or node.type ~= "directory" then
              vim.notify("📁 tree2scaffold: select a directory first", vim.log.levels.WARN)
              return
            end

            local root = node.path
            vim.notify("⏳ Running tree2scaffold on: " .. root, vim.log.levels.INFO)

            -- Grab the tree spec from the '+' register
            local tree_spec = vim.fn.getreg("+")
            if tree_spec == "" then
              vim.notify("📋 tree2scaffold: clipboard is empty", vim.log.levels.WARN)
              return
            end

            -- Run the CLI synchronously, piping tree_spec into stdin
            local cmd = { "tree2scaffold", "-root", root }
            local output = vim.fn.system(cmd, tree_spec)
            local ok = vim.v.shell_error == 0

            if ok then
              vim.notify("✅ Scaffold complete in " .. root, vim.log.levels.INFO)
              -- refresh Neo-Tree’s filesystem view
              vim.cmd("Neotree action=refresh source=filesystem")
            else
              vim.notify("❌ tree2scaffold failed:\n" .. output, vim.log.levels.ERROR)
            end
          end,
        },
        window = {
          mappings = {
            ["t2s"] = "scaffold",
          },
        },
      },
    },
  },
}
