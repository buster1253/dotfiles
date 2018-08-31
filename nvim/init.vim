"""""""""""""""""""
" NeoVim Settings "
"""""""""""""""""""

" disable arrow keys
noremap <Up> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
noremap <Down> <Nop>

autocmd BufWritePost * silent 
			\!sh /home/petter/.config/nvim/scripts/restart_openresty.sh '%:p'
nnoremap <C-*> 
			\!sh /home/petter/.config/nvim/scripts/restart_openresty.sh '%:p'
set colorcolumn=80
highlight ColorColumn ctermbg=1

" vimwiki settings
set nocompatible
filetype plugin on
syntax on
let g:vimwiki_list = [{'path':'~/vimwiki/',
					 \ 'syntax': 'markdown', 'ext':'.md'}]
" /vimwiki settings

" theme settings
"set termguicolors
    " Nord "
	"let g:nord_italic = 1
	"let g:nord_italic_comments = 1
	"let g:nord_comment_brightness = 15
	"colorscheme nord
     "NeoSolarized
	 "set background=dark
	 "colorscheme NeoSolarized
	 "Oceanic-next "
	 "colorscheme OceanicNext
	 "let g:oceanic_next_terminal_bold = 1
	 "let g:oceanic_next_terminal_italic = 1
	" "
" /theme settings


" Always show status bar    
set laststatus=2
set statusline=%{fugitive#statusline()}
" /theme settings

let g:plug_timeout = 200
" Ale/Linter settings
let g:ale_sh_shell_default_shell = 'zsh'
let g:ale_typescript_tslint_config_path = '/home/petter/tslint.json'
let g:ale_typescript_tslint_use_global = 1
" Set language specific linters
let g:ale_linters = {
\	'javascript': ['eslint'],
\	'typescript': ['tslint'],
\	'sh': ['shellcheck']
\}
" Set language specific fixers
let g:ale_fixers = {
\	'typescript': ['tslint']
\}

" /Ale/Linter settings
""""""""""""""""""""
" Airline settings "
""""""""""""""""""""
"let g:airline_solarized_bg='dark'
let g:airline_theme='wombat'
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

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

Plug 'junegunn/fzf.vim', {'do':'install --all'}

Plug 'terryma/vim-multiple-cursors'


" Multiple Plug commands can be written in a single line using | separators
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'scrooloose/nerdcommenter'
Plug 'Xuyuanp/nerdtree-git-plugin'
" Using a non-master branch
"Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin options
Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Themes
"Plug 'arcticicestudio/nord-vim'
"Plug 'icymind/NeoSolarized'
"Plug 'mhartington/oceanic-next'
" /Themes

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

"Plug 'plasticboy/vim-markdown'

Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'

Plug 'chr4/nginx.vim' " nginx.conf 

" Initialize plugin system
call plug#end()

" fix backspace
set backspace=indent,eol,start

"filetype plugin indent on
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

" /Tab length

