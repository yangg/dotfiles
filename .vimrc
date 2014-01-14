
" Set variables {{{
let mapleader=';'
let $CACHEDIR=$HOME.'/.cache'

if !isdirectory($CACHEDIR) | call mkdir($CACHEDIR) | end
if has('win32') || has('win64')
    let &rtp = substitute(&rtp, 'vimfiles', '.vim', 'g')
end
" }}}

set nocompatible                " be iMproved
filetype off                    " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My Bundles {{{
Bundle 'vim-scripts/mru.vim'
Bundle 'vim-scripts/bufexplorer.zip'
Bundle 'scrooloose/nerdcommenter'
Bundle 'tpope/vim-surround'
Bundle 'vim-scripts/matchit.zip'
Bundle 'scrooloose/nerdtree'
Bundle 'mattn/emmet-vim'
Bundle 'vim-scripts/taglist.vim'
Bundle 'ap/vim-css-color'
Bundle 'yangg/html5.vim'
Bundle 'pangloss/vim-javascript'
Bundle 'vim-scripts/nginx.vim'
autocmd BufRead,BufNewFile /etc/nginx/*,/usr/local/nginx/conf/*
            \ if &ft == '' | setfiletype nginx | endif 
Bundle 'leshill/vim-json'
Bundle 'tomasr/molokai'


" Boundles config {{{
" NERDCommenter
" <leader>cy    NERDComYankComment
" <leader>cs    NERDComSexyComment
" <leader>c$    NERDComEOLComment
" <leader>cA    NERDComAppendComment
" <leader>ca    NERDComAltDelim
let NERDMenuMode = 0
let NERDSpaceDelims = 1
imap <M-/> <C-o><Plug>NERDCommenterToggle

" NERDTree
" NERDTreeGlobalCommands
" NERDTreeMappings
map <F3> :NERDTreeToggle<CR>
imap <F3> <C-o>:NERDTreeToggle<CR>

" emmet
" <C-Y>n        emmet-goto-next-point
" <C-Y>k        emmet-remove-tag
" <C-Y>j        emmet-split-join-tag
" <C-Y>a        emmet-make-anchor-url
let user_emmet_settings = {
            \'indentation' : '    ',
            \'html': {
            \   'snippets': {
            \       'html': "<!DOCTYPE html>\n"
            \           ."<html>\n"
            \           ."<head>\n"
            \           ."\t<meta charset=\"${charset}\"/>\n"
            \           ."\t<meta name=\"viewport\" content=\"width=device-width,minimum-scale=1.0\" />\n"
            \           ."\t<title></title>\n"
            \           ."</head>\n"
            \           ."<body>\n\t${child}|\n</body>\n"
            \           ."</html>",
            \       'scr': "<script>\n|</script>",
            \       'sty': "<style>\n|</style>"
            \   }
            \}
            \}
" let user_emmet_complete_tag = 1

" taglist.vim taglist-intro
if !executable('ctags') | let loaded_taglist = 1 | endif
let Tlist_Auto_Open = 0
let Tlist_Use_Right_Window = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_File_Fold_Auto_Close = 1
" let Tlist_Show_One_File = 1
let tlist_php_settings = 'php;c:class;d:constant;f:function'
" http://stackoverflow.com/questions/1790623/how-can-i-make-vims-taglist-plugin-show-useful-information-for-javascript
let tlist_javascript_settings = 'js;f:function'
" let Tlist_Compact_Format = 1
map <F4> :TlistToggle<CR>
imap <F4> <C-o>:TlistToggle<CR>

" html5.vim
let g:html_exclude_tags = ['html', 'style', 'script']

" ToHtml
let html_use_css = 0
let html_use_encoding = 'UTF-8'
let html_number_lines = 1
" }}}
" }}}

" Set options {{{
syntax on
filetype plugin indent on
set backspace=indent,eol,start
set whichwrap+=<,>,[,]
set tabstop=4 shiftwidth=4 softtabstop=4 expandtab shiftround
set number ruler showcmd
set hlsearch incsearch
set fileformats=unix,dos,mac encoding=utf-8
set fileencodings=ucs-bom,utf-8,default,cp936,gb18030,big5,latin1
set undofile undodir=$CACHEDIR
set dir=$CACHEDIR//
set autochdir
set hidden                      " enable hide modified buffer for gf, :e
set modeline modelines=2
set ignorecase smartcase
set scrolloff=1
set display=lastline
set linebreak
set linespace=4
" set list
set listchars=eol:¶,tab:>-,trail:·,extends:»,precedes:« " 182, , 187, 171
set iskeyword=@,48-57,_,-
set wildignore=*.swp,.DS_Store,.localized,.git,.svn
set wildmenu
set wildmode=longest:full
set path=,,~/Documents,~/Dropbox/Projects,~/Dropbox/Snippets
set nobackup
set history=99
" set diffopt+=vertical         " use :vert diffsplit instead
set splitright splitbelow
set nostartofline
set nojoinspaces                " do not insert two spaces after [.?!] when join lines
set winaltkeys=no
" statusline {{{
set laststatus=2
set statusline=
set statusline+=[%n]
set statusline+=%1*\ %f%*
set statusline+=%2*\ %m%*
set statusline+=[%{&ff},%{&fenc}]
set statusline+=%y%r
set statusline+=%=%l,%c
set statusline+=\ \ \ %P\ 
hi default link User1 Define
hi default link User2 Keyword
hi default link User3 Function
" }}}
if has("gui_running") " guioptions {{{
    set lines=30 columns=100    " Vim window size
    set guioptions-=T           " hide tool bar
    set guioptions-=m           " hide menu bar
    set guifont=DejaVu\ Sans\ Mono\ 11,Menlo:h14,Consolas:h12
    colorscheme molokai
end " }}}
" }}}

" Autocmds {{{
" When editing a file, always jump to the last known cursor position.
" And open enough folds to make the cursor is not folded
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufWinEnter *
            \ if line("'\"") <= line("$") |
            \   exe "normal! g`\"" | exe "normal! zv" |
            \ endif
autocmd FileType json,yaml  setlocal ts=2 sw=2 sts=2
autocmd FileType ruby       setlocal ts=2 sw=2 sts=2
autocmd FileType vim,help   setlocal keywordprg=:help
autocmd FileType gitconfig  setlocal noexpandtab

autocmd FileType html,php,javascript setl includeexpr=substitute(v:fname,'^/','','')

" Auto reload nginx & apache {{{
function! Reload()
    let output = system(&ft == 'nginx' ? 'service nginx configtest && service nginx reload' : 'service apache2 reload')
    if v:shell_error
        echohl WarningMsg | echo output
    endif
endfunction
if executable('service')
    autocmd BufWritePost /etc/nginx/*,/etc/apache2/* call Reload()
endif
" }}}
" }}}

" Key mappings {{{
" Use Ctrl-o instead of <Esc> in insert mode mappings
" move cursor in insert mode
imap <M-h> <Left>
imap <M-j> <C-o><Down>
imap <M-k> <C-o><Up>
imap <M-l> <Right>
imap <M-e> <C-o>A
imap <M-a> <C-o>I
imap <M-d> <C-o>de
imap <M-Backspace> <C-o>db      " diff from <C-w>
imap <M-o> <C-o>O

nmap <Esc><Esc> :nohl<CR>
" move cursor in long line
map <Up> gk
map <Down> gj

nnoremap Y y$
vnoremap <BS> d                 " backspace in Visual mode deletes selection
cnoremap <C-a> <Home>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <M-f> <S-Right>
cnoremap <M-b> <S-Left>
" }}}

" Custom commands {{{
" locate file in Finder {{{
function! s:open(path)
    let path = shellescape(a:path != '' ? a:path : expand('%'))
    let cmd = 'open -R '
    if executable('explorer')
       let cmd = 'explorer /select,'
    elseif executable('nautilus') " ubuntu
       let cmd = 'nautilus -n '
    endif
    call system(cmd . path)
endfunction
command! -nargs=? -complete=file Open call s:open(<q-args>)
" }}}

command! W exe 'silent write !sudo tee %'
" }}}

" Search for visually selected text {{{
function! s:search(type)
    let old_reg = getreg('"')
    let old_regtype = getregtype('"')
    normal gvy
    let @/ = substitute(escape(@", a:type . '.\*$^~['), '\_s\+', '\\_s\\+', 'g')
    call setreg('"', old_reg, old_regtype)
endfunction
vnoremap * :<C-u>call <SID>search('/')<CR>/<C-r>/<CR>
vnoremap # :<C-u>call <SID>search('?')<CR>?<C-r>/<CR>
" }}}

if filereadable(expand('~/.vimrc.local'))
    source ~/.vimrc.local
endif

" vim: ft=vim fdm=marker
