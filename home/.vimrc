"######################################################################
"
" ~/.vimrc
" vim Konfigurationsdatei
"
"#######################################################################


"#######################################################################
" Einstellungen
set nocompatible   " VIM-Zusätze aktivieren

set showmode
set showcmd
set ruler     " Position(Prozent, Top, Bottom oder All)
set report=0
set title
set icon

" Backup-Files in ~./vimbackup erstellen falls vorhanden
let BACKUPDIR=expand("~/.vimbackup")
if isdirectory(BACKUPDIR)
  set backup
  set backupdir=~/.vimbackup
else
  set nobackup
endif

"hi statement ctermfg=darkblue guifg=darkblue
"hi identifier ctermfg=black guifg=black
"colorscheme desert
set background=light


" Return entfernt/erneuert Suchmusterhighlighting (Toggle)
" (/<BS> leert Statuszeile um Verwirrung zu vermeiden!)
nnoremap <CR> :set invhls<CR>/<BS>

set noerrorbells  " kEINE tÖNE set novisualbell  " kein Blinken

set encoding=utf8  " UTF8 als Zeichensatz
set mouse=         " Mausunterstüzung deaktivieren
set number         " Zeilennummern angeben


set incsearch      " Zeigt Suchergebnisse während dem Suchen an
set hlsearch       " Suchresultate farbig hervorheben
set ignorecase     " Ignoriert Gross/Kleinschreibung beim Suchen
set smartcase      " Nur Gross/Kleinschreibung beachten, wenn Grossbuchstabe vorhanden
set wrapscan       " Nach dem Zeilenende weitersuchen

set autoread       " Liest die Datei neu, wenn ausserhalb von VIM geändert.
set tabstop=2      " Tabulator entspricht 2 Leerzeichen
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

set autoindent     " Automatisch einrücken
set wrap           " Zeilenumbruch aktivieren
"set whichwrap " Mit der Ruecktaste nicht ueber das Zeinende hinaus
set list           " listchars anzeigen
set listchars=tab:»·,trail:· " Tabs und Leerzeichen am Zeilenende anzeigen
set scrolloff=3     " Beginne mit Scrollen 3 Zeilen vorher
set term=xterm     " $TERM

set wildmode=longest,list:longest,list:full  " besseres öffen von Files mittels :tabe

set showtabline=2 " Tabs immer anzeigen


" colorscheme default  " Farbschema
" colorscheme desert  " Farbschema

syntax enable         " Code farbig darstellen

"#######################################################################
" Makros
map <F12> :w!<CR>:!aspell --lang=de check %<CR>:e! %<CR>

map <leader>hex :%!xxd<CR>        " Hexeditor mit \hex starten
map <leader>nhex :%!xxd -r<CR>    " Hexeditor mit \nhex beenden

map <F2>  O<ESC>72i#<ESC>
map <F3>  :r!date +\%Y-\%m-\%d<CR>
" map <F11> :!javac %; basename % .java | xargs java

map <C-C> : w ! xclip<CR><CR>


nnoremap <silent> <Space> :nohl<Bar>:echo<CR> " space = keine markierungen mehr und ruhig sein

set modeline

nmap \l :setlocal number!<CR>
nmap \p :set paste!<CR>

" Beim Datei-Öffnen zur letzten Position springen
" (nur wenn "autocommands" einkompiliert, Pos. gültig und nicht in Event-Handler)
if has("autocmd")
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
endif

" Filetype spezifisch
autocmd BufNewFile,BufRead *.tex map <F5> :w! <CR>:! pdflatex % <CR>
autocmd BufNewFile,BufRead *.tex set textwidth=72
autocmd BufNewFile,BufRead *.java map <F5> :w! <CR>:!javac %; java `basename % .java`<CR>
autocmd BufNewFile,BufRead *.c map <F5> :w! <CR>:!clear; gcc -o `basename % .c` % && ./`basename % .c` <CR>
autocmd BufNewFile,BufRead *.md map <F5> :w! <CR>:!markdown % > `basename % .md`.html<CR>

colorscheme default

" EOF
