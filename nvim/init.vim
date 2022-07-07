set nocompatible            " disable compatibility to old time vi
set showmatch               " show matching brackets.
set hidden                  " permite editar sem salvar ao sair do arquivo
set ignorecase              " case insensitive matching
set mouse=v                 " middle click paste with mouse
set hlsearch                " highlight search results
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
set relativenumber          " adiciona linhas relativas
set wildmode=longest,list   " get bash like tab completions
set cc=120                   " set an 80 column border for good coding style
filetype plugin indent on   " allows auto indenting depending on file type
set tabstop=2               " number of columns occupied by a tab character
set expandtab               " converts tabs to white space
set shiftwidth=2            " width for auto indents
set softtabstop=2           " see multiple spaces as tab stops so <BS> does the right thing
set inccommand=split        " mostra em tempo real as alterações de texto %s/teste/novoTexto/g
set encoding=UTF-8

" Spellchecker
" set spell
" set spelllang=en_us,pt_br

set laststatus=2
set noshowmode

let g:lightline = {
  \ 'colorscheme': 'wombat',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
  \ },
  \ 'component_function': {
  \   'gitbranch': 'FugitiveHead',
  \ },
\ }

let mapleader="\<space>"    " leader key
nnoremap <leader>; A;<esc>

" abre o arquivo de configuraçao
nnoremap <leader>cf :vsplit ~/.config/nvim/init.vim<cr>  

" abre a busca por aquivos no C+p
nnoremap <c-p> :Files<cr>

" NERDTree maps
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" HotActions map
nnoremap <C-s> :w<CR>
nnoremap <C-q> :q<CR>
inoremap jj <Esc>

" telescope map
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

let g:floaterm_keymap_new    = '<F7>'
let g:floaterm_keymap_prev   = '<F8>'
let g:floaterm_keymap_next   = '<F9>'
let g:floaterm_keymap_toggle = '<F12>'

nnoremap   <silent>   <F7>    :FloatermNew<CR>
nnoremap   <silent>   <F8>    :FloatermPrev<CR>
nnoremap   <silent>   <F9>    :FloatermNext<CR>
nnoremap   <silent>   <F12>   :FloatermToggle<CR>

call plug#begin()
Plug 'sainnhe/sonokai'
"Plug 'EdenEast/nightfox.nvim' 
Plug 'terryma/vim-multiple-cursors' " Selecionar multiplas ocorrencias no arquivo com um preview
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'dense-analysis/ale' " lint
"Plug 'jiangmiao/auto-pairs' " auto-pairs
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'itchyny/lightline.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'alvan/vim-closetag'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'storyn26383/vim-vue'
Plug 'Raimondi/delimitMate'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'vim-syntastic/syntastic'
Plug 'psliwka/vim-smoothie' " Scroll
Plug 'voldikss/vim-floaterm'
Plug 'tpope/vim-commentary'
Plug 'pantharshit00/vim-prisma'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} "Betther highlighting
Plug 'editorconfig/editorconfig-vim'
" Inicio do barbar
Plug 'kyazdani42/nvim-web-devicons'
Plug 'romgrk/barbar.nvim'
" Fim do barbar

Plug 'preservim/nerdcommenter'
Plug 'phaazon/hop.nvim'
Plug 'mhinz/vim-startify'

call plug#end()

let g:airline#extensions#tabline#enabled = 1 " Enable the list of buffers

set syntax=o

"Sonokai theme
if has('termguicolors')
  set termguicolors
endif
" The configuration options should be placed before `colorscheme sonokai`.
let g:sonokai_style = 'atlantis'
let g:sonokai_better_performance = 1
colorscheme sonokai

" Transparent background
hi EndOfBuffer guibg=NONE ctermbg=NONE

" RESTORE_VIEW
"https://github.com/vim-scripts/restore_view.vim/blob/master/plugin/restore_view.vim
if exists("g:loaded_restore_view")
    finish
endif
let g:loaded_restore_view = 1

if !exists("g:skipview_files")
    let g:skipview_files = []
endif

function! MakeViewCheck()
    if &l:diff | return 0 | endif
    if &buftype != '' | return 0 | endif
    if expand('%') =~ '\[.*\]' | return 0 | endif
    if empty(glob(expand('%:p'))) | return 0 | endif
    if &modifiable == 0 | return 0 | endif
    if len($TEMP) && expand('%:p:h') == $TEMP | return 0 | endif
    if len($TMP) && expand('%:p:h') == $TMP | return 0 | endif

    let file_name = expand('%:p')
    for ifiles in g:skipview_files
        if file_name =~ ifiles
            return 0
        endif
    endfor

    return 1
endfunction

augroup AutoView
    autocmd!
    " Autosave & Load Views.
    autocmd BufWritePre,BufWinLeave ?* if MakeViewCheck() | silent! mkview | endif
    autocmd BufWinEnter ?* if MakeViewCheck() | silent! loadview | endif
augroup END

set viewoptions=cursor,folds,slash,unix

"Coc
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

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


" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" barbar
nnoremap <silent>    <A-,> :BufferPrevious<CR>
nnoremap <silent>    <A-.> :BufferNext<CR>
nnoremap <silent>    <A-<> :BufferMovePrevious<CR>
nnoremap <silent>    <A->> :BufferMoveNext<CR>
nnoremap <silent>    <A-p> :BufferPin<CR>
nnoremap <silent>    <A-c> :BufferClose<CR>
nnoremap <silent>    <C-1> :BufferGoto 1<CR>
nnoremap <silent>    <C-2> :BufferGoto 2<CR>
nnoremap <silent>    <C-3> :BufferGoto 3<CR>
nnoremap <silent>    <C-4> :BufferGoto 4<CR>
nnoremap <silent>    <C-5> :BufferGoto 5<CR>
nnoremap <silent>    <C-6> :BufferGoto 6<CR>
nnoremap <silent>    <C-7> :BufferGoto 7<CR>
nnoremap <silent>    <C-8> :BufferGoto 8<CR>
nnoremap <silent>    <C-9> :BufferGoto 9<CR>

" blankline
let g:indent_blankline_show_current_context = v:true 
let g:indent_blankline_show_current_context_start= v:true 
let g:indent_blankline_space_char_blankline = " " 
