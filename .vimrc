" >>> Include Vim-Plug
if empty(glob('~/.vim/autoload/plug.vim'))
    !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
     \  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif
" <<< Include Vim-Plug

" >>> Vim-Plug
let g:plug_window='topleft new'
call plug#begin('~/.vim/plugged')

" Themes
Plug 'morhetz/gruvbox'

"  Brackets
Plug 'jiangmiao/auto-pairs'

" Formatting
Plug 'ntpeters/vim-better-whitespace'

" Comments
Plug 'tpope/vim-commentary'

" Finding files
Plug 'ctrlpvim/ctrlp.vim'

" Pasting
Plug 'junegunn/vim-peekaboo'

" Visuals
Plug 'bling/vim-bufferline'
Plug 'vim-airline/vim-airline'

"  Syntax and checking
Plug 'scrooloose/syntastic'
Plug 'nachumk/systemverilog.vim'
"Plug 'xolox/vim-easytags'

" General Plugins
Plug 'farmergreg/vim-lastplace' " Open files at same last place
Plug 'tpope/vim-sensible'
Plug 'xolox/vim-misc'

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

" Buffers - next/previous: F10, F9.
nnoremap <F10> :bn<CR>
nnoremap <F9> :bp<CR>

" Autocompletion on files
set wildmode=longest,list
set wildmenu

" Indenting
set autoindent " Automatically indent
"set cindent " Indent based on C syntax
":#set cinwords+=foreach

" Strip whitespace on saving file
autocmd BufEnter * EnableStripWhitespaceOnSave
" Show whitespace
command! Whitespace :set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:< | :set list
command! Nowhitespace :set nolist

" Enable cursorline
set cursorline
augroup cline
  au!
  autocmd WinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END

" Airline customization
" let g:airline_section_y = 'BN: %{bufnr("%")}'
" let g:airline#extensions#branch#use_vcscommand = 1
let g:airline#extensions#tabline#enabled = 1

" Gruvbox customization
set background=dark    " Setting dark mode
let g:gruvbox_contrast_dark='hard'
colorscheme gruvbox

" CTags
set tags+=tags
" Use control + y to show a list of tag-matches"
nnoremap <C-y> g<C-]>

set tabstop=3 shiftwidth=3
set expandtab

noremap jk <ESC>
let mapleader = "\<Space>"

filetype plugin indent on
set encoding=utf-8

" Filetype specifics
autocmd FileType yaml setlocal shiftwidth=2 tabstop=2
autocmd FileType python setlocal shiftwidth=3 tabstop=3
