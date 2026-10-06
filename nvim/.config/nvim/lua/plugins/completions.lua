-- blink.cmp replaces nvim-cmp: same LSP/path/buffer/snippet sources,
-- native fuzzy matcher, no per-keystroke lag.
return {
	{
		"saghen/blink.cmp",
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
		version = "1.*",
		opts = {
			keymap = { preset = "default" },
			appearance = {
				nerd_font_variant = "mono",
			},
			completion = {
				menu = { border = "rounded" },
				documentation = {
					auto_show = true,
					window = { border = "rounded" },
				},
			},
			signature = {
				enabled = true,
				window = { border = "rounded" },
			},
			sources = {
				default = { "lsp", "path", "buffer", "snippets" },
			},
		},
		opts_extend = { "sources.default" },
	},
}
