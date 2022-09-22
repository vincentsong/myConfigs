"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=500

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread
au FocusGained,BufEnter * checktime

"With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","

" Relative line number
:set number relativenumber
:set nu rnu

" Add a bit extra margin to the left
set foldcolumn=1

set incsearch " Enable incremental search
set hlsearch  " Enable highlight search

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax on

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

set omnifunc=syntaxcomplete#Complete

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

""""""""""""""""""""""""""""""
" Tabs
"""""""""""""""""""""""""""""
" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" remap esc
inoremap jk <esc>
" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Vim Plugins
call plug#begin()
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/syntastic'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'alvan/vim-closetag'
Plug 'AndrewRadev/tagalong.vim'
Plug 'ap/vim-css-color'
Plug 'prettier/vim-prettier'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'peitalin/vim-jsx-typescript'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

"""""""""""""""""""
" CoC
"""""""""""""""""""
let g:coc_global_extensions = [ 'coc-tsserver' ]

if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif

if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif

function! ShowDocIfNoDiagnostic(timer_id)
  if (coc#float#has_float() == 0 && CocHasProvider('hover') == 1)
    silent call CocActionAsync('doHover')
  endif
endfunction

function! s:show_hover_doc()
  call timer_start(300, 'ShowDocIfNoDiagnostic')
endfunction

autocmd CursorHoldI * :call <SID>show_hover_doc()
autocmd CursorHold * :call <SID>show_hover_doc()

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>ca <Plug>(coc-codeaction)
nmap <leader>rn <Plug>(coc-rename)

""""""""""""""""""""
" NERDTree
"""""""""""""""""""""
let NERDTreeShowHidden = 1
let NERDTreeShowLineNumbers = 0
let NERDTreeMinimalMenu = 1

nmap <> :NERDTreeToggle<CR>

""""""""""""""""""""""""""
" Emmet
"""""""""""""""""""""""""
let g:user_emmet_leader_key=','

"""""""""""""""""""""""""""""""
" Aireline
""""""""""""""""""""""""""""""""
let g:aireline_powerline_fonts=1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

let g:airline_theme='luna'
