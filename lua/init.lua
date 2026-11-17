
require("lazy").setup({
	-- LSP Support
	{
		'neovim/nvim-lspconfig',
		dependencies ={
			'williamboman/mason.nvim',
			'mason-org/mason-lspconfig.nvim',
		},
	},
	-- Autocompletion
	{

		'hrsh7th/nvim-cmp',
		dependencies = {
			'hrsh7th/cmp-nvim-lsp',
      			'L3MON4D3/LuaSnip',
      			'saadparwaiz1/cmp_luasnip',
		},
	},
	-- Syntax highlighting
  	'nvim-treesitter/nvim-treesitter',
})
