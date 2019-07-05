au Syntax capnp runtime! syntax/capnp.vim
au BufRead,BufNewFile *.capnp set filetype=capnp
"""""""""""""""""""
"   Vim Settings  "
"""""""""""""""""""

" Plug {{{
if has('nvim')
	if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
		silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
			https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
		autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
	endif
else
	if empty(glob('~/.vim/autoload/plug.vim'))
		silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
			https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
		autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
	endif
endif

let g:plug_timeout = 200
" }}}

 "plugins {{{
if has('nvim')
	call plug#begin('~/.local/share/nvim/plugged')
else
	call plug#begin('~/.vim/plugged')
endif
Plug 'scrooloose/nerdcommenter'        " quick commenting
Plug 'junegunn/fzf.vim'                " some fzf commands for vim
Plug 'vim-airline/vim-airline'         " Airline statusbar
Plug 'vim-airline/vim-airline-themes'  " Airline themes
Plug 'vim-syntastic/syntastic'         " Syntastic
Plug 'airblade/vim-gitgutter'          " git line markings
Plug 'tpope/vim-fugitive'              " git integration
Plug 'vimwiki/vimwiki'                 " simple note taking
Plug 'vim-pandoc/vim-pandoc'           " markdown pandoc
Plug 'vim-pandoc/vim-pandoc-syntax'    " markdown pandoc syntax highlighting
Plug 'dhruvasagar/vim-table-mode'      " markdown tables made EZ
Plug 'chr4/nginx.vim'                  " nginx.conf
Plug 'rhysd/vim-clang-format'          " autoformating for clang
Plug 'morhetz/gruvbox'                 " gruvbox theme
Plug 'rust-lang/rust.vim'              " rust tools
Plug 'Dimercel/todo-vim'               " todo list
Plug 'abudden/taghighlight-automirror' " highlight custom c defines/functions
Plug 'christoomey/vim-tmux-navigator'  " tmux integration
Plug 'gsiano/vmux-clipboard'           " yank to tmux clipboard
Plug 'edkolev/tmuxline.vim'
Plug 'stephpy/vim-yaml'
Plug 'majutsushi/tagbar'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'raghur/mermaid-filter'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
"Plug 'vim-utils/vim-man'
call plug#end()
" }}}

" set filetype for 'config' files TODO move this somewhere
au BufRead config set filetype=config

" get some folding going
augroup filetype_vim
	autocmd!
	autocmd FileType vim setlocal foldmethod=marker
augroup end

augroup tt2
	autocmd!
	autocmd FileType tt2 setlocal filetype=html
augroup end

augroup service
	autocmd!
	autocmd FileType *.service setlocal filetype=systemd
augroup end


" remove inserted space from abbreviations <C-R>Eatchar()<CR>
func! Eatchar(pat)
	let c = nr2char(getchar(0))
	return (c =~ a:pat) ? '' : c
endfunc

" alternatively start using ~/.vim/ftdetect/ft.vim
augroup nginx_conf
	autocmd!
	autocmd FileType nginx call Nginx_abbr()
augroup end

function! Nginx_abbr()
	abbr cbl content_by_lua_block<space>{<cr>}<esc>O
	abbr abl access_by_lua_block<space>{<cr>}<esc>O
endfunction

augroup lua_file
	autocmd!
	autocmd FileType lua call Lua_abbr()
augroup end

