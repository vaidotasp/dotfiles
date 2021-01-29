"Initialize Vim-Plug~/.vim/plugged
call plug#begin('~/.local/share/nvim/plugged')
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
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
Plug 'gruvbox-community/gruvbox'
Plug 'preservim/nerdtree'
Plug 'machakann/vim-highlightedyank'
Plug 'jonathanfilip/vim-lucius'
Plug 'ayu-theme/ayu-vim'
Plug 'christoomey/vim-system-copy'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'romainl/vim-cool'
Plug 'evanleck/vim-svelte', {'branch': 'main'}
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
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
" Plug 'nvim-lua/popup.nvim'
" Plug 'nvim-lua/plenary.nvim'
" Plug 'nvim-telescope/telescope.nvim'
call plug#end()

" lua require'lspconfig'.tsserver.setup{}

" Completion stuff here
" let g:completion_enable_auto_popup = 1
" let g:completion_enable_auto_hover = 1
" let g:completion_matching_smart_case = 1
" let g:completion_auto_change_source = 1
" let g:completion_matching_strategy_list = ['fuzzy', 'substring', 'exact', 'all']
" autocmd BufEnter * lua require'completion'.on_attach()

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

"COC Things"

let g:coc_global_extensions=[
      \'coc-css',
      \'coc-highlight',
      \'coc-html',
      \'coc-marketplace',
      \'coc-prettier',
      \'coc-rust-analyzer',
      \'coc-sh',
      \'coc-tabnine',
      \'coc-tsserver',
      \'coc-jest',
      \]

" Yank highlight duration
let g:highlightedyank_highlight_duration = 150

"set background=light " for the dark version
" let g:gruvbox_contrast_dark="medium"
" let g:gruvbox_invert_selection = 0
" let g:gruvbox_bold = 0


" THEMES/COLORS
colorscheme gruvbox
" colorscheme lucius
"colorscheme ayu

let g:tmux_navigator_disable_when_zoomed = 1

"Leader Change
let mapleader = "\<Space>"

"Format JSON
nmap <leader>jq :%!jq '.'<CR>

"NVIM - LSP Bindings
" nnoremap <leader>r <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
" nnoremap <leader>e <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>

" nnoremap <silent> gt <cmd>lua vim.lsp.buf.definition()<CR>
" nnoremap <silent> cc <cmd>lua vim.lsp.stop_client(vim.lsp.get_active_clients())<CR>
" nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
" nnoremap <silent> re     <cmd>lua vim.lsp.buf.rename()<CR>
" nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
" nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
" nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
" nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
" nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
" nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
" nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> <leader>e <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>r <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap gd <Plug>(coc-definition)
nmap gt <Plug>(coc-type-definition)
nmap gi <Plug>(coc-implementation)
nmap gr <Plug>(coc-references)

" Git
nmap <silent> <leader>v <Plug>(coc-git-nextchunk)
nmap <silent> <leader>c <Plug>(coc-git-prevchunk)
nmap <silent> <leader>b <Plug>(coc-git-chunkinfo)
" nmap <silent> <leader>gb <Plug>(coc-git-chunkUndo)
nnoremap <leader>gb :call CocAction('runCommand', 'git.chunkUndo')<CR>

" JEST Runner
" Run jest for current project
" command! -nargs=0 Jest :call  CocAction('runCommand', 'jest.projectTest')
nnoremap <leader>te :call CocAction('runCommand', 'jest.projectTest')<CR>
nnoremap <leader>tr :call CocAction('runCommand', 'jest.fileTest')<CR>


" Run jest for current file
command! -nargs=0 JestCurrent :call  CocAction('runCommand', 'jest.fileTest', ['%'])

"Undo TREE
nmap <leader>io :UndotreeToggle<cr>

" If doc exist, show in I - man pages typically
nnoremap <silent> I :call <SID>show_documentation()<CR>

"Move highlighted chunks around line in other editors
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"VIM FUGITIVE
nmap <leader>gp :diffget //3<CR>
nmap <leader>gq :diffget //2<CR>

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
" nnoremap <silent> <leader>F :FZF ~<cr>
nnoremap <silent> <leader>fa :Files<cr>
nnoremap <silent> <leader>q :Buffers<cr>
nnoremap <silent> <leader>ff :GFile<cr>
nnoremap <silent> <leader>fg :Ag<cr>
nnoremap <silent> <Leader>fw :Ag <C-R><C-W><CR>

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

"Syntax highlight for jsdoc
let g:javascript_plugin_jsdoc = 1

"Indent based on file type
"GO DEV SETUP
"Disable stuff we do not need from vim-go as coc-go handles it well enough
" let g:go_def_mapping_enabled = 0
" let g:go_highlight_diagnostic_warnings = 0
" let g:go_highlight_diagnostic_errors = 0
" let g:go_fmt_options = "-tabwidth=4"

" TAB/SPACE Config
au BufNewFile,BufRead *.go setlocal noet ts=4 sw=4 sts=4
autocmd Filetype go setlocal shiftwidth=4 softtabstop=4

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
" set ttyfast " faster redrawing
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
" set nolazyredraw " don't redraw while executing macros

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

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
