set nocompatible

""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle
"
""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype off                  

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'

" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'

" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
"
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Better typescript
Plugin 'leafgarland/typescript-vim'

" Lightline status line
Plugin 'itchyny/lightline.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal

""""""""""""""""""""""""""""""""""""""""""""""""""""
" General config
"
""""""""""""""""""""""""""""""""""""""""""""""""""""
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

" highlight the line that the cursor is on
set cursorline

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
" filetype plugin on
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

" Open new split panes to the right and bottom
set splitbelow
set splitright


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
" autocmd BufNewFile,BufRead *.ts set syntax=typescript

