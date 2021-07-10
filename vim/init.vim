"Initialize Vim-Plug~/.vim/plugged
call plug#begin('~/.local/share/nvim/plugged')
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/gv.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-sleuth'
Plug 'mbbill/undotree'
Plug 'christoomey/vim-tmux-navigator'
Plug 'gruvbox-community/gruvbox'
Plug 'jonathanfilip/vim-lucius'
Plug 'preservim/nerdtree'
Plug 'machakann/vim-highlightedyank'
Plug 'christoomey/vim-system-copy'
Plug 'romainl/vim-cool'
Plug 'heavenshell/vim-jsdoc', {
  \ 'for': ['javascript', 'javascript.jsx','typescript'],
  \ 'do': 'make install'
\}
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'simrat39/symbols-outline.nvim'

"TS Things
 Plug 'leafgarland/typescript-vim', { 'for': ['typescript','typescriptreact'] }
 Plug 'HerringtonDarkholme/yats.vim'

Plug 'dyng/ctrlsf.vim'

"JSX VIM
 Plug 'MaxMEllon/vim-jsx-pretty'

"LSP???!!
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'hrsh7th/nvim-compe'
Plug 'neovim/nvim-lspconfig'
Plug 'glepnir/lspsaga.nvim'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

"Top bar
Plug 'kyazdani42/nvim-web-devicons'
Plug 'romgrk/barbar.nvim'
call plug#end()

"BAR
let bufferline = get(g:, 'bufferline', {})
let bufferline.animation = v:false
let bufferline.closable = v:false


set completeopt=menuone,noselect

"LSPS laid out here
lua << EOF

local lspconfig = require'lspconfig'
lspconfig.gopls.setup{
  root_dir = lspconfig.util.root_pattern('.git');
}
require'lspconfig'.tsserver.setup{}
require'lspconfig'.html.setup{}
require'lspconfig'.cssls.setup{}
require'lspconfig'.rust_analyzer.setup{}


require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
  };
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  }
)

EOF

autocmd FileType markdown let b:coc_suggest_disable = 1

highlight link CompeDocumentation NormalFloat

inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

" Yank highlight duration
let g:highlightedyank_highlight_duration = 150

let g:gruvbox_contrast_dark="hard"
let g:gruvbox_bold = 0
let g:gruvbox_italic = 0

colorscheme gruvbox

set termguicolors

let g:tmux_navigator_disable_when_zoomed = 1

"Leader Change
let mapleader = "\<Space>"

"Source vimrc on the fly
nnoremap so :so $MYVIMRC<CR>
"Format JSON
nmap <leader>jq :%!jq '.'<CR>

let g:completion_matching_smart_case = 1
let g:completion_auto_change_source = 1
let g:completion_matching_strategy_list = ['fuzzy', 'substring', 'exact', 'all']

" Goto previous/next diagnostic warning/error
nnoremap <silent><leader>e <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent><leader>r <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <silent>K <cmd>lua vim.lsp.buf.hover()<CR>

"How does type def differ from buf def?
" nnoremap <silent> gt   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gt <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent><leader> cr     <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>

autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *

nnoremap <leader>gb :call CocAction('runCommand', 'git.chunkUndo')<CR>

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

"Console it all baby
imap cll console.log()<Esc><S-f>(a

"Search Replace stuff
nnoremap <Leader>t :%s///gc<Left><Left><Left>

"Buffer movement etc
nmap <leader>w :bd<CR>

"FZF and AG
nnoremap <silent> <leader>F :FZF ~<cr>
nnoremap <silent> <leader>fa :Files<cr>
nnoremap <silent> <leader>q :Buffers<cr>
nnoremap <silent> <leader>ff :GFile<cr>
nnoremap <silent> <leader>fg :Ag<cr>
nnoremap <silent> <Leader>fw :Ag <C-R><C-W><CR>

nmap ge :NERDTreeToggle<CR>
nmap gf :NERDTreeFind<CR>

let NERDTreeShowHidden=1


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

set mouse=a
set background=dark " for the dark version
set number
set rnu "relatives
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

set cursorline
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

syntax on
