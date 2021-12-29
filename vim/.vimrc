"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SHELL STUFF:
"This kinda ruined my evening. I even forgot the point of
"setting shell here is, but commenting it out un-screwed Vim-Plug
"on Neovim 0.6.0
"set shell=zsh
"set shellcmdflag=-l


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" WINDOW STUFF:
set equalalways


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" THEMES AND COLORS:
syntax enable
"set termguicolors
set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=grey


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TEXT EDITING AND MOTIONS:
"set guicursor= 
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab  " turns tabs keypresses into spaces as set above
set autoindent
set smartindent
set nowrap
set nu  " line numbers
set relativenumber
set scrolloff=8
set signcolumn=yes


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FILES AND BACKUPS:
set noswapfile " gonna use undo directory instead of backups/swap
set nobackup
set undodir=~/.vim/undo  " must be created by hand!
set undofile
set hidden  "hides buffer when abandoned, rather than unloading  
" set clipboard=unnamed  "use system clipboard as default register
set clipboard^=unnamed,unnamedplus
filetype plugin on
set path +=**  " during file search, recurse down directories 
set wildmenu  " display all matching files when we tab complete


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SEARCH:
set incsearch
set ignorecase
set smartcase  " search is case-sensitive only if uppercase letter is incl
set nohlsearch


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISC:
set nocompatible
set noerrorbells
set updatetime=50  " time waiting for command completion (default 4000ms = 4s)
set cmdheight=2  " Give more space for displaying messages.


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CUSTOM KEYMAPPING:
let mapleader = " "
" Create line above/below (O/o) from normal mode.
nnoremap <leader>o mpo<esc>`p
nnoremap <leader>O mpO<esc>`p
nnoremap <leader>l 0v$
nnoremap <leader>] :e ~/.vimrc<Enter>
nnoremap <leader>\ :source ~/.vimrc<Enter>
nnoremap <leader>sc :source %<Enter>
" Set G to go to end of last line, rather than any column of last line
nnoremap gg goto 1 
nnoremap G <C-End> 
" save out
nnoremap <leader>w :w<Enter>

" tryna get a fast window split going, needs work
"nnoremap <leader>ss <C-w>s<C-j><C-v> 


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS:

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

"Plug 'gruvbox-community/gruvbox'
"Plug 'preservim/nerdtree'
"Plug 'Xuyuanp/nerdtree-git-plugin'
"Plug 'tpope/vim-commentary'

"" git
"Plug 'tpope/vim-fugitive'
"Plug 'vim-airline/vim-airline'
"Plug 'airblade/vim-gitgutter'

"" fzf 
""    https://github.com/junegunn/fzf.vim
""    preview colors: brew install bat
""    fulltext search: brew install ripgrep
"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
"Plug 'junegunn/fzf.vim'

call plug#end()


""""""""""""""""""""""""""""""""""""""""
"" PLUGIN CONFIG:
"let NERDTreeShowHidden=1
"colorscheme gruvbox
"vnoremap <leader>/ :Commentary<Enter>
"nnoremap <leader>/ :Commentary<Enter>

"" fzf
"nnoremap <leader>ff :Files<Enter>
"nnoremap <leader>fg :GFiles<Enter>
"nnoremap <leader>b :Buffers<Enter>
"nnoremap <leader>ft :Rg 
"" https://www.erickpatrick.net/blog/adding-syntax-highlighting-to-fzf.vim-preview-window
"let $FZF_DEFAULT_OPTS="--ansi --preview-window 'right:60%' --layout reverse --margin=1,4 --preview 'bat --color=always --style=header,grid --line-range :300 {}'"

"" NERDTree
"nnoremap <leader>nn :NERDTreeToggle<Enter>
"nnoremap <leader>nf :NERDTreeFind<CR>



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" EXPERIMENTAL:
ab yolo swaggalicious

function! GetVisualSelection(indic_return_list)
    " Why is this not a built-in Vim script function?!
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    if a:indic_return_list == 0
        return join(lines, "\n")
    endif
    return lines
endfunction

function! RunSelectedQuery()
    let selected_query = GetVisualSelection(0)
    silent !clear
    execute "!python3 $CONFIG_HOME/bin/query_postgres.py \"" . selected_query . "\""
endfunction

function! PutSelectedQuery()
    let selected_query = GetVisualSelection(0)
    execute "normal! mz"
    "silent !clear
    let query_res = system("python3 $CONFIG_HOME/bin/query_postgres.py \"" . selected_query . "\"")
    execute "normal! o" . query_res . "\<Esc>kmx"
    execute "normal! `zo/*\<esc>"
    execute "normal! `xA*/\<esc>j"
endfunction

vnoremap <Leader>se <Esc>:call RunSelectedQuery()<CR>
vnoremap <Leader>sr <Esc>:call PutSelectedQuery()<CR>
