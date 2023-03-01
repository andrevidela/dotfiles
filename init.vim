let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

autocmd BufWritePre * :%s/\s\+$//e

" Plug 'https://github.com/edwinb/idris2-vim.git'
" LSP things
Plug 'https://github.com/scalameta/nvim-metals.git'
Plug 'neovim/nvim-lspconfig'
Plug 'ShinKage/idris2-nvim'
Plug 'MunifTanjim/nui.nvim'
Plug 'nvim-lua/plenary.nvim'
" Plug 'kabouzeid/nvim-lspinstall'
" Plug 'autozimu/LanguageClient-neovim', {
"     \ 'branch': 'next',
"     \ 'do': 'bash install.sh'
"     \ }

" Theming
Plug 'folke/lsp-colors.nvim'
Plug 'haishanh/night-owl.vim'
Plug 'ayu-theme/ayu-vim'

" Unicode shortcuts
Plug 'arthurxavierx/vim-unicoder'

" telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" box drawing
Plug 'jbyuki/venn.nvim'
nnoremap <leader>ff <cmd>Telescope find_files<cr>


call plug#end()
lua << EOF
vim.lsp.set_log_level("debug")

local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

require('idris2').setup({
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

if (has("termguicolors"))
 set termguicolors
endif
syntax enable

let ayucolor="dark"   " for dark version of theme
colorscheme ayu


