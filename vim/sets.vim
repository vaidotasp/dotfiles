syntax on
set background=dark " for the dark version
set number
set tabstop=2 " number of visual spaces per tab
set softtabstop=2 " number of spaces in tab when editing
set shiftwidth=2 " number of spaces when shift indenting
set expandtab " tab to spaces
set showtabline=2

set smartindent
set shiftround " round indent to a multiple of 'shiftwidth'
set showmatch " highlight matching [{()}]
set incsearch " search as characters are entered
set noruler
set noshowmode
set hidden
set ignorecase " case insensitive searching
set smartcase " case-sensitive if expresson contains a capital letter
set nowrap " no wrap
set autoindent " automatically set indent of new line
set ttyfast " faster redrawing
set cmdheight=1 "display messages
set wildmenu " enhanced command line completion
set signcolumn=yes
set shortmess+=c
set scrolloff=8

set undodir=~/.vim/undodir
set undofile
set termguicolors
set cursorline
set ambiwidth=double
set inccommand=nosplit
set nolazyredraw " don't redraw while executing macros

" code folding settings
set foldmethod=syntax " fold based on indent
set foldlevelstart=99
set foldnestmax=10 " deepest fold is 10 levels
set nofoldenable " don't fold by default
set foldlevel=1
set laststatus=2 " show the status line all the time
" Eliminating the delay for seamless insert/normal/visual switch
set timeoutlen=1000 ttimeoutlen=0

set backspace=indent,eol,start  " more powerful backspacing
set completeopt=menuone,noinsert,noselect

"FZF for Vim
set rtp+=/usr/local/opt/fzf
