set runtimepath+=~/.vimruntime

source ~/.vimruntime/vimrcs/basic.vim
source ~/.vimruntime/vimrcs/utils.vim
source ~/.vimruntime/vimrcs/keybind.vim
source ~/.vimruntime/vimrcs/plugin.vim
source ~/.vimruntime/vimrcs/plugin_config.vim

try
    source ~/.vimruntime/vimrcs/my_configs.vim
catch

endtry
