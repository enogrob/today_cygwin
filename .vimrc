set exrc
set secure

set nocompatible

filetype on
syntax enable

filetype plugin on
filetype indent on
""set modifiable
set encoding=utf-8

set showmode "mostra o modo em que estamos
set ignorecase "faz o vim ignorar maiÃºsculas e minÃºsculas nas buscas
""set columns=88 "Determina a largura da janela.
"set cul        "abreviaÃ§Ã£o de cursor line (destaca linha atual)


" --------------------------------------
"  linas destacadas
set cursorline
" hi CursorLine ctermbg=yellow cterm=none

" usar 256 cores
set t_Co=256

colorscheme default


" ------------------------------
" funÃ§Ãµes do mouse funcionando no terminal com tmux
set mouse=a

" setas do teclado funcinarem no mode inserÃ§Ã£o com tmux
" nnoremap <Esc>A <up>
inoremap <Esc>C <right>
inoremap <Esc>D <left>
inoremap <Esc>A <up>
inoremap <Esc>B <down>
inoremap <Esc>C <right>
inoremap <Esc>D <left>

" Enabling clipboard
set clipboard=unnamed


"------------------------------------
" desabilita o corretor ortogrÃ¡fico
set nospell

" por padrÃ£o verificar a ortografia  
" set spell

" adicionando o dicionÃ¡rio portuguÃªs do Brasil e inglÃªs
set spelllang=pt,en 

" alterando a forma como o vim sinaliza as palavras erradas
highlight clear SpellBad
highlight SpellBad term=reverse cterm=underline

" utilizar o dicionÃ¡rio como fonte das palavras sugeridas no autocompletar
" set dictionary=/usr/share/dict/words
set complete+=kspell


"------------------------------------
" Mostra nome do arquivo no rodape da tela
"set title

" Envia mais caracteres ao terminal, melhorando o redraw de janelas
set ttyfast

" mostrar o nÃºmero de linhas 
set nu! 

" quebrar linha respeitando as palavras
set linebreak 


"------------------------------------
"Better Esc
" utilizar jj como atalho para ESC 
inoremap jj <Esc>
nnoremap JJJJ <Nop>


"------------------------------------
" Bundle - gerenciar plugins

" para instalar plugins via bundle, 'filetype off', tem que estar marcado,
" porem os arquivos em .R e .tex nÃ£o sÃ£o reconhecidos
filetype off                   " required! PROBLEMA

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" required! 
Plugin 'gmarik/vundle'
Plugin 'klen/python-mode'

" My Bundles here:
"
Plugin 'scrooloose/nerdtree'
Plugin 'vim-scripts/AutoClose'
Plugin 'jcfaria/Vim-R-plugin'
Plugin 'kien/ctrlp.vim'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'LaTeX-Box-Team/LaTeX-Box'
Plugin 'vim-scripts/tComment'
Plugin 'vim-scripts/VOoM'
Plugin 'kakkyz81/evervim'
Plugin 'kshenoy/vim-signature'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'bling/vim-airline'
Plugin 'scrooloose/syntastic'

" Plugin 'Valloric/YouCompleteMe'
Plugin 'justmao945/vim-clang'

" Bundle 'ervandew/supertab'
" Bundle 'AutoComplPop'

" original repos on github
Plugin 'tpope/vim-fugitive'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'tpope/vim-rails.git'

" vim-scripts repos
Plugin  'L9'
Plugin  'FuzzyFinder'

" non github repos
Plugin 'git://git.wincent.com/command-t.git'
" ...
call vundle#end()"

filetype plugin indent on     " required!

" Brief help
" " :PluginList       - lists configured plugins
" " :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" " :PluginSearch foo - searches for foo; append `!` to refresh local cache
" " :PluginClean      - confirms removal of unused plugins; append `!` to
" auto-approve removal
" "
" " see :h vundle for more details or wiki for FAQ
" " Put your non-Plugin stuff after this line

	
"------------------------------------
" LATEX
"
let g:tex_flavor='latex'
let g:Tex_ViewRule_pdf = 'Preview' " pode ser Skim no lugar do Preview

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
"let g:tex_flavor='latex'


" --------------------------------------
" Desabilitando atalhos chatos como Ã£ para /item e outros
let g:Tex_AdvancedMath = 0 "desabilitando o ~a criar mathcal ou \cite
"let g:Tex_EnvironmentMaps=0
"let g:Tex_EnvironmentMenus=0
"let g:Tex_FontMaps=0
"let g:Tex_FontMenus=0
"let g:Tex_SectionMaps=0
"let g:Tex_SectionMenus=0

" quando reinstalar o plugin Ã© necessÃ¡rio inserir novamente
" esta linha de comando no arquivo 
" ~/.vim/ftpugin/tex.vim
imap <buffer> <leader>it <Plug>Tex_InsertItemOnThisLine 



" --------------------------------------
" ################################################# 
" http://www.lepem.ufc.br/jaa/vim-r-plugin.html

"------------------------------------
" Behavior
"------------------------------------
"let maplocalleader = ","
"let mapleader = ";"

"------------------------------------
" Appearance
"------------------------------------
" colorscheme southernlights

"------------------------------------
" Showmarks
"------------------------------------
let marksCloseWhenSelected = 0
let showmarks_include="abcdefghijklmnopqrstuvwxyz"

"------------------------------------
" Vim-R-plugin
"------------------------------------
let vimrplugin_objbr_place = "console,right"
if $DISPLAY != ""
     let vimrplugin_openpdf = 1
     let vimrplugin_openhtml = 1
endif
if has("gui_running")
  inoremap <C-Space> <C-x><C-o>
else
   inoremap <Nul> <C-x><C-o>
endif
vmap <Space> <Plug>RDSendSelection
nmap <Space> <Plug>RDSendLine


