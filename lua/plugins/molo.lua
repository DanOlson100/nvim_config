-- Personal Color Scheme 
return {
    'danolson100/molo',
    priority = 1001,

-- Setup and Apply new colorscheme
    config = function()
        vim.cmd.colorscheme 'molo'
    end,
}
