set nocompatible
set encoding=utf-8

" shows partial commands in the last line of the screen
set showcmd 

" Show 2 status lines
set laststatus=2



""""""""""""""""""""""""""""""""""""""""""""""""""""
" Visual look/feel
"
""""""""""""""""""""""""""""""""""""""""""""""""""""
" syntax highlighting
syntax on

" display cursor position in the status line
set ruler				            

" display line numbers
set number			

" make colors compatible
set t_Co=256           
set background=dark
colorscheme elflord



"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tabs
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
" set noswapfile          

" when a file has changed on disk, just load it
set autoread                        

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

" live match highlighting
set showmatch           

" highlight search results
set hlsearch                        

" makes search act like search in the browser
set incsearch                       
