-- Rainbow Parens/Delimiters
return {
    { 'HiPhish/rainbow-delimiters.nvim',

-- Setup Rainbow delimiters
        strategy = {
            [''] = 'rainbow-delimiters.strategy.global',
            vim =  'raindow-delimiters.strategy.local',
        },
        query = {
            [''] = 'rainbow-delimiters',
            lua = 'rainbow-blocks',
        },
        highlight = {
           'RainbowDelimiterRed',
            'RainbowDelimiterYellow',
            'RainbowDelimiterBlue',
            'RainbowDelimiterOrange',
            'RainbowDelimiterGreen',
            'RainbowDelimiterViolet',
            'RainbowDelimiterCyan',
        },
    },
}

