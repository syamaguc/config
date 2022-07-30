set runtimepath+=~/.vimruntime

source ~/.vimruntime/vimrcs/basic.vim
source ~/.vimruntime/vimrcs/keybind.vim
source ~/.vimruntime/vimrcs/platform.vim
source ~/.vimruntime/vimrcs/utils.vim

source ~/.vimruntime/nvimrcs/plugin.vim
source ~/.vimruntime/nvimrcs/plugin_config.vim
source ~/.vimruntime/nvimrcs/coc.vim

try
    source ~/.vimruntime/nvimrcs/my_configs.vim
catch

endtry
