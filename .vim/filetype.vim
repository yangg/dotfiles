
" autocmd BufNewFile,BufRead ?\+.sample exe "doau filetypedetect BufRead " . fnameescape(expand("<afile>:r"))
