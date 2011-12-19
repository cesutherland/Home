autocmd FileType php set omnifunc=phpcomplete#CompletePHP

colorscheme delek

set formatoptions=tcroqw

set number
set titlestring=%f
set title
set cindent
set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set nowrap

set wildmode=longest,list,full
set wildmenu

set pastetoggle=<F2>

map <F4> :NERDTreeToggle <CR>

map <F5> :set nowrap! <CR>
map <F6> :set nonumber! <CR>
map <F7> :set tabstop=2 shiftwidth=2 <CR>
map <F8> :set tabstop=4 shiftwidth=4 <CR>

map <F9> :GitDiff <CR>
map <F10> :GitCommit <CR>

" Tabbed editing
nmap ,, :tabnew<CR>
nmap ,. :tabnext<CR>
nmap ., :tabpre<CR>

"folding
set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=3         "this is just what i use

filetype plugin indent on
autocmd FileType cpp setlocal expandtab shiftwidth=2 tabstop=2
