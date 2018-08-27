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
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'w0rp/ale'
Plugin 'lervag/vimtex'
Plugin 'shime/vim-livedown'
Plugin 'fatih/vim-go', { 'do': ':GoInstallBinaries' }

" fzf
set rtp+=~/.fzf
Plugin 'junegunn/fzf.vim'

" Appearance
Plugin 'morhetz/gruvbox'

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
" set cursorline

" set how many lines of history VIM has to remember
set history=500

" Scrolloff 8 lines when moving with cursor
set so=8

" Enable wildmenu
set wildmenu
set wildmode=list:longest,list:full

" Faster switching between INSERT/NORMAL modes
set ttimeoutlen=10

" write to file on calling :make
set autowrite

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

" Use ripgrep for vimgreping
if executable('rg')
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m
endif

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

" highlight previously pasted text
nnoremap gp `[v`]

" Make :make command be silent except for errors
noremap <leader>m :silent make\|redraw!\|cw<CR>

" Close buffer without closing window
command! Bd bp | sp | bn | bd

" Insert literal tab
inoremap <S-Tab> <C-V><Tab>

" Automatically format json with =j
nmap =j :%!python -m json.tool<CR>

" Quickfix
map <C-n> :cnext<cr>
map <C-m> :cprevious<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""
" Airline
"
""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline_powerline_fonts=1
let g:airline_inactive_collapse=1
let g:airline_theme="gruvbox"
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'

""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree
"
""""""""""""""""""""""""""""""""""""""""""""""""""""
let NERDTreeMinimalUI = 1
" let NERDTreeWinSize = 25
let NERDTreeIgnore = ['\.pyc$', '\.o$', '\.pdf$']
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeDirArrows = 1

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
let wiki_1 = {
      \ "path": "~/vimwiki/",
      \ "auto_toc": 1,
      \ "auto_tags": 1,
      \ "syntax": 'markdown',
      \ "ext": '.md',
      \ "nested_syntaxes": {
              \'python': 'python',
              \'c++': 'cpp',
              \'c': 'c',
              \'sh': 'sh',
              \'yaml': 'yaml'},
      \ "list_margin": 2,
      \ }

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
let g:vimtex_compiler_method='latexmk'
let g:vimtex_compiler_latexmk = {
    \ 'background' : 1,
    \ 'build_dir' : '',
    \ 'callback' : 1,
    \ 'continuous' : 1,
    \ 'executable' : 'latexmk',
    \ 'options' : [
    \   '-pdf',
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=1',
    \   '-interaction=nonstopmode',
    \ ],
    \}
let g:vimtex_matchparen_enabled = 0
let g:vimtex_complete_enabled = 0
let g:vimtex_fold_enabled = 0

" vim-livedown - live markdown preview
let g:livedown_browser = "firefox"

" ignore files
set wildignore+=*.aux,*.fdb_latexmk,*.fls,*.gz

""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-go
"
""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:go_fmt_command = "goimports"
let g:go_def_mode = "godef"

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
"autocmd FileType go nmap <Leader>i <Plug>(go-info)

""""""""""""""""""""""""""""""""""""""""""""""""""""
" fzf
"
""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

let g:fzf_buffers_jump = 1

" command! -bang -nargs=? -complete=dir Files
"     \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" if no bang specified, use '?' to toggle preview window
command! -bang -nargs=* Find
    \ call fzf#vim#grep('rg --column --line-number --no-heading  --smart-case --hidden --follow --glob "!.git/*" --color=always '. shellescape(<q-args>).'| tr -d "\017"', 1,
    \   <bang>0 ? fzf#vim#with_preview('up:50%')
    \           : fzf#vim#with_preview('right:50%:hidden', '?'),
    \   <bang>0)

" magic. add a '!' after typing <C-p> for preview mode, similar to :grep!
map <C-p> :Find<Space>
nnoremap <silent> <leader>zf :Files<cr>
nnoremap <silent> <leader>zb :Buffers<cr>

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-l> <plug>(fzf-complete-buffer-line)

" Advanced customization using autoload functions
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})

""""""""""""""""""""""""""""""""""""""""""""""""""""
" ale
"
""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
