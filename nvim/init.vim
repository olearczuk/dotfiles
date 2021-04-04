syntax on

set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set relativenumber
set nowrap
set incsearch
set nohlsearch
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set scrolloff=8
set signcolumn=yes

set colorcolumn=120
highlight ColorColumn ctermbg=0 guibg=lightgrey

call plug#begin(stdpath('config') . '/plugged')

Plug 'morhetz/gruvbox'
Plug 'jremmen/vim-ripgrep'
Plug 'nvim-telescope/telescope.nvim'
Plug 'tpope/vim-fugitive'
Plug 'vim-utils/vim-man'
Plug 'lyuts/vim-rtags'
Plug 'git@github.com:kien/ctrlp.vim.git'
Plug 'git@github.com:Valloric/YouCompleteMe.git'
Plug 'mbbill/undotree'
Plug 'preservim/nerdtree'
" Only for educational purposes
Plug 'ThePrimeagen/vim-be-good', {'do': './install.sh'}" 

call plug#end()

colorscheme gruvbox
set background=dark

if executable('rg')
    let g:rg_derive_root='true'
endif

let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:netrw_browse_split=2
let g:netrw_banner = 0
let g:netrw_winsize = 25

let g:ctrlp_use_caching = 0

let mapleader = " "
" Ctrl+c = ESC
inoremap <C-C> <Esc>
nnoremap <C-C> <Esc>
vnoremap <C-C> <Esc>
onoremap <C-C> <Esc>
" Splitting windows
nnoremap <leader>sv <C-w>v
nnoremap <leader>sh <C-w>S
" Switching between windows
nnoremap <silent> <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>w :wincmd w<CR>
nnoremap <leader>wo <C-w>o<CR>
" Moving windows
nnoremap <leader>H :wincmd H<CR>
nnoremap <leader>J :wincmd J<CR>
nnoremap <leader>K :wincmd K<CR>
nnoremap <leader>L :wincmd L<CR>
" Resizing windows
nnoremap <silent> <leader>+ :vertical resize +5<CR>
nnoremap <silent> <leader>- :vertical resize -5<CR>
" Tabs management
nnoremap <leader>te :tabe<CR>
nnoremap <leader>tc :tabc<CR>
nnoremap <leader>tn :tabn<CR>
nnoremap <leader>tp :tabp<CR>
nnoremap <leader>tl :tabl<CR>
nnoremap <leader>tf :tabr<CR>
" Buffers management
nnoremap <leader>bp :bp<CR>
nnoremap <leader>bn :bn<CR>
nnoremap <leader>bd :bd<CR>
nnoremap <leader>bls :ls<CR>

nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>ps :Rg<SPACE>

nnoremap <silent><leader>gd :YcmCompleter GoTo<CR>
nnoremap <silent><leader>gf :YcmCompleter FixIt<CR>
nnoremap <silent><leader>gr :YcmCompleter RefactorRename<SPACE>

nnoremap <leader>nn :NERDTree<CR>
nnoremap <leader>nt :NERDTreeToggle<CR>
nnoremap <leader>nf :NERDTreeFind<CR>

let NERDTreeMinimalUI = 1
" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * silent NERDTreeMirror
