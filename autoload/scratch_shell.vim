let s:last_cmd = ''

function! scratch_shell#Run(cmd) abort
    if empty(a:cmd)
        echohl WarningMsg | echom 'ScratchShell: no command given' | echohl None
        return
    endif

    let s:last_cmd = a:cmd

    let bufnr = bufnr(g:scratch_shell_bufname)
    let winid = bufnr != -1 ? bufwinid(bufnr) : -1

    if winid != -1
        call win_gotoid(winid)
    elseif bufnr != -1
        execute g:scratch_shell_position . ' ' . g:scratch_shell_height . 'split'
        execute 'buffer ' . bufnr
    else
        execute g:scratch_shell_position . ' ' . g:scratch_shell_height . 'new'
        execute 'file ' . g:scratch_shell_bufname
        setlocal buftype=nofile bufhidden=hide noswapfile nobuflisted
        setlocal filetype=scratch_shell_output
    endif

    setlocal modifiable
    silent %delete _

    call setline(1, ['$ ' . a:cmd, repeat('─', 60), ''])

    let output = systemlist(a:cmd . ' 2>&1')
    call append('$', empty(output) ? ['(no output)', ''] : output + [''])

    let exit_code = v:shell_error
    let status_line = exit_code == 0 ? '✓ exited 0' : '✗ exited ' . exit_code
    call append('$', [repeat('─', 60), status_line])

    normal! gg
    setlocal nomodifiable

endfunction

function! scratch_shell#Prompt(...) abort
    let prefix = a:0 > 0 && !empty(a:1) ? a:1 . ' && ' : ''
    let cmd = input('Command: ')
    if !empty(cmd)
        call scratch_shell#Run(prefix . cmd)
    endif
endfunction

function! scratch_shell#Repeat() abort
    if empty(s:last_cmd)
        echohl WarningMsg | echom 'ScratchShell: no previous command' | echohl None
        return
    endif
    call scratch_shell#Run(s:last_cmd)
endfunction

function! scratch_shell#Edit() abort
  if !exists('s:last_cmd') || empty(s:last_cmd)
    call scratch_shell#Prompt()
    return
  endif

  let l:cmd = input('Edit command: ', s:last_cmd, 'shellcmd')
  if empty(l:cmd) | return | endif
  call scratch_shell#Run(l:cmd)
endfunction
