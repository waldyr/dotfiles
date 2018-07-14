""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader=","

let $FZF_DEFAULT_COMMAND = 'ag -l -g ""'
nnoremap <c-p> :Files<cr>
nnoremap \ :Ag<cr>
nnoremap <leader>gs :Git<cr>)
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

function! TestIt(...)
  let p = expand('%:h')
  let f = expand('%')
  let l = line(".")
  let c = '!clear && rails t'

  write

  if a:0 == 0
    exec c
  elseif a:1 == 'f'
    exec c . ' ' . f
  elseif a:1 == 'l'
    exec c . ' ' . f . ':' . l
  endif
endfunction
map <leader>t :call TestIt('l')<cr>
map <leader>f :call TestIt('f')<cr>

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

function! StripTrailingWhitespaces()
  call Preserve("%s/\\s\\+$//e")
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

" if this window is last on screen quit without warning
function! MyLastWindow()
  if &buftype=="quickfix"
    if winbufnr(2) == -1
      quit!
    endif
  endif
endfunction

autocmd BufWritePre * :call mkdir(expand('%:p:h'), 'p')
autocmd BufWritePre * :call StripTrailingWhitespaces()
autocmd BufEnter * call MyLastWindow()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
silent! if plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'

Plug 'sonph/onehalf', { 'rtp': 'vim/' }

call plug#end()
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

syntax on
set cursorline
colorscheme onehalflight
set so=10 " Set 7 lines to the cursor - when moving vertical..
set cmdheight=2 " The commandbar height
set nocompatible
set whichwrap+=<,>,h,l " Traverse endline to next line
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

set lbr
set tw=500

set autoindent
set smartindent
set wrap
