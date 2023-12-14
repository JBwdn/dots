" NVIM Config - Jake 2023-04
" ========================

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

" Coc extensions:
let g:coc_global_extensions = [
		\ 'coc-json',
		\ 'coc-prettier',
		\ 'coc-yaml',
		\ 'coc-toml',
		\ 'coc-rust-analyzer',
		\ 'coc-pyright',
		\ 'coc-markdownlint',
		\ 'coc-json',
		\ 'coc-snippets',
		\ ]

" Plugins
call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install() } }
Plug 'preservim/nerdtree'
Plug 'morhetz/gruvbox'
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-commentary'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'christoomey/vim-tmux-navigator'
Plug 'jiangmiao/auto-pairs'
Plug 'luochen1990/rainbow'
Plug 'tpope/vim-dispatch'
Plug 'radenling/vim-dispatch-neovim'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'tmhedberg/SimpylFold'
Plug 'honza/vim-snippets'
Plug 'ludovicchabant/vim-gutentags'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'airblade/vim-gitgutter'
" Keep an eye on this until autocomplete is fixed:
" Plug 'sourcegraph/sg.nvim', { 'do': 'nvim -l build/init.lua' }
call plug#end()

" Reload config:
command! ReloadConfig :source $MYVIMRC
command! RC :ReloadConfig

" Run pre-commit:
command! PreCommit :Dispatch pre-commit run --all-files
command! PC :PreCommit

" Recursive ctag lookup:
set tags+=./tags;/

" Escape terminal:
tnoremap <Esc> <C-\><C-n>

" Python:
let python3_host_prog='/home/jb/.miniconda/envs/nvim_env/bin/python3'

autocmd FileType python map <buffer> <F7> :w<CR>:exec 'Dispatch python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F7> <esc>:w<CR>:exec 'Dispatch python3' shellescape(@%, 1)<CR>
autocmd FileType python map <buffer> <F8> :w<CR>:exec 'Dispatch! black %; isort %'<CR>q
autocmd FileType python imap <buffer> <F8> <esc>:w<CR>:exec 'Dispatch! black %; isort %'<CR>q
autocmd FileType python map <buffer> <F9> :w<CR>:exec 'Dispatch pyright' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec 'Dispatch pyright' shellescape(@%, 1)<CR>
autocmd FileType python map <buffer> <F10> :w<CR>:exec 'Dispatch pylint' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F10> <esc>:w<CR>:exec 'Dispatch pylint' shellescape(@%, 1)<CR>

" iPython REPL:
command! IPYREPL :vsplit | wincmd l | terminal ipython
noremap <F5> :IPYREPL<CR>
" Send visual mode selection to repl
autocmd FileType python vmap <CR> y<C-w>wpa<CR><C-\><C-n><C-w>p

" Julia (TO BE TESTED FULLY)
autocmd FileType julia map <buffer> <F7> :w<CR>:exec 'Dispatch julia' shellescape(@%, 1)<CR>
autocmd FileType julia imap <buffer> <F7> <esc>:w<CR>:exec 'Dispatch julia' shellescape(@%, 1)<CR>
autocmd FileType julia map <buffer> <F8> :w<CR>:exec 'Dispatch! julia-format' shellescape(@%, 1)<CR>
autocmd FileType julia imap <buffer> <F8> <esc>:w<CR>:exec 'Dispatch! julia-format' shellescape(@%, 1)<CR>
autocmd FileType julia map <buffer> <F9> :w<CR>:exec 'Dispatch julia -e "using Revise; Revise.includet(\"' . shellescape(@%, 1) . '\")"'<CR>
autocmd FileType julia imap <buffer> <F9> <esc>:w<CR>:exec 'Dispatch julia -e "using Revise; Revise.includet(\"' . shellescape(@%, 1) . '\")"'<CR>
autocmd FileType julia map <buffer> <F10> :w<CR>:exec 'Dispatch julia -e "using Pkg; Pkg.test(\"' . shellescape(@%, 1) . '\")"'<CR>
autocmd FileType julia imap <buffer> <F10> <esc>:w<CR>:exec 'Dispatch julia -e "using Pkg; Pkg.test(\"' . shellescape(@%, 1) . '\")"'<CR>