function! Lua_abbr()
	abbr fun function()<cr>end<esc>?(<cr>:noh<cr>i
	abbr mfun _M.=<space>function()<cr>end<esc>?=<cr>:noh<CR><C-R>Eatchar('\s')
	"abbr if if then<CR>end<ESC>ki
	abbr nloge ngx.log(ngx.ERR,
endfunction

syntax on
filetype plugin on
set nocompatible
set termguicolors

set timeoutlen=1000 ttimeoutlen=0


" Syntastic ------------------- {{{
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_enable_signs = 1

" Lua
let g:syntastic_lua_checkers = ["luacheck"]
let g:syntastic_lua_luacheck_args = "--std ngx_lua --ignore '4[123]1/err' --ignore '4[123]1/data'"
let g:syntastic_check_on_open = 1


"let g:syntastic_rust_checkers = ['rustc']
" }}}

" general settings {{{
let mapleader = ","
set laststatus=2       " Always show status bar
"set directory=.        " save swapfiles with file
"set shell=zsh

set smarttab
set tabstop=4                   " tab width in spaces
set softtabstop=4
set shiftwidth=4
set shiftround

set completeopt=menu
set autoindent
set backspace=indent,eol,start

set hlsearch     " hightlight search text
set incsearch
" split direction
set splitbelow
set splitright

set guioptions=+a
set clipboard+=unnamed
"set clipboard=unnamed

set wildmenu
set wildmode=longest,list,full
set relativenumber
set number

set showcmd      " show command in bottom bar
set showmatch    " hightlight matching [{()}]"
set scrolloff=3  " keep 3 lines above and below cursor

"}}}

" Theme {{{
colorscheme gruvbox
let g:gruvbox_bold=1
let g:gruvbox_italic=1
let g:gruvbox_contrast_dark='hard'
set background=dark

" Airline settings
let g:airline_theme='gruvbox'
let g:airline_powerline_fonts = 1
"}}}


"let g:pandoc#formatting#textwidth = 80
"let g:pandoc#command#autoexec_on_writes = 1
let g:pandoc#command#autoexec_command = 'Pandoc! -F mermaid-filter pdf'

" vim/nvim specific settings {{{
if has('nvim')
	" show the effects of commands while typing
	set inccommand=split
else
	"set Vim-specific sequences for RGB colors, something to do with tmux
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
	set t_Co=256
endif
"}}}
let g:rust_use_custom_ctags_defs = 1  "ignore https://github.com/rust-lang/rust.vim/blob/master/ctags/rust.ctags

if !exists('g:tagbar_type_rust')
   let g:tagbar_type_rust = {
       \ 'ctagstype' : 'rust',
       \ 'kinds' : [
         \'M:macro,Macro Definition',
         \'P:method,A method',
         \'c:implementation,implementation',
         \'e:enumerator,An enum variant',
         \'f:function,Function',
         \'g:enum,Enum',
         \'i:interface,trait interface',
         \'m:field,A struct field',
         \'n:module,module',
         \'s:struct,structural type',
         \'t:typedef,Type Alias',
         \'v:variable,Global variable',
       \ ]
   \ }
endif


let g:vimwiki_list = [
	\ {'path':'~/.config/vimwiki/',
	\ 'syntax': 'markdown',
	\ 'ext':'.md'}]

" FZF
let g:fzf_action = {
	\ 'ctrl-t': 'tab split',
	\ 'ctrl-x': 'split',
	\ 'ctrl-v': 'vsplit',
\}


" Reopen file at same line when it was closed
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
	\| exe "normal! g'\""


" helpful lines
set colorcolumn=81
set cursorline cursorcolumn
hi Comment cterm=italic
hi ColorColumn  guibg=#b8bb26
hi CursorLine   guibg=#3C3836
hi CursorColumn guibg=#3C3836
hi NonText      guibg=NONE guifg=#689d6a
hi SpecialKey   guibg=NONE guifg=#689d6a

" Restore from fullscreen mode, and restore previously closed sessions {{{
nnoremap <C-w>z :mksession! ~/session.vim<CR>
nnoremap <C-w>o :mksession! ~/session.vim<CR>:wincmd o<CR>
nnoremap <C-w>u :source ~/session.vim<CR>
" TODO make fzf session searcher

" }}}

" Display incorrect space and tab usage {{{
nnoremap <Leader>l :set list! listchars=tab:>\ ,trail:· <CR>
hi ExtraWhitespace guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
" }}}

" keybindings {{{
nnoremap N Nzz
nnoremap n nzz

nnoremap <F5> :TODOToggle <CR>
"open fzf buffers
nnoremap <C-b> :Buffers<CR>

"vnoremap " <esc><esc>`<i"<esc>`>la"<esc>

nnoremap - ddkP
nnoremap _ ddp

nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" unmap ex-mode
nmap Q  <NOP>
nmap gQ <NOP>
"}}}

augroup markdown
	au!
	au FileType,BufEnter,FileReadPost vimwiki,*.md set filetype=pandoc
augroup end

map <leader>k <Plug>(Man)

let g:mkdp_auto_close = 1
let g:mkdp_auto_start = 0
