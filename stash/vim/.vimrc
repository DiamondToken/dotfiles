syntax enable
set number relativenumber
set tabstop=4
set shiftwidth=4
set expandtab
syntax on
set backspace=indent,eol,start
set showcmd
set wildmenu
set scrolloff=5
set smartcase
set ignorecase
"set backup
"set lbr
"set bex=&
"set ai
"set si

set is
set t_Co=256


let python_highlight_all = 1
let g:livepreview_previewer = 'zathura'
"let mapleader="\\"

call plug#begin()
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex'}
Plug 'chrisbra/Colorizer'
Plug 'tpope/vim-surround'
Plug 'altercation/vim-colors-solarized'
call plug#end()

colorscheme solarized
set background=dark

filetype on
