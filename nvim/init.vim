call plug#begin()
" terraform integration
Plug 'hashivim/vim-terraform'
" Specify a directory for plugins For Neovim: stdpath('data') . '/plugged' Avoid using standard Vim directory names like 'plugin' call plug#begin('~/.vim/plugged')
" theme
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'MarSoft/nerdtree-grep-plugin'

" Make sure you use single quotes
" auto completion
Plug 'neoclide/coc.nvim', {'branch': 'release' }

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'
" fzf
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" editorconfig
Plug 'editorconfig/editorconfig-vim'


Plug 'junegunn/seoul256.vim'
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

" Unmanaged plugin (manually installed and updated)
Plug '~/my-prototype-plugin'

" vim-visual-multi
" Plug 'mg979/vim-visual-multi', {'branch': 'master'}
" nerdtree
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'tpope/vim-commentary'

" git integration
Plug 'airblade/vim-gitgutter'

" Initialize plugin system
call plug#end()

" seoul256 (dark):
"   Range:   233 (darkest) ~ 239 (lightest)
"   Default: 237
let g:seoul256_background = 235
colo seoul256

nnoremap <silent> <expr> <Leader><Leader> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":FZF\<cr>"


:syntax on
:set relativenumber
map <C-o> :NERDTreeToggle<CR>
" colorscheme gruvbox
" close nerdtree on file open
let NERDTreeQuitOnOpen = 1
" autocmd vimenter * NERDTree
" autocmd FileType apache setlocal commentstring=#\ %s
map <C-/>:vim-commentary<CR>
" make nerdtree prettier
let NERDTreeMinimalUI = 1
let NERDTreeShowHidden=1

autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
:set number
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" easier split nav
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" tab navigation
nnoremap <C-[> :tabp<CR>
nnoremap <C-]> :tabn<CR>
let mapleader="\\"
runtime coc.vim
" diff
nnoremap <C-d> :windo diffthis<CR>
nnoremap <C-s> :diffoff!<CR>
" fzf
let $FZF_DEFAULT_COMMAND = 'ag -g ""'
map <Leader>f :Files<CR>
map <Leader>t :Ag<CR>

