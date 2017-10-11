" >>> Include Vim-Plug
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif
call plug#begin('~/.config/nvim/plugged')
" <<< Include Vim-Plug

" >>> Vim-Plug
let g:plug_window='topleft new'
call plug#begin('~/.vim/plugged')

" General Plugins
Plug 'farmergreg/vim-lastplace' " Open files at same last place
Plug 'tpope/vim-sensible'
Plug 'xolox/vim-misc'

" Themes
Plug 'morhetz/gruvbox'

" Brackets
Plug 'jiangmiao/auto-pairs'

" Formatting
Plug 'ntpeters/vim-better-whitespace'

" Comments
Plug 'tpope/vim-commentary'

" Finding files
Plug 'ctrlpvim/ctrlp.vim'

" Pasting
Plug 'junegunn/vim-peekaboo'

" Syntax and checking
Plug 'scrooloose/syntastic'
Plug 'nachumk/systemverilog.vim'
Plug 'xolox/vim-easytags'

call plug#end()
" <<< Vim-Plug

" Backspace needs to work always
set backspace=indent,eol,start

" Navigation
nnoremap <tab> <c-w><c-w>

" Delete lines don't get in yank buffer
noremap dd "_dd
noremap D "_D
noremap d "_d
noremap X "_X
noremap x "_x"

" Visuals
"set number
set ruler
syntax on
set title
set scrolloff=4 " Stay 4 lines from top/bottom

set showmatch " Highlight matching brackets

set wrap " Wrap lines
set wrapmargin=2 " Stay 2 chars from side
set linebreak " Smarter wrapping
if v:version > 703
  set breakindent " Indent wrapped lines to same level
endif

" Searching
set magic  " Use magic regexes
set hlsearch " Highlight all matches
set incsearch " Show matches while typing
set ignorecase " Ignore case when searching
set smartcase " Be case sensitive if at least one uppercase char is used
vnoremap // y/<C-R>"<CR>

" Autocompletion on files
set wildmode=longest,list
set wildmenu

" Indenting
set autoindent " Automatically indent
"set cindent " Indent based on C syntax
":#set cinwords+=foreach

" Strip whitespace on saving file
autocmd BufEnter * EnableStripWhitespaceOnSave

" Enable cursorline
set cursorline
augroup cline
  au!
  autocmd WinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END

set background=dark    " Setting dark mode
colorscheme gruvbox

set tabstop=3 shiftwidth=3
au FileType python setl sw=3 sts=3 et
set expandtab

noremap jk <ESC>
let mapleader = "\<Space>"

filetype plugin indent on
set encoding=utf-8
