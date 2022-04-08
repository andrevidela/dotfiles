let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

" Plug 'https://github.com/edwinb/idris2-vim.git'
" LSP things
Plug 'https://github.com/scalameta/nvim-metals.git'
Plug 'neovim/nvim-lspconfig'
Plug 'ShinKage/idris2-nvim'
Plug 'MunifTanjim/nui.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'kabouzeid/nvim-lspinstall'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh'
    \ }

" Theming
Plug 'folke/lsp-colors.nvim'
Plug 'haishanh/night-owl.vim'
Plug 'ayu-theme/ayu-vim'

" Unicode shortcuts
Plug 'arthurxavierx/vim-unicoder'

" telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

call plug#end()
lua << EOF
vim.lsp.set_log_level("debug")


-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

end

local idris2 = require('idris2')
idris2.setup({
  server = {
    on_attach = function(...)
      vim.cmd [[nnoremap <LocalLeader>ics <Cmd>lua require('idris2.code_action').case_split()<CR>]]
      vim.cmd [[nnoremap <LocalLeader>imc <Cmd>lua require('idris2.code_action').make_case()<CR>]]
      vim.cmd [[nnoremap <LocalLeader>imw <Cmd>lua require('idris2.code_action').make_with()<CR>]]
      vim.cmd [[nnoremap <LocalLeader>iml <Cmd>lua require('idris2.code_action').make_lemma()<CR>]]
      vim.cmd [[nnoremap <LocalLeader>iac <Cmd>lua require('idris2.code_action').add_clause()<CR>]]
      vim.cmd [[nnoremap <LocalLeader>ies <Cmd>lua require('idris2.code_action').expr_search()<CR>]]
      vim.cmd [[nnoremap <LocalLeader>igd <Cmd>lua require('idris2.code_action').generate_def()<CR>]]
      vim.cmd [[nnoremap <LocalLeader>irh <Cmd>lua require('idris2.code_action').refine_hole()<CR>]]
      vim.cmd [[nnoremap <LocalLeader>isp <Cmd>lua require('idris2.hover').open_split()<CR>]]
      vim.cmd [[nnoremap <LocalLeader>icp <Cmd>lua require('idris2.hover').close_split()<CR>]]
      vim.cmd [[nnoremap ]m <Cmd>lua require('idris2.metavars').goto_next()<CR>]]
      vim.cmd [[nnoremap [m <Cmd>lua require('idris2.metavars').goto_prev()<CR>]]
      vim.cmd [[nnoremap <LocalLeader>ibm <Cmd>lua require('idris2.browse').browse({popup=true})<CR>]]
      on_attach(...)
    end,
    autostart = true,
    init_options = {
       logFile = "~/.cache/idris2-lsp/server.log",
    },
  }
})

-- Set here your preferred colors for semantic values
-- vim.cmd [[highlight link LspSemantic_type Include]]   -- Type constructors
-- vim.cmd [[highlight link LspSemantic_function Identifier]] -- Functions names
-- vim.cmd [[highlight link LspSemantic_enumMember Number]]   -- Data constructors
-- vim.cmd [[highlight LspSemantic_variable guifg=gray]] -- Bound variables
-- vim.cmd [[highlight link LspSemantic_keyword Structure]]  -- Keywords
-- vim.cmd [[highlight link LspSemantic_namespace Identifier]] -- Explicit namespaces
-- vim.cmd [[highlight link LspSemantic_postulate Define]] -- Postulates
-- vim.cmd [[highlight link LspSemantic_module Identifier]] -- Module identifiers
EOF


:set expandtab tabstop=4 shiftwidth=4
:noh
:set number
autocmd BufWritePre * :%s/\s\+$//e

if (has("termguicolors"))
 set termguicolors
endif
syntax enable

let ayucolor="dark"   " for dark version of theme
colorscheme ayu
