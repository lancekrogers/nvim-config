set nocompatible              " required
filetype off                  " required

call plug#begin('~/.nvim/plugged')

Plug 'tmhedberg/SimpylFold'

" Navigation
Plug 'preservim/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'majutsushi/tagbar'

" Notes/Productivity
Plug 'arakkkkk/kanban.nvim'
Plug 'xolox/vim-notes'
" Plug 'vimwiki/vimwiki'

" Other Tools
Plug 'tpope/vim-surround' 
Plug 'preservim/nerdcommenter'
Plug 'Konfekt/FastFold'

Plug 'adelarsq/vim-matchit'
Plug 'lfv89/vim-interestingwords'
Plug 'dhruvasagar/vim-table-mode'

Plug 'xolox/vim-misc'
Plug 'mhinz/vim-crates'
Plug 'simeji/winresizer'
Plug 'lancekrogers/vim-log-highlighting'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'udalov/kotlin-vim'
" Plug 'puremourning/vimspector'
Plug 'mfussenegger/nvim-jdtls'
Plug 'HiPhish/gradle.nvim'
Plug 'mfussenegger/nvim-dap'
Plug 'williamboman/mason.nvim'

" HTML Boilerplate
Plug 'mattn/emmet-vim'

" Plug 'mitchpaulus/autocorrect.vim'

" Hex colors
Plug 'KabbAmine/vCoolor.vim'
Plug 'ap/vim-css-color'
"Plug 'KabbAmine/zeavim.vim'

" Syntax Stuff

" Syntax Highlighing
Plug 'sheerun/vim-polyglot'
Plug 'lepture/vim-jinja'
Plug 'Quramy/vim-js-pretty-template'

" React
"Plug 'mxw/vim-jsx'

" Smart Contracts
Plug 'rnestler/michelson.vim'
Plug 'jacqueswww/vim-vyper'
Plug 'aldur/vim-algorand-teal'

" Git stuff
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'mbbill/undotree'

" Doesn't work on popos desktop for some unknown reason
Plug 'nvie/vim-flake8'

" Javascript
Plug 'moll/vim-node'
Plug 'ternjs/tern_for_vim'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'jparise/vim-graphql'

" Golang
Plug 'fatih/vim-go'

" Color Scemes
Plug 'jnurmine/Zenburn'
Plug 'yassinebridi/vim-purpura'
Plug 'morhetz/gruvbox'
" Plug 'altercation/vim-colors-solarized'
"Plug 'lancekrogers/vim-colorstepper'

" Neovim Specific plugins
Plug 'VonHeikemen/lsp-zero.nvim'
Plug 'brooth/far.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'karb94/neoscroll.nvim'

" search
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'kelly-lin/telescope-ag'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Debugging
Plug 'nvim-lua/plenary.nvim'
Plug 'mfussenegger/nvim-dap'

" See hrsh7th's other plugins for more completion sources!

" To enable more of the features of rust-analyzer, such as inlay hints and more!
Plug 'simrat39/rust-tools.nvim'


" Cmp setup
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

call plug#end()

set clipboard+=unnamedplus

" Enable folding
set foldmethod=indent |
set foldlevel=99

" Show search count
set shortmess-=S

" Enable folding with the spacebar
nnoremap <space> za

au BufNewFile,BufRead *.py,*.vy
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set colorcolumn=80 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |

au BufNewFile,BufRead *.ts,*.js,*.html,*.css,*.jsx,*.sql,*.sol
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2 |
    \ set textwidth=99 |
    \ set colorcolumn=100 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |

au BufNewFile,BufRead *.sh,*.vimrc
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |
set encoding=utf-8

" set fdm=marker

let python_highlight_all=1
syntax on

" Toggle Colorscheme
let g:colorcode = 0

" Default colorscheme
set termguicolors
if $COLORTERM == 'gnome-terminal'
  set t_Co=256
endif
colorscheme gruvbox 
set background=dark
hi Normal ctermbg=none

function! ToggleLightDark()
  if &background=="dark"
      echo "LET THERE BE LIGHT" 
      set background=light
  elseif &background=="light"
      echo "LET THERE BE DARKNESS"
      set background=dark
  endif
endfunction

function! ToggleColorScheme()
  if g:colorcode == 0
    colorscheme gruvbox
    
    let g:colorcode = 1    
    echo "colorscheme set to gruvbox"
  elseif g:colorcode == 1
    colorscheme purpura 
    hi Normal ctermbg=none
    let g:colorcode = 2
  else
    colorscheme koehler 
    echo "colorscheme set to koehler"
    let g:colorcode = 0
  endif
endfunction

let NERDTreeIgnore=['\.pyc$', '\~$', '__pycache__'] "ignore files in NERDTree

" enable line numbers
let NERDTreeShowLineNumbers=1
" make sure relative line numbers are used
autocmd FileType nerdtree setlocal relativenumber

" Terminal settings
tnoremap <Esc> <C-\><C-n>

"autocmd VimEnter * NERDTreeToggle

" let $BASH_ENV = '~/.bash_profile'

set spelllang=en

autocmd BufRead,BufNewFile *.md setlocal spell

" autocmd BufRead,BufNewFile *.txt setlocal spell

autocmd BufRead,BufNewFile *.tex setlocal spell

autocmd BufRead,BufNewFile *.html setlocal spell

let g:javasxript_plugin_flow = 1
let g:jsx_ext_required = 0


autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

" FINDING FILES:

" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**

" Display all matching files when we tab complete
 set wildmenu
" NOW WE CAN:
" -- Hit tab to :find by partial match
" -- Use * to make it fuzzy

" THINGS TO CONSIDER:
"  -- :b lets you autocomplete any open buffer

