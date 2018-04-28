set colorcolumn=100 " line to indicate 100 characters (limit for code)

let mapleader=","

colorscheme gruvbox
let g:gruvbox_contrast_dark='soft'

set hidden
set encoding=utf-8
set background=dark
set hlsearch
set number
set relativenumber " turning on relative line numbers (experimental)

imap jj <esc>
" Mapping for ctrl-o to add line (without entering insert)
nmap <C-o> O<Esc>
" Mapping to add carraige return at cursor (is this overriding anything?)
nmap <C-p> i<Enter><Esc>
"nmap q @q
nmap Y y$

set cursorline

augroup filetype javascript syntax=javascript

" small command for setting CSS window size
command LayoutCSS vertical resize 60

" NORM MODE ----
" do some mapping.... :<,>norm gUw
":g/^$/norm INOTHING HERE
":%norm <whatever>
":<,>g/\S/norm wgUW (capitalize second word on non-blank lines)

" =================================================================================
" EasyMotion mappings
" =================================================================================
let g:EasyMotion_keys=' abcdefghijklmnopqrstuvwxyz'
"map <leader><leader>j <Plug>(easymotion-j) " find lines below
"map <leader><leader>k <Plug>(easymotion-k) " find lines above
map <leader><leader>l <Plug>(easymotion-lineforward)
map <leader><leader>h <Plug>(easymotion-linebackward)

