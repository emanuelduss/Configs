"
" ~/.vimrc
"
set colorcolumn=80
set icon
set report=0
set ruler
set showcmd
set showmode
set title

" Backup-Files in ~./vimbackup erstellen falls vorhanden
let BACKUPDIR=expand("~/.vimbackup")
if isdirectory(BACKUPDIR)
  set backup
  set backupdir=~/.vimbackup
else
  set nobackup
endif

set undofile
set undodir=~/.vimundo

set noerrorbells  " Keine Töne
set novisualbell  " kein Blinken

set encoding=utf8  " UTF8 als Zeichensatz
set mouse=         " Mausunterstüzung deaktivieren
set number         " Zeilennummern angeben

set incsearch      " Zeigt Suchergebnisse während dem Suchen an
set hlsearch       " Suchresultate farbig hervorheben
set ignorecase     " Ignoriert Gross/Kleinschreibung beim Suchen
set smartcase      " Nur Gross/Kleinschreibung beachten, wenn Grossbuchstabe vorhanden
set wrapscan       " Nach dem Zeilenende weitersuchen

set autoread       " Liest die Datei neu, wenn ausserhalb von VIM geändert.
set tabstop=4      " Tabulator entspricht 8 Leerzeichen
set softtabstop=2  " Weicher Tabulator
set shiftwidth=2   " " einzug um vier spalten vergörssern/kleinern
set expandtab      " Tabulatoren in Spaces umwandeln
set shiftround    " Immer bis zum nächstgelegenen tabstopp springen

set showmatch
set matchpairs=(:)
set mps+=[:]
set mps+={:}
set mps+=<:>
set matchtime=5
set nofoldenable

set autoindent     " Automatisch einrücken
set wrap           " Zeilenumbruch aktivieren
set textwidth=80
set list           " listchars anzeigen
set listchars=tab:▸·,trail:· " Tabs und Leerzeichen am Zeilenende anzeigen
set scrolloff=3     " Beginne mit Scrollen 3 Zeilen vorher
"set term=xterm     " $TERM

set wildmode=longest,list:longest,list:full  " besseres öffen von Files mittels :tabe
set showtabline=2 " Tabs immer anzeigen

" Beim Datei-Öffnen zur letzten Position springen
" (nur wenn "autocommands" einkompiliert, Pos. gültig und nicht in Event-Handler)
if has("autocmd")
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
endif

let mapleader = "-"

map <leader>hex :%!xxd<CR>        " Hexeditor mit \hex starten
map <leader>nhex :%!xxd -r<CR>    " Hexeditor mit \nhex beenden
map <leader>ipsort :%! sort -n -t . -k 1,1 -k 2,2 -k 3,3 -k 4,4<CR> " IPv4 Adressen sortieren
map <leader>sudowrite :w ! sudo tee %<CR>:q!<CR> " sudo trick

map <F3>  :r!date +\%Y-\%m-\%d<CR>
map <C-C> : w ! xclip<CR><CR>
map <F12> :w!<CR>:!aspell --lang=de_CH check %<CR>:e! %<CR>

map <F4>  :r!./getscreenshot<CR>

nnoremap <silent> <Space> :nohl<Bar>:echo<CR> " space = keine markierungen mehr und ruhig sein

noremap <c-j> <c-w>j
noremap <c-k> <c-w>k
noremap <c-l> <c-w>l
noremap <c-h> <c-w>h

set modeline

nmap \n :setlocal number!<CR>
nmap \l :setlocal list!<CR>
nmap \p :setlocal paste!<CR>
nmap \w :setlocal wrap!<CR>
set spelllang=de_ch

" Filetype spezifisch
" autocmd BufNewFile,BufRead *.tex map <F5> :w! <CR>:! pdflatex % <CR>
" autocmd BufNewFile,BufRead *.tex set textwidth=72
" autocmd BufNewFile,BufRead *.java map <F5> :w! <CR>:!javac %; java `basename % .java`<CR>
" autocmd BufNewFile,BufRead *.c map <F5> :w! <CR>:!clear; gcc -o `basename % .c` % && ./`basename % .c` <CR>
" autocmd BufNewFile,BufRead *.cpp map <F5> :w! <CR>:!clear; clang++ -o `basename % .cpp` % && ./`basename % .cpp` <CR>
" autocmd BufNewFile,BufRead *.md map <F5> :w! <CR>:!markdown % > `basename % .md`.html<CR>

autocmd Filetype gitcommit setlocal spell textwidth=72
autocmd Filetype markdown setlocal wrap linebreak nolist textwidth=0 wrapmargin=0 " http://vim.wikia.com/wiki/Word_wrap_without_line_breaks
autocmd FileType sh,cucumber,ruby,yaml,zsh,vim setlocal shiftwidth=2 tabstop=2 expandtab
autocmd FileType python setlocal shiftwidth=4 tabstop=4 expandtab
autocmd Bufread,BufNewFile *.md set filetype=markdown " Vim interprets .md as 'modula2' otherwise, see :set filetype?

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

let g:closetag_filenames = "*.html,*.xhtml,*.phtml"

filetype plugin indent on
"let base16colorspace=256  " Access colors present in 256 colorspace
set background=light

" templates
autocmd BufNewFile *.html 0r ~/skeleton.html

"colorscheme delek
silent! colorscheme molokai
set background=dark
syntax on

" filetype plugin indent on
" set grepprg=grep\ -nH\ $*
" let g:tex_flavor = "latex"
" set runtimepath=~/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,~/.vim/after
"
