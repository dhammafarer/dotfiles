"--------------Vundle-----------------"
set nocompatible              " be iMproved, required

" Get the runtime path to include Vundle and initialize
set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin()

" Base plugins
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-sensible'
Plugin 'jonathanfilip/vim-lucius'
Plugin 'tpope/vim-surround'
Plugin 'rking/ag.vim'
Plugin 'easymotion/vim-easymotion'
Plugin 'mg979/vim-visual-multi'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'jiangmiao/auto-pairs'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'airblade/vim-gitgutter'
"Plugin 'vimwiki/vimwiki'
Plugin 'suan/vim-instant-markdown', {'rtp': 'after'}
Plugin 'vim-scripts/loremipsum'
Plugin 'danro/rename.vim'
Plugin 'vijaymarupudi/nvim-fzf'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
"Plugin 'https://github.com/alok/notational-fzf-vim'
Plugin 'majutsushi/tagbar'
Plugin 'chrisbra/csv.vim'
Plugin 'tpope/vim-speeddating' "incrementing dates with <C-A>
Plugin 'vim-scripts/utl.vim'
Plugin 'lifepillar/pgsql.vim'
Plugin 'vim-scripts/dbext.vim'
Plugin 'ryanoasis/vim-devicons'
Plugin 'baskerville/vim-sxhkdrc'

" autocompletion
Plugin 'roxma/nvim-yarp'
Plugin 'roxma/vim-hug-neovim-rpc'
Plugin 'Valloric/ListToggle' "quickfix list
Plugin 'neoclide/coc.nvim', {'branch': 'release'}
Plugin 'Shougo/pum.vim'
Plugin 'prettier/vim-prettier'
Plugin 'jxnblk/vim-mdx-js'

"html
Plugin 'mattn/emmet-vim'

" js
Plugin 'pangloss/vim-javascript'
Plugin 'leafgarland/typescript-vim'
Plugin 'peitalin/vim-jsx-typescript'
Plugin 'styled-components/vim-styled-components'
Plugin 'jparise/vim-graphql'

" haskell
Plugin 'neovimhaskell/haskell-vim'
Plugin 'Shougo/vimproc.vim'
Plugin 'eagletmt/neco-ghc'
Plugin 'alx741/vim-stylishask'
Plugin 'itchyny/vim-haskell-indent'

"rust
Plugin 'cespare/vim-toml' "toml syntax
Plugin 'rust-lang/rust.vim' "rust syntax

"" word processing
Plugin 'vim-pandoc/vim-pandoc'
Plugin 'vim-pandoc/vim-pandoc-syntax'
Plugin 'luochen1990/rainbow'
Plugin 'skywind3000/asyncrun.vim'

" python
Plugin 'nvie/vim-flake8'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'vim-python/python-syntax'
Plugin 'tell-k/vim-autopep8'

call vundle#end()            " required
syntax on
filetype on
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
"---------Settings---END--------------"

"----------------Keys-----------------"
"let mapleader = ","
"let g:mapleader = ","
nnoremap <Space> <Nop>
let mapleader = "\<Space>"
nmap <leader>w :w!<cr>				"fast saves
nmap <leader>x :q<cr>				  "fast quit
nmap <leader>s :saveas		    "save as

nmap <leader><esc> :nohlsearch<cr>
nnoremap ,cd :cd %:p:h<CR>:pwd<CR> 		"Auto change directory to match current file ,cd
"nmap <C-v> :vertical resize +5<cr>

nmap :bp :BufSurfBack<cr>			"go backward in buffer
nmap :bn :BufSurfForward<cr>			"go forward in buffer
"map <leader>n :NERDTreeToggle<CR>
nmap <leader>n <Cmd>CocCommand explorer<CR>
"-------------Keys---END--------------"
"
"-----------------CtrlP---------------"
"map <D-p> :CtrlP<cr>
"nmap <C-d> :CtrlPBufTag<cr>
"nmap <C-e> :CtrlPMRUFiles<cr>
"
"" I don't want to pull up these folders/files when calling CtrlP
"set wildignore+=*/vendor/**
"set wildignore+=*/public/forum/**
"set wildignore+=*/node_modules/**
"set wildignore+=*/bin/**
"
"let g:ctrlp_match_window = 'top,order::ttb,min:1,max:30,results:30'
"-------------CtrlP---END-------------"

"-----------------fzf---------------"
map <C-p> :Files<CR>
nmap <C-e> :History<cr>
nmap <C-u> :Marks<cr>
"-------------fzf---END-------------"

"-----------UltiSnips-----------------"
let g:UltiSnipsEditSplit="vertical"

let g:UltiSnipsSnippetsDir="~/.snippets"
let g:UltiSnipsSnippetDirectories=["UltiSnips"]

set completeopt-=preview "Remove preview window
"--------UltiSnips---END--------------"

"---------------Misc=-----------------"
highlight Search cterm=underline
autocmd cursorhold * set nohlsearch
autocmd cursormoved * set hlsearch
command! H let @/="" 				                  "Remove search results

