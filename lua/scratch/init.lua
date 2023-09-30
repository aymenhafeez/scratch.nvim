local M = {}

local scratch_content = {}
local scratch_buf = nil
local scratch_win = nil
local vpad = 4
local hpad = 10

function M.ToggleScratch()
  if scratch_buf and not vim.api.nvim_buf_is_valid(scratch_buf) then
    scratch_buf = nil
    scratch_win = nil
  end

  if not scratch_buf then
    scratch_buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_name(scratch_buf, 'scratch_buffer')

    vim.api.nvim_buf_set_option(scratch_buf, 'bufhidden', 'hide')

    local width = 60
    local height = 10

    scratch_win = vim.api.nvim_open_win(scratch_buf, true, {
      relative = "cursor",
      width = width,
      height = height,
      row = vpad,
      col = hpad,
      style = "minimal",
      border = "rounded",
      title = "Scratch buffer",
      title_pos = "center"
    })

    local content = scratch_content[scratch_buf] or {}
    vim.api.nvim_buf_set_lines(scratch_buf, 0, -1, false, content)

  else
    if vim.api.nvim_win_is_valid(scratch_win) then
      vim.api.nvim_win_hide(scratch_win)
    else
      local width = 60
      local height = 10
      scratch_win = vim.api.nvim_open_win(scratch_buf, true, {
        relative = "cursor",
        width = width,
        height = height,
        row = vpad,
        col = hpad,
        style = "minimal",
        border = "rounded",
        title = "Scratch buffer",
        title_pos = "center"
      })
    end
  end
end

function M.SaveScratch()
  if scratch_buf and vim.api.nvim_buf_is_valid(scratch_buf) then
    scratch_content[scratch_buf] = vim.api.nvim_buf_get_lines(scratch_buf, 0, -1, false)
  end
end

function M.setup(config)
  config = config or {}
  vpad = config.vpad or vpad
  hpad = config.hpad or hpad

  vim.cmd("command! Scratch lua require'scratch'.ToggleScratch()")
  -- vim.keymap.set("n", "<leader>ss", ":Scratch<CR>", { noremap = true })
end

return M