""vimrplugin_screenplugin = 0
""vimrplugin_tmux = 0

"------------------------------------
" R
" terminal de saÃ­da 
" selecionar iTerm
"let vimrplugin_term_cmd = "/Applications/Utilities/iTerm.app/Contents/MacOS/iTerm -t R"

" selecionar Terminal
"let vimrplugin_term = "/Applications/Utilities/Terminal.app/Contents/MacOS/Terminal" 


"------------------------------------
" copiar e colar
vmap <C-c> "*y     " Yank current selection into system clipboard
nmap <C-c> "*Y     " Yank current line into system clipboard (if nothing is selected)
nmap <C-v> "*p     " Paste from system clipboard


" --------------------------------------
" Substituido pelo plugin AutoClose
"Ativa fechamento automÃ¡tico para parÃªntese
"Set automatic expansion of parenthesis/brackets
"inoremap  { {<CR>}<C-O>
"inoremap [ []<LEFT>
"inoremap ( ()<LEFT>
"inoremap " ""<LEFT>
"inoremap ' ''<LEFT>


" --------------------------------------
" Markdown
:nnoremap <leader>md :silent !open -a Marked.app '%:p'<cr>


" ------------------------------
" NERDTree
"autocmd vimenter * NERDTree
"autocmd vimenter * if !argc() | NERDTree | endif
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeWinPos = "right"
let g:vimrplugin_term = "mintty"

"------------------------------
" NerdTreeTabs
map <Leader>n <plug>NERDTreeTabsToggle<CR>

" ------------------------------
" Highlight things that we find with the search
set hlsearch


" ------------------------------
" Python 
" Disable pylint checking every save
let g:pymode_lint_write = 0

" Set key 'R' for run python code
let g:pymode_run_key = 'R'

" Load show documentation plugin
let g:pymode_doc = 1

" Key for show python documentation
let g:pymode_doc_key = 'K'


"------------------------------
" cCommand - atalho: control _ + control _ 
" atalho para comentar e descomentar para arquivos de qualquer tipo
map <leader>xx <C-_><C-_>


"------------------------------
" autocompletar
" completa busca o nome da funÃ§Ã£o no R ou LaTeX
imap ,<tab> <C-x><C-o>
" completa arguemntos de uma funÃ§Ã£o 
imap .<tab> <C-x><C-a>
" completa palavras buscando nos dicionÃ¡rios, tanto inglÃªs como portuguÃªs
imap ,.<tab> <C-x><C-k>
" completa linhas inteiras com base nas linhas que jÃ¡ existem no arquivo
imap .,<tab> <C-x><C-l>

"------------------------------
" Maps to resizing a window split
nnoremap <silent> <Leader>, :vertical resize +4<cr>
nnoremap <silent> <Leader>. :vertical resize -4<cr>
nnoremap <silent> <Leader>> :resize +4<cr>
nnoremap <silent> <Leader>< :resize -4<cr>


"------------------------------
" evervim - notas do evernote no vim
" let g:evervim_devtoken=

"------------------------------
" sempre mostrar a barra inferior com o status
set laststatus=2


"------------------------------
" configuraÃ§Ã£o da powerline
""let g:airline_powerline_fonts = 1
set encoding=utf-8
set guifont=Consolas\ for\ Powerline\ FixedD\:h9

let g:airline_symbols = {}
let g:airline_left_sep = "\u2b80"
let g:airline_left_alt_sep = "\u2b81"
let g:airline_right_sep = "\u2b82"
let g:airline_right_alt_sep = "\2b83"
let g:airline_symbols.branch = "\u2b60"
let g:airline_symbols.readonly = "\u2b64"
let g:airline_symbols.linenr = "\u2b61"

let g:Powerline_symbols = 'unicode'
let g:Powerline_symbols = 'fancy'
"let g:Powerline_dividers_override = ['>>', '>', '<<', '<']"


"------------------------------
" Cores para as tabs, linhas e menu de auto completar
hi Cursor ctermfg=234 ctermbg=202 cterm=NONE guifg=#1e1e1e guibg=#fc5604 gui=NONE
hi Visual ctermfg=NONE ctermbg=59 cterm=NONE guifg=NONE guibg=#373b41 gui=NONE
hi CursorLine ctermfg=NONE ctermbg=236 cterm=NONE guifg=NONE guibg=#2f2f2f gui=NONE
hi CursorColumn ctermfg=NONE ctermbg=236 cterm=NONE guifg=NONE guibg=#2f2f2f gui=NONE
hi ColorColumn ctermfg=NONE ctermbg=236 cterm=NONE guifg=NONE guibg=#2f2f2f gui=NONE
hi LineNr ctermfg=248 ctermbg=236 cterm=NONE guifg=#727372 guibg=#2f2f2f gui=NONE
" 
hi Title       term=NONE cterm=NONE ctermfg=251  ctermbg=NONE gui=NONE guifg=#c6c6c6 guibg=#000000
hi TabLine     term=NONE cterm=NONE ctermfg=248   ctermbg=237  gui=NONE guifg=#000000 guibg=#3a3a3a
hi TabLineFill term=NONE cterm=NONE ctermfg=248   ctermbg=237  gui=NONE guifg=#000000 guibg=#3a3a3a
hi TabLineSel  term=NONE cterm=NONE ctermfg=231  ctermbg=237  gui=NONE guifg=#ffffff guibg=#3a3a3a
" 
hi Pmenu	term=NONE cterm=NONE ctermfg=231  ctermbg=237  gui=NONE guifg=#ffffff guibg=#3a3a3a 
hi PmenuSel 	term=NONE cterm=NONE ctermfg=234  ctermbg=244  gui=NONE guifg=#ffffff guibg=#3a3a3a




