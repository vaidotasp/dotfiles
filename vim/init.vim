"Initialize Vim-Plug~/.vim/plugged
call plug#begin('~/.local/share/nvim/plugged')
Plug 'neoclide/coc.nvim'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-sleuth'
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'mbbill/undotree'
Plug 'christoomey/vim-tmux-navigator'
Plug 'morhetz/gruvbox'
Plug 'preservim/nerdtree'
Plug 'machakann/vim-highlightedyank'
Plug 'jonathanfilip/vim-lucius'
Plug 'christoomey/vim-system-copy'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'romainl/vim-cool'
Plug 'evanleck/vim-svelte', {'branch': 'main'}
Plug 'heavenshell/vim-jsdoc', { 
  \ 'for': ['javascript', 'javascript.jsx','typescript'], 
  \ 'do': 'make install'
\}


"TS Things
Plug 'leafgarland/typescript-vim', { 'for': ['typescript','typescriptreact'] }
Plug 'HerringtonDarkholme/yats.vim'
" Plug 'peitalin/vim-jsx-typescript'

"JSX VIM
Plug 'MaxMEllon/vim-jsx-pretty'

"LSP???!!
" Plug 'neovim/nvim-lspconfig'
" Plug 'nvim-lua/completion-nvim'
call plug#end()

" set filetypes as typescriptreact
"autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact


let g:vim_jsx_pretty_highlight_close_tag = 1

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'tabline': {
      \   'left': [ ['buffers'] ],
      \   'right': [ ['close'] ]
      \ },
      \ 'component_expand': {
      \   'buffers': 'lightline#bufferline#buffers'
      \ },
      \ 'component_type': {
      \   'buffers': 'tabsel'
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status'
      \ },
      \ }

" let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
" lua require'nvim_lsp'.tsserver.setup{ on_attach=require'completion'.on_attach }


"Further LSP setup
" let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
" lua <<EOF
" require'nvim_lsp'.tsserver.setup{ on_attach=require'completion'.on_attach }
" EOF


"let g:coc_node_path = '/Users/vpiekus/.config/nvm/14.1.0/bin/node'

let g:highlightedyank_highlight_duration = 150
set showtabline=2

set background=dark " for the dark version
"set background=light " for the dark version
let g:gruvbox_contrast_dark="medium"
" let g:gruvbox_invert_selection = 0
let g:gruvbox_bold = 0

" THEMES/COLORS
colorscheme gruvbox
"colorscheme lucius

" set background=light " for the light version

let g:tmux_navigator_disable_when_zoomed = 1

"Leader Change
let mapleader = "\<Space>" 

"Format JSON
nmap <leader>jq :%!jq '.'<CR>

"______coc specific stuff
command! -nargs=0 Prettier :CocCommand prettier.formatFile
nmap <leader>p :CocCommand prettier.formatFile<CR>
vmap <leader>,r  <Plug>(coc-format-selected)
nmap <leader>,r <Plug>(coc-format-selected)
nmap <silent> <leader>e <Plug>(coc-diagnostic-prev-error)
nmap <silent> <leader>r <Plug>(coc-diagnostic-next-error)
" nmap <silent> <leader>a <Plug>(coc-diagnostic-next-error)
" nmap <silent> <leader>a <Plug>(coc-diagnostic-next)

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

" If doc exist, show in I - man pages typically
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

"VIM FUGITIVE
nmap <leader>gp :diffget //3<CR>
nmap <leader>gq :diffget //2<CR>

"COC GIT mappings
" navigate chunks of current buffer
nmap <leader>c <Plug>(coc-git-prevchunk)
nmap <leader>v <Plug>(coc-git-nextchunk)
" show chunk diff at current position
nmap gs <Plug>(coc-git-chunkinfo)
nmap gu :CocCommand git.chunkUndo<CR>

"Reboot coc for when it inevitably goes bad
nmap <leader>cc :CocRestart <CR>
nmap clean :call coc#util#float_hide() <CR>
nmap <leader>s :w<CR>
"nmap <leader>q :q<CR>

"Fugitive
nmap <leader>gs :Gstatus<CR>

"Better movement to the front of the line
nmap 0 ^

"Search Replace stuff
nnoremap <Leader>t :%s///gc<Left><Left><Left>

"Buffer movement etc
nmap <leader>w :bd<CR>

"FZF and AG
nnoremap <silent> <leader>ff :Files<cr>
nnoremap <silent> <leader>F :FZF ~<cr>
nnoremap <silent> <leader>q :Buffers<cr>
nnoremap <silent> <leader>fg :GFile<cr>
nnoremap <silent> <leader>ag :Ag<cr>
nnoremap <silent> <Leader>aw :Ag <C-R><C-W><CR>
nnoremap <silent> <Leader>prw :CocSearch <C-R><C-W><CR>

"Trying some nerdtree
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"
nmap ge :NERDTreeToggle<CR>
nmap gf :NERDTreeFind<CR>

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
" nnoremap <esc> :noh<return><esc>

"Indent based on file type
"GO DEV SETUP
"Disable stuff we do not need from vim-go as coc-go handles it well enough
let g:go_def_mapping_enabled = 0
let g:go_highlight_diagnostic_warnings = 0
let g:go_highlight_diagnostic_errors = 0
" let g:go_fmt_options = "-tabwidth=4"

au BufNewFile,BufRead *.go setlocal noet ts=4 sw=4 sts=4


autocmd Filetype go setlocal shiftwidth=4 softtabstop=4

syntax on
set smartindent
"set clipboard=unnamed " use os clipboard
set shiftwidth=2 " number of spaces when shift indenting
set tabstop=2 " number of visual spaces per tab
set softtabstop=2 " number of spaces in tab when editing
set shiftround " round indent to a multiple of 'shiftwidth'
set expandtab " tab to spaces
set showmatch " highlight matching [{()}]
set incsearch " search as characters are entered
" set hlsearch " highlight matches
set noruler
set noshowmode
set hidden
set ignorecase " case insensitive searching
set smartcase " case-sensitive if expresson contains a capital letter
set nowrap " no wrap
set autoindent " automatically set indent of new line
set ttyfast " faster redrawing
set cmdheight=1 "display messages
set shortmess+=c
set wildmenu " enhanced command line completion
set signcolumn=yes
set shortmess+=c

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

"Split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

nmap <C-6> <C-^>


" Eliminating the delay for seamless insert/normal/visual switch
set timeoutlen=1000 ttimeoutlen=0

set backspace=indent,eol,start  " more powerful backspacing

"FZF for Vim
set rtp+=/usr/local/opt/fzf

"tab completion
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
