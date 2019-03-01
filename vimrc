set nocompatible

" Pathogen for installing plugins
execute pathogen#infect()

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set backup		" keep a backup file
set backupdir=~/.vim/tmp//,.
set directory=~/.vim/tmp//,.
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching


" Don't use Ex mode, use Q for formatting
"map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

let mapleader = ","

" Silly little mappings that make my life easier ;)
inoremap jk <ESC>
nnoremap <Space><Space> <PageDown>L
nnoremap <Space>k <PageUp>H
nnoremap <Space>j <PageDown>L
map Q :q!
nnoremap <Space>so :source $MYVIMRC<CR>

" Can't always use CTRL-W (esp. when working from Chromebook) #map
nnoremap <Space>wc :winc 

" Show mappings in this file
nnoremap <Space>kb :vne<CR>:r !grep map $HOME/.vimrc<CR>

" Open the file (on line number) in vertical split #map
nnoremap <Space>gf :vsp<CR>gF
nnoremap <Return> :vsp<CR>gF

" Insert the date in YYYY-MM-DD format inline just before cursor position #map
nnoremap <Leader>di me:r !date +\%F<CR>A <Esc>0D`ePJx

" Vimways.org: insert date inline #map
inoremap <C-g><C-t> <C-r>=strftime("%F")<CR>

" Insert the date in YYYY-MM-DD Day format and insert two lines #map
nnoremap <Space>da :r !date +\%F" "\%a<CR>o<CR>

" Insert the time in HH:MM format #map
nnoremap <Space>ti :r !date +\%R<CR>

" Mark a gtd task complete and move completed tasks to the bottom #map
nnoremap <Space>co $F*ciw+ <Esc>md:r !date +\%F<CR>0D`dpJx
nnoremap <Space>do :g/^\s*+/m$<CR>:set nohls<CR>

" Find and remove trailing whitespace #map
nnoremap <Space>ws /\s\+$<CR>
nnoremap <Space>wd :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

set number

"" From  https://shapeshed.com/vim-netrw/ Make netrw work like NERDtree.
"" This didn't work the way I thought it would...
let g:netrw_banner = 0
"let g:netrw_liststyle = 3
let g:netrw_browse_split = 2
"let g:netrw_altv = 1
"let g:netrw_winsize = 25
"augroup ProjectDrawer
"	  autocmd!
"	    autocmd VimEnter * :Vexplore
"    augroup END
"
"
"" From Tim Pope
"" Per default, netrw leaves unmodified buffers open. This autocommand
"" deletes netrw's buffer once it's hidden (using ':q', for example)
"autocmd FileType netrw setl bufhidden=delete



" These may be useful for working with LaTeX.
set wrap
set linebreak
set nolist
set textwidth=0
set wrapmargin=0
"filetype plugin on
set grepprg=grep\ -nH\ $*
"filetype indent on
let g:tex_flavor='latex'

" From danielmiessler.com: Remap your leader key
set encoding=utf-8
vnoremap . :norm.<CR>
" set spell spellang=en_us "throws error msg on startup

" From lukesmith.xyz:  Splits open at the bottom and right, which is
" non-retarded, unlike vim defaults.
set splitbelow
set splitright


" Solarized colorscheme
set t_Co=256
let g:solarized_termcolors=256
call pathogen#infect()
syntax on
set background=dark " dark | light "
colorscheme solarized
"filetype plugin on
set cursorline
set colorcolumn=80
call togglebg#map("<F5>")

" TODO Clean up this file!
