:set number
:set relativenumber
:set autoindent
:set tabstop=4
:set shiftwidth=4
:set smarttab
:set softtabstop=4
:set mouse=a



let mapleader = " "

" Remape space+| to open netrw 
noremap <Leader>e :Ex<CR>


call plug#begin()
Plug 'https://github.com/vim-airline/vim-airline'	
Plug 'https://github.com/preservim/nerdtree' "Nerdtree

call plug#end()

nnoremap <Leader>f :NERDTreeToggle<CR>
"nnoremap <Leader>f :NERDTreeFocus<CR>
nnoremap <Leader>n :NERDTree<CR>

let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"