" Toggle spellchecking
function! ToggleSpellCheck()
  set spell!
    if &spell
        echo "Spellcheck ON"
    else
        echo "Spellcheck OFF"
    endif
endfunction

" Custom toggles
nnoremap <F6> :call ToggleColorScheme()<CR>
nnoremap <F2> :call ToggleLightDark()<CR>

nnoremap <silent> S :call ToggleSpellCheck()<CR>
nnoremap <silent> C :call ToggleYCM()<CR> 

" Toggle NERDTree
nmap <silent><C-n> :NERDTreeToggle<CR>

" Toggle tag bar
nmap <silent><F8> :TagbarToggle<CR>
nmap <silent><F9> :TagbarOpenAutoClose<CR> 
let g:tagbar_show_linenumbers = 1

" Always show statusline
" if !exists('laststatus')
  " set laststatus=2
" endif
" let g:airline#exensions#tabline#enabled = 1

autocmd FileType python nnoremap <LocalLeader>i :!isort %<CR><CR>

" Flake8 Python linting 
" Commented out because it does not work on my popos desktop
autocmd FileType python map <buffer> <F3> :call flake8#Flake8()<CR>
" autocmd BufWritePost *.py call flake8#Flake8()

nnoremap <leader>cn :cnext<CR>
nnoremap <leader>cp :cprev<CR>


" Tern go to definition enable keyboard shortcuts
let g:tern_map_keys=1

"tern show argument hints
let g:tern_show_argument_hints='on_hold'

" Enable mouse support for normal mode
set mouse=nv

" Find cursor easier
set cursorline

set nu
set rnu

" Toggle line number modes
nnoremap <silent><F7> :exec &nu==&rnu? "se nu!" : "se rnu!"<CR> 

" format json 
nnoremap <silent> <leader>jf :%!jq .<CR>

" Search And Grep to Ag Updates

" Silversearcher grep
if executable('ag') 
    " Note we extract the column as well as the file and line number
    set grepprg=ag\ --nogroup\ --nocolor\ --column
    set grepformat=%f:%l:%c%m
endif



let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:gitgutter_grep = 'ag'

nmap <silent> .<RIGHT> :GitGutterNextHunk<CR>
nmap <silent> .<LEFT> :GitGutterPrevHunk<CR>
nmap <silent> <RIGHT> :cnext<CR>
nmap <silent> <LEFT> :cprev<CR>

" bind // (double slash) to grep shortcut
"
" Ag is overriden by the telescope ag plugin
nnoremap // :Ag<SPACE>
"  Original Ag command bound to  AgJS aka ag jump search
command -nargs=+ -complete=file -bar AgJS silent! grep! <args>|cwindow|redraw!
nnoremap /// :AgJS<SPACE>

" fzf
" This is the default extra key bindings

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-l': 'vsplit' }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }

" Replace ctrl-p with telescope
nnoremap <leader><c-p> :FZF<cr>
nnoremap <c-p> <cmd>Telescope find_files<cr>  

nmap <F5> :UndotreeToggle<CR>

let g:NERDSpaceDelims = 1

" let g:AutocorrectFiletypes = ["text","markdown","tex"]

" Notes
let g:notes_directories = ['~/Desktop/Notes']
let g:notes_suffix = '.txt'

" HTML Boilerplate
let g:user_emmet_leader_key=','

" Rust
let g:rustfmt_autosave = 1
if has('nvim')
  autocmd BufRead Cargo.toml call crates#toggle()
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

let g:far#source = 'agnvim'
let g:far#ignore_files = ['<path-to-far.vim-repo>/farignore', '<path-to-far.vim-repo>/.gitignore'] 

" Search copied text in visual mode"
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

xnoremap p pgvy

" coc global extensions
" let g:coc_global_extensions = ['coc-json', 'coc-git', 'coc-css', 'coc-emmet', 'coc-go', coc-html', 'coc-jedi', 'coc-json', 'coc-markdownlint', 'coc-prettier', 'coc-rust-analyzer', 'coc-sh', 'coc-solidity', 'coc-tabnine', 'coc-tsserver']

" If you want to start window resize mode by `Ctrl+T`
let g:winresizer_start_key = '<C-T>'

" If you want to cancel and quit window resize mode by `z` (keycode 122)
let g:winresizer_keycode_cancel = 122

" Golang
au FileType go set noexpandtab
au FileType go set shiftwidth=4
au FileType go set softtabstop=4
au FileType go set tabstop=4

let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_auto_sameids = 1
let g:go_fmt_command = "goimports"
" Error and warning signs.
let g:go_auto_type_info = 1
let g:go_addtags_transform = "snakecase"

set completeopt=menuone,noinsert,noselect

" Avoid showing extra messages when using completion
set shortmess+=c

" Configure LSP through rust-tools.nvim plugin.
" rust-tools will configure and enable certain LSP features for us.
" See https://github.com/simrat39/rust-tools.nvim#configuration
set completeopt=menu,menuone,noselect

" Code navigation shortcuts
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>

nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>
" Set updatetime for CursorHold
" 300ms of no cursor movement to trigger CursorHold
set updatetime=300

" Goto previous/next diagnostic warning/error
nnoremap <silent> g[ <cmd>lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.diagnostic.goto_next()<CR>

" Reload
nnoremap <leader>l <C-L>

" Window navigation
tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-l> <C-\><C-N><C-w>l
inoremap <C-h> <C-\><C-N><C-w>h
inoremap <C-j> <C-\><C-N><C-w>j
inoremap <C-k> <C-\><C-N><C-w>k
inoremap <C-l> <C-\><C-N><C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Copilot maps
imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
        let g:copilot_no_tab_map = v:true

lua require('lancekrogers')
