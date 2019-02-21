"""""""""""""""""""
"   Vim Settings  "
"""""""""""""""""""
set nocompatible
filetype plugin on
syntax on

" Run auto reload script on save, used for openresty
"autocmd BufWritePost * silent !sh $HOME/.config/tools/scripts/restart_openresty.sh '%:p'
autocmd BufWritePost * :redraw!

nnoremap <C-*> !sh /home/petter/.config/nvim/scripts/restart_openresty.sh '%:p'

" split direction
set splitbelow
set splitright


" Easier split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

set clipboard=unnamed " yank cross terminals

" Always show status bar
set laststatus=2
set statusline=%{fugitive#statusline()}

let g:plug_timeout = 200
" Ale/Linter settings
let g:ale_sh_shell_default_shell = 'zsh'
let g:ale_typescript_tslint_config_path = '/home/petter/tslint.json'
let g:ale_typescript_tslint_use_global = 1
" Set language specific linters
let g:ale_linters = {
\	'javascript': ['eslint'],
\	'typescript': ['tslint'],
\	'sh': ['shellcheck'],
\	'C': ['gcc'],
\}
" Set language specific fixers
let g:ale_fixers = {
\	'typescript': ['tslint']
\}

" /Ale/Linter settings
""""""""""""""""""""
" Airline settings "
""""""""""""""""""""
let g:airline_theme='wombat' " gruvbox
let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1
"""""""""""""""""""""
" /Airline settings "
"""""""""""""""""""""
highlight Comment cterm=italic
set directory=$HOME/.vim/swap//


" NERDTree
" Autoclose vim if NERDTree is only open window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree")
			\&& b:NERDTree.isTabTree()) | q | endif
" /NERDTree

let mapleader = ","
"line Number
set nu
""""""""""""
" markdown "
""""""""""""
"let vim_markdown_preview_hotkey='<C-z>'
"let vim_markdown_preview_browser='Firefox Developer Edition'
"let g:markdown_composer_browser='firefox-developer-edition'
"let g:markdown_composer_custom_css=
	"\['file:///home/petter/.local/share/plugged/github-css/github-markdown.css']
"""""""""""""
" /markdown "
"""""""""""""
if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')
Plug 'terryma/vim-multiple-cursors'

" Multiple Plug commands can be written in a single line using | separators
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'scrooloose/nerdcommenter'
Plug 'Xuyuanp/nerdtree-git-plugin'

"Plug '~/.fzf'
Plug 'junegunn/fzf.vim'
" Vim-airline for powerline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Linter
Plug 'w0rp/ale'
"Plug 'palantir/tslint'
" Autocomplete / complete framework

" Typescript
Plug 'leafgarland/typescript-vim'

" Gitgutter
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" AutoPair
"Plug 'jiangmiao/auto-pairs'

Plug 'vimwiki/vimwiki'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'dhruvasagar/vim-table-mode'
" PlantUML UML/sequence scheme language
Plug 'scrooloose/vim-slumlord'
Plug 'aklt/plantuml-syntax'

"Plug 'xolox/vim-lua-ftplugin' " lua completion
"Plug 'xolox/vim-misc'
Plug 'chr4/nginx.vim' " nginx.conf
"Plug 'Valloric/YouCompleteMe'

Plug 'rhysd/vim-clang-format'
Plug 'tpope/vim-surround' " ds, cs, yss "
" Themes
Plug 'morhetz/gruvbox'
"Plug 'arcticicestudio/nord-vim'
"Plug 'icymind/NeoSolarized'
"Plug 'mhartington/oceanic-next'
Plug 'rust-lang/rust.vim'

Plug 'Dimercel/todo-vim'

" ord mode
Plug 'easymotion/vim-easymotion'
" Initialize plugin system
call plug#end()



" configure tabs and spaces
"set expandtab " insert tabs
set smarttab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set completeopt+=longest
set autoindent
" fix backspace
set backspace=indent,eol,start

set hlsearch " hightlight search text
set incsearch

set relativenumber

set showcmd " show command in bottom bar
set showmatch " hightlight matching [{()}]"
" Disable arrow keys
noremap <Up>	<Nop>
noremap <Left>	<Nop>
noremap <Right> <Nop>
noremap <Down>	<Nop>

" Theme
colorscheme gruvbox
set background=dark
set termguicolors
let g:gruvbox_italic=1

" Vimwiki
au FileType vimwiki set syntax=pandoc
let g:vimwiki_list = [{'path':'~/.config/vimwiki/', 'syntax': 'markdown', 'ext':'.md'}]

" FZF
let g:fzf_action = {
			\ 'ctrl-t': 'tab split',
			\ 'ctrl-x': 'split',
			\ 'ctrl-v': 'vsplit'}

" Reopen file at same line when it was closed
if has("autocmd")
	au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
		\| exe "normal! g'\"" | endif
endif

" Highlight line end for 80 char lines
set colorcolumn=81
highlight ColorColumn ctermbg=blue guibg=#fabd2f
" Cursor line and column hightlight
hi CursorLine   cterm=NONE	ctermbg=darkred	ctermfg=white guibg=#3C3836
hi CursorColumn cterm=NONE ctermbg=darkblue ctermfg=white guibg=#3C3836
nnoremap <Leader>m :set cursorline! cursorcolumn!<CR>
set cursorline cursorcolumn

" Show command completion suggestions
set wildmode=longest,list,full
set wildmenu

" center result of N/n
map N Nzz
map n nzz

nnoremap <C-w>z :mksession! ~/session.vim<CR>
nnoremap <C-w>o :mksession! ~/session.vim<CR>:wincmd o<CR>
nnoremap <C-w>u :source ~/session.vim<CR>

highlight NonText ctermbg=NONE guibg=NONE ctermfg=green guifg=#689d6a
highlight SpecialKey ctermbg=NONE guibg=NONE ctermfg=green guifg=#689d6a

nmap <Leader>l :set list! listchars=tab:\ ,trail:· <CR>

" Show trailing whitespace and spaces before a tab:
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

nmap <F5> :TODOToggle <CR>
