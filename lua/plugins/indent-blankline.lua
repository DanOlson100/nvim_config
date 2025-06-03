-- Indent Guides
return {
    { 'lukas-reineke/indent-blankline.nvim',
        main = "ibl",
	---@module "ibl"
	---@type ibl.config
--        opts = {
--            char = '┊',
--            show_trailing_blankline_indent = false,
--        },
       config = function()
           require("ibl").setup {}
       end,
    }
}
