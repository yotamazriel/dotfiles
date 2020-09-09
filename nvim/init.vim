call plug#begin()
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" "theme"
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/seoul256.vim'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" "nerdtree menue"
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'MarSoft/nerdtree-grep-plugin'
"Plug 'preervim/nerdtree'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" "editing"
" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/vim-easy-align'
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
" Multiple Plug commands can be written in a single line using | separators
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
" Plug 'wsdjeg/FlyGrep.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdcommenter'
Plug 'sbdchd/neoformat'
" Plug 'terryma/vim-multiple-cursors'
Plug 'tmhedberg/SimpylFold'
Plug 'machakann/vim-highlightedyank'
Plug 'tpope/vim-surround'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" "git"
Plug 'https://github.com/junegunn/vim-github-dashboard.git'
Plug 'airblade/vim-gitgutter'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" "fzf"
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" "python"
Plug 'davidhalter/jedi-vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'
Plug 'neomake/neomake'

call plug#end()
let mapleader="\\"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" "theme" 
:syntax on
:set relativenumber
:set number

"""""""""""""""""""""""""""""""""""""""" "sjunegunn/seoul256"
"   Range:   233 (darkest) ~ 239 (lightest)
"   Default: 237
let g:seoul256_background = 235
colo seoul256

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" "editing"
" easier split nav
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" tab navigation
nnoremap <C-[> :tabp<CR>
nnoremap <C-]> :tabn<CR>

:map <C-j> cw<C-r>0<ESC>

" diff
nnoremap <C-d> :windo diffthis<CR>
nnoremap <C-s> :diffoff!<CR>
"""""""""""""""""""""""""""""""""""""""" "machakann/vim-highlightedyankAA"
" set highlight duration time to 1000 ms, i.e., 1 second
let g:highlightedyank_highlight_duration = 1000
hi HighlightedyankRegion cterm=reverse gui=reverse

"""""""""""""""""""""""""""""""""""""""" "tmhedberg/SimpylFold"
let g:SimpylFold_docstring_preview = 0
let b:SimpylFold_fold_docstring = 0
let g:SimpylFold_fold_docstring = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" "nerdtree menue"
map <C-o> :NERDTreeToggle<CR>
" close nerdtree on file open
let NERDTreeQuitOnOpen = 1
" make nerdtree prettier
let NERDTreeMinimalUI = 1
" show hidden files (dotfiles)
let NERDTreeShowHidden=1
" open a NERDTree automatically when vim starts up if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"""""""""""""""""""""""""""""""""""""""" "Xuyuanp/nerdtree-git-plugin"
let g:NERDTreeGitStatusShowIgnored = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" "fzf"
let $FZF_DEFAULT_COMMAND = 'Ag -g ""'
map <Leader>f :Files<CR>
map <Leader>t :Ag<CR>
nnoremap <silent> <expr> <Leader><Leader> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":FZF\<cr>"
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--info=inline', '--preview', '~/.vim/plugged/fzf.vim/bin/preview.sh {}']}, <bang>0)

"""""""""""""""""""""""""""""""""""""""" "mileszs/ack.vim"
"let g:ackprg = 'rg --nogroup --nocolor --column'
let g:ackprg = 'ag --nogroup --nocolor --column'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" "python"
"""""""""""""""""""""""""""""""""""""""" "deoplete.nvim"
let g:deoplete#enable_at_startup = 1
" inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
set splitbelow
let g:airline_theme='<theme>' " <theme> is a valid theme name
" Enable alignmentdavidhalter/jedi-vimdavidhalter/jedi-vimdavidhalter/jedi-vim
let g:neoformat_basic_format_align = 1

" Enable tab to spaces conversion
let g:neoformat_basic_format_retab = 1

" Enable trimmming of trailing whitespace
let g:neoformat_basic_format_trim = 1

"""""""""""""""""""""""""""""""""""""""" "davidhalter/jedi-vim"
" disable autocompletion, cause we use deoplete for completion
let g:jedi#completions_enabled = 0
" open the go-to function in split, not another buffer
let g:jedi#use_splits_not_buffers = "right"

let g:jedi#goto_command = "<leader>d"
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_stubs_command = "<leader>s"
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>r"
"""""""""""""""""""""""""""""""""""""""" "neomake/neomake"
let g:neomake_python_enabled_makers = ['pylint']
call neomake#configure#automake('nrwi', 500)

