


" Tab length:

filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab

"line Number
set nu

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Multiple Plug commands can be written in a single line using | separators
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using a non-master branch
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin options
Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Nord theme vim
Plug 'arcticicestudio/nord-vim'

" Vim-airline for powerline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Linter
Plug 'w0rp/ale'

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

" Initialize plugin system
call plug#end()

set t_Co=256

let g:plug_timeout = 200

let g:Powerline_symbols = "fancy"
let g:airline_powerline_fonts = 1

set laststatus=2

" YCM settings"
let g:ycm_min_num_of_chars_for_comepletion = 2

" Theme:

colorscheme nord

let g:nord_italic_comments = 1
highlight Comment cterm=italic
