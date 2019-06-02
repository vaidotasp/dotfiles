"Initialize Vim-Plug~/.vim/plugged
call plug#begin('~/.local/share/nvim/plugged')
Plug 'scrooloose/nerdtree'
"Completion stuff
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}

" Plugin outside ~/.vim/plugged with post-update hook
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale'
Plug 'chemzqm/vim-jsx-improve'
Plug 'altercation/vim-colors-solarized'
"Plug 'joshdick/onedark.vim'
Plug 'sheerun/vim-polyglot'
Plug 'jordwalke/vim-taste'
"Plug 'chriskempson/base16-vim'
call plug#end()

set ambiwidth=double
set termguicolors     " enable true colors support
"colorscheme base16-default-dark
set background=dark " for the dark version
colorscheme taste
" set background=light " for the light version

"Airline Theme
"let g:airline_theme='base16'
let g:airline_theme='taste'

"Buffer movement
nmap ,l :bnext<CR>
nmap ,k :bprev<CR>

"ALE Setup
"Enable completion where available
let g:ale_completion_enabled = 0

"Sign Gutter Toggle -> Always on
let g:ale_sign_column_always = 1

"Get some opacity going on popupmenus
"set pumblend=20
"FZF
nnoremap <silent> <leader>f :FZF<cr>
nnoremap <silent> <leader>F :FZF ~<cr>

" Show Line Numbers
set number

" Indent using spaces instead of tabs
set expandtab

" The number of spaces to use for each indent
set shiftwidth=2

" Open NERDTree by default
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" NERDTREE minimize details
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeShowHidden=1

" Toggle file drawer in/out
nmap ,n :NERDTreeFind<CR>
nmap ,m :NERDTreeToggle<CR>

" Use , as <Leader>
let mapleader=","

" Enable yanking to the clipboard
set clipboard=unnamed

" Highlight search matches
set hlsearch

"Remove search match Highlighting
nnoremap <esc> :noh<return><esc>

" Syntax Highlighting ON
syntax on

set smartindent
set clipboard=unnamed " use os clipboard
set shiftwidth=2 " number of spaces when shift indenting
set tabstop=2 " number of visual spaces per tab
set softtabstop=2 " number of spaces in tab when editing
set expandtab " tab to spaces
"set cursorline  " highlight current line
set showmatch " highlight matching [{()}]
set incsearch " search as characters are entered
set hlsearch " highlight matches

" airline
"let g:airline_theme='solarized'
"let g:airline_solarized_bg='dark'
let g:airline#extensions#branch#enabled = 1 
let g:airline#extensions#tabline#enabled = 1 
let g:airline_section_warning = '' 
let g:airline_section_y = '' 
let g:airline_section_x = '' 
"let g:airline_left_sep = ' '
"let g:airline_right_sep = ' '

"set laststatus=2 " for airline

set noruler
set noshowmode
set hidden

" Eliminating the delay for seamless insert/normal/visual switch
set timeoutlen=1000 ttimeoutlen=0

set backspace=indent,eol,start  " more powerful backspacing

"FZF for Vim
set rtp+=/usr/local/opt/fzf

" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <expr> <tab> InsertTabWrapper()
inoremap <s-tab> <c-n>
