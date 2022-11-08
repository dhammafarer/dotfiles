"--------------Vundle-----------------"
set nocompatible              " be iMproved, required

"" Get the runtime path to include Vundle and initialize
"set rtp+=~/.vim/bundle/Vundle.vim
"call vundle#begin()

"" Base plugins
"Plugin 'VundleVim/Vundle.vim'
"Plugin 'vim-airline/vim-airline'
"Plugin 'vim-airline/vim-airline-themes'
"Plugin 'tpope/vim-sensible'
"Plugin 'tpope/vim-surround'
"Plugin 'easymotion/vim-easymotion'
"Plugin 'mg979/vim-visual-multi'
"Plugin 'bronson/vim-trailing-whitespace'
"Plugin 'jiangmiao/auto-pairs'
"Plugin 'junegunn/fzf.vim'
"Plugin 'ryanoasis/vim-devicons'

"call vundle#end()            " required

syntax on
filetype plugin indent on

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"-----------Vundle---END--------------"

"------------Settings-----------------"
set t_Co=16
set guioptions-=T                               "Removse top toolbar
set guioptions-=r                               "Removes right hand scroll bar
set go-=L                                       "Removes left hand scroll bar
set showmode                    		"always show what mode we're currently editing in
set nowrap                      		"wrap lines
set tabstop=2                   		"a tab is four spaces
set smarttab
set tags=tags
set softtabstop=2               		"when hitting <BS>, pretend like a tab is removed, even if spaces
set expandtab                   		"expand tabs by default (overloadable per file type later)
set shiftwidth=2                		"number of spaces to use for autoindenting
set shiftround                  		"use multiple of shiftwidth when indenting with '<' and '>'
set backspace=indent,eol,start  		"allow backspacing over everything in insert mode
set autoindent                  		"always set autoindenting on
set smartindent                 		"increate the indent in a new block
set copyindent                  		"copy the previous indentation on autoindenting
set number                      		"always show line numbers
set ignorecase                  		"ignore case when searching
set smartcase                   		"ignore case if search pattern is all lowercase,
set timeout timeoutlen=500 ttimeoutlen=100
set novisualbell           			"don't beep
set noerrorbells         			"don't beep
set autowrite  					"Save on buffer switch
set guicursor=a:blinkOn0
set mouse=a
set iskeyword-=_
set modifiable
set clipboard=unnamed
set linespace=7
set encoding=UTF-8
"---------Settings---END--------------"

"----------------Keys-----------------"
let mapleader = ","
let g:mapleader = ","
nmap <leader>w :w!<cr>				"fast saves
nmap <leader>x :q<cr>				  "fast quit
nmap <leader>s :saveas		    "save as

nmap <leader><esc> :nohlsearch<cr>

nmap :bp :BufSurfBack<cr>			"go backward in buffer
nmap :bn :BufSurfForward<cr>			"go forward in buffer
map <leader>n :NERDTreeToggle<CR>
"-------------Keys---END--------------"

"-----------------fzf---------------"
map <C-p> :Files<CR>
nmap <C-e> :History<cr>
nmap <C-u> :Marks<cr>
"-------------fzf---END-------------"

"---------------Misc=-----------------"
highlight Search cterm=underline
autocmd cursorhold * set nohlsearch
autocmd cursormoved * set hlsearch
command! H let @/="" 				                  "Remove search results

" air-line
let g:airline_powerline_fonts = 1
let g:airline_theme='minimalist'

"----------------Tabs-----------------"
map <leader>tn :tabnew<cr>
map <leader>d :tabnext<cr>
map <leader>c :tabprevious<cr>
map <leader>to :tabonly<cr>

noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>
"--------------Tabs---END-------------"

"-----easymotion------
nmap s <Plug>(easymotion-overwin-f)
"nmap s <Plug>(easymotion-overwin-f2)
let g:EasyMotion_smartcase = 1
map h <Plug>(easymotion-j)
map l <Plug>(easymotion-k)
