"""""""""""""""""""
" NeoVim Settings "
"""""""""""""""""""
autocmd BufWritePost * silent 
			\!sh /home/petter/.config/nvim/scripts/restart_openresty.sh '%:p'
nnoremap <C-*> 
			\!sh /home/petter/.config/nvim/scripts/restart_openresty.sh '%:p'
set colorcolumn=81
highlight ColorColumn ctermbg=1

" Vimwiki
set nocompatible
filetype plugin on
syntax on
let g:vimwiki_list = [{'path':'~/vimwiki/',
					 \ 'syntax': 'markdown', 'ext':'.md'}]

" Theme
colorscheme gruvbox
set background=dark
set termguicolors

let g:gruvbox_italic=1
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
\	'C': ['gcc']
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
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" /NERDTree

let mapleader = ","
"line Number
set nu
""""""""""""
" markdown "
""""""""""""
let vim_markdown_preview_hotkey='<C-z>'
let vim_markdown_preview_browser='Firefox Developer Edition'
let g:markdown_composer_browser='firefox-developer-edition'
let g:markdown_composer_custom_css=['file:///home/petter/.local/share/plugged/github-css/github-markdown.css']
"""""""""""""
" /markdown "
"""""""""""""
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

"Plug 'junegunn/fzf.vim'
" Vim-airline for powerline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Linter
Plug 'w0rp/ale'
Plug 'palantir/tslint'
" Autocomplete / complete framework

" Typescript
Plug 'leafgarland/typescript-vim'

" Gitgutter
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" AutoPair
Plug 'jiangmiao/auto-pairs'

Plug 'vimwiki/vimwiki'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'

Plug 'chr4/nginx.vim' " nginx.conf 

Plug 'rhysd/vim-clang-format'
Plug 'tpope/vim-surround' " ds, cs, yss"
" Themes
Plug 'morhetz/gruvbox'
"Plug 'arcticicestudio/nord-vim'
"Plug 'icymind/NeoSolarized'
"Plug 'mhartington/oceanic-next'

" Initialize plugin system
call plug#end()

" fix backspace
set backspace=indent,eol,start

" configure tabs and spaces
set noexpandtab " insert tabs 
set smarttab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set completeopt+=longest
set autoindent
set noexpandtab

" Disable arrow keys
noremap <Up>	<Nop>
noremap <Left>	<Nop>
noremap <Right> <Nop>
noremap <Down>	<Nop>

" Reopen file at same line when it was closed
if has("autocmd")
	au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
		\| exe "normal! g'\"" | endif
endif

" Cursor line and column hightlight
hi CursorLine	cterm=NONE	ctermbg=darkred	ctermfg=white guibg=#cc241d guifg=#ebdbb2
hi CursorColumn cterm=NONE ctermbg=darkblue ctermfg=white guibg=#cc241d guifg=#ebdbb2
nnoremap <Leader>m :set cursorline! cursorcolumn!<CR>

" Search for word under cursor
vnoremap // y/<C-R>"<CR>