"----------VimWiki----------"

let wiki_1 = {}
let wiki_1.path = '$HOME/Nextcloud/Documents/Notes'
let wiki_1.syntax = 'markdown'
let wiki_1.ext = '.md'

"let wiki_2 = {}
"let wiki_2.name = 'personal'
"let wiki_2.path = '$HOME/wiki/wiki-personal'
"let wiki_2.syntax = 'markdown'
"let wiki_2.ext = '.md'

let g:vimwiki_list = [wiki_1]
let g:vimwiki_folding = 'list'


:map <leader>c <Plug>VimwikiToggleListItem

let g:taskwiki_markup_syntax = "markdown"

let g:instant_markdown_autostart = 0 "disable autostart
map <leader>md :InstantMarkdownPreview<CR>
let g:instant_markdown_browser = "google-chrome-stable --new-window"

"----------------"
set thesaurus+=~/Dropbox/Config/mthesaur.txt
let g:vroom_use_colors = 1
"------------Misc---END---------------"

" Create/edit file in the current directory
"nmap <leader>e :edit %:p:h/

" For local replace
nnoremap gr *:%s///gc<left><left><left>

autocmd FileType vue runtime! ftplugin/html/sparkup.vim

"----------------- Commands -------------------"
command DiaryTime execute "put=system('date +%H:%M')"
:command! -nargs=1 VueSpec execute 'e test/unit/specs/<args>.spec.js <bar> split src/components/<args>.vue'
:command! -nargs=1 VueSpecPage execute 'e test/unit/specs/<args>.spec.js <bar> split src/pages/<args>.vue'

"autocmd BufNewFile,BufRead *.vue set filetype=html "When opening or creating a .vue file set the filetype to HTML for proper rendering
"JSX
let g:jsx_ext_required = 0
" enable sparkup in jsx
autocmd FileType javascript.jsx runtime! ftplugin/html/sparkup.vim
let g:closetag_filenames = "*.html,*.erb,*.jsx"
nnoremap <Leader>e :e <C-R>=expand('%:p:h') . '/'<CR>

" emmmet
let g:user_emmet_settings={'javascript.jsx': {'extends':'jsx'}}

" Asynchronous Lint Engine (ALE)
" Limit linters used for JavaScript.
let g:ale_linters = {
\  'javascript': ['eslint', 'tsserver'],
\  'typescript': ['tsserver', 'eslint'],
\  'python': ['flake8', 'pylint']
\}
let g:ale_echo_msg_format = '%linter%: %s'

autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact

" add omnicompletion
filetype plugin on
set omnifunc=syntaxcomplete#Complete

let g:SuperTabDefaultCompletionType = "<C-X><C-O>"

"## HASKELL
" neco-ghc
"let g:ycm_semantic_triggers = {'haskell' : ['.'], 'elm': ['.']}
let g:haskellmode_completion_ghc = 1
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
let g:necoghc_enable_detailed_browse = 1
let g:haskell_classic_highlighting = 1


"## END-HASKELL

" file navigation
"nnoremap <Leader>c :e *.cabal<CR>
nnoremap <Leader>p :e package.json<CR>
nnoremap <Leader>t :e Cargo.toml<CR>
nnoremap <Leader>m :e src/main.rs<CR>
nnoremap <Leader>wc :e webpack.config.js<CR>
nnoremap <Leader>gc :e gatsby-config.ts<CR>
nnoremap <Leader>gn :e gatsby-node.js<CR>

"map <silent> tw :GhcModTypeInsert<CR>
"map <silent> ts :GhcModSplitFunCase<CR>
"map <silent> tq :GhcModType<CR>
"map <silent> te :GhcModTypeClear<CR>

" typescript
"autocmd FileType typescript setlocal completeopt-=menu

" List Toggle
let g:lt_location_list_toggle_map = '<leader>l'
let g:lt_quickfix_list_toggle_map = '<leader>q'
let g:lt_height = 5

" Lucius theme
"colorscheme lucius
"autocmd VimEnter * LuciusLightHighContrast
"let g:lucius_no_term_bg = 1
"let g:lucius_contrast_bg = 'high'
"colorscheme OceanicNext
"hi Visual term=reverse cterm=reverse guibg=Grey

let g:tsuquyomi_disable_quickfix = 1

"prettier
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.vue,*.yml,*.yaml,*.html,*.mdx Prettier

let g:rainbow_active = 1

"spellchecking
set nospell
let g:pandoc#spell#enabled = 0


"opening tag brackets
hi htmlTag ctermfg=4

"opening tag brackets
hi htmlTagName ctermfg=14

"component tag
hi tsxTagName ctermfg=14

"closing tag brackets
hi tsxCloseTag ctermfg=4
"single tag closing bracket
hi tsxCloseString ctermfg=4

