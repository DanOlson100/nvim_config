-- Indent Guides
return {
    { 'lukas-reineke/indent-blankline.nvim',
        --opts = {
        --    char = '|',
        --    show_trailing_blankline_indent = false,
        --},
        main = "ibl",
	---@module "ibl"
	---@type ibl.config
       temp = function()
           require("ibl").setup({})
       end,
    }
}
