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
Plug 'lewis6991/gitsigns.nvim'
Plug 'nvim-telescope/telescope.nvim'

"Bottom bar
Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}
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

require('gitsigns').setup{
  keymaps = {
    noremap = true,
    buffer = true,
    ['n <leader>v'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'"},
    ['n <leader>c'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'"},

    ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
    ['v <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
    ['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
    ['v <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    ['n <leader>hR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
    ['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
    ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',

  }
}

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

--GalaxyLine
local status_ok, gl = pcall(require, "galaxyline")
if not status_ok then
  return
end

local gl = require('galaxyline')
local gls = gl.section
local condition = require "galaxyline.condition"

gl.short_line_list = { "NvimTree", "vista", "dbui", "packer" }


--local colors = require('galaxyline.theme').default
local colors = {
  -- bg = "#2E2E2E",
  -- bg = '#292D38', 
  bg = "#292929",
  yellow = "#DCDCAA",
  dark_yellow = "#D7BA7D",
  cyan = "#4EC9B0",
  green = "#608B4E",
  light_green = "#B5CEA8",
  string_orange = "#CE9178",
  orange = "#FF8800",
  purple = "#C586C0",
  magenta = "#D16D9E",
  grey = "#858585",
  blue = "#569CD6",
  vivid_blue = "#4FC1FF",
  light_blue = "#9CDCFE",
  red = "#D16969",
  error_red = "#F44747",
  info_yellow = "#FFCC66",
}


local buffer_not_empty = function()
  if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
    return true
  end
  return false
end

table.insert(gls.left, {
    ViMode = {
    provider = function()
      -- auto change color according the vim mode
      local mode_color = {
        n = colors.blue,
        i = colors.green,
        v = colors.purple,
        [""] = colors.purple,
        V = colors.purple,
        c = colors.magenta,
        no = colors.blue,
        s = colors.orange,
        S = colors.orange,
        [""] = colors.orange,
        ic = colors.yellow,
        R = colors.red,
        Rv = colors.red,
        cv = colors.blue,
        ce = colors.blue,
        r = colors.cyan,
        rm = colors.cyan,
        ["r?"] = colors.cyan,
        ["!"] = colors.blue,
        t = colors.blue,
      }
      vim.api.nvim_command("hi GalaxyViMode guifg=" .. mode_color[vim.fn.mode()])
      return "▊"
    end,
    separator_highlight = "StatusLineSeparator",
    highlight = "StatusLineNC",
  },

})

vim.fn.getbufvar(0, "ts")

table.insert(gls.left, {
  GitIcon = {
    provider = function()
      return "  "
    end,
    condition = condition.check_git_workspace,
    separator = " ",
    separator_highlight = {"#292929", "#292929"},
    highlight = {"#C67158", "#292929"},
  },
})
table.insert(gls.left, {
  GitBranch = {
    provider = "GitBranch",
    condition = condition.check_git_workspace,
    separator = " ",
    separator_highlight = {"#292929", "#292929"},
    highlight = {"#87B479","#292929"},

  },
})
table.insert(gls.left, {
  DiffAdd = {
    provider = "DiffAdd",
    condition = condition.hide_in_width,
    icon = "  ",
    highlight = {"#C67158","#292929"},
  },
})

table.insert(gls.left, {
  DiffModified = {
    provider = "DiffModified",
    condition = condition.hide_in_width,
    icon = " 柳",
    highlight = {"#5486C0","#292929"},
  },
})

table.insert(gls.left, {
  DiffRemove = {
    provider = "DiffRemove",
    condition = condition.hide_in_width,
    icon = "  ",
    highlight ={"#AF4B57","#292929"},
  },
})

table.insert(gls.left, {
  DiagnosticError = {
    provider = "DiagnosticError",
    icon = "  ",
    highlight = {"#F44848","#292929" },
  },
})
table.insert(gls.left, {
  DiagnosticWarn = {
    provider = "DiagnosticWarn",
    icon = "  ",
    highlight = {"#FF8800","#292929" },
  },
})

table.insert(gls.left, {
  DiagnosticInfo = {
    provider = "DiagnosticInfo",
    icon = "  ",
    highlight = {"#FFCC66","#292929" },
  },
})

table.insert(gls.left, {
  DiagnosticHint = {
    provider = "DiagnosticHint",
    icon = "  ",
    highlight = {"#4DC1FF","#292929" },
  },
})

table.insert(gls.right, {
  TreesitterIcon = {
    provider = function()
      if next(vim.treesitter.highlighter.active) ~= nil then
        return "  "
      end
      return ""
    end,
    separator = " ",
    separator_highlight = {"#292929", "#292929"},
    highlight = {"#87B479","#292929"},
  },
})

local get_lsp_client = function(msg)
  msg = msg or "LSP Inactive"
  local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
  local clients = vim.lsp.get_active_clients()
  if next(clients) == nil then
    return msg
  end
  local lsps = ""
  for _, client in ipairs(clients) do
    local filetypes = client.config.filetypes
    if filetypes and vim.fn.index(filetypes, buf_ft) ~= 1 then
      -- print(client.name)
      if lsps == "" then
        -- print("first", lsps)
        lsps = client.name
      else
        lsps = lsps .. ", " .. client.name
        -- print("more", lsps)
      end
    end
  end
  if lsps == "" then
    return msg
  else
    return lsps
  end
end

table.insert(gls.right, {
  ShowLspClient = {
    provider = get_lsp_client,
    condition = function()
      local tbl = { ["dashboard"] = true, [" "] = true }
      if tbl[vim.bo.filetype] then
        return false
      end
      return true
    end,
    icon = "  ",
    highlight = {"#C7C8C0","#292929"},
  },
})

table.insert(gls.right, {
  LineInfo = {
    provider = "LineColumn",
    separator = " ",
    separator_highlight = {"#292929", "#292929"},
    highlight = {"#C7C8C0","#292929"},
  },
})

table.insert(gls.right, {
  PerCent = {
    provider = "LinePercent",
    separator = " ",
    separator_highlight = {"#292929", "#292929"},
    highlight = {"#C7C8C0","#292929"},
  },
})

table.insert(gls.right, {
  Tabstop = {
    provider = function()
      return "Spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth") .. " "
    end,
    condition = condition.hide_in_width,
    separator = " ",
    separator_highlight = {"#292929", "#292929"},
    highlight = {"#C7C8C0","#292929"},
  },
})

table.insert(gls.right, {
  BufferType = {
    provider = "FileTypeName",
    condition = condition.hide_in_width,
    separator = " ",
    separator_highlight = {"#292929", "#292929"},
    highlight = {"#C7C8C0","#292929"},
  },
})

table.insert(gls.right, {
  Space = {
    provider = function()
      return " "
    end,
    separator = " ",
    highlight = {"#C7C8C0","#292929"},
  },
})

table.insert(gls.short_line_left, {
  BufferType = {
    provider = "FileTypeName",
    separator = " ",
    separator_highlight = {"#292929", "#292929"},
    highlight = {"#C7C8C0","#292929"},
  },
})

table.insert(gls.short_line_left, {
  SFileName = {
    provider = "SFileName",
    condition = condition.buffer_not_empty,
    highlight = {"#C7C8C0","#292929"},
  },
})

EOF

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
