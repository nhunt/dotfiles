execute pathogen#infect()              

set nocompatible
filetype plugin on
syntax enable                          " Syntax highlighting


" ==[ Global Settings ]======================================================

set background=dark                    " Dark colors (bold text)
set hlsearch                           " Highlight search results
set cursorline                         " Highlight current line
set smartindent                        " Better indenting rules
set scrolloff=5                        " Keep at least 5 lines visible
set ruler                              " Show where you are
set ignorecase                         " Case-insensitive search
set smartcase                          " Do smart case (in)sensitive searches
set listchars=eol:$,trail:#,tab:->     " White space display


" ==[ Keyboard Remapping ]===================================================

" Re-map the escape key for ergonomic access
inoremap <C-l> <Esc>
vnoremap <silent> <C-l> <Esc>

" Easy timestamp inserts with F5
nnoremap <F5> "=strftime("%c")<CR>P
inoremap <F5> <C-R>=strftime("%c")<CR>

" Quick access to my .vimrc file
nnoremap cv :e $MYVIMRC<CR> 

" Quick searching for the current word
map gr :grep -R -I <cword> . <CR>


" ==[ User-defined functions ]===============================================

function! LastModified()
   " Look for a line containing the string 'Last modified' or 'last-modified',
   " and update the timestamp that follows.  A pre-write hook is installed
   " such that each time the file is written, the timestamp is automatically
   " updated.
   if &modified
      let save_cursor = getpos(".")
      let n = min([20, line("$")])
      let now = strftime('%c')
      keepjumps exe '1,' . n . 's#^\(.\{,10}\(Last modified\|last-modified\): \).*#\1' . now . '#e'
      call histdel('search', -1)
      call setpos('.', save_cursor)
   endif
endfun
autocmd BufWritePre * call LastModified()


" ==[ Language-specific ]====================================================

function CSettings()
   set formatoptions+=t                   " Make sure text wraps
   set foldmethod=indent                  " Automatic syntax folding
   set textwidth=80                       " Default text width of 80 chars
   set expandtab ts=3 sw=3 sts=3          " Spaces > tabs
endfun

function MarkdownSettings()
   set foldmethod=indent
endfun

function YamlSettings()
   set expandtab ts=2 sw=2 sts=2          " Spaces > tabs, smaller for yaml
endfun

function PythonSettings()
   set expandtab ts=3 sw=3 sts=3          " Spaces > tabs
endfun

function GoSettings()
   set noexpandtab ts=3 sw=3 sts=3        " Spaces > tabs
endfun

" Language specific overrides
au BufNewFile,BufRead *.h,*.c,*.cpp,*.S call CSettings()
au BufNewFile,BufRead *.py              call PythonSettings()
au BufNewFile,BufRead *.md              call MarkdownSettings()
au BufNewFile,BufRead *.yaml            call YamlSettings()
au BufNewFile,Bufread *.go              call GoSettings()
