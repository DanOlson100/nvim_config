-- NVim Directory Browser
-- This currently uses vim.validate which is
-- depreciated and errors out in checkhealth
return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    enabled = true,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },

-- Setup Nvim-Tree
    config = function()
        require("nvim-tree").setup {
	    sort = {
	        sorter = "case_sensitive",
	    },
	    view = {
	        width = 30,
	    },
        renderer = {
            group_empty = true,
        },
        filters = {
            dotfiles = true,
        },
	}
    end,
}

