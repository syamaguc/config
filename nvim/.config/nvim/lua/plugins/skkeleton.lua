return {
  {
    -- SKK
    "vim-skk/skkeleton",
    dependencies = { "vim-denops/denops.vim" },
    config = function()
      vim.api.nvim_set_keymap("i", "<C-j>", "<Plug>(skkeleton-toggle)", { noremap = true })
      vim.api.nvim_set_keymap("c", "<C-j>", "<Plug>(skkeleton-toggle)", { noremap = true })
      vim.api.nvim_exec(
        [[
                call skkeleton#config({ 
                    \  'globalJisyo': expand('~/.config/nvim/skk/SKK-JISYO.L'),
                    \  'eggLikeNewline': v:true,
                    \ })
            ]],
        false
      )
    end,
  },
  -- override nvim-cmp
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "vim-skk/skkeleton", "rinx/cmp-skkeleton" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "skkeleton" } }))
    end,
  },
}
