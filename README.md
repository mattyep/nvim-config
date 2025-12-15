# Neovim Configuration Guide

A modern Neovim setup optimized for Go development with LSP support, file navigation, and essential development tools.

## Table of Contents
- [Overview](#overview)
- [Configuration Structure](#configuration-structure)
- [Key Plugins](#key-plugins)
- [Installation](#installation)
- [Key Bindings](#key-bindings)
- [How It Works](#how-it-works)

## Overview

This configuration uses **lazy.nvim** as the plugin manager, providing a clean and modular setup with:
- LSP (Language Server Protocol) support with autocomplete and diagnostics
- File tree navigation
- Fuzzy finding with Telescope
- Syntax highlighting with Treesitter
- Git integration
- Beautiful UI with Catppuccin theme

## Configuration Structure

```
~/.config/nvim/
├── init.lua                 # Main entry point
├── lazy-lock.json           # Plugin version lock file
├── lua/
│   ├── config/             # Configuration files
│   │   ├── lazy.lua        # Plugin manager bootstrap
│   │   ├── lspconfig.lua   # LSP keybindings & diagnostics
│   │   ├── telescope.lua   # Fuzzy finder keybindings
│   │   └── gopls.lua       # Go-specific LSP settings
│   └── plugins/            # Plugin specifications
│       ├── bufferline.lua  # Buffer tabs
│       ├── catppuccin.lua  # Color scheme
│       ├── gitsigns.lua    # Git decorations
│       ├── lualine.lua     # Status line
│       ├── mason.lua       # LSP/tool installer
│       ├── nvim-tree.lua   # File explorer
│       ├── telescope.lua   # Fuzzy finder
│       └── treesitter.lua  # Syntax highlighting
```

## Key Plugins

### Plugin Manager
- **lazy.nvim**: Fast and modern plugin manager with lazy loading capabilities

### UI & Navigation
- **catppuccin**: Soothing pastel color scheme
- **lualine**: Elegant status line at the bottom
- **bufferline**: Buffer tabs at the top with NvimTree integration
- **nvim-tree**: File explorer sidebar with icon support
- **nvim-web-devicons**: File type icons throughout the UI

### Development Tools
- **nvim-lspconfig**: Core LSP configuration
- **mason.nvim**: Easy LSP server and tool installation
- **mason-tool-installer**: Automatically installs Go development tools:
  - `gopls` - Go language server
  - `gofumpt` - Stricter Go formatter
  - `goimports` - Import organizer
  - `golangci-lint` - Go linter
  - `delve` - Go debugger
  - `staticcheck` - Go static analyzer

### Code Intelligence
- **nvim-treesitter**: Advanced syntax highlighting and code understanding
- **telescope.nvim**: Fuzzy finder for files, text, and more
- **gitsigns**: Git change indicators in the gutter

## Installation

### Prerequisites

1. **Neovim 0.9+**
   ```bash
   # macOS
   brew install neovim
   
   # Linux (Ubuntu/Debian)
   sudo apt install neovim
   
   # Arch Linux
   sudo pacman -S neovim
   ```

2. **Git** (for plugin manager)
   ```bash
   git --version  # Verify installation
   ```

3. **Node.js** (optional, for some LSP servers)
   ```bash
   brew install node  # macOS
   ```

4. **ripgrep** (for Telescope live_grep)
   ```bash
   brew install ripgrep  # macOS
   sudo apt install ripgrep  # Linux
   ```

5. **A Nerd Font** (for icons)
   - Download from [nerdfonts.com](https://www.nerdfonts.com/)
   - Install and set in your terminal

### Apply This Configuration

1. **Backup existing config** (if any)
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   mv ~/.local/share/nvim ~/.local/share/nvim.backup
   ```

2. **Clone or copy the configuration**
   ```bash
   # Create the directory
   mkdir -p ~/.config/nvim
   
   # Copy your config files to ~/.config/nvim/
   # Maintain the structure shown above
   ```

3. **Launch Neovim**
   ```bash
   nvim
   ```

4. **Automatic setup happens**:
   - lazy.nvim bootstraps automatically
   - All plugins are downloaded
   - Mason installs Go tools
   - Treesitter downloads parsers

5. **Wait for installation** to complete (first launch takes 1-2 minutes)

6. **Restart Neovim** to ensure everything loads correctly

## Key Bindings

### Leader Key
- **Space** (`<Space>`) is the leader key for most commands

### File Operations
| Key | Mode | Action |
|-----|------|--------|
| `Ctrl+n` | All | Toggle file tree (NvimTree) |
| `Ctrl+a` | All | Save current file |
| `jk` | Insert | Exit insert mode (to Normal) |

### Telescope (Fuzzy Finder)
| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep (search text) |
| `<leader>fb` | List open buffers |
| `<leader>fh` | Search help tags |

### LSP Navigation
| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | Find references |
| `gi` | Go to implementation |
| `gt` | Go to type definition |
| `K` | Hover documentation |
| `Ctrl+k` | Signature help |

### LSP Actions
| Key | Action |
|-----|--------|
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code action |

### Diagnostics (Errors/Warnings)
| Key | Action |
|-----|--------|
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |
| `<leader>e` | Show diagnostic float |
| `<leader>q` | Open diagnostic list |

## How It Works

### Bootstrap Process

1. **init.lua** is the entry point that:
   - Loads the lazy.nvim plugin manager
   - Loads LSP configuration
   - Loads Telescope configuration
   - Loads Go-specific settings
   - Sets global keybindings
   - Applies the color scheme

2. **lazy.lua** bootstraps the plugin manager:
   - Downloads lazy.nvim if not present
   - Sets leader keys (`Space` and `\`)
   - Imports all plugin specs from `lua/plugins/`

3. **Plugin files** return Lua tables describing:
   - Plugin repository
   - Dependencies
   - Configuration functions
   - Lazy loading rules

### Plugin Loading

lazy.nvim automatically:
- Clones plugins from GitHub
- Manages dependencies
- Lazy-loads plugins when needed
- Runs setup functions

Example from bufferline.lua:
```lua
return {
    'akinsho/bufferline.nvim',  -- GitHub repo
    version = "*",               -- Use latest version
    dependencies = 'nvim-tree/nvim-web-devicons',  -- Requires icons
    config = function()
        -- Setup code runs when plugin loads
        require("bufferline").setup{ ... }
    end,
}
```

### LSP Configuration

The LSP setup involves three components:

1. **mason.nvim**: Installs language servers and tools
2. **nvim-lspconfig**: Provides configuration for LSP servers
3. **gopls.lua**: Custom Go language server settings

Key features:
- Automatic imports organization on save
- Code formatting with gofumpt
- Static analysis with staticcheck
- Diagnostics displayed inline and in the gutter

### Treesitter

Provides superior syntax highlighting by:
- Parsing code into AST (Abstract Syntax Tree)
- Understanding code structure
- Enabling advanced features like incremental selection

### Go Development Workflow

When you open a `.go` file:
1. gopls language server activates
2. Treesitter provides syntax highlighting
3. On save:
   - Imports are organized
   - Code is formatted with gofumpt
   - Diagnostics appear for errors

## Customization

### Add More Languages

Edit `lua/plugins/mason.lua`:
```lua
ensure_installed = {
  "gopls",
  "lua_ls",      -- Add Lua
  "pyright",     -- Add Python
  "ts_ls",       -- Add TypeScript
}
```

### Change Color Scheme

Edit `init.lua`:
```lua
vim.cmd.colorscheme "tokyonight"  -- Instead of catppuccin
```

Then add the theme plugin to `lua/plugins/`.

### Modify Key Bindings

Edit the relevant config file:
- Global keys: `init.lua`
- LSP keys: `lua/config/lspconfig.lua`
- Telescope: `lua/config/telescope.lua`

### Configure Plugin Options

Each plugin file accepts options. See plugin documentation:
- Check `:help <plugin-name>`
- Visit the plugin's GitHub repository

## Troubleshooting

### Plugins not loading
```vim
:Lazy sync  " Sync all plugins
```

### LSP not working
```vim
:Mason      " Open Mason UI to check installations
:LspInfo    " Check LSP status
```

### Treesitter errors
```vim
:TSUpdate   " Update parsers
:TSInstall go lua  " Install specific parsers
```

### Clear cache and reinstall
```bash
rm -rf ~/.local/share/nvim
rm -rf ~/.cache/nvim
nvim  # Reinstalls everything
```

## Resources

- [lazy.nvim documentation](https://github.com/folke/lazy.nvim)
- [LSP configuration guide](https://github.com/neovim/nvim-lspconfig)
- [Neovim documentation](https://neovim.io/doc/)
- [Telescope documentation](https://github.com/nvim-telescope/telescope.nvim)

## Summary

This configuration provides a modern development environment with:
- ✅ Minimal configuration with maximum functionality
- ✅ Fast startup with lazy loading
- ✅ Full LSP support for intelligent code editing
- ✅ Beautiful UI with carefully chosen plugins
- ✅ Optimized for Go development
- ✅ Easy to extend and customize

The modular structure makes it simple to add or remove plugins, and the lazy.nvim manager ensures everything stays fast and organized.
