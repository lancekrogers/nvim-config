return {
  "direnv/direnv.vim", -- < 200 LoC, zero deps
  lazy = false, -- load immediately (before lspconfig)
  init = function()
    -- optional: be explicit about auto‐export
    vim.g.direnv_auto = 1 -- on BufEnter/DirChanged
  end,
}
