"""""""""""""""""""
" NeoVim Settings "
"""""""""""""""""""

" vimwiki settings

set nocompatible
filetype plugin on
syntax on
let g:vimwiki_list = [{'path':'~/vimwiki/',
					 \ 'syntax': 'markdown', 'ext':'.md'}]

" /vimwiki settings

" theme settings
set termguicolors
    " Nord "
	let g:nord_italic = 1
	let g:nord_italic_comments = 1
	let g:nord_comment_brightness = 15
	colorscheme nord
    " NeoSolarized
    " set background=dark
    " colorscheme NeoSolarized
	" Oceanic-next "
	" colorscheme OceanicNext
	" let g:oceanic_next_terminal_bold = 1
	" let g:oceanic_next_terminal_italic = 1
	" "
" Always show status bar    
set laststatus=2
" /theme settings

let g:plug_timeout = 200


" Ale/Linter settings

let g:ale_typescript_tslint_config_path = '/home/petter/tslint.json'
let g:ale_typescript_tslint_use_global = 1
" Set language specific linters
let g:ale_linters = {
\	'javascript': ['eslint'],
\	'typescript': ['tslint']
\}
" Set language specific fixers
let g:ale_fixers = {
\	'typescript': ['tslint']
\}

" /Ale/Linter settings
""""""""""""""""""""
" Airline settings "
""""""""""""""""""""
let g:airline_solarized_bg='dark'
let g:airline_theme='nord'
let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1
"""""""""""""""""""""
" /Airline settings "
"""""""""""""""""""""		
" YCM settings
let g:ycm_min_num_of_chars_for_comepletion = 2

highlight Comment cterm=italic

set directory=$HOME/.vim/swap//

" Tab length
filetype plugin indent on
set autoindent
set noexpandtab
set tabstop=4
set shiftwidth=4

" /Tab length

" NERDTree
" Autoclose vim if NERDTree is only open window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" /NERDTree

" swap escape and caps-lock when entering vim
"au VimEnter * !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'
"au VimEnter * !xmodmap -e 'clear Lock' -e 'keycode 0x9 = Caps_Lock'
" rebind escape and caps-lock when leaving vim 
"au VimLeave * !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Caps_Lock'
"au VimLeave * !xmodmap -e 'clear Lock' -e 'keycode 0x9 = Escape'
"
let mapleader = ","
"line Number
set nu
""""""""""""
" markdown "
""""""""""""
let vim_markdown_preview_hotkey='<C-z>'
let vim_markdown_preview_browser='Firefox Developer Edition'
let g:markdown_composer_browser='firefox-developer-edition'
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
Plug 'Xuyuanp/nerdtree-git-plugin'
" Using a non-master branch
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin options
Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Themes
Plug 'arcticicestudio/nord-vim'
Plug 'icymind/NeoSolarized'
Plug 'mhartington/oceanic-next'
" /Themes

" Vim-airline for powerline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Linter
Plug 'w0rp/ale'
Plug 'palantir/tslint'
" Autocomplete / complete framework
Plug 'valloric/youcompleteme'

" Typescript

Plug 'leafgarland/typescript-vim'

" Gitgutter
Plug 'airblade/vim-gitgutter'

" Git tool
Plug 'tpope/vim-fugitive'

" AutoPair
Plug 'jiangmiao/auto-pairs'

Plug 'vimwiki/vimwiki'

Plug 'plasticboy/vim-markdown'

function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    if has('nvim')
      !cargo build --release
    else
      !cargo build --release --no-default-features --features json-rpc
    endif
  endif
endfunction

Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }
" Initialize plugin system
call plug#end()


