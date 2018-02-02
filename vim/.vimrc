set nocompatible

""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle
"
""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype off                  

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'leafgarland/typescript-vim'
Plugin 'pangloss/vim-javascript'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vimwiki/vimwiki'
Plugin 'morhetz/gruvbox'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'nightsense/carbonized'
Plugin 'w0rp/ale'
Plugin 'lervag/vimtex'

call vundle#end()            " required
filetype plugin indent on    " required

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

" Plugin for statusline already shows insert, so don't show it status
set noshowmode

" Set to auto read when a file is changed from the outside
set autoread

" display cursor position in the status line
set ruler				            

" display line numbers
set number			

" make line numbers relative to current line
set relativenumber

" no wrapping
set nowrap

" highlight the line that the cursor is on
set cursorline

" set how many lines of history VIM has to remember
set history=500

" Scrolloff 8 lines when moving with cursor
set so=8

" Enable wildmenu 
set wildmenu

" Faster switching between INSERT/NORMAL modes
set ttimeoutlen=10

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
" set t_Co=256           
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
" set smartindent		            	

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
" Completion
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Omni-completion
set omnifunc=syntaxcomplete#Complete

" Popup menu inserts the longest common text of all matches, menu comes up if
" only one match
set completeopt=longest,menuone

" key maps to make popup menu more intuitive
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <C-D> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <C-U>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"

" Always keep a menu item highlighted so that you can continue typing to
" narrow down matches, and pressing enter will select it
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
            \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
inoremap <expr> <C-p> pumvisible() ? '<C-p>' :
            \ '<C-p><C-r>=pumvisible() ? "\<lt>Up>" : ""<CR>'

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Commands/Mappings
" 
"""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = " "
let maplocalleader = " "

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

nnoremap j gj
nnoremap k gk

nmap <silent> // :nohlsearch<CR>

" Make :make command be silent except for errors
noremap <leader>m :silent make\|redraw!\|cw<CR>

" Close buffer without closing window
command! Bd bp | sp | bn | bd

" Insert literal tab
inoremap <S-Tab> <C-V><Tab>

" Automatically format json with =j
nmap =j :%!python -m json.tool<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""
" Airline
"
""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline_powerline_fonts=1
let g:airline_inactive_collapse=1
let g:airline_theme="gruvbox"

""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree
"
""""""""""""""""""""""""""""""""""""""""""""""""""""
let NERDTreeMinimalUI = 1
" let NERDTreeWinSize = 25
let NERDTreeIgnore = ['\.pyc$', '\.o$', '\.pdf$']
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeDirArrows = 1

" Open NERDTree on opening vim
" autocmd vimenter * NERDTree

" Open NERDTree when opening vim on one or more files and switch to window 
" autocmd VimEnter * if argc() >= 1 | NERDTree | wincmd p | endif

" Open NERDTree when entering vim on a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

" Close vim if the only window left is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Open NERDTree
map <C-n> :NERDTreeToggle<CR>
map <Leader>nf : NERDTreeFind<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vimwiki
"
""""""""""""""""""""""""""""""""""""""""""""""""""""
let wiki_1 = {}
let wiki_1.path = "~/Dropbox/code/wiki/"
" Auto update table of contents on saving wiki page
let wiki_1.auto_toc = 1
" Use markdown
let wiki_1.syntax = 'markdown'
let wiki_1.ext = '.md'
let wiki_1.nested_syntaxes = {
            \'python': 'python', 
            \'c++': 'cpp',
            \'c': 'c',
            \'sh': 'sh' }
" Auto highlight on opening
let wiki_1.automatic_nested_syntaxes = 1
let wiki_1.list_margin = 2

" Vimwiki Global options
let g:vimwiki_list = [wiki_1]
let g:vimwiki_global_ext = 0
" Highlight checked list items and their children with a special color
let g:vimwiki_hl_cb_checked = 2

let g:markdown_fenced_languages = ['sh', 'bash=sh', 'css', 'c', 'cpp', 'javascript', 'js=javascript', 'json=javascript', 'make', 'python', 'html', 'vim']

" Vimwiki mappings
nmap <Leader>vo <Plug>VimwikiVSplitLink
nmap <Leader>ho <Plug>VimwikiSplitLink

""""""""""""""""""""""""""""""""""""""""""""""""""""
" cpp-enhanced-highlight
"
""""""""""""""""""""""""""""""""""""""""""""""""""""
" Highlight of class scope
let g:cpp_class_scope_highlight = 1

" Highlight member variables
let g:cpp_member_variable_highlight = 1

" Highlight class names in declarations
let g:cpp_class_decl_highlight = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""
" vimtex
"
""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vimtex_latexmk_options = '-pdf -shell-escape -verbose -file-line-error'
let g:vimtex_matchparen_enabled = 0
let g:vimtex_complete_enabled = 0
let g:vimtex_fold_enabled = 0

