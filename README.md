# Scratch.nvim

Toggle a floating 'scratch' window for quick notes and temporary text.

## Installation

### Lazy

```lua
{
  "aymenhafeez/scratch.nvim",
  config = function()
    require("scratch").setup()
  end,
}
```

## Usage

The plugin provides the following commands:

- `:ScratchOpen` - Open the scratch window
- `:ScratchClose` - Close the scratch window
- `:ScratchToggle` - Toggle the scratch window
- `:ScratchClear` - Clear the contents of the scratch buffer

or call the function directly:

```lua
require("scratch").open()
require("scratch").close()
require("scratch").toggle()
require("scratch").clear()
```

### Keymaps

Example:

```lua
vim.keymap.set("n", "<leader>ss", "<cmd>ScratchToggle<cr>", { desc = "Toggle scratch window" })
vim.keymap.set("n", "<leader>sc", "<cmd>ScratchClear<cr>", { desc = "Clear scratch buffer" })
```

or by calling the functions:

```lua
vim.keymap.set("n", "<leader>ss", function() require("scratch").toggle() end, { desc = "Toggle scratch window" })
vim.keymap.set("n", "<leader>sc", function() require("scratch").clear() end, { desc = "Toggle scratch window" })
```

## Configuration

The following options are set by default:

```lua
{
  window_type = "float", -- "float", "split", or "regular"

  float_config = {
    relative = "editor",
    width = 0.8,
    height = 0.8,
    row = 0.1,
    col = 0.1,
    style = "minimal",
    border = "none",
    title = " Scratch ",
    title_pos = "center",
  },

  split_config = {
    split = "below", -- "below", "above", "left", "right"
    -- Optional: specify size (defaults to 30% of screen)
    -- width = 40,  -- for vertical splits (left/right)
    -- height = 15, -- for horizontal splits (below/above)
  },

  buf_options = {
    buftype = "nofile",
    bufhidden = "hide",
    swapfile = false,
    filetype = "markdown",
  },

  win_options = {
    number = false,
    relativenumber = false,
    wrap = true,
  },
}
```

### Config Options

#### `window_type` (string)

The type of window to display. Options:
- `"split"` - split window (default)
- `"float"` - floating window
- `"regular"` - regular full window

#### `float_config` (table)

Window configuration options map directly to `nvim_open_win()`.

Configuration for floating windows.

- `relative` (string) - what the window position is relative to (`"editor"`, `"win"`, `"cursor"`)
- `width` (number) - width in columns (or 0-1 for percentage)
- `height` (number) - height in rows (or 0-1 for percentage)
- `row` (number) - row position
- `col` (number) - column position
- `style` (string) - window style (`"minimal"` removes UI elements)
- `border` (string|table) - border style (`"none"`, `"single"`, `"double"`, `"rounded"`, `"solid"`, `"shadow"`, or array)
- `title` (string) - window title
- `title_pos` (string) - title position (`"left"`, `"center"`, `"right"`)

#### `split_config` (table)

Configuration for split windows:

- `split` (string) - split direction: `"below"`, `"above"`, `"left"`, `"right"`
- `width` (number) - width for vertical splits (left/right), defaults to 30% of screen
- `height` (number) - height for horizontal splits (below/above), defaults to 30% of screen

#### `buf_options` (table)

Buffer-local options:

- `buftype` (string, default: `"nofile"`)
- `bufhidden` (string, default: `"hide"`)
- `swapfile` (boolean, default: `false`)
- `filetype` (string, default: `"markdown"`)

#### `win_options` (table)

Window-local options:

- `number` (boolean, default: `false`)
- `relativenumber` (boolean, default: `false`)
- `wrap` (boolean, default: `true`)

### Dynamic window type

You can also pass configuration options to the Lua functions directly. An
example use case for this could be having separate keymaps for floating or split
Scratch windows:

```lua
vim.keymap.set("n", "<leader>ss", function()
  require("scratch").toggle {
    window_type = "split",
  }
end)

vim.keymap.set("n", "<leader>sc", function()
  require("scratch").toggle {
    window_type = "float",
    float_config = {
      border = "rounded"
    }
  }
end)
```

## License

MIT
