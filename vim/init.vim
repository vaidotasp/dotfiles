"Initialize Vim-Plug~/.vim/plugged
call plug#begin('~/.local/share/nvim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'jordwalke/vim-taste'
Plug 'mbbill/undotree'
Plug 'christoomey/vim-tmux-navigator'
Plug 'morhetz/gruvbox'
Plug 'hzchirs/vim-material'
"
"TS Things
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript', { 'for': 'typescript.jsx' }
"JSX VIM
Plug 'chemzqm/vim-jsx-improve'
"
call plug#end()

" Dark

" THEMES/COLORS
colorscheme gruvbox
set background=dark " for the dark version
"set background=light " for the light version
let g:gruvbox_contrast_dark="medium"
"let g:gruvbox_contrast_light="hard"
let g:gruvbox_bold=1
" colorscheme gruvbox
" colorscheme vim-material
"Airline Theme
"let g:airline_theme='base16'
"let g:airline_theme='taste'
let g:airline_theme='gruvbox'

let g:tmux_navigator_disable_when_zoomed = 1

"Leader Change
let mapleader = " "

"______coc specific stuff
nmap ge :CocCommand explorer<CR>
command! -nargs=0 Prettier :CocCommand prettier.formatFile
vmap <leader>,r  <Plug>(coc-format-selected)
nmap <leader>,r <Plug>(coc-format-selected)
" nmap <silent> <leader>a <Plug>(coc-diagnostic-next-error)
" nmap <silent> <leader>a <Plug>(coc-diagnostic-next)
nmap <silent> [c <Plug>(coc-diagnostic-prev-error)
nmap <silent> ]c <Plug>(coc-diagnostic-next-error)

"Undo TREE
nmap <leader>io :UndotreeToggle<cr>

"EXPERIMENTAL DOCUMENTATION STUFF
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
nnoremap <silent> I :call <SID>show_documentation()<CR>

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
"Do Hover!
nmap <silent> gh :call CocAction('doHover')<CR>


"Move highlighted chunks around line in other editors
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"COC GIT mappings
" navigate chunks of current buffer
nmap [g <Plug>(coc-git-prevchunk)
nmap ]g <Plug>(coc-git-nextchunk)
" show chunk diff at current position
nmap gs <Plug>(coc-git-chunkinfo)
nmap gu :CocCommand git.chunkUndo<CR>

nmap <leader>s :w<CR>
nmap <leader>q :q<CR>

"Fugitive
nmap <leader>gs :Gstatus<CR>

"Better movement to the front of the line
nmap 0 ^

"Buffer movement etc
nmap <leader>w :bd<CR>
nmap <leader>l :bnext<CR>
nmap <leader>k :bprev<CR>

"FZF and AG
nnoremap <silent> <leader>ff :Files<cr>
nnoremap <silent> <leader>F :FZF ~<cr>
nnoremap <silent> <leader>fg :GFile<cr>
nnoremap <silent> <leader>ag :Ag<cr>
nnoremap <silent> <Leader>aw :Ag <C-R><C-W><CR>


let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Show Line Numbers
set number

"Syntax highlight for jsdoc
let g:javascript_plugin_jsdoc = 1

"Setting the update time to display gitgutter info quicker
set updatetime=300

"Remove search match Highlighting
nnoremap <esc> :noh<return><esc>

syntax on
set smartindent
set clipboard=unnamed " use os clipboard
set shiftwidth=2 " number of spaces when shift indenting
set tabstop=2 " number of visual spaces per tab
set softtabstop=2 " number of spaces in tab when editing
set shiftround " round indent to a multiple of 'shiftwidth'
set expandtab " tab to spaces
set showmatch " highlight matching [{()}]
set incsearch " search as characters are entered
set hlsearch " highlight matches
set noruler
set noshowmode
set hidden
set ignorecase " case insensitive searching
set smartcase " case-sensitive if expresson contains a capital letter
set lazyredraw " don't redraw while executing macros
set wrap " turn on line wrapping
set wrapmargin=8
set linebreak " set soft wrapping
set showbreak=… " show ellipsis at breaking
set autoindent " automatically set indent of new line
set ttyfast " faster redrawing
set cmdheight=1 "display messages
set shortmess+=c
set wildmenu " enhanced command line completion
set signcolumn=yes
set shortmess+=c

set undodir=~/.vim/undodir
set undofile
"set number relativenumber
"set nu rnu
set termguicolors
set cursorline
set ambiwidth=double
set foldmethod=manual
" set t_Co=256 " Explicitly tell vim that the terminal supports 256 colors
set inccommand=nosplit
set nolazyredraw " don't redraw while executing macros

" code folding settings
set foldmethod=syntax " fold based on indent
set foldlevelstart=99
set foldnestmax=10 " deepest fold is 10 levels
set nofoldenable " don't fold by default
set foldlevel=1
set laststatus=2 " show the status line all the time


" Airline
"let g:airline_powerline_fonts = 1
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

"Split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>


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
