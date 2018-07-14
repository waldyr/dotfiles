""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set shell=/bin/bash
set encoding=utf8
try
	lang en_US
catch
endtry

" Enable filetype plugin
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

let mapleader=","

set tags=.git/tags,tags;

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FZF
nnoremap <c-p> :FZF<cr>

" Ag
nnoremap \ :Ag<cr>

" Fugitive
nnoremap <leader>gl :Glog<cr>
nnoremap <leader>gs :Gstatus<cr>]]

" Buffer search with FZF
nnoremap <leader>b :Buffers<cr>

" tab navigation
map <tab> :tabnext<cr>
map <s-tab> :tabprev<cr>

" Disable Entering Ex mode
map Q <Nop>

" Disable K looking man stuff up
map K <Nop>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Custom Functions & Commands
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Preserve history and cursor position while executing the given command
function! Preserve(command)
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  execute a:command
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
map <leader>n :call RenameFile()<cr>

function! StripTrailingWhitespaces()
  call Preserve("%s/\\s\\+$//e")
endfunction

" Multipurpose tab key
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <expr> <tab> InsertTabWrapper()
inoremap <s-tab> <c-n>

autocmd BufWritePre * :call mkdir(expand('%:p:h'), 'p')
autocmd BufWritePre * :call StripTrailingWhitespaces()

autocmd BufReadPost *.vue set syntax=html

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
silent! if plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-commentary'

Plug 'waldyr/vim-localorie'

Plug 'sonph/onehalf', { 'rtp': 'vim/' }

call plug#end()
endif

nnoremap <silent> <leader>lt :call localorie#translate()<cr>
nnoremap <silent> <leader>le :call localorie#expand_key()<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on
set t_Co=256
set cursorline
colorscheme onehalflight

set so=10 " Set 7 lines to the cursor - when moving vertical..

set wildmenu " Turn on WiLd menu

set ruler " Always show current position

set cmdheight=2 " The commandbar height

set hidden " Change buffer - without saving

set nocompatible

set backspace=eol,start,indent " Set backspace config

set whichwrap+=<,>,h,l " Traverse endline to next line

set hlsearch " Search highlight

set incsearch " Make search act like search in modern browsers

set nolazyredraw " Don't redraw while executing macros

set showmatch " Show matching bracets when text indicator is over them

set number " Show me the numbers

set ignorecase

set smartcase

" No sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Turn backup off
set nobackup
set nowb
set noswapfile

" Fold related
set foldmethod=manual
set nofoldenable
set nojoinspaces

" Tab related
set expandtab
set shiftwidth=2
set tabstop=2
set smarttab

set lbr
set tw=500

set autoindent
set smartindent
set wrap
