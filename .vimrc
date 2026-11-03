function! s:MkNonExDir(file, buf)
    " Only proceed if the buffer is a normal file and not a special one (like netrw)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir = fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction

augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

set relativenumber
set number
set cursorline
filetype plugin indent on
syntax enable

" --- Core behavior ---
set nocompatible
set autoread
set mouse=a
set clipboard=unnamedplus
set backspace=indent,eol,start
set scrolloff=8
set sidescrolloff=8
set splitright splitbelow
set updatetime=300
set timeoutlen=500 ttimeoutlen=10

" --- Search ---
set ignorecase smartcase
set incsearch hlsearch
nnoremap <silent> <Esc><Esc> :nohlsearch<CR>

" --- Indentation ---
set expandtab shiftwidth=4 softtabstop=4 tabstop=4
set autoindent smartindent

" --- UI ---
set wildmenu wildmode=longest:full,full
set laststatus=2 ruler showcmd
set signcolumn=yes
set linebreak breakindent
set list listchars=tab:»·,trail:·,nbsp:+

" --- Persistence ---
set undofile undodir=~/.vim/undo//
set directory=~/.vim/swap//
set backupdir=~/.vim/backup//
set viminfo='200,<500,s50,h
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" --- Mappings ---
nnoremap j gj
nnoremap k gk
nnoremap Y y$
vnoremap < <gv
vnoremap > >gv
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
cnoremap w!! w !sudo tee % >/dev/null

" --- Misc ---
set path+=**
autocmd BufWritePre * if &ft !~# 'markdown\|diff' | let s:v = winsaveview() | keeppatterns %s/\s\+$//e | call winrestview(s:v) | endif
