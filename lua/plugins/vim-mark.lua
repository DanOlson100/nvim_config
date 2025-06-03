-- Mark Words to Highlight (Works in Vim)
return {
    {   'inkarkat/vim-mark',
        priority = 999,                                 -- Needed for priority issue with * 
        dependencies = {
            'inkarkat/vim-ingo-library',                -- Dep Lib for vim-mark
        },
    },
}
