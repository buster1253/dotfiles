"""""""""""""""""""
"   Vim Settings  "
"""""""""""""""""""

source $HOME/.config/nvim/configs/functions.vim

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
Plug 'junegunn/fzf.vim'                " some fzf commands for vim
Plug 'scrooloose/nerdcommenter'        " quick commenting
Plug 'airblade/vim-gitgutter'          " git line markings
Plug 'tpope/vim-fugitive'              " git integration
Plug 'vimwiki/vimwiki'                 " simple note taking
Plug 'vim-pandoc/vim-pandoc'           " markdown pandoc
Plug 'vim-pandoc/vim-pandoc-syntax'    " markdown pandoc syntax highlighting
Plug 'dhruvasagar/vim-table-mode'      " markdown tables made EZ
Plug 'christoomey/vim-tmux-navigator'  " tmux integration
Plug 'gsiano/vmux-clipboard'           " yank to tmux clipboard
Plug 'edkolev/tmuxline.vim'
Plug 'majutsushi/tagbar'
Plug 'raghur/mermaid-filter'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'junegunn/vim-easy-align' " languages
Plug 'sheerun/vim-polyglot'
Plug 'chr4/nginx.vim'                  " nginx.conf
Plug 'rust-lang/rust.vim'              " rust tools
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'stephpy/vim-yaml'
Plug 'morhetz/gruvbox'                 " gruvbox theme
Plug 'itchyny/lightline.vim'
Plug 'mattn/emmet-vim'
Plug 'sainnhe/gruvbox-material'
Plug 'liuchengxu/vista.vim'
Plug 'mzlogin/vim-markdown-toc'
Plug 'Kogia-sima/sailfish', {'rtp': 'syntax/vim'}
Plug 'hrsh7th/nvim-compe'
Plug 'lervag/vimtex'
Plug 'lambdalisue/suda.vim'


Plug 'fatih/vim-go'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Collection of common configurations for the Nvim LSP client
Plug 'neovim/nvim-lspconfig'
" Completion framework
Plug 'hrsh7th/nvim-cmp'
" LSP completion source for nvim-cmp
Plug 'hrsh7th/cmp-nvim-lsp'
" Snippet completion source for nvim-cmp
Plug 'hrsh7th/cmp-vsnip'
" Other usefull completion sources
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'
" Snippet engine
Plug 'hrsh7th/vim-vsnip'
" To enable more of the features of rust-analyzer, such as inlay hints and more!
Plug 'simrat39/rust-tools.nvim'


Plug 'nvim-telescope/telescope.nvim'



call plug#end()
" }}}


" set filetype for 'config' files
au BufRead config set filetype=config

" get some folding going
augroup filetype_vim
	autocmd!
	autocmd FileType vim setlocal foldmethod=marker
augroup end

augroup tt2
	autocmd!
	au BufRead,BufNewFile *.tt2 set filetype=html
augroup end

augroup service
	autocmd!
	autocmd FileType *.service setlocal filetype=systemd
augroup end

augroup c_header
	autocmd!
	autocmd BufEnter,BufWrite *.h setlocal filetype=c
augroup end
let g:c_syntax_for_h = 1

autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 200)


" alternatively start using ~/.vim/ftdetect/ft.vim
augroup nginx_conf
	autocmd!
	autocmd FileType nginx call Nginx_abbr()
augroup end

au Syntax capnp runtime! syntax/capnp.vim
au BufRead,BufNewFile *.capnp set filetype=capnp

augroup markdown
	au!
	au FileType,BufEnter,FileReadPost vimwiki,*.md set filetype=mdown
augroup end

" Theme {{{
syntax enable
filetype plugin on
set nocompatible
set termguicolors

" Vista tagbar
function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction

"set background=dark
colorscheme gruvbox
let g:lightline = {
	\ 'colorscheme': 'gruvbox',
	\ 'active': {
	\   'left': [ [ 'mode', 'paste' ],
	\             [ 'readonly', 'filename', 'modified', 'gitbranch', 'method' ] ]
	\ },
	\ 'component_function': {
	\		'gitbranch': 'FugitiveHead',
	\		'method': 'NearestMethodOrFunction'
	\ },
\ }
let g:tmuxline_powerline_separators = 0
let g:tmuxline_preset = 'full'
let g:airline#extensions#tmuxline#enabled = 0
let g:tmuxline_theme = {
	\   'a'    : [ 121, 239 ],
    \   'b'    : [ 121, 240 ],
    \   'c'    : [ 121, 236 ],
    \   'x'    : [ 121, 236 ],
    \   'y'    : [ 121, 239 ],
    \   'z'    : [ 121, 103 ],
    \   'win'  : [ 121, 236 ],
    \   'cwin' : [ 121, 103 ],
    \   'bg'   : [ 121, 236 ],
\ }

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

