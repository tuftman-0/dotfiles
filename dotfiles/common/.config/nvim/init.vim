autocmd! BufWritePost ~/.config/nvim/init.vim nested :source ~/.config/nvim/init.vim

" get cool plugins
call plug#begin('~/.vim/plugged')
" Essential
Plug 'jeffkreeftmeijer/neovim-sensible'
Plug 'junegunn/vim-easy-align'
Plug 'machakann/vim-swap'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-speeddating', { 'for': 'org' }
Plug 'tpope/vim-fugitive'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle'}
" Slightly less essential
" Plug 'jceb/vim-orgmode', { 'for': 'org' }
" Lightline
Plug 'itchyny/lightline.vim'
Plug '844196/lightline-badwolf.vim'
Plug 'mgee/lightline-bufferline'
" Airline
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
" Filesystem
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Programming
Plug 'ajh17/VimCompletesMe'
Plug 'roxma/nvim-completion-manager'
Plug 'hkupty/iron.nvim',
Plug 'wilywampa/vim-ipython', 
Plug 'kovisoft/slimv'
" Themes
Plug 'nanotech/jellybeans.vim'
Plug 'sheerun/vim-wombat-scheme'
Plug 'sjl/badwolf'
" to try out
Plug 'majutsushi/tagbar'
Plug 'fncll/wordnet.vim'
Plug 'sagarrakshe/toggle-bool'
Plug 'https://github.com/jpalardy/vim-slime'
call plug#end()

"*****************************THEME AND COLOURS*******************************"

let g:lightline = {
  \ 'colorscheme': 'badwolf',
  \ 'active': {
  \   'left':[ [ 'mode', 'paste' ],
  \            [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
  \ },
  \ 'component': {
  \   'lineinfo': ' %3l:%-2v',
  \ },
  \ 'component_function': {
  \   'readonly': 'LightlineReadonly',
  \   'fugitive': 'LightlineFugitive'
  \ },
  \ 'separator': { 'left': '', 'right': '' },
  \ 'subseparator': { 'left': '', 'right': '' }
  \ }

function! LightlineReadonly()
        return &readonly ? '' : ''
endfunction

function! LightlineFugitive()
        if exists('*fugitive#head')
                let branch = fugitive#head()
                return branch !=# '' ? ''.branch : ''
        endif
        return ''
endfunction

let g:lightline.tabline = {
  \   'left': [ ['buffers'] ],
  \   'right': [ ['tabs'] ]
  \ }

let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type   = {'buffers': 'tabsel'}
set showtabline=2  " Show tabline
set guioptions-=e  " Don't use GUI tabline


colorscheme badwolf
" let g:airline_theme='badwolf'   "kolor is also good 
" let g:airline_highlighting_cache = 1
" let g:airline#extensions#whitespace#enabled=0
" let g:airline_extensions = []
let g:lisp_rainbow=1
set ttimeoutlen=5



" configuring highlighting colours
set hlsearch incsearch
set inccommand=nosplit

"****************************GENERAL CONFIGURATION****************************"
let g:python3_host_prog = '/home/josh/anaconda3/bin/python3'
let g:python_host_prog = '/usr/bin/python2'
let g:slime_target = "neovim"

" set expandtab          " enter spaces when tab is pressed
" set tabstop=4          " use 4 spaces to represent tab
" set softtabstop=4
" set shiftwidth=4       " number of spaces to use for auto indent
" set autoindent         " copy indent from current line when starting a new line

" set encoding=utf-8
set scrolloff=3
set cursorline
set showmode
set showcmd
set noshowmatch
" set matchtime=1


set hidden
set wildmenu
set wildmode=list:longest
set ruler
set backspace=indent,eol,start
set laststatus=2
set undofile

" configure expanding of tabs for various file types
" au BufRead,BufNewFile *.c       set noexpandtab
" au BufRead,BufNewFile *.py      set expandtab
" au BufRead,BufNewFile *.h       set noexpandtab
" au BufRead,BufNewFile Makefile* set noexpandtab

filetype plugin indent on

" ipython jupyter-qtconsole connection thing
let g:ipy_monitor_subchannel = 0

" cool line numbering config
:set number relativenumber
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END:


"*******************************CUSTOM KEYBINDS*******************************"
:let mapleader = ','

" Toggle various booleans
nnoremap <leader>r :ToggleBool<CR>

nnoremap <leader>pl oPlug 'pa'

" fuzzy finder
nnoremap <leader>ff :FZF<CR>

" Use <leader>l to clear the search highlighting
nnoremap <silent> <leader>l :noh<CR>

" easy align mapping
vmap <Enter> <Plug>(EasyAlign)
nmap <leader>a <Plug>(EasyAlign)

" Toggle undotree
nnoremap <leader>ut :UndotreeToggle<CR>
nnoremap <leader>tb :TagbarToggle<CR>

" makes it easier to get out of terminal mode
if exists(':tnoremap')
  tnoremap <Esc> <C-\><C-n>
endif

" iron.nvim
" deactivate default mappings
let g:iron_map_defaults=0
" define custom mappings for the python filetype
augroup ironmapping
    autocmd!
    autocmd Filetype python nmap <buffer> <localleader>t <Plug>(iron-send-motion)
    autocmd Filetype python vmap <buffer> <localleader>t <Plug>(iron-send-motion)
    autocmd Filetype python nmap <buffer> <localleader>p <Plug>(iron-repeat-cmd)
augroup END

" alt function for coding in V
function! Alt()
  let c = nr2char(getchar() + 128)
  exec 'normal gi'.c
endfunction
inoremap <M-a> <C-o>:call Alt()<CR>

" scroll window one line in insert mode more easily

nmap <M-h> 5gh
nmap <M-j> 5gj
nmap <M-k> 5gk
nmap <M-l> 5l

vmap <M-h> 5gh
vmap <M-j> 5gj
vmap <M-k> 5gk
vmap <M-l> 5l

" Unused alt moving lines
" move selection of text using ALT+[jk]
" vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
" vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z
" Move a line of text using ALT+[jk]
" Normal mode
" nmap <M-j> mz:m+<cr>`z
" nmap <M-k> mz:m-2<cr>`z
" Insert mode
" imap <M-j> <C-o>:m .+1<CR>
" imap <M-k> <C-o>:m .-2<CR>

" Use backspace to switch buffers
" nnoremap <BS> <C-^>

"******************************CUSTOM COMMANDS********************************"
" Save as super user even if vim was opened as regular user
command! W w !sudo tee "%" > /dev/null


"************************MESSY AIRLINE SYMBOL CONFIG**************************"
" if !exists('g:airline_symbols')
"     let g:airline_symbols = {}
" endif
" let g:miniBufExplForceSyntaxEnable = 1
" let g:airline_powerline_fonts = 1
" let g:Powerline_symbols='unicode'
" let g:airline#extensions#tabline#enabled = 1
" let g:airline_detect_modified=1
" let g:airline_inactive_collapse=1
" let g:airline_symbols.branch     = ''
" let g:airline_symbols.paste      = 'ρ'
" let g:airline_symbols.readonly   = ''
" let g:airline_symbols.linenr     = '¶'
" let g:airline_symbols.maxlinenr  = ''
" let g:airline_symbols.whitespace = 'Ξ'
