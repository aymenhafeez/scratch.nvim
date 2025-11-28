describe("scratch", function()
	local scratch

	before_each(function()
		scratch = require("scratch")
		scratch.setup()
	end)

	after_each(function()
		scratch.close()
	end)

	it("can be required", function()
		assert.is_not_nil(scratch)
	end)

	it("can open scratch window", function()
		scratch.open()

		local buf = vim.api.nvim_win_get_buf(0)
		assert.is_true(vim.api.nvim_buf_is_valid(buf))

		assert.equals("nofile", vim.bo[buf].buftype)
		assert.equals("markdown", vim.bo[buf].filetype)
		assert.is_false(vim.bo[buf].swapfile)
	end)

	it("can close scratch window", function()
		scratch.open()
		local win = vim.api.nvim_get_current_win()
		scratch.close()

		assert.is_false(vim.api.nvim_win_is_valid(win))
	end)

	it("can toggle scratch window", function()
		scratch.toggle()
		local win_1 = vim.api.nvim_get_current_win()
		assert.is_true(vim.api.nvim_win_is_valid(win_1))

		scratch.toggle()
		assert.is_false(vim.api.nvim_win_is_valid(win_1))
	end)

	it("can clear scratch window", function()
		scratch.open()
		local buf = vim.api.nvim_get_current_buf()
		vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "line 1", "line 2" })

		scratch.clear()

		local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
		assert.equals(1, #lines)
		assert.equals("", lines[1])
	end)

	it("sets correct window options", function()
		scratch.open()
		local win = vim.api.nvim_get_current_win()

		assert.is_false(vim.wo[win].number)
		assert.is_false(vim.wo[win].relativenumber)
		assert.is_true(vim.wo[win].wrap)
	end)

	it("preserves buffer contents across toggle", function()
		scratch.open()
		local buf = vim.api.nvim_get_current_buf()
		vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "test line" })

		scratch.close()
		scratch.open()

		local new_buf = vim.api.nvim_get_current_buf()
		local lines = vim.api.nvim_buf_get_lines(new_buf, 0, -1, false)
		assert.equals("test line", lines[1])
	end)
end)
