set nocompatible            " Use Vim defaults
"
" Fixes the `q` bug https://github.com/neovim/neovim/issues/6403
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=0
set guicursor=

call plug#begin('~/.local/share/nvim/plugged')

let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/bin/python3.7'

" Sensible VIM Defaults
Plug 'tpope/vim-sensible'
" Git wrapper
Plug 'tpope/vim-fugitive'
" quoting / parenthesis matching
Plug 'tpope/vim-surround'
" Unix shell wrappers (i.e. :Rename :MkDir :Delete etc)
Plug 'tpope/vim-eunuch'
" improved indentation & syntax
Plug 'pangloss/vim-javascript'
" Plug 'vimlab/neojs'

if has('python')
    " Python smart autocompletion
    Plug 'zchee/deoplete-jedi', { 'do': ':UpdateRemotePlugins' }
endif
" better solarized theme
Plug 'romainl/flattened'
" HTML tag matching
Plug 'gregsexton/MatchTag'
" pretty tab bar
Plug 'bling/vim-airline'

" Git/mercurial/others diff icons on the side of the file lines
Plug 'mhinz/vim-signify'

" More up-to-date fork of 'hdima/python-syntax'
Plug 'achimnol/python-syntax'
" syntax highlighting for less
Plug 'groenewege/vim-less'
" auto-format sql files
Plug 'b4b4r07/vim-sqlfmt'
" highlighting for ansible yaml files
Plug 'chase/vim-ansible-yaml'
" async autocomplete for neovim
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" runs linters such as flake8, mypy, jslint, etc
Plug 'w0rp/ale'
" quick snippet shortcuts
Plug 'SirVer/ultisnips'
" Quick file opener
Plug 'ctrlpvim/ctrlp.vim'

call plug#end()

set runtimepath+=~/projects/stream

" vim-sqlfmt
let g:sqlfmt_command = "sqlformat"
let g:sqlfmt_options = "-r -k upper"

" UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" let g:jedi#auto_close_doc = 0  " close preview window after completion
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

let g:ale_linters = {
\   'jsx': ['eslint'],
\   'javascript': ['eslint'],
\   'python': ['flake8'],
\}
" \   'python': ['flake8', 'mypy'],
let b:ale_fixers = {'python': ['black']}
let g:airline#extensions#ale#enabled = 1
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_python_mypy_options = '--ignore-missing-imports'
" Don't run ale when text changes - mypy uses way too much CPU
let g:ale_lint_on_text_changed = 'never'

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
  set grepformat=%f:%l:%c:%m,%f:%l:%m

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" Use deoplete.
let g:deoplete#enable_at_startup = 1
" set completeopt-=preview

" Always show status bar
set laststatus=2
au BufReadPost *.conf set syntax=ini

" set syntax of Jenkinsfile to groovy
au BufNewFile,BufRead Jenkinsfile setf groovy

set termguicolors
set background=dark
colorscheme flattened_dark

" In case I ever go back to solarized, this helps make it sane
" let g:solarized_termcolors=256
" let g:solarized_termtrans=1
" colorscheme solarized
"
" if exists("g:colors_name")
"     if g:colors_name != 'solarized'
"         " I despise bright yellow line numbers
"         " disabled for solarized
"         highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
"     endif
" endif

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


" prevent slow downs from syntax highlighting
set synmaxcol=2048
set mouse=

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

set bs=indent,eol,start " allow backspacing over everything in insert mode
"set ai                 " always set autoindenting on
"set backup             " keep a backup file
set backupdir=~/.local/share/nvim/swap

" not necessary w/ neovim - neovim uses shada
" set viminfo='20,\"50    " read/write a .viminfo file, don't store more
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

" w!!
cmap w!! w !sudo tee > /dev/null %
