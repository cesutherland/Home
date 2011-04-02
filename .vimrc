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

set pastetoggle=<F2>
map <F5> :set nowrap! <CR>

"folding
set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=3         "this is just what i use
