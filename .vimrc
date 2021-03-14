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

" Change Cursor
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
:autocmd InsertEnter,InsertLeave * set cul!

"With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","

" Relative line number
:set number relativenumber
:set nu rnu

" Wild menu
set wildchar=<Tab> wildmenu wildmode=longest:list,full 
set wildcharm=<C-Z>
nnoremap <F10> :b <C-Z>

" Add a bit extra margin to the left
set foldcolumn=1

set incsearch " Enable incremental search
set hlsearch  " Enable highlight search

"""""""""""""""""""""""""""""""
" Terminal
"""""""""""""""""""""""""""""""
set termwinsize=12x0
set splitbelow
set mouse=a
nmap <F3> :term<CR>
tnoremap <ESC> <C-w>:q!<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax on 

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Buffers
:set confirm


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git etc. anyway...
set nobackup
set nowb
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

"""""""""""""""""""""""
" Buffers
""""""""""""""""""""""
" Close the current buffer
map <leader>bd :bd<cr>

" Close all the buffers
map <leader>ba :bufdo bd<cr>

map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

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

" Fast saving
nmap <leader>w :w!<cr>

" :W sudo saves the file
" (useful for handling the permission-denied error)
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!


" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

""""""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""""""
call plug#begin('~/.local/share/nvim/plugged')
    Plug 'tpope/vim-dispatch'
    Plug 'sheerun/vim-polyglot'
    Plug 'jiangmiao/auto-pairs'
    Plug 'tpope/vim-fugitive'
    Plug 'scrooloose/syntastic'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'ctrlpvim/ctrlp.vim'
    Plug 'ryanoasis/vim-devicons'
    Plug 'majutsushi/tagbar'
    Plug 'preservim/nerdtree'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'dyng/ctrlsf.vim'
    Plug 'sainnhe/edge'
call plug#end()

"""""""""""""""""""""""""""""""
" Coc Config
""""""""""""""""""""""""""""""""

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
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
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

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

""""""""""""""""""""
" NERDTree
"""""""""""""""""""""
let NERDTreeShowHidden = 1
let NERDTreeShowLineNumbers = 0
let NERDTreeMinimalMenu = 1

nmap <F2> :NERDTreeToggle<CR>

"""""""""""""""""""""""
" Tagbar
""""""""""""""""""""""""

" Focus the panel when opening it
let g:tagbar_autofocus = 1

" Highlight the active tag
let g:tagbar_autoshowtag = 1

" Make panel vertical and place on the right
let g:tagbar_position = 'botright vertical'

" Mapping to open and close the panel
nmap <F8> :TagbarToggle<CR>

""""""""""""""""""""""""""""""
" Ctrlfs
"""""""""""""""""""""""""""""""
" Use the ack tool as the backend
let g:ctrlsf_backend = 'ack'

" Auto close the results panel when opening a file
let g:ctrlsf_auto_close = { "normal":0, "compact":0 }

" Immediately switch focus to the search window
let g:ctrlsf_auto_focus = { "at":"start" }

" Don't open the preview window automatically
let g:ctrlsf_auto_preview = 0

" Use the smart case sensitivity search scheme
let g:ctrlsf_case_sensitive = 'smart'

" Normal mode, not compact mode
let g:ctrlsf_default_view = 'normal'

" Use absoulte search by default
let g:ctrlsf_regex_pattern = 0

" Position of the search window
let g:ctrlsf_position = 'right'

" Width or height of search window
let g:ctrlsf_winsize = '46'

" Search from the current working directory
let g:ctrlsf_default_root = 'cwd'

" (Ctrl+F) Open search prompt (Normal Mode)
nmap <C-F>f <Plug>CtrlSFPrompt 

" (Ctrl-F + f) Open search prompt with selection (Visual Mode)
xmap <C-F>f <Plug>CtrlSFVwordPath

" (Ctrl-F + F) Perform search with selection (Visual Mode)
xmap <C-F>F <Plug>CtrlSFVwordExec

" (Ctrl-F + n) Open search prompt with current word (Normal Mode)
nmap <C-F>n <Plug>CtrlSFCwordPath

" (Ctrl-F + o )Open CtrlSF window (Normal Mode)
nnoremap <C-F>o :CtrlSFOpen<CR>

" (Ctrl-F + t) Toggle CtrlSF window (Normal Mode)
nnoremap <C-F>t :CtrlSFToggle<CR>

" (Ctrl-F + t) Toggle CtrlSF window (Insert Mode)
inoremap <C-F>t <Esc>:CtrlSFToggle<CR>

"""""""""""""""""""""""""""""""
" CtrlP
""""""""""""""""""""""""""""""""
let g:ctrlp_open_multiple_files = 'ij'


""""""""""""""""""""""""""""""""
" Build command binding
"""""""""""""""""""""""""""""""""

"open vim-dispatch window and scroll to bottom
nnoremap <C-m>m :Copen<CR> <bar> G

"Build debug and release targets
"nnoremap <F5> :Dispatch! make -C build/Debug<CR>
"nnoremap <F6> :Dispatch! make -C build/Release<CR>

""""""""""""""""""""""""""""""""
" Edge color scheme
"""""""""""""""""""""""""""""""""
let g:edge_style = 'aura'
let g:edge_enable_italic = 0
let g:edge_disable_italic_comment = 1
if has('termguicolors')
    set termguicolors
endif
set guifont=Hack\ 11
set background=dark
colorscheme edge

