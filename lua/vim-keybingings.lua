-- completions
local cmp = require("cmp")
cmp.setup({
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	}),
})

--formatting
vim.keymap.set("n", "<leader>fd", vim.lsp.buf.format, { silent = true })

-- commenting
require("Comment").setup({
	toggler = {
		line = "<C-/>",
		block = "<C-A>",
	},
})

--code actions
vim.keymap.set("n", "K", vim.lsp.buf.hover, { silent = true })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { silent = true })
vim.keymap.set({ "v", "n" }, "ca", require("actions-preview").code_actions)
vim.keymap.set("n", "<leader>td", ":Trouble diagnostics toggle<CR>", { silent = true })
vim.keymap.set("n", "<leader>tq", ":Trouble qflist toggle<CR>", { silent = true })

-- debugging
vim.keymap.set("n", "<C-b>", function()
	require("dap").toggle_breakpoint()
end)
vim.keymap.set("n", "<F5>", function()
	require("dap").continue()
end)

-- running go tests
vim.keymap.set("n", "<leader>rt", function()
	return ":silent !zellij run -d Down -n go-tests -- go test " .. vim.fn.expand("%:p:h") .. " -v<CR>"
end, { expr = true, silent = true })
vim.keymap.set("n", "<leader>gt", function()
	return ":silent !gotests -w -only " .. vim.fn.expand("<cword>") .. " " .. vim.fn.expand("%:p:h") .. "<CR>"
end, { expr = true, silent = true })

-- undo tree
vim.keymap.set("n", "<leader>ut", "<cmd>lua require('undotree').toggle()<cr>", { silent = true })

--Neotree
vim.keymap.set("n", "<leader>nt", ":Neotree filesystem toggle left<CR>", { silent = true })
vim.keymap.set("n", "<leader>nf", ":Neotree focus<CR>", { silent = true })

--harpoon
local harpoon = require("harpoon")
vim.keymap.set("n", "<leader>ha", function()
	harpoon:list():add()
end)
vim.keymap.set("n", "<leader>hr", function()
	harpoon:list():clear()
end)
--harpoon telescope integration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
	local file_paths = {}
	for _, item in ipairs(harpoon_files.items) do
		table.insert(file_paths, item.value)
	end

	require("telescope.pickers")
		.new({}, {
			prompt_title = "Harpoon",
			finder = require("telescope.finders").new_table({
				results = file_paths,
			}),
			previewer = conf.file_previewer({}),
			sorter = conf.generic_sorter({}),
		})
		:find()
end
vim.keymap.set("n", "<leader>hs", function()
	toggle_telescope(harpoon:list())
end, { desc = "Open harpoon window" })

--telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>tf", builtin.find_files, {})
vim.keymap.set("n", "<leader>tg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>tb", builtin.buffers, {})

-- todo-comments
vim.keymap.set("n", "<leader>tds", ":TodoTelescope cwd=<C-r>=getcwd()<CR><CR>")
vim.keymap.set("n", "]t", function()
	require("todo-comments").jump_next()
end, { desc = "Next todo comment" })
vim.keymap.set("n", "[t", function()
	require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

--yazi neovim
vim.keymap.set("n", "<leader>yo", ":Yazi<CR>")
