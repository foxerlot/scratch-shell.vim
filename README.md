# scratch-shell.vim

Run shell commands and capture their output in a reusable scratch buffer — the Emacs-style experience, in Vim.

```
$ cargo build --release
────────────────────────────────────────────────────────────
   Compiling scratch-shell v0.1.0
    Finished release [optimized] target(s) in 2.41s
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
Plug 'you/scratch-shell.vim'
```

**packer.nvim**
```lua
use 'you/scratch-shell.vim'
```

**Lazy.nvim**
```lua
{ 'you/scratch-shell.vim' }
```

**Manual (Vim)**
```sh
mkdir -p ~/.vim/pack/plugins/start
git clone https://github.com/you/scratch-shell.vim ~/.vim/pack/plugins/start/scratch-shell.vim
```

**Manual (Neovim)**
```sh
mkdir -p ~/.local/share/nvim/site/pack/plugins/start
git clone https://github.com/you/scratch-shell.vim ~/.local/share/nvim/site/pack/plugins/start/scratch-shell.vim
```

## Commands

| Command | Description |
|---|---|
| `:Scratch <cmd>` | Run a shell command and show output in the scratch buffer |
| `:ScratchMake` | Run `makeprg` (falls back to `make`) |
| `:ScratchRepeat` | Re-run the last command |
| `:ScratchPrompt [prefix]` | Open an interactive prompt, optionally prepending a prefix |

## Mappings

No mappings are set by default. Add whichever of these you like to your `vimrc`:

```vim
" Prompt for a command
nnoremap <leader>s :ScratchPrompt<CR>

" Prompt with 'cd ..' automatically prepended
nnoremap <leader>cm :ScratchPrompt cd ..<CR>

" Run makeprg / make
nnoremap <leader>m :ScratchMake<CR>

" Repeat the last command
nnoremap <leader>r :ScratchRepeat<CR>
```

## Configuration

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

## Advanced usage

The public API functions can be called directly from your own mappings or scripts:

```vim
" Call the runner directly
call scratch_shell#Run('npm test')

" Prompt with a custom prefix
call scratch_shell#Prompt('cd ~/myproject')

" Re-run last command
call scratch_shell#Repeat()
```

## Help

After installation, run `:helptags ALL` once to index the docs, then:

```vim
:help scratch-shell
```

## License

MIT