" =================================================================================
" fzf mappings
" =================================================================================
nmap <space>b :Buffers<CR>  " search open buffers
nmap <space>f :Files<CR>    " search files in root directory (?)
nmap <space>t :BTags<CR>    " search buffer tags
nmap <space>c :Colors<CR>   " search color schemes
nmap <space>l :Lines<CR>    " search lines in current file
nmap <space>w :Windows<CR>  " search windows
nmap <space>r :History<CR>  " search recently opened files
nmap <space>h :History/<CR> " search vim command history
nmap <space>m :Maps<CR>     " search vim mappings
nmap <space>h :History/<CR> " search other (?) history
nmap <space>` :Marks<CR>    " search vim marks
nmap <space>ag :Ag<CR>      " search with Ag
nmap <space>g :GitFiles<CR> " search files that have a git history
nmap <space>co :Commits<CR> " search through git history


let g:fzf_colors =
    \ { 'fg': ['fg', 'Normal'],
    \   'bg': ['bg', 'Normal'],
    \   'hl': ['fg', 'Comment'], 
    \   'fg+': ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
    \   'bg+': ['bg', 'CursorLine', 'CursorColumn', 'Normal'],
    \   'hl+': ['fg', 'Statement'],
    \   'info': ['fg', 'PreProc'],
    \   'border': ['fg', 'Ignore'],
    \   'prompt': ['fg', 'Conditional'],
    \   'pointer': ['fg', 'Exception'],
    \   'marker': ['fg', 'Keyword'],
    \   'spinner': ['fg', 'Label'],
    \   'header': ['fg', 'Comment'] }


" code for autocomplete
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>


" some magic to get vim-markdown-preview to work (via "grip")
let vim_markdown_preview_github=1
nnoremap <silent> <leader>c :set scrollbind<CR>
nnoremap <F5> :buffers<CR>:buffer<Space>
hi ColorColumn ctermbg=8

" =================================================================================
"  Piping external commands to vim (http://vi.stackexchange.com/questions/1971)
" =================================================================================
command! -nargs=* -complete=shellcmd Rsplit execute "new | r !<args>"
command! -nargs=* -complete=shellcmd Rtab execute "tabnew | r !<args>" 
command! -nargs=* -complete=shellcmd Rpaste execute "r !<args>"

" Use 'Q' to close single buffer (note: if there are unsaved changes, it will warn)
:command Q bd

" =================================================================================
"  python setup
" =================================================================================
autocmd FileType python
    \ setlocal ai si et sta sw=4
    \ textwidth=100 backspace=indent,eol,start fo=croql
    \ colorcolumn=80

" =================================================================================
"  vim-airline setup
" =================================================================================
set t_Co=256

if !exists('g:airline_symbols')
    let g:airline_symbols={}
endif
let g:airline_symbols.space="\ua0"
" unicode symbols (note: adding these because symbols seems weird on airline... working??)
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'ξ'

" airline symbols
let g:airline_symbols.branch = ''

let g:airline_powerline_fonts=1
let g:airline_theme='bubblegum'
set laststatus=2
set ttimeoutlen=50

" =================================================================================
"  vim-tag setup
" =================================================================================
nmap <F8> :TagbarToggle<CR>

" =================================================================================
"  vim-argwrap bindings
" =================================================================================
nnoremap <silent> <leader>w :ArgWrap<CR>

" =================================================================================
"  NERDTree-related stuff
" =================================================================================
" Open NERDTree automatically (disabling this now...hide nerdtree by default)
"autocmd VimEnter * NERDTree
" Jump to main window (by default, the focus is on NERDTree
autocmd VimEnter * wincmd p
" Close NERDTree if its the last buffer open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Toggle NERDTree on/off with ctrl-tab
nnoremap <silent> <F2> :NERDTreeToggle<CR>

" Add JS beautify functionality
autocmd FileType javascript noremap <buffer> <c-f> :call JsBeautify()<CR>
autocmd Filetype json noremap <buffer> <c-f> :call JsonBeautify()<CR>
autocmd Filetype jsx noremap <buffer> <c-f> :call JsxBeautify()<CR>
autocmd Filetype html noremap <buffer> <c-f> :call HtmlBeautify()<CR>
autocmd Filetype css noremap <buffer> <c-f> :call CSSBeautify()<CR>

" =================================================================================
" lightline config
" =================================================================================
let g:lightline = {}
let g:lightline.colorscheme = 'gruvbox'
let g:lightline.active = {}
let g:lightline.active.left = [['mode', 'paste'], ['readonly', 'filename', 'modified']]

" =================================================================================
" Window Resizing
" =================================================================================

" Allow for +/- to resize window
if bufwinnr(1)
    map <Up> <C-W>-
    map <Down> <C-W>+
    map <Right> <C-W>>
    map <Left> <C-W><
endif

nnoremap <C-e> <C-w>=<CR>


" Cycle through buffers with tab/shift-tab
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Remap ^ and $, since these are annoying
" Note: These are overriding default [[ ]] bindings, which skip to beginning/end of paragraph/block
nnoremap [[ ^
nnoremap ]] $

" Tried using <space> to show/hide fold, but had weird side effects
map + za
map +a zA
map - zr
map -a zR
set foldmethod=indent
set foldlevel=99

" Python-specific stuff (bad side-effects?)
set tabstop=4
set shiftwidth=4
set expandtab

" =================================================================================
" vim-plug stuff (in place of vundle) stuff
" =================================================================================
set nocompatible
filetype off

call plug#begin()
Plug 'chriskempson/base16-vim'
Plug 'ap/vim-css-color'
Plug 'pangloss/vim-javascript'
Plug 'severin-lemaignan/vim-minimap'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
Plug 'itchyny/lightline.vim'
Plug 'maksimr/vim-jsbeautify'
Plug 'FooSoft/vim-argwrap'
Plug 'easymotion/vim-easymotion'
Plug 'vim-syntastic/syntastic'
" Plug 'mxw/vim-jsx'
Plug 'majutsushi/tagbar'
"Plug 'python-mode/python-mode'
"Plug 'chriskempson/base16-vim'
"Plug 'mhinz/vim-janah'
Plug 'morhetz/gruvbox'
Plug 'junegunn/seoul256.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'jlanzarotta/bufexplorer'
Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'posva/vim-vue'
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-startify'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'isRuslan/vim-es6'
" Plug 'kien/ctrlp.vim'
call plug#end()
