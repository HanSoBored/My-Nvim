return {
	-- Treesitter markdown parser
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = { "markdown", "markdown_inline" },
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
		},
	},

	-- Better markdown rendering (Obsidian-style)
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = "markdown",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {
			heading = {
				enabled = true,
				sign = true,
				width = "block",
			},
			bullet = {
				enabled = true,
				["repeat"] = true,
			},
			checkbox = {
				enabled = true,
			},
			code = {
				enabled = true,
				width = "block",
			},
			dash = {
				enabled = true,
			},
			quote = {
				enabled = true,
			},
			table = {
				enabled = true,
			},
			link = {
				enabled = true,
			},
		},
		keys = {
			{ "<leader>mm", "<cmd>RenderMarkdown toggle<cr>", desc = "Toggle Markdown Render" },
		},
	},

	-- Set conceallevel for markdown files
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "markdown",
				callback = function()
					vim.opt_local.conceallevel = 2
					vim.opt_local.concealcursor = "nvi"
				end,
			})
		end,
	},
}
