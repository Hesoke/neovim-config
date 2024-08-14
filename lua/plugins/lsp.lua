return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			auto_install = true,
		},
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			require("mason-lspconfig").setup_handlers({
				function(server_name)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
					})
				end,
				--if any adittional config required, add extra function
				function()
					require("lspconfig").gopls.setup({
						capabilities = capabilities,
						settings = {
							gopls = {
								analyses = {
									unusedparams = true,
								},
								staticcheck = true,
							},
						},
						on_attach = function(client, bufnr)
							vim.api.nvim_create_autocmd("LspProgress", {
								callback = function()
									vim.cmd("redrawstatus")
								end,
							})
						end,
						flags = {
							debounce_text_changes = 150,
						},
					})
				end,
			})
		end,
	},
}
