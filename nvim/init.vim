call plug#begin()
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" "theme"
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/seoul256.vim'
"Plug 'elzr/vim-json'

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
Plug 'machakann/vim-highlightedyank'
Plug 'tpope/vim-surround'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" "git"
Plug 'https://github.com/junegunn/vim-github-dashboard.git'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'APZelos/blamer.nvim'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" "fzf"
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" "python"
Plug 'davidhalter/jedi-vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'
Plug 'neomake/neomake'
Plug 'SkyLeach/pudb.vim'
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}

call plug#end()

let mapleader=";"
set noswapfile
nnoremap <leader>O :only<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" "theme" 
:syntax on
:set relativenumber
:set number
"""""""""""""""""""""""""""""""""""""""" "vim-airline/vim-airline-themes"
 " This is disabled by default; add the following to your vimrc to enable the extension:
let g:airline#extensions#tabline#enabled = 1

"Separators can be configured independently for the tabline, so here is how you can define "straight" tabs:
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

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

map <C-n> ciw<C-r>0<ESC>

" autoload changed files
set autoread
au FocusGained,BufEnter * checktime
set updatetime=100

" diff
nnoremap <C-d> :windo diffthis<CR>
nnoremap <C-s> :diffoff!<CR>

" easier clipboard
noremap <Leader>y "*y
noremap <Leader>p "*p

noremap <Leader>w <C-w>200><C-w>200+
noremap <Leader>fj :%!jq .<CR>

"""""""""""""""""""""""""""""""""""""""" "machakann/vim-highlightedyankAA"
" set highlight duration time to 1000 ms, i.e., 1 second
let g:highlightedyank_highlight_duration = 1000
hi HighlightedyankRegion cterm=reverse gui=reverse

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" "nerdtree menue"
map <Leader>o :NERDTreeToggle<CR>
nmap <Leader>H :NERDTreeFind<CR>

" close nerdtree on file open
let NERDTreeQuitOnOpen = 1
" make nerdtree prettier
let NERDTreeMinimalUI = 1
" show hidden files (dotfiles)
let NERDTreeShowHidden = 1
" open a NERDTree automatically when vim starts up if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"""""""""""""""""""""""""""""""""""""""" "Xuyuanp/nerdtree-git-plugin"
"let g:NERDTreeGitStatusShowIgnored = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" "git"
"""""""""""""""""""""""""""""""""""""""" "APZelos/blamer.nvim"
let g:blamer_enabled = 1
let g:blamer_delay = 500
let g:blamer_template = '<committer>, <committer-time> • <commit-short> • <summary>'
let g:blamer_prefix = ' <<< '

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" "fzf"
let $FZF_DEFAULT_COMMAND = 'Ag -g ""'
map <Leader>f :Files<CR>
map <Leader>T :Ag<CR>
map <Leader>t :Ag<space>
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
"let g:deoplete#auto_complete_delay = 100

"""""""""""""""""""""""""""""""""""""""" "numirias/semshi"
nmap <silent> <leader>rr :Semshi rename<CR>

nmap <silent> <Tab> :Semshi goto name next<CR>
nmap <silent> <S-Tab> :Semshi goto name prev<CR>

nmap <silent> <leader>gc :Semshi goto class next<CR>
nmap <silent> <leader>gC :Semshi goto class prev<CR>

nmap <silent> <leader>gf :Semshi goto function next<CR>
nmap <silent> <leader>gF :Semshi goto function prev<CR>

nmap <silent> <leader>gu :Semshi goto unresolved first<CR>
nmap <silent> <leader>gp :Semshi goto parameterUnused first<CR>

nmap <silent> <leader>ee :Semshi error<CR>
nmap <silent> <leader>ge :Semshi goto error<CR>

"""""""""""""""""""""""""""""""""""""""" "SkyLeach/pudb.vim"
" Nvim python environment settings
if has('nvim')
  let g:python_host_prog='/Users/yotamazriel/.pyenv/shims/python'
  let g:python3_host_prog='/Users/yotamazriel/.pyenv/shims/python'
  " set the virtual env python used to launch the debugger
  let g:pudb_python=':h nvim-python/Users/yotamazriel/.pyenv/shims/python'
  " set the entry point (script) to use for pudb
  let g:pudb_entry_point='~/src/poweruser_tools/test/test_templates.py'
  " Unicode symbols work fine (nvim, iterm, tmux, nyovim tested)
  let g:pudb_breakpoint_symbol='☠'
endif

nnoremap <leader>S :PUDBSetEntrypoint <CR>
nnoremap <leader>B :PUDBToggleBreakPoint <CR>
"nnoremap <leader>T :let g:pudb_entry_point='test' <CR>
nnoremap <leader>D :PUDBLaunchDebuggerTab <CR>
let $PY_CONFIG= "/Users/yotamazriel/Documents/config.yaml"

"""""""""""""""""""""""""""""""""""""""" "davidhalter/jedi-vim"
" disable autocompletion, cause we use deoplete for completion
let g:jedi#completions_enabled = 1
" open the go-to function in split, not another buffer
"let g:jedi#use_tabs_not_buffers = 1
let g:jedi#use_splits_not_buffers = "left"
let g:jedi#show_call_signatures = "1"

let g:jedi#goto_command = "<leader>d"
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_stubs_command = "<leader>s"
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>r"

"""""""""""""""""""""""""""""""""""""""" "neomake/neomake"
"let g:neomake_python_enabled_makers = ['pylint']
"call neomake#configure#automake('nrwi', 500)
function! GotoJump()
  jumps
  let j = input("Please select your jump: ")
  if j != ''
    let pattern = '\v\c^\+'
    if j =~ pattern
      let j = substitute(j, pattern, '', 'g')
      execute "normal " . j . "\<c-i>"
    else
      execute "normal " . j . "\<c-o>"
    endif
  endif
endfunction
