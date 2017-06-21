""""""""""""""""""""""""""""""""""""""""""""""""""""
" General config
"
""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
set encoding=utf-8

" Languages
let $LANG='en'
set langmenu=en

" shows partial commands in the last line of the screen
set showcmd 

" Show 2 status lines
set laststatus=2

" Set to auto read when a file is changed from the outside
set autoread

" display cursor position in the status line
set ruler				            

" display line numbers
set number			

" set how many lines of history VIM has to remember
set history=500

" Scrolloff 8 lines when moving with cursor
set so=8

" Enable wildmenu 
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""
" Visual look/feel
"
""""""""""""""""""""""""""""""""""""""""""""""""""""
" syntax highlighting
filetype plugin on
syntax on

" make colors compatible
set t_Co=256           
set background=dark
colorscheme gruvbox


"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Indentation
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""
" TODO- make specific .vim files for different file types
" INTERFERES WITH smartindent       

" for checking indents on files
" filetype plugin indent on         

set tabstop=4
set shiftwidth=4
set softtabstop=4

" use spaces instead of tabs
set expandtab			            

" tab key inserts tab stops, bksp deletes tabs
set smarttab			   

" match indents on new lines
set autoindent			            

" intelligently dedent/indent new lines
set smartindent		            	

" tab / shifting moves to closest tabstop
set shiftround                      

" Make backspace behave like it should
set backspace=eol,start,indent

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Annoying things
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Stop using swap files
set noswapfile          

" get rid of annoying error notifiations
set noerrorbells
set novisualbell

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Searching
" 
"""""""""""""""""""""""""""""""""""""""""""""""""""""
" case insensitive search
set ignorecase                      

" if there are uppercase letters, become case-sensitive
set smartcase                       

" Show bracket pairs
set showmatch           

" highlight search results
set hlsearch                        

" makes search act like search in the browser
set incsearch                       

" enhanced tab completion
" set wildchar=<Tab> wildmenu wildmode=full

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Buffers, Tabs, Windows 
" 
"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Switch buffers without forcing a save
set hidden


"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Netrw
" 
"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set with of Netrw window
let g:netrw_winsize = 25

" Close Netrw Banner
let g:netrw_banner = 0

" Tree view of files
let g:netrw_liststyle = 3

" Open files in previous window
let g:netrw_browse_split = 4

" Split left
let g:netrw_altv = 1

" Don't save history to .netrwhist file
let g:netrw_dirhistmax = 0

" Launch right after vim is entered
" augroup ProjectDrawer
"     autocmd!
"     autocmd VimEnter * :Vexplore
" augroup END


"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Commands/Mappings
" 
"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Make :make command be silent except for errors
noremap <leader>m :silent make\|redraw!\|cw<CR>

" Close buffer without closing window
command Bd bp | sp | bn | bd

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Other
" 
"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Typescript syntax highlighting
autocmd BufNewFile,BufRead *.ts set syntax=typescript

