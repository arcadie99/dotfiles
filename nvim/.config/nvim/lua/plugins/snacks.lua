-- Utility bundle: dashboard, indent guides, notifications, floating
-- terminal, zen mode, and a lazygit popup (lazygit is already on PATH
-- via brew). Kept to a modest subset, not the full snacks feature set.
return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		dashboard = { enabled = true },
		indent = { enabled = true },
		notifier = { enabled = true },
		lazygit = { enabled = true },
		terminal = { enabled = true },
		zen = { enabled = true },
	},
	keys = {
		{
			"<leader>gg",
			function()
				Snacks.lazygit()
			end,
			desc = "Lazygit",
		},
		{
			"<leader>zz",
			function()
				Snacks.zen()
			end,
			desc = "Zen mode",
		},
		{
			"<leader>tt",
			function()
				Snacks.terminal()
			end,
			desc = "Terminal",
		},
	},
}
