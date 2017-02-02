set nocompatible

set showcmd 			            " shows partial commands in the last line of the screen
set encoding=utf-8

" Visual / Look and Feel
syntax on				            " syntax highlighting
set ruler				            " display cursor position in the status line
set number				            " display line numbers
set background=dark
set t_Co=256                        " Compatibility for colors?
colorscheme elflord

" Tabs
" INTERFERES WITH smartindent       " TODO- make specific .vim files for different file types
" filetype plugin indent on         " for checking indents on files

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab			            " use spaces instead of tabs
set smarttab			            " tab key inserts tab stops, bksp deletes tabs
set autoindent			            " match indents on new lines
set smartindent		            	" intelligently dedent/indent new lines
set shiftround                      " tab / shifting moves to closest tabstop
set backspace=eol,start,indent

" Annoying things
" set noswapfile          
set autoread                        " when a file has changed on disk, just load it
set noerrorbells
set novisualbell


" Searching
set ignorecase                      " case insensitive search
set smartcase                       " if there are uppercase letters, become case-sensitive
set showmatch                       " live match highlighting
set hlsearch                        " highlight search results
set incsearch                       " makes search act like search in the browser
