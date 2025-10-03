" ========================================
" VPS-Optimized Vim Configuration
" Focused on Python & Shell Script Development
" ========================================

" Disable Vi compatibility mode
set nocompatible

" ========================================
" vim-plug Plugin Manager Setup
" ========================================
" Auto-install vim-plug if not present
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugin declarations
call plug#begin('~/.vim/plugged')

" ========================================
" Essential Plugins (Lightweight)
" ========================================

" File management (choose one based on VPS resources)
Plug 'preservim/nerdtree'                " File tree explorer

" Minimal status line (lighter than airline)
Plug 'itchyny/lightline.vim'                " Lightweight status line

" Essential editing tools
Plug 'tpope/vim-surround'                    " Surround text objects
Plug 'tpope/vim-commentary'                  " Easy commenting
Plug 'jiangmiao/auto-pairs'                  " Auto close brackets

" ========================================
" Python-specific Plugins (Simplified)
" ========================================

" Python syntax and indentation
Plug 'vim-python/python-syntax'             " Enhanced Python syntax
Plug 'Vimjas/vim-python-pep8-indent'        " PEP8 indentation
Plug 'jeetsukumaran/vim-pythonsense'        " Python text objects

" Core plugins for linting and completion (no external dependencies)
Plug 'dense-analysis/ale'                    " Async linting (built-in linters)
Plug 'lifepillar/vim-mucomplete'             " Minimal completion plugin

" ========================================
" Shell Script Support
" ========================================

" Remove bash-language-server as it requires Node.js
Plug 'z0mbix/vim-shfmt', { 'for': 'sh' }    " Shell script formatter

" ========================================
" Git Integration (Lightweight)
" ========================================

Plug 'tpope/vim-fugitive'                    " Git wrapper
Plug 'airblade/vim-gitgutter'            " Git diff in gutter (only if enough memory)

" ========================================
" Optional Enhancements (Memory permitting)
" ========================================

Plug 'morhetz/gruvbox'                   " Color scheme
Plug 'Yggdroot/indentLine'               " Indentation lines
Plug 'mbbill/undotree'                   " Undo history visualizer

call plug#end()

" ========================================
" Basic Vim Settings (Optimized for VPS)
" ========================================

" File handling
set autoread                    " Auto reload files changed outside vim
set hidden                      " Allow switching buffers without saving
set noswapfile                  " Disable swap files (save disk I/O)
set nobackup                    " Disable backup files
set nowb                        " Disable writebackup
set updatetime=200             " Slower update time for VPS (default 4000)

" Interface
set number                      " Show line numbers
set showcmd                     " Show command in status line
set showmatch                   " Show matching brackets
set ruler                       " Show cursor position
set laststatus=2                " Always show status line
set wildmenu                    " Enhanced command line completion
set wildmode=longest:full,full  " Complete longest match, then full
set signcolumn=number           " Use number column for signs (save space)

" Search
set incsearch                   " Incremental search
set hlsearch                    " Highlight search results
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uppercase present

" Indentation (Python-focused)
set autoindent                  " Auto indent new lines
set smartindent                 " Smart indentation
set expandtab                   " Use spaces instead of tabs
set tabstop=4                   " Tab width (Python standard)
set shiftwidth=4                " Indent width
set softtabstop=4               " Soft tab width
set shiftround                  " Round indent to multiple of shiftwidth
set listchars=tab:=,trail:
set list

" Folding (useful for Python)
set foldmethod=indent           " Fold based on indentation
set foldlevelstart=99           " Start with all folds open
set foldnestmax=10              " Maximum fold nesting

" Scrolling and display
set scrolloff=3                 " Keep 3 lines above/below cursor (reduced for VPS)
set sidescrolloff=5             " Keep 5 columns left/right of cursor
set wrap                      " Don't wrap long lines
set linebreak                   " Break lines at word boundaries
set breakindent
" set breakindentopt=shift:3
set showbreak=\ \               " with a trailing space
" highlight NonText ctermfg=lightgray ctermbg=lightblue guibg=#003366

" Encoding and format
set encoding=utf-8              " Use UTF-8 encoding
set fileencoding=utf-8          " File encoding
set fileformat=unix             " Unix line endings

" Performance optimizations for VPS
set ttyfast                     " Fast terminal connection
set lazyredraw                  " Don't redraw during macros
set synmaxcol=500               " Only highlight first 200 columns
set ttimeoutlen=50              " Faster key sequence timeout

" Mouse (if supported)
" if has('mouse')
"     set mouse=a                 " Enable mouse in all modes
" endif

" ========================================
" Completion Settings for MUcomplete
" ========================================

set completeopt+=menuone       " Show menu even for single match
set completeopt+=noselect      " Don't auto-select first match
set completeopt-=preview       " Disable preview window
set belloff+=ctrlg             " Disable bell for completion
set shortmess+=c               " Don't show completion messages

" ========================================
" Color Scheme (Conditional)
" ========================================

syntax enable
set background=dark

" Use color scheme if available, otherwise fallback
if exists('g:plugs') && has_key(g:plugs, 'gruvbox')
    try
        colorscheme gruvbox
    catch /^Vim\%((\a\+)\)\=:E185/
        colorscheme default
    endtry
else
    colorscheme default
    " Manual dark theme for default colorscheme
    highlight Comment ctermfg=darkgray
    highlight LineNr ctermfg=gray
    highlight CursorLine cterm=underline
endif

" ========================================
" Key Mappings (Python-focused)
" ========================================

" Set leader key
let mapleader = ","
let g:mapleader = ","

" Quick save and quit
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>x :x<CR>

" Clear search highlighting
nnoremap <leader><space> :nohlsearch<CR>

" Python-specific mappings
nnoremap <leader>r :!python3 %<CR>              " Run current Python file
nnoremap <leader>i :!python3 -i %<CR>           " Run in interactive mode
nnoremap <leader>py :!python3 -m py_compile %<CR>  " Compile check

" Shell script mappings
nnoremap <leader>sh :!bash %<CR>                " Run current shell script
nnoremap <leader>sc :!shellcheck %<CR>          " Check shell script

" Buffer navigation
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprevious<CR>
nnoremap <leader>bd :bdelete<CR>

" Window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <Tab><Tab> <C-w>w

" Better indenting in visual mode
vnoremap < <gv
vnoremap > >gv

" Comment toggle (using vim-commentary)
nnoremap <leader>/ :Commentary<CR>
vnoremap <leader>/ :Commentary<CR>

" Completion mappings
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"

" ========================================
" Plugin Configurations
" ========================================

" Lightline (minimal status line)
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

" NERDTree (if installed)
if exists('g:plugs') && has_key(g:plugs, 'nerdtree')
    let g:NERDTreeWinSize=25                     " Smaller window for VPS
    let g:NERDTreeShowHidden=1
    let g:NERDTreeIgnore=['.git$', '__pycache__$', '*.pyc$', '.vscode$']
    nnoremap <leader>e :NERDTreeToggle<CR>
    nnoremap <leader>f :NERDTreeFind<CR>
endif

" ========================================
" ALE Configuration (Simplified)
" ========================================

let g:ale_enabled = 1
let g:ale_sign_column_always = 0                 " Don't always show sign column
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'

" Use only built-in linters (no external dependencies)
let g:ale_linters = {
\   'python': ['python', 'pycodestyle', 'pydocstyle'],
\   'sh': ['shell'],
\}

" Use only built-in fixers
let g:ale_fixers = {
\   'python': ['autopep8'],
\   'sh': ['shfmt'],
\}

" ALE completion integration with mucomplete
let g:ale_completion_enabled = 0                 " Let mucomplete handle completion
let g:ale_completion_autoimport = 1

" Auto-fix on save (optional)
let g:ale_fix_on_save = 0                        " Disabled by default for VPS performance

" Faster linting
let g:ale_lint_delay = 800                      " Delay linting for performance
let g:ale_lint_on_text_changed = 'never'        " Only lint on save/enter
let g:ale_lint_on_insert_leave = 1

" ========================================
" MUcomplete Configuration
" ========================================

let g:mucomplete#enable_auto_at_startup = 1     " Enable auto completion
let g:mucomplete#completion_delay = 1           " Small delay for performance

" Define completion chains for different file types
let g:mucomplete#chains = {}
let g:mucomplete#chains.default = ['path', 'omni', 'keyn', 'keyp', 'dict', 'uspl']
let g:mucomplete#chains.python = ['path', 'omni', 'keyn', 'keyp']
let g:mucomplete#chains.sh = ['path', 'omni', 'keyn']
let g:mucomplete#chains.text = ['path', 'keyn', 'dict', 'uspl']

" Minimum prefix length
let g:mucomplete#minimum_prefix_length = 2

" Don't auto complete in comments and strings
let g:mucomplete#no_mappings = 1

" ========================================
" Python syntax highlighting
" ========================================

let g:python_highlight_all = 1
let g:python_highlight_space_errors = 0          " Disable to reduce visual clutter

" ========================================
" IndentLine (if installed)
" ========================================

if exists('g:plugs') && has_key(g:plugs, 'indentLine')
    let g:indentLine_enabled = 1
    let g:indentLine_char = '┊'
    let g:indentLine_faster = 1                  " Use faster drawing method
    " let g:indentLine_setConceal = 0              " Don't hide quotes in JSON
    let g:indentLine_conceallevel = 1
    let g:indentLine_concealcursor = ''     " do not hide char at cursor(?)
endif

" UndoTree (if installed)
if exists('g:plugs') && has_key(g:plugs, 'undotree')
    nnoremap <leader>u :UndotreeToggle<CR>
    let g:undotree_SetFocusWhenToggle = 1
endif

" ========================================
" Python-specific Settings
" ========================================

" Python file type settings
autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType python setlocal textwidth=88              " PEP8 line length
autocmd FileType python setlocal colorcolumn=89            " Show line limit
autocmd FileType python setlocal foldmethod=indent
autocmd FileType python setlocal commentstring=#\ %s

" Enable omni completion for Python
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete

" Python path detection
if executable('python3')
    let g:python3_host_prog = exepath('python3')
endif

" Shell script settings
autocmd FileType sh setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType sh setlocal foldmethod=syntax
autocmd FileType sh setlocal omnifunc=syntaxcomplete#Complete

" JSON setting for IndentLine
" autocmd FileType json setlocal conceallevel=2 concealcursor=
autocmd FileType json setlocal conceallevel=0
autocmd FileType json let b:indentLine_enabled = 0


" ========================================
" Custom Functions
" ========================================

" Remove trailing whitespace
function! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfunction
command! TrimWhitespace call TrimWhitespace()
nnoremap <leader>tw :TrimWhitespace<CR>

" Python virtual environment detection
function! DetectVirtualEnv()
    if exists('$VIRTUAL_ENV')
        return fnamemodify($VIRTUAL_ENV, ':t')
    else
        return ''
    endif
endfunction

" Quick Python execution with different interpreters
function! RunPython()
    let l:python_cmd = 'python3'
    if exists('$VIRTUAL_ENV')
        let l:python_cmd = $VIRTUAL_ENV . '/bin/python'
    endif
    execute '!' . l:python_cmd . ' %'
endfunction
nnoremap <leader>pr :call RunPython()<CR>

" Memory usage check for VPS
function! CheckMemory()
    let l:mem_info = system('free -h | head -2')
    echo l:mem_info
endfunction
command! MemCheck call CheckMemory()

" Quick edit vimrc
nnoremap <leader>ev :edit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" toggle number, linebreak, breakindent, showbreak
function! ToggleViewSettings()
    IndentLinesToggle
    set number!
    set linebreak!
    set breakindent!
    set list!
    if &showbreak == ''
        set showbreak=\ \               " with a trailing space
    else
        set showbreak=
    endif

    " show info
    echo "IndentLine: " . (exists('b:indentLine_enabled') && b:indentLine_enabled ? 'ON' : 'OFF') .
        \ " | Number: " . (&number ? 'ON' : 'OFF') .
        \ " | LineBreak: " . (&linebreak ? 'ON' : 'OFF') .
        \ " | BreakIndent: " . (&breakindent ? 'ON' : 'OFF') .
        \ " | ShowBreak: " . (&showbreak != '' ? 'ON' : 'OFF')
endfunction

nnoremap <leader>c :call ToggleViewSettings()<CR>
inoremap <leader>c <C-O>:call ToggleViewSettings()<CR>

" ========================================
" Auto Commands
" ========================================

" Return to last edit position when opening files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Auto trim whitespace on save for Python and shell scripts
autocmd BufWritePre *.py,*.sh call TrimWhitespace()

" Auto-reload .vimrc when saved
autocmd BufWritePost .vimrc source %

" Python-specific auto commands
autocmd FileType python nnoremap <buffer> <F5> :call RunPython()<CR>
autocmd FileType python inoremap <buffer> <F5> <Esc>:call RunPython()<CR>

" Shell script auto commands
autocmd FileType sh nnoremap <buffer> <F5> :!bash %<CR>

" ========================================
" VPS Performance Optimizations
" ========================================

" Disable some features for better performance on low-end VPS
set noshowcmd                    " Don't show command in status line (save CPU)
set shortmess+=I                 " Don't show intro message
set complete-=i                  " Don't scan included files for completion
set complete-=t                  " Don't scan tags for completion

" Limit syntax highlighting for large files
autocmd BufWinEnter * if line2byte(line("$") + 1) > 100000 | syntax clear | endif

" ========================================
" Fallback Status Line (if lightline fails)
" ========================================

if !exists('g:loaded_lightline')
    set statusline=
    set statusline+=%#StatusLine#
    set statusline+=\ %f
    set statusline+=\ %m%r%h%w
    set statusline+=%=
    set statusline+=\ %{DetectVirtualEnv()}
    set statusline+=\ %y
    set statusline+=\ %p%%
    set statusline+=\ %l:%c
    set statusline+=\ 
endif
