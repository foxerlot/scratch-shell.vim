if exists('g:loaded_scratch_shell') | finish | endif
let g:loaded_scratch_shell = 1

" Where the scratch window opens: 'botright', 'topleft', 'vertical botright' …
let g:scratch_shell_position = get(g:, 'scratch_shell_position', 'botright')

" Height of the scratch window in lines (ignored for vertical splits)
let g:scratch_shell_height   = get(g:, 'scratch_shell_height',   15)

" Buffer name shown in the buffer list
let g:scratch_shell_bufname  = get(g:, 'scratch_shell_bufname',  '__ScratchShell__')

" Set to 1 to move the cursor into the scratch window after each run
let g:scratch_shell_focus    = get(g:, 'scratch_shell_focus',    0)

" Run any shell command
command! -nargs=+ -complete=shellcmd Scratch call scratch_shell#Run(<q-args>)

" Run &makeprg (falls back to 'make')
command! ScratchMake call scratch_shell#Run(empty(&makeprg) ? 'make' : expand(&makeprg))

" Re-run the last command
command! ScratchRepeat call scratch_shell#Repeat()

" Open a prompt (optional prefix prepended with &&)
command! -nargs=? ScratchPrompt call scratch_shell#Prompt(<q-args>)
