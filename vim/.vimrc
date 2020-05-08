""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle
"
""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'scrooloose/nerdtree'
" Plug 'scrooloose/nerdcommenter'
Plug 'itchyny/lightline.vim'
Plug 'vimwiki/vimwiki'
Plug 'dense-analysis/ale'
Plug 'lervag/vimtex'
Plug 'shime/vim-livedown'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'junegunn/goyo.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-obsession'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'airblade/vim-gitgutter'

" fzf
set rtp+=~/.fzf
Plug 'junegunn/fzf.vim'

" Appearance
Plug 'morhetz/gruvbox'
let g:gruvbox_sign_column = 'bg0'

call plug#end()

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

" set how many lines of history VIM has to remember
set history=500

" Scrolloff 8 lines when moving with cursor
set so=8

" Enable wildmenu
set wildmenu
set wildmode=list:longest,list:full

" Faster switching between INSERT/NORMAL modes
set ttimeoutlen=10

" Faster gitgutter updates
set updatetime=100

" write to file on calling :make
set autowrite

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" don't redraw the screen while executing macros
set lazyredraw

" persist undos across vim sessions
set undofile

""""""""""""""""""""""""""""""""""""""""""""""""""""
" Visual look/feel
"
""""""""""""""""""""""""""""""""""""""""""""""""""""
" syntax highlighting
" filetype plugin on
syntax on

" make colors compatible
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
set background=dark
function! MyHighlights() abort
    highlight clear SignColumn
    highlight Comment cterm=italic gui=italic
endfunction

augroup MyColors
    autocmd!
    autocmd ColorScheme * call MyHighlights()
augroup END

" these escape codes are for terminal vim to display italics correctly
set t_ZH=[3m
set t_ZR=[23m
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

" Don't move when searching current word
nnoremap * *<c-o>

" Force saving files that require root permission
cnoremap w!! w !sudo tee > /dev/null %

" Quit with error out of vimdiff so that git mergetool doesn't mark files as
" done merging
if &diff
    map Q :cquit<CR>
endif
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
map <Leader>nf :NERDTreeFind<CR>

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
      \ "list_margin": 0,
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
nmap <Leader>mcr <Plug>VimwikiTableMoveColumnRight
nmap <Leader>mcl <Plug>VimwikiTableMoveColumnLeft

" Change cwd to current file
nmap <Leader>cd :cd %:p:h<CR>:pwd<CR>

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
let g:vimtex_matchparen_enabled = 0
let g:vimtex_complete_enabled = 0
let g:polyglot_disabled = ['latex']

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
let g:go_gopls_enabled = 0
let g:go_code_completion_enabled = 0
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1

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
autocmd FileType go nmap <leader>t  <Plug>(go-test)
"autocmd FileType go nmap <Leader>i <Plug>(go-info)

" disable vim-go :GoDef short cut (gd)
" this is handled by LanguageClient [LC]
let g:go_def_mapping_enabled = 0

" disable vim-go :GoDoc as doc lookup is handled by coc.nvim
let g:go_doc_keywordprg_enabled = 0

let g:go_fmt_options = {
\ 'gofmt': '-s',
\ }
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
nnoremap <silent> <leader>zt :Windows<cr>

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-l> <plug>(fzf-complete-buffer-line)

" Advanced customization using autoload functions
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})

" CTRL-A CTRL-Q to select all and build quickfix list

function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

""""""""""""""""""""""""""""""""""""""""""""""""""""
" ale
"
""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ale_linters = {
    \ 'python': ['flake8'],
    \ 'go': ['gofmt', 'golint', 'govet', 'gobuild', 'golangci-lint']
    \ }
let g:ale_go_gometalinter_options = "--fast"
let g:ale_go_gometalinter_lint_package = 1
let g:ale_go_golangci_lint_options = ""
let g:ale_go_golangci_lint_package = 1

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
let g:ale_echo_msg_format = '%linter% says %s'

""""""""""""""""""""""""""""""""""""""""""""""""""""
" goyo - distraction free writing
"
""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:goyo_width=200
let g:goyo_height='95%'
function! s:goyo_enter()
  silent !tmux set status off
  silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  set noshowmode
  set noshowcmd
  set nolist linebreak wrap
  :GitGutterEnable
endfunction

function! s:goyo_leave()
  silent !tmux set status on
  silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  set showmode
  set showcmd
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

""""""""""""""""""""""""""""""""""""""""""""""""""""
" coc.nvim
"
""""""""""""""""""""""""""""""""""""""""""""""""""""
" Most settings here stolen from coc.nvim's Github README
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
" nmap <silent> [c <Plug>(coc-diagnostic-prev)
" nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add diagnostic info for https://github.com/itchyny/lightline.vim
let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'cocstatus', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status',
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" Make pasting in insert mode work better
" Stolen from https://coderwall.com/p/if9mda/automatically-set-paste-mode-in-vim-when-pasting-in-insert-mode
function! WrapForTmux(s)
  if !exists('$TMUX')
    return a:s
  endif

  let tmux_start = "\<Esc>Ptmux;"
  let tmux_end = "\<Esc>\\"

  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-gitgutter
"
""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:gitgutter_preview_win_floating = 0
let g:gitgutter_sign_allow_clobber = 0

nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)
nmap ghs <Plug>(GitGutterStageHunk)
nmap ghu <Plug>(GitGutterUndoHunk)
nmap ghp <Plug>(GitGutterPreviewHunk)

nnoremap <leader>gd :execute ':Gdiff ' . system('git rev-parse $REVIEW_BASE')<cr>
