# 🛠️ Neovim Configuration

Welcome to my personal Neovim configuration. This setup is tailored for a clean, performant, and user-friendly editing experience. All configuration files are written in Lua for better structure and efficiency.

---

## ✨ Features

* Written in **pure Lua**
* Minimal yet powerful plugin setup
* Enhanced **editor UI** and **clipboard support**
* Improved **search behavior**
* Optimized for **developer ergonomics**

---

## 🔧 Default Settings

These default options are configured in [`lua/latuconsinafr/settings.lua`](lua/latuconsinafr/settings.lua):

### 🧮 Interface

* `number = true` – Enable absolute line numbers
* `relativenumber = true` – Show relative line numbers for easier movement
* `cursorline = true` – Highlight the current line for better visibility
* `colorcolumn = '100'` – Highlight column 100 as a soft line length limit
* `signcolumn = 'yes'` – Always show the sign column to prevent layout shifts
* `termguicolors = true` – Enable true color support for better theme rendering
* `fillchars = { eob = ' ' }` – Hide `~` on empty lines

### 🧹 Indentation

* `expandtab = true` – Convert tabs to spaces
* `shiftwidth = 2` – Indent size of 2 spaces
* `tabstop = 2` – Tab character is 2 spaces wide
* `softtabstop = 2` – Backspace/delete respects 2 spaces
* `smartindent = true` – Auto-indent new lines smartly

### 🔍 Search

* `hlsearch = true` – Highlight all search results
* `incsearch = true` – Incremental search as you type

### 📋 Clipboard

* `clipboard = 'unnamedplus'` – Use system clipboard

### 📜 Scrolling

* `scrolloff = 8` – Keep 8 lines above/below cursor when scrolling

### ⚡ Performance

* `updatetime = 50` – Faster updates for things like CursorHold events

### 🗂️ Folding

* `foldmethod = 'syntax'` – Use syntax-based folding

### 🪄 Spellcheck

* `spell = true` – Enable spell checking
* `spelllang = { 'en_gb' }` – British English dictionary

### 🧩 Filename Characters

* `isfname:append('@-@')` – Allow `@-@` in filenames (useful for some projects)

---

More sections coming soon including plugin management, key mappings, language support, UI tweaks, and performance optimizations.

> 📁 This setup lives in the `lua/latuconsinafr/` directory structure for modularity and organization.

---

## 📦 Plugins & Setup

This config integrates with a rich collection of plugins for enhanced functionality, appearance, and developer experience. Plugin keybindings are managed in separate config files located in `lua/latuconsinafr/plugins/`.

### Plugin Highlights:

* **Fuzzy Finding**: `fzf-lua` — Fast, extensible fuzzy finder with preview, live grep, buffer search, and more.
* **UI/UX Enhancements**: `lualine`, `bufferline`, `noice`, `nvim-notify`, `toggleterm`, `smear-cursor`, `which-key`, `showkey`
* **Editing**: `yanky`, `nvim-surround`, `nvim-autopairs`, `comment.nvim`, `inc-rename`, `neogen`
* **LSP & Treesitter**: `nvim-lspconfig`, `nvim-treesitter`, `vim-illuminate`, `goto-preview`
* **Git Integration**: `gitsigns.nvim`
* **Visuals**: `colorizer`, `nvim-web-devicons`, `indent-blankline`, `nvim-ufo`
* **Motion**: `cinnamon.nvim` — smooth scrolling with custom easing

Each plugin is lazily loaded and configured individually using `lazy.nvim`. Explore each plugin’s config in `lua/latuconsinafr/plugins/` to see custom behaviors and mappings.

---

*Note: Plugin-specific mappings are documented in their respective configuration files.*

## 🧠 Custom Keybindings

This section documents the core keybindings defined in `lua/latuconsinafr/maps.lua`. These mappings enhance the default Neovim experience for faster navigation, editing, and searching.

---

### General & File Operations

| Mapping            | Mode | Description                            |
| ------------------ | ---- | -------------------------------------- |
| `<leader>sv`       | n    | Source the entire `init.lua` config    |
| `<leader><leader>` | n    | Source the current file (quick reload) |
| `<leader>pv`       | n    | Open file explorer (netrw)             |
| `<leader>rr`       | n    | Force reload current buffer            |

---

### Text Editing

| Mapping     | Mode | Description                               |
| ----------- | ---- | ----------------------------------------- |
| `J`         | v    | Move selected line(s) down                |
| `K`         | v    | Move selected line(s) up                  |
| `J`         | n    | Join lines and preserve cursor position   |
| `<C-d>`     | n    | Scroll down half-page, center cursor      |
| `<C-u>`     | n    | Scroll up half-page, center cursor        |
| `n`         | n    | Next search result, center screen         |
| `N`         | n    | Previous search result, center screen     |
| `<leader>p` | x    | Paste over selection without yanking      |
| `<leader>y` | n/v  | Yank to system clipboard                  |
| `<leader>Y` | n    | Yank entire line to system clipboard      |
| `<leader>d` | n/v  | Delete without affecting clipboard        |
| `<C-c>`     | i    | Exit insert mode                          |
| `Q`         | n    | Disable accidental macro recording (noop) |

---

### Quickfix & Location Lists

| Mapping      | Mode | Description                    |
| ------------ | ---- | ------------------------------ |
| `<C-k>`      | n    | Next item in quickfix list     |
| `<C-j>`      | n    | Previous item in quickfix list |
| `<leader>k`  | n    | Next item in location list     |
| `<leader>j`  | n    | Previous item in location list |
| `<leader>qq` | n    | Toggle quickfix window         |

---

### Search & Replace

| Mapping        | Mode | Description                                            |
| -------------- | ---- | ------------------------------------------------------ |
| `<leader>rw`   | n    | Replace current word globally (no confirm)             |
| `<leader>rwc`  | n    | Replace word from cursor to EOF (with confirmation)    |
| `<leader>rg`   | n    | Manual replace (prompt input) globally                 |
| `<leader>rgc`  | n    | Manual replace (prompt input) with confirmation to EOF |
| `<leader>rq`   | n    | Replace in quickfix lines only (manual)                |
| `<leader>rqc`  | n    | Replace in quickfix lines with confirmation (manual)   |
| `<leader>rqg`  | n    | Manual global replace in all quickfix-listed files     |
| `<leader>rqgc` | n    | Manual confirm replace in all quickfix-listed files    |

---

### Find & Delete

| Mapping      | Mode | Description                                  |
| ------------ | ---- | -------------------------------------------- |
| `<leader>dw` | n    | Delete all lines containing current word     |
| `<leader>df` | n    | Delete all lines matching last search result |

---

*Note: Plugin-specific mappings are documented in their own configuration files.*

## 🎨 Colorscheme

This configuration uses the [rose-pine](https://github.com/rose-pine/neovim) colorscheme for a soft, elegant, and legible aesthetic. It emphasizes cohesive theming and calm contrast for focused editing.

> To change the theme or customize its palette, see the theme setup in `lua/latuconsinafr/plugins/color-schemes/rose-pine.lua` (or wherever you configure it).

---

## 🧾 License

This config is open-source under the MIT License.

---

## 🙋‍♂️ Contributions

Feel free to fork, suggest improvements, or file issues if you find bugs or want new features.

