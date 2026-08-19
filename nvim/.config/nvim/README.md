# Neovim Configuration

This repository contains my personal Neovim configuration, using [lazy.nvim](https://github.com/folke/lazy.nvim) for plugin management and various plugins for a rich development experience.

## Installation

To use this configuration, follow these steps:

1. **Clone the Repository**

   ```bash
    git clone https://github.com/arcadie99/nvim-config.git ~/.config/nvim
   ```

2. **Install Neovim**

   Make sure Neovim is installed on your system. You can download it from [the official site](https://neovim.io/) or use your package manager.

3. **Install Plugins**

   Launch Neovim and run the following command to install the plugins:

   ```vim
   :Lazy
   ```

## Configuration Overview

### Basic Settings

Basic settings are defined in `lua/vim-basic-config.lua`, including:

- `expandtab`, `tabstop=4`, `softtabstop=4`, `shiftwidth=4`
- Setting the leader key to space (`" "`)

### Plugins

Plugins are managed with `lazy.nvim`. The following plugins are used:

1. **UI and Theming**
   - `onedarkpro.nvim`: Atom's One Dark theme for Neovim.
   - `lualine.nvim`: A status line plugin.
   - `snacks.nvim`: dashboard, indent guides, notifications, floating terminal, zen mode, lazygit popup.
   - `which-key.nvim`: shows available keybindings as you type.

2. **File Explorer**
   - `neo-tree.nvim`: A file explorer with support for icons and other features.

3. **LSP and Autocompletion**
   - `mason.nvim` and `mason-lspconfig.nvim`: LSP server management (`lua_ls`, `ts_ls`, `clangd`, `intelephense`, `elixirls`, `vue_ls`).
   - `nvim-lspconfig`: LSP configurations.
   - `blink.cmp`, `LuaSnip`: Autocompletion and snippet support.

4. **Code Formatting and Linting**
   - `conform.nvim`: formatting (`stylua`, `prettier`, `mix format`), replaces the unmaintained `none-ls`/`null-ls`.
   - `nvim-lint`: linting (`eslint_d`).

5. **Fuzzy Finder**
   - `telescope.nvim`: A powerful fuzzy finder with extensions for various types of searches.

6. **Syntax Highlighting**
   - `nvim-treesitter`: Enhanced syntax highlighting and parsing for multiple languages.

7. **AI**
   - `claudecode.nvim`: MCP bridge to the Claude Code CLI — buffers, selection and diagnostics visible to Claude live.

### Keybindings

Keybindings are defined throughout the configuration. Notable ones include:

- **General**
  - `<leader>gf`: Format the current buffer.
  - `<leader>nn`: Toggle Neo-tree.
  - `<leader>ca`: Trigger code actions.

- **Telescope**
  - `<C-f>`: Find files.
  - `<leader>ff`: Find files.
  - `<leader>fg`: Live grep.
  - `<leader>fb`: List buffers.
  - `<leader>fh`: Help tags.
  - `<leader>fv`: Git files.

- **LSP**
  - `K`: Hover documentation.
  - `gd`: Go to definition.

- **Autocompletion and Snippets**
  - `<Tab>`/`<CR>`: Navigate and confirm completion suggestions (blink.cmp default preset).

- **Snacks**
  - `<leader>gg`: Open lazygit.
  - `<leader>zz`: Toggle zen mode.
  - `<leader>tt`: Toggle floating terminal.

- **Claude Code**
  - `<leader>ac`: Toggle Claude Code.
  - `<leader>af`: Focus Claude Code.
  - `<leader>as` (visual mode): Send selection to Claude Code.

### Custom Settings

Additional custom settings are defined in various files:

- `.luarc.json`: Lua-specific settings, such as globals (`vim`).
- `init.lua`: Entry point for loading the configuration and setting up plugins.

## Additional Notes

- **Updating Plugins**: Use `:Lazy sync` to update plugins to their latest versions.
- **Adding New Plugins**: Add the plugin specification in `lua/plugins.lua` or a specific file under the `lua/plugins/` directory.
