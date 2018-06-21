autocmd! BufWritePost ~/.config/nvim/init.vim nested :source ~/.config/nvim/init.vim

" get cool plugins
call plug#begin('~/.vim/plugged')
" Essential
Plug 'jeffkreeftmeijer/neovim-sensible'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'machakann/vim-swap'
Plug 'junegunn/vim-easy-align'
" Slightly less essential
Plug 'tpope/vim-fugitive'
Plug 'mbbill/undotree'
Plug 'tpope/vim-speeddating'
Plug 'jceb/vim-orgmode'
" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Filesystem
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Plug 'kien/ctrlp.vim'
Plug 'scrooloose/nerdtree'
" Programming
Plug 'ajh17/VimCompletesMe'
Plug 'hkupty/iron.nvim'
" Plug 'BurningEther/iron.nvim'
Plug 'wilywampa/vim-ipython'
Plug 'kovisoft/slimv'
" Themes
Plug 'joshdick/onedark.vim'
Plug 'morhetz/gruvbox'
Plug 'nanotech/jellybeans.vim'
Plug 'sjl/badwolf'
" to try out
"Plug 'maxboisvert/vim-simple-complete'
call plug#end()

"*****************************THEME AND COLOURS*******************************"
colorscheme badwolf
let g:airline_theme='badwolf'   "kolor is also good 
let g:lisp_rainbow=1


" configuring highlighting colours
set hlsearch incsearch
set inccommand=nosplit
" hi MatchParen cterm=bold ctermbg=red ctermfg=Darkblue
" hi Search cterm=NONE ctermbg=red ctermfg=blue
let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1

"****************************GENERAL CONFIGURATION****************************"
set expandtab          " enter spaces when tab is pressed
set tabstop=4          " use 4 spaces to represent tab
set softtabstop=4
set shiftwidth=4       " number of spaces to use for auto indent
set autoindent         " copy indent from current line when starting a new line

set encoding=utf-8
set scrolloff=3
set cursorline
set showmode
set showcmd
set showmatch
set hidden
set wildmenu
set wildmode=list:longest
set ruler
set backspace=indent,eol,start
set laststatus=2
set undofile

" configure expanding of tabs for various file types
au BufRead,BufNewFile *.py      set expandtab
au BufRead,BufNewFile *.c       set noexpandtab
au BufRead,BufNewFile *.h       set noexpandtab
au BufRead,BufNewFile Makefile* set noexpandtab

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

" fix slow ctrl-P plugin
" let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
" if executable('ag')
"   let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
" endif

"*******************************CUSTOM KEYBINDS*******************************"
:let mapleader = ','

nnoremap <C-P> :FZF<CR>

" Use <Leader>l to clear the search highlighting
nnoremap <silent> <Leader>l :noh<CR>

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
inoremap <C-E> <C-X><C-E>  " up
inoremap <C-Y> <C-X><C-Y>  " down

" move selection of text using ALT+[jk]
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z
" Move a line of text using ALT+[jk]
" Normal mode
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
" Insert mode
inoremap <A-j> <C-o>:m .+1<CR>
inoremap <A-k> <C-o>:m .-2<CR>

" easy align mapping
vmap <Enter> <Plug>(EasyAlign)
nmap <leader>a <Plug>(EasyAlign)

" Use backspace to switch buffers
" nnoremap <BS> <C-^>

"******************************CUSTOM COMMANDS********************************"
" Save as super user even if vim was opened as regular user
command! W w !sudo tee "%" > /dev/null


"************************MESSY AIRLINE SYMBOL CONFIG**************************"
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:miniBufExplForceSyntaxEnable = 1
let g:airline_powerline_fonts = 1
let g:Powerline_symbols='unicode'
let g:airline#extensions#tabline#enabled = 1
let g:airline_detect_modified=1
let g:airline_inactive_collapse=1
let g:airline_symbols.branch     = ''
let g:airline_symbols.paste      = 'ρ'
let g:airline_symbols.readonly   = ''
let g:airline_symbols.linenr     = '¶'
let g:airline_symbols.maxlinenr  = ''
let g:airline_symbols.whitespace = 'Ξ'
