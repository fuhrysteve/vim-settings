set nocompatible            " Use Vim defaults
filetype off                " required for vundle, can be turned on later

set rtp+=~/.vim/bundle/vundle
call vundle#begin()

Plugin 'gmarik/vundle'

let g:syntastic_python_checkers=['flake8']
Plugin 'jmcantrell/vim-virtualenv'
Plugin 'scrooloose/nerdtree.git'
Plugin 'tpope/vim-fugitive.git'
Plugin 'scrooloose/syntastic.git'
if has('python')
    Plugin 'davidhalter/jedi-vim.git'
endif
Plugin 'ivalkeen/vim-simpledb'
Plugin 'saltstack/salt-vim'
Plugin 'nvie/vim-flake8'
Plugin 'flazz/vim-colorschemes'
Plugin 'gregsexton/MatchTag'
Plugin 'vim-scripts/ini-syntax-definition'
Plugin 'bling/vim-airline'
Plugin 'hdima/python-syntax'
Plugin 'groenewege/vim-less'

call vundle#end()

" Always show status bar
set laststatus=2
au BufReadPost *.conf set syntax=ini

" Open NERDTree by default if no fils are specified
autocmd vimenter * if !argc() | NERDTree | endif
let g:NERDTreeDirArrows=0
let NERDTreeIgnore = ['\.pyc$']

let g:solarized_termcolors=256
let g:solarized_termtrans=1
colorscheme solarized
set background=dark

if exists("g:colors_name") 
    if g:colors_name != 'solarized'
        " I despise bright yellow line numbers
        " disabled for solarized
        highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
    endif
endif


" Allow way more tabs
set tabpagemax=50

" disable arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>


syntax on
" prevent slow downs from syntax highlighting
set synmaxcol=2048

"set smartindent
set autoindent
set cindent
"set smarttab
set shiftwidth=4
set tabstop=4
set expandtab
set softtabstop=4
" indent/outdent to nearest tabstops
set shiftround
set hidden

set ic                  " ignore case in search
set incsearch           " incremental search
set hlsearch            " highlight search results
set smartcase           " ignore case when lowercase

" always have some lines of text when scrolling
set scrolloff=8

filetype on             " Enable filetype detection
filetype indent on      " Enable filetype-specific indenting
filetype plugin on      " Enable filetype-specific plugins

set bs=indent,eol,start " allow backspacing over everything in insert mode
"set ai                 " always set autoindenting on
"set backup             " keep a backup file
set viminfo='20,\"50    " read/write a .viminfo file, don't store more
                        " than 50 lines of registers
set history=50          " keep 50 lines of command line history
set ruler               " show the cursor position all the time
set number              " linenumbers

" Only do this part when compiled with support for autocommands
if has("autocmd")
  " In text files, always limit the width of text to 78 characters
  autocmd BufRead *.txt set tw=78
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
endif


" 
cmap w!! w !sudo tee > /dev/null %
