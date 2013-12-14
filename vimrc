autocmd FileType php set omnifunc=phpcomplete#CompletePHP

set t_Co=256
colorscheme deleklocal

set formatoptions=tcroqw

set number
set titlestring=%f
set title
set cindent
set autoindent
set smartindent
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set nowrap

set wildmode=longest,list,full
set wildmenu

set pastetoggle=<F2>

map <F4> :NERDTreeToggle <CR>

map <F5> :set nowrap! <CR>
map <F6> :set nonumber! <CR>
map <F7> :set tabstop=2 softtabstop=2 shiftwidth=2 <CR>
map <F8> :set tabstop=4 softtabstop=4 shiftwidth=4 <CR>

map <F9> :GitDiff <CR>
map <F10> :GitCommit <CR>

" Tabbed editing
nmap ,, :tabnew<CR>
nmap ,. :tabnext<CR>
nmap ., :tabpre<CR>

" Code folding
set foldmethod=indent   " fold based on indent
set foldnestmax=10      " deepest fold is 10 levels
set nofoldenable        " dont fold by default
set foldlevel=3         " this is just what i use

filetype plugin indent on
autocmd FileType cpp setlocal expandtab shiftwidth=2 tabstop=2

set listchars=tab:☆\ ,eol:¬                 " Set hidden display characters

" pathogen
call pathogen#infect()

" window movement
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" mouse
set mouse=a

map <Leader>gs :Git status 
map <Leader>gc :Git commit 
map <Leader>ga :Git add 
map <Leader>gd :Git diff 

" highlight column 80
" set colorcolumn=81
" highlight ColorColumn ctermbg=7

set backupdir=~/tmp
set directory=~/tmp

"no backup files
set nobackup
"only in case you don't want a backup file while editing
set nowritebackup
"no swap files
set noswapfile

" statusline
set laststatus=2
set statusline=%t\ \ %y\ %{strlen(&fenc)?&fenc:'none'},\ %{&ff}%=%l,%c/%L\ %P
hi StatusLine ctermbg=Black ctermfg=Grey
hi StatusLineNC ctermbg=Black ctermfg=Black

