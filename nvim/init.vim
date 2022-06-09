call plug#begin()

Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
"Plug 'prabirshrestha/asyncomplete.vim'
"Plug 'prabirshrestha/asyncomplete-lsp.vim'
"Plug 'Shougo/ddc.vim'
"Plug 'shun/ddc-vim-lsp'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" "terminal"
Plug 'voldikss/vim-floaterm'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" "theme"
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/seoul256.vim'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" "nerdtree menue"
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'MarSoft/nerdtree-grep-plugin'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" "ranger"
Plug 'rbgrouleff/bclose.vim'
Plug 'francoiscabrol/ranger.vim'

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" "lsp"
"Plug 'neoclide/coc.nvim', {'branch': 'release' }

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" "python"
Plug 'alfredodeza/pytest.vim'
Plug 'neomake/neomake'
Plug 'SkyLeach/pudb.vim'
Plug 'cespare/vim-toml'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" "ts"
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" "javascript"
Plug 'pangloss/vim-javascript'

call plug#end()

let mapleader=";"
set noswapfile
nnoremap <leader>O :only<CR>

if executable('pyls')
    " pip install python-language-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'allowlist': ['python'],
        \ })
endif

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> <leader>d <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
    
    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" "terminal"
"""""""""""""""""""""""""""""""""""""""" "voldikss/vim-floaterm"
nnoremap <leader>fr :FloatermNew --height=0.6 --width=0.4 --wintype=float --name=floaterm1 --position=topleft --autoclose=2 ranger --cmd="cd ~"<CR>
" Configuration example
let g:floaterm_keymap_new    = '<Space>fn'
let g:floaterm_keymap_prev   = '<Space>fp'
let g:floaterm_keymap_next   = '<Space>fk'
let g:floaterm_keymap_toggle = '<Space>ff'
let g:floaterm_keymap_kill   = '<Space>fc'
nnoremap <leader>ft :FloatermNew --wintype=float --name=tig --autoclose=2 tig<CR>
nnoremap <leader>gx :FloatermNew! --wintype=float --name=gfix --autoclose=2 gfix<CR>
nnoremap <leader>gc :FloatermNew! --wintype=float --name=gfix --autoclose=2 gc<CR>
nnoremap <leader>wfw :FloatermNew! --wintype=float --name=gfix --autoclose=2 wfw<CR>
nnoremap <leader>wfl :FloatermNew! --wintype=float --name=gfix --autoclose=2 wfl<CR>
nnoremap <leader>ard :FloatermNew! --wintype=float --height=0.3 --name=gfix --autoclose=2 --position=bottomright deploy-head<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" "CICD"

function! DeployCurrentRevision()
  let env = input("Please select environment: ")
  let gitBranch=trim(system("git rev-parse --abbrev-ref HEAD"))
  let gitCommit=trim(system("git rev-parse HEAD | cut -c 1-8 "))
  let repo=trim(system("basename $PWD"))
  let tag = join([gitBranch, gitCommit], '-')
  echo "argo submit --from wftmpl/deploy-".repo." -p env-name=".env." -p tag=".tag
  let result = confirm("Sure?")
  call system("argo submit --from wftmpl/deploy-".repo." -p env-name=".env." -p tag=".tag)
  execute :FloatermNew! --wintype=float --name=gfix --autoclose=2 wfw<CR>
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" "theme" 
:syntax on
:set relativenumber
:set number
highlight Cursor guifg=white guibg=black
highlight iCursor guifg=white guibg=steelblue
set guicursor=n-v-c:block-Cursor
set guicursor+=i:ver100-iCursor
set guicursor+=n-v-c:blinkon0
set guicursor+=i:blinkwait10

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

" easier clipboard
noremap <Leader>y "*y
noremap <Leader>p "*p

noremap <Leader>w <C-w>200><C-w>200+
noremap <Leader>fj :%!jq .<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" "ranger"
let g:ranger_map_keys = 0
map rr :Ranger<CR>

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
"""""""""""""""""""""""""""""""""""""""" "airblade/vim-gitgutter"
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)

"""""""""""""""""""""""""""""""""""""""" "APZelos/blamer.nvim"
let g:blamer_enabled = 0
let g:blamer_delay = 200
let g:blamer_template = '<committer>, <committer-time> • <commit-short> • <summary>'
let g:blamer_prefix = ' <<< '
map <C-b> :BlamerToggle <CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" "fzf"
let $FZF_DEFAULT_COMMAND = 'Ag -g ""'
map <Leader>f :Files<CR>
map <Leader>T :Ag<CR>
map <Leader>t :Ag<space>
map <Leader>wt yiw:Ag<space><C-r>0<CR>
nnoremap <silent> <expr> <Leader><Leader> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":FZF\<cr>"
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--info=inline', '--preview', '~/.vim/plugged/fzf.vim/bin/preview.sh {}']}, <bang>0)

"""""""""""""""""""""""""""""""""""""""" "mileszs/ack.vim"
"let g:ackprg = 'rg --nogroup --nocolor --column'
let g:ackprg = 'ag --nogroup --nocolor --column'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" "python"
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
let $PY_CONFIG= "/Users/yotamazriel/config/engine/config.yaml"

"""""""""""""""""""""""""""""""""""""""" "neomake/neomake"
let g:neomake_python_pylint_maker = {
  \ 'args': [
  \ '-d', 'C0103, C0111, C0301, R0903',
  \ '-f', 'text',
  \ '--msg-template="{path}:{line}:{column}:{C}: [{symbol}] {msg}"',
  \ '-r', 'n'
  \ ],
  \ 'errorformat':
  \ '%A%f:%l:%c:%t: %m,' .
  \ '%A%f:%l: %m,' .
  \ '%A%f:(%l): %m,' .
  \ '%-Z%p^%.%#,' .
  \ '%-G%.%#',
  \ }

let g:neomake_python_enabled_makers = ['flake8', 'pylint']
call neomake#configure#automake('nrwi', 50)
map <leader>ll :lopen <CR>
map <leader>ln :lnext <CR>
map <leader>lp :lprev <CR>

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

" DiffView
function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" "javascript"
" Enables syntax highlighting for JSDocs
let g:javascript_plugin_jsdoc = 1

augroup javascript_folding
    au!
    au FileType javascript setlocal foldmethod=syntax
augroup END
