" enable pathogen
execute pathogen#infect()

" enable nerdTree with CTRL-n
map <C-n> :NERDTreeToggle<CR>

" The usual
:set expandtab
:set tabstop=4
:set shiftwidth=4
:set number
:set scrolloff=10
:set autoindent
:set smartindent
:set mouse=a
:set laststatus=2
:set statusline=%f 
:set clipboard=unnamed
:set showcmd
:set backspace=eol,start,indent

syntax on
filetype on
filetype plugin indent on

" syntastic recommended options
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=0

" tuck away vim turds
set backupdir=~/.vimFiles/backup//
set directory=~/.vimFiles/swapfiles//

" shortcut to enable debug in python
:imap <C-b> import ipdb<CR>ipdb.set_trace()
