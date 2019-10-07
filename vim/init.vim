"Initialize Vim-Plug~/.vim/plugged
call plug#begin('~/.local/share/nvim/plugged')
Plug 'Lokaltog/vim-monotone'
Plug 'scrooloose/nerdtree'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'chemzqm/vim-jsx-improve'
Plug 'jordwalke/vim-taste'
Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'elzr/vim-json'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()


"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
    set termguicolors
  endif
endif
  
set ambiwidth=double
set foldmethod=manual
"colorscheme base16-default-dark
"set background=dark " for the dark version
set background=light " for the light version
colorscheme monotone
"colorscheme taste

"Airline Theme
"let g:airline_theme='base16'
let g:airline_theme='taste'

"______coc specific stuff
command! -nargs=0 Prettier :CocCommand prettier.formatFile
vmap ,r  <Plug>(coc-format-selected)
nmap ,r  <Plug>(coc-format-selected)

" Leader Maps
nmap <space> <leader>
inoremap jk <esc>
inoremap kj <esc>
inoremap <leader> s :w<cr>
nmap <leader>s :w<CR>
nmap <leader>q :q<CR>

"Better movement to the front of the line
nmap 0 ^

"Buffer movement etc
nmap <leader>w :bd<CR>
nmap ,l :bnext<CR>
nmap ,k :bprev<CR>

"FZF
nnoremap <silent> <leader>f :FZF<cr>
nnoremap <silent> <leader>F :FZF ~<cr>
nnoremap <silent> <leader>fg :GFile<cr>
nnoremap <silent> <leader>ag :Ag<cr>

" Show Line Numbers
set number

" Indent using spaces instead of tabs
set expandtab

"Setting the update time to display gitgutter info quicker
set updatetime=100

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
"Some more NERDTree stuff
let g:WebDevIconsOS = 'Darwin'
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1
let g:DevIconsEnableFolderExtensionPatternMatching = 1
let NERDTreeDirArrowExpandable = "\u00a0" " make arrows invisible
let NERDTreeDirArrowCollapsible = "\u00a0" " make arrows invisible
let NERDTreeNodeDelimiter = "\u263a" " smiley face
let NERDTreeShowHidden=1
let NERDTreeDirArrowExpandable = '▷'
let NERDTreeDirArrowCollapsible = '▼'
let g:NERDTreeIndicatorMapCustom = {
  \ "Modified"  : "✹",
  \ "Staged"    : "✚",
  \ "Untracked" : "✭",
  \ "Renamed"   : "➜",
  \ "Unmerged"  : "═",
  \ "Deleted"   : "✖",
  \ "Dirty"     : "✗",
  \ "Clean"     : "✔︎",
  \ 'Ignored'   : '☒',
  \ "Unknown"   : "?"
  \ }

"Remove search match Highlighting
nnoremap <esc> :noh<return><esc>

syntax on
set smartindent
set clipboard=unnamed " use os clipboard
set shiftwidth=2 " number of spaces when shift indenting
set tabstop=2 " number of visual spaces per tab
set softtabstop=2 " number of spaces in tab when editing
set expandtab " tab to spaces
set showmatch " highlight matching [{()}]
set incsearch " search as characters are entered
set hlsearch " highlight matches
set noruler
set noshowmode
set hidden
set ignorecase " case insensitive searching
set smartcase " case-sensitive if expresson contains a capital letter
set nolazyredraw " don't redraw while executing macros
set wrap " turn on line wrapping
set linebreak " set soft wrapping
set autoindent " automatically set indent of new line
set ttyfast " faster redrawing

set t_Co=256 " Explicitly tell vim that the terminal supports 256 colors

" Airline
 let g:airline_powerline_fonts = 1
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
