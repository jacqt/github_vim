""" Begun Vundle Section
set nocompatible
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'vim-scripts/Colour-Sampler-Pack'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
"Plugin 'scrooloose/syntastic'
"Plugin 'Yggdroot/indentLine'
Plugin 'kien/ctrlp.vim'
Plugin 'vim-scripts/VimClojure'
Plugin 'vim-scripts/paredit.vim'
Plugin 'vim-scripts/ShowTrailingWhitespace'
Plugin 'vim-scripts/cljfold.vim'
Plugin 'elixir-lang/vim-elixir'
Plugin 'jacqt/gvimfullscreen_win32' "For this to work, need to copy gvimfullscreen.dll to vim folder

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" End Vundle Section
""""""""""

""" Generic useful settings
set autochdir
set shell=cmd
set foldmethod=syntax
set foldnestmax=3
set number
set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab
set shellcmdflag=/c
set ff=unix
let mapleader = " "
filetype plugin on
syntax on
set nocp

""" Customize gvim
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right scroll bar
set guioptions-=L  "remove left scroll bar
set enc=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf8,prc

""" Useful shortcuts
" F5 full screens gvim
map <F5> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>


""" Color schemes
"color twilight
"color oceandeep
color sorcerer
"color molokai

""" Clojure specific settings
let g:paredit_shortmaps=0
let g:clojure_foldwords ="def,ns"

""" Python specific settings
autocmd FileType python nnoremap \re : call RunPython()<cr>
autocmd FileType python iab ## #############################################################
autocmd FileType python set foldmethod=indent
autocmd FileType python nnoremap <space> za
autocmd FileType python vnoremap <space> zf
function RunPython()
    rightbelow 8 new | r!python #
    setlocal buftype=nofile
    setlocal bufhidden=hide
    setlocal noswapfile
endfunction


""" YouCompleteMe settings
let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_cache_omnifunc = 0
autocmd InsertLeave * if pumvisible() == 0|pclose|endif


""" Ctags setting
" map <ctrl>+F12 to generate ctags for current folder:
map <F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR>
" add current directory's generated tags file to available tags
set tags+=./tags
set tags+=~/.vim/ctags/stl
set tags+=$HOME/vimfiles/ctags/stl


""" Useful commands
" put this in your ~/.vimrc file and :source ~/.vimrc
" then you can do: Dos2Unix
" dos2unix ^M
fun! Dos2unixFunction()
    let _s=@/
    let l = line(".")
    let c = col(".")
    try
        set ff=unix
        w!
        "%s/\%x0d$//e
    catch /E32:/
        echo "Sorry, first save the file."
    endtry
    let @/=_s
    call cursor(l, c)
endfun
com! Dos2Unix keepjumps call Dos2unixFunction()

" Redirect output to new tab
function! TM(cmd)
  redir => message
  silent execute a:cmd
  redir END
  tabnew
  silent put=message
  set nomodified
endfunction
command! -nargs=+ -complete=command TM call TM(<q-args>)
"
set backspace=indent,eol,start

"To set the fonts right
if has("gui_running")
  if has("gui_gtk2")
    set guifont=Inconsolata\ 10
  elseif has("gui_macvim")
    set guifont=Menlo\ Regular:h12
  elseif has("gui_win32")
    set guifont=Consolas:h13:cANSI
  endif
endif

"" Begin useful shell commands
"Command for converting dos to unix for every file in a directory:
""find . -type f -exec dos2unix {} {} \;
