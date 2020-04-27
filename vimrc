set nocompatible
execute pathogen#infect()
" Set statements"{{{
set backspace=indent,eol,start
set backup
set backupdir=~/.vim/tmp//,.
set directory=~/.vim/tmp//,.
set history=50
set ruler
set showcmd
set incsearch
set ignorecase smartcase
set number
set path=.,/usr/include,,,~,**	" Fuzzy find-type settings from https://youtu.be/XA2WjJbmmoM
set wildmenu
set encoding=utf-8
set splitbelow
set splitright
"set spell spelllang=en_us
" EndSet
"}}}
" Conditionals"{{{
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

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
	command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
				\ | wincmd p | diffthis
endif

" EndConditionals
"}}}
" Autocommands"{{{
" Only do this part when compiled with support for autocommands.
if has("autocmd")

	filetype plugin indent on

	augroup vimrcEx
		au!
		autocmd FileType text setlocal textwidth=78
		autocmd BufReadPost *
					\ if line("'\"") > 1 && line("'\"") <= line("$") |
					\   exe "normal! g`\"" |
					\ endif
	augroup END

	augroup VCenterCursor
		au!
		au BufEnter,WinEnter,WinNew,VimResized *,*.*
					\ let &scrolloff=winheight(win_getid())/2
	augroup END

	augroup MapComment
		autocmd!
		autocmd FileType bash	 nnoremap <buffer> <localleader>c I#<esc>
		autocmd FileType sh	 nnoremap <buffer> <localleader>c I#<esc>
		autocmd FileType conf	 nnoremap <buffer> <localleader>c I#<esc>
		autocmd FileType vim	 nnoremap <buffer> <localleader>c 0i"<esc>
	augroup END

	augroup filetype_html
		autocmd!
		autocmd FileType html nnoremap <buffer> <localleader>f Vatzf
	augroup END

	augroup filetype_vim
		autocmd!
		autocmd FileType vim setlocal foldmethod=marker
	augroup END

	augroup filetype_help
		autocmd!
		autocmd FileType help setlocal nohls
		autocmd FileType help nnoremap <buffer> <Tab>	/\v\\|.+\\|<CR>
		autocmd FileType help nnoremap <buffer> <CR>	<C-]>
		autocmd FileType help nnoremap <buffer> H	<C-o>
		autocmd FileType help nnoremap <buffer> L	<C-i>
	augroup END

	"augroup AutoSaveFolds "This throws too many errors!
	"	autocmd!
	"	autocmd BufWinLeave * mkview
	"	autocmd BufWinEnter * silent loadview
	"augroup END

else

	set autoindent		" always set autoindenting on

endif " has("autocmd")

" EndAutocommands
"}}}
" MyMappings"{{{
" Silly little mappings that make my life easier ;)
let mapleader = ","
let maplocalleader = "_"
map!		<C-F>		<Esc>gUiw`]a| " Make word before cursor UPPERCASE
inoremap	<C-g><C-t>	<C-r>=strftime("%F")<CR>| " Vimways.org: insert date inline
inoremap	<C-U>		<C-G>u<C-U>
nnoremap	g*		g*zz
nnoremap	g#		g#zz
nnoremap	H		0
nnoremap	j		jzz
inoremap	jk		<ESC>
nnoremap	k		kzz
nnoremap	L		$
inoremap	<leader>``	``''<esc>hi
inoremap	<leader>`	`'<esc>i
inoremap	<leader><	<><esc>i
inoremap	<leader>'	''<esc>i
inoremap	<leader>"	""<esc>i
inoremap	<leader>(	()<esc>i
inoremap	<leader>[	[]<esc>i
inoremap	<leader>{	{}<esc>i
inoremap	<leader>*	**<esc>i
vnoremap	<leader>``	<esc>`<i``<esc>`>a''<esc>
vnoremap	<leader>`	<esc>`<i`<esc>`>a'<esc>
vnoremap	<leader><	<esc>`<i<<esc>`>a><esc>
vnoremap	<leader>'	<esc>`<i'<esc>`>a'<esc>
vnoremap	<leader>"	<esc>`<i"<esc>`>a"<esc>
vnoremap	<leader>(	<esc>`<i(<esc>`>a)<esc>
vnoremap	<leader>[	<esc>`<i[<esc>`>a]<esc>
vnoremap	<leader>{	<esc>`<i{<esc>`>a}<esc>
vnoremap	<leader>*	<esc>`<i*<esc>`>a*<esc>
"nnoremap	<leader>g	:silent exe "grep! -R " . shellescape(expand("<cWORD>")) . " ."<cr>:copen<cr>
nnoremap	<leader>kb	:!grep "^\w*map\!*\s" $MYVIMRC <bar> sort -k2 -k1 > ~/.vim/mappings.txt<CR>:tabe ~/.vim/mappings.txt<CR>| " Show mappings in this file
nnoremap	<leader>n	:cnext<cr>
nnoremap	<leader>p	:cprevious<cr>
inoremap	<leader>se	#-----------------------------------
nnoremap	<leader>se	i#-----------------------------------<esc>
inoremap	<leader>v	"${}"<esc>hi
nnoremap	<leader>ws	:highlight TrailWS ctermbg=cyan<CR> :match TrailWS /\v\s+$/<CR>
nnoremap	<localleader>ws :match<CR>
nnoremap	n		nzz
nnoremap	N		Nzz
vnoremap	.		:norm.<CR>
nnoremap	Q		:q!
nnoremap	<Return>	:winc gF<CR>| " Open the file (on line number) in new tab
nnoremap	<Space>bb	:tabe $HOME/.bashrc<CR>
nnoremap	<Space>co	I <Esc>0f*Xciw+ <Esc>md:r !date +\%F<CR>0D`dpJx| " Mark a gtd task complete
nnoremap	<Space>da	:r !date +\%F" "\%a<CR>o<CR>| " Insert the date in YYYY-MM-DD Day format and insert two lines
nnoremap	<Space>di	me:r !date +\%F<CR>A <Esc>0D`ePJx| " Insert the date in YYYY-MM-DD format inline just before cursor position
nnoremap	<Space>do	md:g/^\s*+/m$<CR>:set nohls<CR>`d| " Move completed tasks to the bottom of the list
nnoremap	<Space>fi	:find ./.**/
nnoremap	<Space>gf	:winc gF<CR>| " Open the file (on line number) in new tab
nnoremap	<Space>gr	:r <cfile><CR>| " Read contents of the file under the cursor into the current file
nnoremap	<Space>hh	:w<CR>
nnoremap	<Space>hl	:set nohls!<CR>
nnoremap	<Space>j	<PageDown>L
nnoremap	<Space>k	<PageUp>H
nnoremap	<Space>li	:set list!<CR>| " Toggle hidden characters
nnoremap	<Space>ns	/\zs\\.*section\ze[^ ]<CR>zz| " Find next section in LaTeX
nnoremap	<Space>ok	A<Tab>%OK TMC<Esc>
nnoremap	<Space>ps	k?\zs\\.*section\ze[^ ]<CR>zz| " Find previous section in LaTeX
nnoremap	<Space>qq	:q!
nnoremap	<Space>sa	ggVG| " Select all
nnoremap	<Space>so	:source $MYVIMRC<CR>
nnoremap	<Space><Space>	<PageDown>L
nnoremap	<Space>sp	:set nospell!<cr>
nnoremap	<Space>te	:tabe<cr>
nnoremap	<Space>ti	:r !date +\%R<CR>| " Insert the time in HH:MM format
nnoremap	<Space>vv	:tabe $MYVIMRC<CR>
nnoremap	<Space>wc	:winc | " Can't always use CTRL-W (esp. when working from Chromebook)
nnoremap	<Space>wh	<C-w>h
nnoremap	<Space>wj	<C-w>j
nnoremap	<Space>wk	<C-w>k
nnoremap	<Space>wl	<C-w>l
nnoremap	<Space>wq	:wq
nnoremap	<Space>ws	:%s/\s\+$//eg<CR>| " Find and kill trailing whitespace
nnoremap	<Space>ww	<C-w>w
nnoremap	th		:tab help |
nnoremap	/		/\v
nnoremap	Y		y$
nnoremap	*		*zz
nnoremap	#		#zz
" EndMyMappings
"}}}
" Netrw"{{{
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 3
let g:netrw_keepdir = 0
let g:netrw_fastbrowse = 0 " Possibly gets rid of [RO] netrw buffers: https://github.com/tpope/vim-vinegar/issues/13: * Monitor 2019-12-05
" EndNetrw
"}}}
" LaTeX"{{{
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
" EndLaTeX
"}}}
" Solarized colorscheme"{{{
set t_Co=256
let g:solarized_termcolors=256
call pathogen#infect()
syntax on
"set background=light " dark | light "
set background=dark " dark | light "
colorscheme solarized
"filetype plugin on
set cursorline
set cursorcolumn
"set colorcolumn=80
call togglebg#map("<F5>")
" EndSolarized
"}}}
" TODO Clean up this file!
"
" vim: set fdm=marker:
