"Command for converting dos to unix for every file in a directory:
""find . -type f -exec dos2unix {} {} \;
set nocompatible
source $VIMRUNTIME/vimrc_example.vim "???
source $VIMRUNTIME/mswin.vim
behave mswin

"use pathogen
call pathogen#runtime_append_all_bundles()

"color twilight
"color oceandeep
"color sorcerer
color molokai

set foldmethod=syntax
set foldnestmax=3
set number
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
"set diffexpr=MyDiff()
"
filetype plugin on

"set omnifunc=syntaxcomplete#Complete
set nocp
"autocmd FileType python set omnifunc=pythoncomplete#Complete
" use ghc functionality for haskell files
au Bufenter *.hs compiler ghc
autocmd FileType cpp let w:m2=matchadd('ErrorMsg', '\%>100v.\+', -1)
autocmd FileType haskell iab ## -----------------------------------------------------------

"set g:haddock_docdir C:\ghc\ghc-7.0.1\doc

"Wean myself off of using the escape key
"imap <Esc> <<<<<<<<<<<<<<< PLEASE STOP USING THE ESCAPE KEY >>>>>>>>>>>>>>>>>>>> <cr><cr>

"Python stuff
autocmd FileType python nnoremap \re :!pypy %<cr>
autocmd FileType python nnoremap \rr :pyf %<cr>
"autocmd FileType python let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
autocmd FileType python iab ## #############################################################
autocmd FileType python set foldmethod=indent
autocmd FileType python nnoremap <space> za
autocmd FileType python vnoremap <space> zf

"vim2hs unicode support
"set digraph
"set encoding=utf-8
"setglobal fileencoding=utf-8
set enc=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf8,prc
set guifont=Monaco:h11
set guifontwide=NSimsun:h12

"setglobal bomb
"set fileencodings=ucs-bom,utf-8,latin1


function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction


"C type languages
"autocmd FileType c let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
"autocmd FileType cpp let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
"autocmd FileType h let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
autocmd FileType cpp iab ## //////////////////////////////////////////////////////////
" --- OmniCppComplete ---
" -- required --
"
set nocp " non vi compatible mode
filetype plugin on " enable plugins

let g:ycm_min_num_of_chars_for_completion = 1
" -- optional --
" auto close options when exiting insert mode
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
"set completeopt=menu,menuone
"
" -- configs --
"let OmniCpp_MayCompleteDot = 1 " autocomplete with .
"let OmniCpp_MayCompleteArrow = 1 " autocomplete with ->
"let OmniCpp_MayCompleteScope = 1 " autocomplete with ::
"let OmniCpp_SelectFirstItem = 2 " select first item (but don't insert)
"let OmniCpp_NamespaceSearch = 2 " search namespaces in this and included files
"let OmniCpp_ShowPrototypeInAbbr = 1 " show function prototype (i.e. parameters) in popup window
" -- ctags --
" map <ctrl>+F12 to generate ctags for current folder:
set autochdir
map <F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR>

" add current directory's generated tags file to available tags
set tags+=./tags
"set tags+=C:/cpp/stlctags/tags
set tags+=~/.vim/ctags/stl
set tags+=$HOME/vimfiles/ctags/stl

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
