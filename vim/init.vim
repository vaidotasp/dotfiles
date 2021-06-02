"Initialize Vim-Plug~/.vim/plugged
call plug#begin('~/.local/share/nvim/plugged')
" Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/gv.vim'
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
Plug 'jonathanfilip/vim-lucius'
Plug 'preservim/nerdtree'
Plug 'machakann/vim-highlightedyank'
Plug 'christoomey/vim-system-copy'
Plug 'romainl/vim-cool'
Plug 'evanleck/vim-svelte', {'branch': 'main'}
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

" Plug 'peitalin/vim-jsx-typescript'

"JSX VIM
 Plug 'MaxMEllon/vim-jsx-pretty'

"LSP???!!
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'hrsh7th/nvim-compe'
Plug 'neovim/nvim-lspconfig'
Plug 'glepnir/lspsaga.nvim'
" Plug 'kabouzeid/nvim-lspinstall'
Plug 'nvim-lua/lsp_extensions.nvim'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
" Plug 'nvim-telescope/telescope-fzy-native.nvim'
call plug#end()

set completeopt=menuone,noselect
"LSPS laid out here
lua << EOF
--[[

    local function setup_servers()
      require'lspinstall'.setup()
      local servers = require'lspinstall'.installed_servers()
      for _, server in pairs(servers) do
        require'lspconfig'[server].setup{}
      end
    end

    setup_servers()

    -- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
    require'lspinstall'.post_install_hook = function ()
      setup_servers() -- reload installed servers
      vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    require'lspconfig'.html.setup {
    capabilities = capabilities,
    }
    require'lspconfig'.html.setup{on_attach=require'completion'.on_attach}
    require'lspconfig'.rust_analyzer.setup{on_attach=require'completion'.on_attach}
    require'lspconfig'.tsserver.setup{on_attach=require'completion'.on_attach}
    require'lspconfig'.gopls.setup{on_attach=require'completion'.on_attach}
    require'nvim-treesitter.configs'.setup {
       ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
       highlight = {
         enable = false,              -- false will disable the whole extension
         disable = { "tsx", "typescript" },  -- list of language that will be disabled
       },
     }
--]]


local lspconfig = require'lspconfig'
lspconfig.gopls.setup{
  root_dir = lspconfig.util.root_pattern('.git');
}

require'lspconfig'.tsserver.setup{}
require'lspconfig'.gopls.setup{}
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

local opts = {
    -- whether to highlight the currently hovered symbol
    -- disable if your cpu usage is higher than you want it
    -- or you just hate the highlight
    -- default: true
    highlight_hovered_item = true,

    -- whether to show outline guides 
    -- default: true
    show_guides = true,
}

require('symbols-outline').setup(opts)

-- local saga = require 'lspsaga'

-- saga.init_lsp_saga()

require'nvim-treesitter.configs'.setup {
  ensure_installed = { "javascript", "graphql", "typescript" }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = { "" }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "c" },  -- list of language that will be disabled
  },
}

require('telescope').setup{
  -- ...
}

EOF

" let g:vim_jsx_pretty_highlight_close_tag = 1

autocmd FileType markdown let b:coc_suggest_disable = 1

highlight link CompeDocumentation NormalFloat

inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })


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
" let g:coc_global_extensions=[
"       \'coc-css',
"       \'coc-highlight',
"       \'coc-html',
"       \'coc-marketplace',
"       \'coc-prettier',
"       \'coc-sh',
"       \'coc-tsserver',
"       \'coc-jest',
"       \]

" Yank highlight duration
let g:highlightedyank_highlight_duration = 150

let g:gruvbox_contrast_dark="hard"
let g:gruvbox_bold = 0
let g:gruvbox_italic = 0


" THEMES/COLORS
"let ayucolor="mirage" " for mirage version of theme

colorscheme gruvbox
"colorscheme lucius
"colorscheme ayu

set termguicolors

