" Define a function to set conceallevel to 2 for Markdown files
function! SetConceallevelForMarkdown()
    setlocal conceallevel=2
endfunction

" Define a function to reset conceallevel to 0 for all other file types
function! ResetConceallevelForOtherFiles()
    setlocal conceallevel=0
endfunction

" Set up autocommands
augroup markdown_settings
    autocmd!
    autocmd FileType markdown call SetConceallevelForMarkdown()
    autocmd FileType * call ResetConceallevelForOtherFiles()
augroup END

