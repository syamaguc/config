return {
  {
    "catppuccin/nvim",
    require("catppuccin").setup({
      flavour = "frappe",
    }),
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