let g:tmux_navigator_disable_when_zoomed = 1

"Leader Change
let mapleader = "\<Space>"

"Source vimrc on the fly
nnoremap so :so $MYVIMRC<CR>
"Format JSON
nmap <leader>jq :%!jq '.'<CR>

"NVIM - LSP Bindings ---COMPLETION
" inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" Set completeopt to have a better completion experience

let g:completion_matching_smart_case = 1
let g:completion_auto_change_source = 1
let g:completion_matching_strategy_list = ['fuzzy', 'substring', 'exact', 'all']

" Avoid showing message extra message when using completion
" set shortmess+=c
" imap <tab> <Plug>(completion_smart_tab)
" imap <s-tab> <Plug>(completion_smart_s_tab)

"NVIM - LSP Bindings ---BINDINGS
 " set updatetime=300
 " autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()
 " set signcolumn=yes
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
" nnoremap <silent><leader>ca :Lspsaga code_action<CR>


"Use K to show documentation in preview window.
" nnoremap <silent> K :call <SID>show_documentation()<CR>

" function! s:show_documentation()
"   if (index(['vim','help'], &filetype) >= 0)
"     execute 'h '.expand('<cword>')
"   elseif (coc#rpc#ready())
"     call CocActionAsync('doHover')
"   else
"     execute '!' . &keywordprg . " " . expand('<cword>')
"   endif
" endfunction

" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
" nmap <silent> <leader>e <Plug>(coc-diagnostic-prev)
" nmap <silent> <leader>r <Plug>(coc-diagnostic-next)

" vmap <leader>p  <Plug>(coc-format-selected)
" nmap <leader>p  <Plug>(coc-format-selected)

" GoTo code navigation.
" nmap gd <Plug>(coc-definition)
" nmap gt <Plug>(coc-type-definition)
" nmap gi <Plug>(coc-implementation)
" nmap gr <Plug>(coc-references)
" nmap <leader>ac  <Plug>(coc-codeaction)


" Git
" nmap <silent> <leader>v <Plug>(coc-git-nextchunk)
" nmap <silent> <leader>c <Plug>(coc-git-prevchunk)
" nmap <silent> <leader>b <Plug>(coc-git-chunkinfo)
" nmap <silent> <leader>gb <Plug>(coc-git-chunkUndo)
nnoremap <leader>gb :call CocAction('runCommand', 'git.chunkUndo')<CR>

" JEST Runner
" Run jest for current project
" command! -nargs=0 Jest :call  CocAction('runCommand', 'jest.projectTest')
" nnoremap <leader>te :call CocAction('runCommand', 'jest.projectTest')<CR>
" nnoremap <leader>tr :call CocAction('runCommand', 'jest.fileTest')<CR>


" Run jest for current file
" command! -nargs=0 JestCurrent :call  CocAction('runCommand', 'jest.fileTest', ['%'])

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

"Telescope
" Find files using Telescope command-line sugar.
" nnoremap <leader>ff <cmd>Telescope find_files<cr>
" nnoremap <leader>fg <cmd>Telescope live_grep<cr>
" nnoremap <leader>q <cmd>Telescope buffers<cr>
" nnoremap <leader>fh <cmd>Telescope help_tags<cr>


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

"Indent based on file type
"GO DEV SETUP
" let g:go_def_mode='gopls'
" let g:go_info_mode='gopls'
"Disable stuff we do not need from vim-go as coc-go handles it well enough
let g:go_def_mapping_enabled = 0
let g:go_highlight_diagnostic_warnings = 0
let g:go_highlight_diagnostic_errors = 0
" let g:go_fmt_options = "-tabwidth=4"

" TAB/SPACE Config
au BufNewFile,BufRead *.go setlocal noet ts=4 sw=4 sts=4
autocmd Filetype go setlocal shiftwidth=4 softtabstop=4

syntax on
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

" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction
