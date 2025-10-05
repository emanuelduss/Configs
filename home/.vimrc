""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" ~/.vimrc
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Options
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" General
set nocompatible               " Use vim features
let mapleader = "-"            " Change <leader>
filetype plugin on             " Enable filetype plugins

" Theme & Colors
syntax on                      " Syntax highlighting
set term=xterm-256color        " Mitigate display issues
set background=dark            " Dark terminal
colorscheme default            " Colorscheme
highlight LineNr ctermfg=grey
highlight Comment ctermfg=grey
highlight StatusLine ctermfg=gray
highlight StatusLineNc ctermfg=gray
" highlight Statement ctermfg=yellow
" highlight Identifier ctermfg=blue
" highlight Constant ctermfg=lightblue
" highlight Preproc ctermfg=green
" highlight Special ctermfg=magenta
" highlight Type ctermfg=magenta

" Behavior
set autoindent                 " Automatically indent text
set autoread                   " Re-read file if changed outside of vim
set hidden                     " Don't ask for saving when switching buffers
set mouse=a                    " Enable mouse support
set ignorecase                 " Search case-insensitive
set smartcase                  " Search case-sensitive when uppercase, requires ignorecase

" Tabs
set expandtab                  " Convert tabs to spaces
set shiftround                 " Adjust indentation on shiftwidth
set shiftwidth=2               " Indent by n spaces
set softtabstop=2              " Add/remove spaces on tab/BS
set tabstop=4                  " Tab width

" Visual
set hlsearch                   " Highlight search results
set incsearch                  " Show search results while searching
set laststatus=2               " Always show statusline
set linebreak                  " Visually wrap lines at breakat characters
set list                       " Show hidden characters
set listchars=tab:→\           " Show tabs
set listchars+=trail:·         " Show trailing spaces
set matchpairs+=<:>            " Also match angle brackets
set nofoldenable               " Don't fold by default
set number                     " Show line numbers
set report=0                   " Always show number of lines/words changed
set scrolloff=3                " Minimal lines before/after the cursor
set showmatch                  " Show matching bracket on insert
set title                      " Show filename in window title

" Statusline
set statusline=                " Reset statusline
set statusline+=\ %n           " Buffer Number
set statusline+=\ │            " Separator
set statusline+=\ %f           " Filename
set statusline+=\ %m           " Modified Flag
set statusline+=\ %r           " Readonly Flag
set statusline+=\ %h           " Help Buffer Flag
set statusline+=\ %w           " Preview Window Flag
set statusline+=\ %q           " Quickfix/Location List Flag
set statusline+=%=             " Change to right alignment
set statusline+=\ │            " Separator
set statusline+=\ %y           " Filetype
set statusline+=\ [%{&fileencoding?&fileencoding:&encoding}]
set statusline+=\ [%{&fileformat}\]
set statusline+=\ │            " Separator
set statusline+=\ %l:%c        " Line and column number
set statusline+=\ %LL          " Total line number
set statusline+=\ %P           " Percentage through file
set statusline+=\              " Leading space

" Automatically jump to last position in file
if has("autocmd")
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
endif

" Save backups in ~/.vim/backup if directory exists
if isdirectory(expand("~/.vim/backup"))
  set backup
  set backupdir=~/.vim/backup
endif

" Save undo files in ~/.vim/undo if directory exists
if isdirectory(expand("~/.vim/undo"))
  set undofile
  set undodir=~/.vim/undo
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Mappings
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Navigation Buffers
nnoremap <silent> gb :bnext<CR>
nnoremap <silent> gB :bprevious<CR>
nnoremap <leader>b :ls<CR>:b<space>
nnoremap <silent> <leader><Tab> :bnext<CR>
nnoremap <silent> <Tab> :bnext<CR>
nnoremap <silent> <S-Tab> :bprevious<CR>

" Navigation Windows
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

" Custom Leader Vim Commands
nnoremap <leader>l :setlocal list!<CR>:setlocal list?<CR>
nnoremap <leader>n :setlocal number!<CR>:setlocal number?<CR>
nnoremap <leader>p :setlocal paste!<CR>:setlocal paste?<CR>
nnoremap <leader>s :setlocal spell!<CR>:setlocal spell?<CR>
nnoremap <leader>w :setlocal wrap!<CR>:setlocal wrap?<CR>
nnoremap <leader>r :source ~/.vimrc<CR>
nnoremap <silent> <leader>- :nohl<CR>:echo<CR>
nnoremap <silent> <Space> :nohl<CR>:echo<CR>

" Custom Leader External Commands
nnoremap <leader>copy :w ! xclip -selection primary<CR>
nnoremap <leader>date :r!date +\%Y-\%m-\%d<CR>
nnoremap <leader>hex :%!xxd<CR>
nnoremap <leader>ipsort :%! sort -n -t . -k 1,1 -k 2,2 -k 3,3 -k 4,4<CR>
nnoremap <leader>nhex :%!xxd -r<CR>

" Custom Leader in Diff Mode (mergetool)
if &diff
    map <leader>1 :diffget LOCAL<CR>
    map <leader>2 :diffget BASE<CR>
    map <leader>3 :diffget REMOTE<CR>
endif

" Custom Ex Commands
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Plugin Specific Mappings
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" NERDTree
nnoremap <silent> <leader>e :NERDTree<CR>

" FZF
nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>g :Rg<CR>
nnoremap <silent> <leader>/ :BLines<CR>
nnoremap <silent> <leader>m :Marks<CR>