"attribute name
hi tsxAttrib ctermfg=12 cterm=italic
"attribute equal
hi tsxEqual ctermfg=4
"attribute string
hi tsxString ctermfg=13

hi tsxCloseTagName ctermfg=14

hi tsxAttributeBraces ctermfg=9

hi String ctermfg=13
hi Number ctermfg=11
hi Comment ctermfg=4
hi LineNr ctermfg=8

highlight ALEWarning ctermfg=0 ctermbg=11
highlight ALEError ctermfg=15 ctermbg=9

"let g:deoplete#enable_at_startup = 1
"let g:deoplete#max_menu_width = 0
"call deoplete#custom#source('ghc',  'max_menu_width', 0)
"call deoplete#custom#source('ghc',  'max_abbr_width', 0)
"call deoplete#custom#source('ghc',  'max_kind_width', 0)

"folding
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=2

"remap za to space
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

"make views automatic
"autocmd BufWinLeave *.* mkview
"autocmd BufWinEnter *.* silent loadview

"notational fzf
"let g:nv_search_paths = ['~/wiki', 'docs.md' , './notes.md']
let g:nv_search_paths = ["."]
"let g:nv_default_extension = '.wiki'
noremap <silent> <C-s> :NV<CR>

let maplocalleader = "\\"

" change current word (like ciw) but repeatable with dot . for the same next
" word
nnoremap <silent> <C-n> :let @/=expand('<cword>')<cr>cgn

" Goldendict
:nmap <silent> <F1> :AsyncRun goldendict <cword><CR>
:vmap <silent> <F1> y :AsyncRun goldendict "<C-R>""<CR>

" Pmenu colors
hi Pmenu ctermfg=15 ctermbg=235 guibg=#d7e5dc gui=NONE
hi PmenuSel ctermfg=0 ctermbg=13 guibg=#d7e5dc gui=NONE
hi PmenuSbar ctermfg=0 ctermbg=232 guibg=#d7e5dc gui=NONE
hi PmenuThumb ctermfg=0 ctermbg=238 guibg=#d7e5dc gui=NONE


" air-line
let g:airline_powerline_fonts = 1
let g:airline_theme='minimalist'

set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" air-line
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" airline symbols
let g:airline_left_sep = ''
let g:airline_right_sep = ''
"let g:airline_symbols.colnr = ':'
"let g:airline_symbols.maxlinenr= ''

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

"let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'default'

" tabline
:hi TabLineFill ctermfg=0 ctermbg=240
:hi TabLine ctermfg=242 ctermbg=0 cterm=none
:hi TabLineSel ctermfg=250 ctermbg=0
:hi Title ctermfg=250 ctermbg=0

highlight SignColumn      ctermfg=7 ctermbg=0
highlight GitGutterAdd    ctermfg=2 ctermbg=0
highlight GitGutterChange ctermfg=3 ctermbg=0
highlight GitGutterDelete ctermfg=1 ctermbg=0

"Rust
let g:rustfmt_autosave = 1
let g:rustfmt_command = "rustfmt"

" Completion
" Better completion
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect
" Better display for messages
"set cmdheight=2
" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

"-----easymotion------
nmap s <Plug>(easymotion-overwin-f)
"nmap s <Plug>(easymotion-overwin-f2)
let g:EasyMotion_smartcase = 1
map h <Plug>(easymotion-j)
map l <Plug>(easymotion-k)

" pgqsl
let g:sql_type_default = 'pgsql'

"#### Coc vim ####
set encoding=utf-8

set nobackup
set nowritebackup
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

set updatetime=300
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
"inoremap <silent><expr> <TAB>
"      \ pumvisible() ? "\<C-n>" :
"      \ <SID>check_back_space() ? "\<TAB>" :
"      \ coc#refresh()
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
"
"function! s:check_back_space() abort
"  let col = col('.') - 1
"  return !col || getline('.')[col - 1]  =~# '\s'
"endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [ <Plug>(coc-diagnostic-prev)
nmap <silent> ] <Plug>(coc-diagnostic-next)

nmap <leader>a <Plug>(coc-codeaction)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" show diagnostics on cursor
nnoremap <silent>k :call CocAction('doHover')<CR>

" show diagnostics in a list
nnoremap <silent> <space>d :<C-u>CocList diagnostics<cr>

" show diagnostics in a list
nnoremap <silent> <space>s :<C-u>CocList -I symbols<cr>

" rename a symbol
nmap <leader>rn <Plug>(coc-rename)

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" END coc configuration

" coc snippets
"inoremap <silent><expr> <TAB>
"      \ pumvisible() ? coc#_select_confirm() :
"      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
"      \ <SID>check_back_space() ? "\<TAB>" :
"      \ coc#refresh()
"
"function! s:check_back_space() abort
"  let col = col('.') - 1
"  return !col || getline('.')[col - 1]  =~# '\s'
"endfunction

let g:coc_snippet_next = '<tab>'

" indent guides
let g:indent_guides_auto_colors = 0
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=8
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4

hi link markdownError NONE