" Julia REPL:
command! JULIAREPL :vsplit | wincmd l | terminal julia
autocmd FileType julia map <F5> :JULIAREPL<CR>
" Send visual mode selection to repl
autocmd FileType julia vmap <CR> y<C-w>wpa<CR><C-\><C-n><C-w>p

" Rust:
autocmd FileType rust map <buffer> <F7> :w<CR>:exec '!cargo run'<CR>
autocmd FileType rust imap <buffer> <F7> <esc>:w<CR>:exec '!cargo run'<CR>
autocmd FileType rust map <buffer> <F8> :w<CR>:exec '!cargo fmt'<CR>
autocmd FileType rust imap <buffer> <F8> <esc>:w<CR>:exec '!cargo fmt'<CR>
autocmd FileType rust map <buffer> <F9> :w<CR>:exec '!cargo clippy'<CR>
autocmd FileType rust imap <buffer> <F9> <esc>:w<CR>:exec '!cargo clippy'<CR>
autocmd FileType rust map <buffer> <F10> :w<CR>:exec '!cargo check'<CR>
autocmd FileType rust imap <buffer> <F10> <esc>:w<CR>:exec '!cargo check'<CR>

" Bash:
autocmd FileType sh map <buffer> <F7> :w<CR>:exec 'Dispatch bash' shellescape(@%, 1)<CR>
autocmd FileType sh imap <buffer> <F7> <esc>:w<CR>:exec 'Dispatch bash' shellescape(@%, 1)<CR>
autocmd FileType sh map <buffer> <F8> :w<CR>:exec 'Dispatch! beautysh' shellescape(@%, 1)<CR>
autocmd FileType sh imap <buffer> <F8> <esc>:w<CR>:exec 'Dispatch! beautysh' shellescape(@%, 1)<CR>

" Settings
" ========

" Remap moving between windows
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

" Map to move lines/selections up and down
nno <silent> <A-j> :m .+1<CR>==
nno <silent> <A-k> :m .-2<CR>==
vno <silent> <A-j> :m '>+1<CR>gv=gv
vno <silent> <A-k> :m '<-2<CR>gv=gv

" Tab rendering
set tabstop=2
set autoindent

" Editor
set number
set hlsearch
syntax on
set listchars=eol:⤶,tab:\|·,trail:~,space:·
set list

" 2 space tabs for markdown
autocmd FileType markdown setlocal tabstop=2 shiftwidth=2 expandtab

" Timestamp insert shortcut
map <leader>D :put =strftime('%a %Y_%m_%d %H:%M:%S')<CR>

" Spellcheck in markdown and git commit:
autocmd FileType markdown setlocal spell spelllang=en_gb
autocmd FileType gitcommit setlocal spell spelllang=en_gb
autocmd FileType markdown setlocal complete+=kspell
autocmd FileType gitcommit setlocal complete+=kspell

" Coc:
" Tab to cycle coc suggestions, accept by continuing to type:
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Use shift-K to lookup docs:
nnoremap <silent> K :call ShowDocumentation()<CR>
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Copilot:
let g:copilot_filetypes = {'*': v:true}
imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true
let g:copilot_no_enter_map = v:true

" Nerdtree:
map <F2> :NERDTreeToggle<CR>

let NERDTreeShowHidden=1
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1
let NERDTreeWinSize=25
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''
let NERDTreeWinPos=1

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Colourscheme:
let g:gruvbox_italic=1
colorscheme gruvbox
let g:gruvbox_contrast_dark='hard'
let g:airline_theme='base16_gruvbox_dark_hard'

" Folding:
set foldlevelstart=1
set foldmethod=syntax
let g:SimpylFold_docstring_preview=1
let g:SimpylFold_fold_docstring=1
let g:SimpylFold_fold_import=0

" Coc Snippets:
imap <C-l> <Plug>(coc-snippets-expand)
let g:coc_snippet_next = '<tab>'
let g:coc_snippet_prev = '<s-tab>'

" Telescope (fuzzy finder):
nnoremap ff <cmd>Telescope find_files<cr>
nnoremap fg <cmd>Telescope live_grep<cr>
nnoremap ft <cmd>Telescope tags<cr>
nnoremap fb <cmd>Telescope buffers<cr>
nnoremap fh <cmd>Telescope help_tags<cr>
