![lang](https://img.shields.io/badge/LANG-Vim_Script-blue?style=flat-square)
![license](https://img.shields.io/badge/LICENSE-GPL_V3-orange?style=flat-square)
# scratch-shell.vim

Run shell commands and capture their output in a reusable scratch buffer — the Emacs-style experience, in Vim.

```
$ cc hello.c -o hello && ./hello
────────────────────────────────────────────────────────────

Hello, scratch-shell!

────────────────────────────────────────────────────────────
✓ exited 0
```

## Features

- Output lands in a persistent split buffer instead of the janky `:!` overlay
- Reuses the same window across runs — no split pile-up
- Remembers the last command for quick re-runs
- Interactive prompt with optional command prefix (e.g. prepend `cd ..` automatically)
- Works with `makeprg` for build-system integration
- Zero dependencies, pure Vimscript

## Installation

**vim-plug**
```vim
Plug 'foxerlot/scratch-shell.vim'
```

**packer.nvim**
```lua
use 'foxerlot/scratch-shell.vim'
```

**Lazy.nvim**
```lua
{ 'foxerlot/scratch-shell.vim' }
```

**Manual (Vim)**
```sh
mkdir -p ~/.vim/pack/plugins/start
git clone https://github.com/foxerlot/scratch-shell.vim ~/.vim/pack/plugins/start/scratch-shell.vim
```

**Manual (Neovim)**
```sh
mkdir -p ~/.local/share/nvim/site/pack/plugins/start
git clone https://github.com/foxerlot/scratch-shell.vim ~/.local/share/nvim/site/pack/plugins/start/scratch-shell.vim
```

## Commands

| Command | Description |
|---|---|
| `:Scratch <cmd>` | Run a shell command and show output in the scratch buffer |
| `:ScratchMake` | Run `makeprg` (falls back to `make`) |
| `:ScratchRepeat` | Re-run the last command |
| `:ScratchEdit` | Edit the last command in a prompt, then run it |
| `:ScratchPrompt [prefix]` | Open an interactive prompt, optionally prepending a prefix |

## Example Configuration

```vim
" Prompt for a command
nnoremap <leader>s :ScratchPrompt<CR>

" Prompt with 'cd ..' automatically prepended
nnoremap <leader>c :ScratchPrompt cd ..<CR>

" Run makeprg / make
nnoremap <leader>m :ScratchMake<CR>

" Repeat the last command
nnoremap <leader>r :ScratchRepeat<CR>

" Edit the last command before re-running it
nnoremap <leader>e :ScratchEdit<CR>
```

## Options

All options are optional. Set them in your `vimrc` before the plugin loads.

```vim
" Where the scratch split opens (default: bottom)
" Accepts any Vim split modifier: 'topleft', 'vertical botright', etc.
let g:scratch_shell_position = 'botright'

" Height of the window in lines (ignored for vertical splits)
let g:scratch_shell_height = 15

" Buffer name shown in :ls
let g:scratch_shell_bufname = '__ScratchShell__'

" Set to 1 to move the cursor into the scratch window after each run
let g:scratch_shell_focus = 0
```

## Help

After installation, run `:helptags ALL` once to index the docs, then:

```
:help scratch-shell
```
