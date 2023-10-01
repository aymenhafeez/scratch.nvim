local M = {}

local default_opts = {
  relative = "editor",
  width = 80,
  height = 20,
  row = 4,
  col = 10,
  style = "minimal",
  border = "rounded",
  title = "Scratch buffer",
  title_pos = "center"
}

local scratch_content = {}
local scratch_buf = nil
local scratch_win = nil

function M.ToggleScratch(config)
  config = config or {}
  local opts = vim.tbl_extend("force", default_opts, config)

  if scratch_buf and not vim.api.nvim_buf_is_valid(scratch_buf) then
    scratch_buf = nil
    scratch_win = nil
  end

  if not scratch_buf then
    scratch_buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_name(scratch_buf, 'scratch_buffer')
    vim.api.nvim_buf_set_option(scratch_buf, 'bufhidden', 'hide')

    scratch_win = vim.api.nvim_open_win(scratch_buf, true, opts)

    local content = scratch_content[scratch_buf] or {}
    vim.api.nvim_buf_set_lines(scratch_buf, 0, -1, false, content)

    vim.cmd([[startinsert]])
  else
    if vim.api.nvim_win_is_valid(scratch_win) then
      vim.api.nvim_win_hide(scratch_win)
    else
      scratch_win = vim.api.nvim_open_win(scratch_buf, true, opts)
      vim.cmd([[startinsert]])
    end
  end
end

function M.SaveScratch()
  if scratch_buf and vim.api.nvim_buf_is_valid(scratch_buf) then
    scratch_content[scratch_buf] = vim.api.nvim_buf_get_lines(scratch_buf, 0, -1, false)
  end
end

function M.setup()
  vim.cmd([[command! Scratch lua require'scratch'.ToggleScratch(vim.fn["scratch#config"]())]])
end

return M
