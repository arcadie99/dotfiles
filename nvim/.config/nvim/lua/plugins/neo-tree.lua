return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			local icons = require("icons")

			require("neo-tree").setup({
				default_component_configs = {
					icon = {
						folder_closed = icons.ui.folder_closed,
						folder_open = icons.ui.folder_open,
						folder_empty = icons.ui.folder_empty,
						default = icons.ui.default,
					},
					git_status = {
						symbols = {
							added = icons.git.added,
							modified = icons.git.modified,
							deleted = icons.git.deleted,
							renamed = icons.git.renamed,
							untracked = icons.git.untracked,
							ignored = icons.git.ignored,
							unstaged = icons.git.unstaged,
							staged = icons.git.staged,
							conflict = icons.git.conflict,
						},
					},
				},
			})

			vim.keymap.set("n", "<leader>nn", ":Neotree reveal <CR>")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local icons = require("icons")

			require("lualine").setup({
				options = {
					section_separators = { left = icons.misc.separator, right = icons.misc.separator },
					component_separators = { left = icons.misc.separator, right = icons.misc.separator },
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff" },
					lualine_c = { "filename" },
					lualine_x = {
						{
							"diagnostics",
							symbols = {
								error = icons.diagnostics.error .. " ",
								warn = icons.diagnostics.warn .. " ",
								info = icons.diagnostics.info .. " ",
								hint = icons.diagnostics.hint .. " ",
							},
						},
						"encoding",
						"fileformat",
						"filetype",
					},
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
			})
		end,
	},
}
