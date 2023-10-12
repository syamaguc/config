-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

--- for Python
vim.g.python3_host_prog = "$PYENV_ROOT" .. "/versions/neovim3/bin/python"