set completeopt=menuone,noinsert,noselect
"set completeopt=menuone,noselect
set shortmess+=c
set autoindent
set backspace=indent,eol,start

set hlsearch     " hightlight search text
set incsearch
" split direction
set splitbelow
set splitright

set clipboard+=unnamed

let g:clipboard = {
            \'name': 'waylandCliboard',
            \ 'copy': {
            \	'+': 'wl-copy -p',
            \	'*': 'wl-copy -p',
            \},
            \ 'paste': {
            \	'+': 'wl-paste -p -n',
            \	'*': 'wl-paste -p -n',
            \},
            \'cache_enabled': 1,
            \}

set wildmenu
set wildmode=longest,list,full
set relativenumber
set number

set showcmd      " show command in bottom bar
set showmatch    " hightlight matching [{()}]"
set scrolloff=3  " keep 3 lines above and below cursor

set timeoutlen=1000 ttimeoutlen=0

set exrc             " source local vimrc files automatically
set secure           " reduce risk from sourcing local vimrc files

set hidden
set updatetime=300
set signcolumn=yes

" Netrw
let g:netrw_banner = 0
let g:netrw_browse_split = 1
let g:netrw_liststyle = 3

"}}}

let g:lsp_cxx_hl_use_text_props = 1

"let g:pandoc#formatting#textwidth = 80
"let g:pandoc#command#autoexec_on_writes = 1
let g:pandoc#command#autoexec_command = 'Pandoc! -F mermaid-filter pdf'
let g:pandoc#syntax#codeblocks#embeds#langs = ['lua', 'c', 'nginx', 'dot', 'typescript', 'php', 'sql', 'javascript', 'rust', 'json', 'go']

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

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

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

let g:termdebug_wide=1

" helpful lines {{{
set textwidth=100
let &colorcolumn=join(range(101,101),',')
set cursorline cursorcolumn
hi Comment cterm=italic

" }}}

" Display incorrect space and tab usage {{{
nnoremap <Leader>l :set list! listchars=tab:│\ ,trail:· <CR>
"nnoremap <Leader>l :set list! listchars=trail:· <CR>
"set list! listchars=tab:│\ ,trail:·
hi link ExtraWhitespace DiffDelete
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
" }}}

" keybindings {{{

nnoremap N Nzz
nnoremap n nzz

nnoremap - ddkP
nnoremap _ ddp

nnoremap <leader>t :Vista!!<cr>

" easy source and edit config
"nnoremap <leader>ev :vsplit $MYVIMRC<cr>
"nnoremap <leader>sv :source $MYVIMRC<cr>

" lazygit toggle
"nnoremap <silent> <Leader>lg :call ToggleLazyGit()<CR>

nnoremap <leader>b :Buffers<CR>

" term mode
tnoremap <C-e> <C-\><C-n>

" unmap ex-mode
nmap Q  <NOP>
nmap gQ <NOP>

" synctex
function! Synctex()
	 let vimura_param = " --synctex-forward " . line('.') . ":" . col('.') . ":" . expand('%:p') . " " . substitute(expand('%:p'),"tex$","pdf", "")
    if has('nvim')
        call jobstart("vimura neovim" . vimura_param)
    else
        exe "silent !vimura vim" . vimura_param . "&"
    endif
    redraw!
endfunction
nmap <C-enter> :call Synctex()<cr>

"}}}

let g:mkdp_auto_close = 1
let g:mkdp_auto_start = 0
let g:mkdp_open_to_world = 0
let g:mkdp_browser = ''
let g:mkdp_port = 8080

map <leader>k <Plug>(Man)

"au Filetype lua setlocal omnifunc=v:lua.vim.lsp.omnifunc
"au BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 1000)

"lua require "lsp"
let g:completion_chain_complete_list = [
    \{'complete_items': ['lsp', 'snippet']},
    \{'mode': '<c-p>'},
    \{'mode': '<c-n>'}
\]

lua require 'cfg'
