set formatoptions=tcroqw
set updatetime=200
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

" disable modelines for security
set modelines=0
set nomodeline

set wildmode=longest,list,full
set wildmenu

" always show status line:

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
if exists('+ttymouse') " not used in nvim
  set ttymouse=sgr
endif

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
set statusline=\ %f\ %m\ %y\ %{strlen(&fenc)?&fenc:'none'},\ %{&ff}
set statusline+=%=%l,%c/%L\ \ \ \ \ %P\ 

" splits
set fillchars=vert:\│

" syntax
syntax on

" color scheme
set termguicolors
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_contrast_light = 'hard'
colorscheme gruvbox

" fix backspace
set backspace=indent,eol,start

" don't fix end of line
set nofixendofline

" case insensitive completion
set ignorecase
set infercase

" format JSON
function! FormatJSON()
  :%! python -m json.tool
  :%s/\ \ \ \ /  /g
endfunction
command JSON call FormatJSON()

" CtrlP
let g:ctrlp_map = '<Leader>t'
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|vendor'
map ; :CtrlPBuffer<CR>

" Syntastic
"let g:syntastic_javascript_jshint_exec = '/home/carl/local/bin/jshint'
" let g:syntastic_jshint_exec = '/home/carl/local/bin/jshint'
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_php_checkers = ['php']

" php:
let php_sql_heredoc = 0
let php_html_in_heredoc = 0
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
let g:pdv_template_dir = $HOME ."/.vim/bundle/pdv/templates_snip"
nnoremap <silent> <Leader>h :<C-u>call pdv#DocumentWithSnip()<CR>
" autocmd FileType php setlocal binary noeol omnifunc=phpcomplete#CompletePHP
" autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP

augroup SmartyHTML
  autocmd!
  autocmd Filetype smarty set filetype=smarty.html
augroup END

" vim-ack:
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" coc
function InstallCompletion()
  :CocInstall coc-json coc-tsserver
endfunction
command InstallCompletion call InstallCompletion()

" coc completion
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" airline
let g:airline_section_a=''
let g:airline_powerline_fonts = 1

