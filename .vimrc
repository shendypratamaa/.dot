syntax on
filetype on
set guicursor=""
set clipboard=unnamed
set scrolloff=8
set tabstop=4 softtabstop=4
set shiftwidth=4
set timeoutlen=200
set updatetime=200
set number
set relativenumber
set expandtab
set smartindent
set termguicolors
set noswapfile
set incsearch

colorscheme peachpuff

let mapleader = " "
nnoremap <leader><CR> :so ~/.vimrc<CR>
nnoremap <C-n> :Lex 30<CR>
nnoremap <CR> :noh<CR>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
inoremap jk <esc>

" yank
vnoremap <leader>p "_dP
vnoremap <leader>y "+y
nnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" quickfix
nnoremap ]q :cnext<CR>
nnoremap [q :cprev<CR>

" buffers
nnoremap ]qq :bw<CR>
nnoremap <S-l> :bn<CR>
nnoremap <S-h> :bp<CR>
