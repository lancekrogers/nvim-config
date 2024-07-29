--/plugins/mini-comment.lua

return {
  { import = "lazyvim.plugins.extras.coding.mini-comment" },
  {
    "echasnovski/mini.comment",
    opts = {
      mappings = {
        comment = "<LEADER>/",
        comment_line = "<LEADER>/",
        comment_visual = "<LEADER>/",
        textobject = "<LEADER>/",
      },
    },
  },
}
