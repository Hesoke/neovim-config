return {
	{
		"folke/trouble.nvim",
		cmd = "Trouble",

		config = function()
			require("trouble").setup()
		end,
	},
	{
		"mfussenegger/nvim-dap",

		dependencies = {
			-- DAPs
			"leoluz/nvim-dap-go",

			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
		},

		config = function()
			-- require DAPs
			require("dap-go").setup()

			require("dapui").setup()

			local dap, dapui = require("dap"), require("dapui")
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end
		end,
	},
}
