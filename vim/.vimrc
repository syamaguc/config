" Leader key
let g:mapleader = "\<Space>"
let g:maplocalleader = ','

filetype plugin on
filetype indent on
syntax on

" show complete if there are just 1 candidate
set completeopt+=menuone

" Line
set so=7
set number
" if set cursorline, tmux transparent doesn't work
set cursorline
set ruler

" Command mode complement
set nocompatible
set wildmenu
set wildmode=longest:full,full

" Height of the command bar
set cmdheight=1

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Add a bit extra margin to the left
set foldcolumn=1

" Turn backup off, since most stuff is in SVN, git etc. anyway...
set nobackup
set nowb
set noswapfile

" Cursol shape
let &t_EI .= "\<Esc>[0 q"
let &t_SI .= "\<Esc>[6 q"
autocmd Vimleave * silent !echo -ne "\e[8 q"

" Use Unix as the standard file type
set encoding=utf8
set ffs=unix,dos,mac

" Tab setting
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500
set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" Specify the behavior when switching between buffers
try
  srt switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Load macro
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
source $VIMRUNTIME/macros/matchit.vim


" -------------
" => Editing
" -------------
inoremap <silent> jj <ESC>
imap <silent> kk <ESC>f)a
noremap j gj
noremap k gk
noremap <leader>w :w<CR>

" -------------
" => Moving
" -------------
" jump motion
noremap <C-i> <C-i>

" Smart way to move between windows
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l

" Complement moving
inoremap <C-j> <C-n>
inoremap <C-k> <C-p>

" Bash like keys for the command line
cnoremap <C-a>		<Home>
cnoremap <C-e>		<End>

" jump to bracket
nmap H [%
nmap L ]%

" -------------
" => Explorer
" -------------
" FZF
nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>g :Rg<CR>

" Tab
nmap <leader>1 :tabfirst<cr>
nmap <C-t> :tabnew<cr>
nmap <C-w> :tabclose<cr>
nmap <C-q> :tabonly<cr>
nmap <leader><TAB> :tabnext<cr>

" -------------
" => Other
" -------------

" Fast saving
nmap <leader><ESC> <ESC><S-z><S-z>

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Copy to clipboard
vmap cp "+ygv

" paste
nmap paste "+p}k

" sudo w
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

" Check file absolutely path
command! FP :echo expand("%:p")
