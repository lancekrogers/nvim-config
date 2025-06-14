-- ~/.config/nvim/lua/plugins/neo-tree.lua
return {
  {
    "nvim-neo-tree/neo-tree.nvim",
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

          toggle_git_highlight = function()
            local disable = not vim.g.neo_tree_git_highlight_disabled
            vim.g.neo_tree_git_highlight_disabled = disable

            local groups = {
              "NeoTreeGitUnstaged",
              "NeoTreeGitStaged",
              "NeoTreeGitUntracked",
              "NeoTreeGitIgnored",
              "NeoTreeGitRenamed",
              "NeoTreeGitDeleted",
              "NeoTreeGitConflict",
            }

            if disable then
              for _, group in ipairs(groups) do
                vim.api.nvim_set_hl(0, group, { link = "Normal" })
              end
              vim.notify("🎨 Git highlighting disabled", vim.log.levels.INFO)
            else
              -- Reload the colorscheme to reset highlight groups to defaults
              local scheme = vim.g.colors_name or "default"
              vim.cmd.colorscheme(scheme)
              vim.notify("🎨 Git highlighting enabled", vim.log.levels.INFO)
            end

            -- Refresh Neo-tree
            vim.cmd("Neotree action=refresh source=filesystem")
          end,
        },
        window = {
          mappings = {
            ["t2s"] = "scaffold",
            -- ["s"] = "toggle_git_highlight",
          },
        },
      },
    },
  },
}
