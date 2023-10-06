# Scratch.nvim

Toggle a floating 'scratch' window.

## Installation

### Lazy

```lua
{
  "aymenhafeez/scratch.nvim",
  config = function()
    -- create 'Scratch' command
    vim.cmd([[command! Scratch lua require'scratch'.ToggleScratch(config)]])
  end
}
```

### Packer

```lua
use {
  "aymenhafeez/scratch.nvim",
  -- create 'Scratch' command
  config = function()
    vim.cmd([[command! Scratch lua require'scratch'.ToggleScratch(config)]])
  end
}
```
