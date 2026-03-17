-- ~/.config/nvim/lua/plugins/background.lua
return {
  {
    "xiyaowong/nvim-transparent",
    lazy = false,
    priority = 1000,
    opts = {
      enable = true,
      -- These groups will be fully transparent
      extra_groups = {
        "Normal",
        "NormalFloat",
        "NvimTreeNormal",
        "NonText",
        "SignColumn",
        "StatusLine",
        "StatusLineNC",
        "EndOfBuffer",
        "NormalNC",
        "TabLine",
        "TabLineFill",
        "TabLineSel",
        "Folded",
        "FoldColumn",
        "LineNr",
        "VertSplit",
        "FloatBorder",
        -- Add support for common plugins
        "TelescopeNormal",
        "TelescopeBorder",
        "WhichKeyFloat",
        "BufferLineTabClose",
        "BufferlineBufferSelected",
        "BufferLineFill",
        "BufferLineBackground",
        "BufferLineSeparator",
        "BufferLineIndicatorSelected",
      },
      -- Keep these elements visible for better usability
      exclude_groups = {
        "CursorLine",
        "CursorLineNr",
        "Search",
        "IncSearch",
        "Visual",
        "Pmenu",
      },
    },
    init = function()
      -- Set up transparency and colors
      vim.cmd([[
        " Set background transparent
        hi Normal guibg=NONE ctermbg=NONE
        hi NonText guibg=NONE ctermbg=NONE
        hi SignColumn guibg=NONE ctermbg=NONE
        hi VertSplit guibg=NONE ctermbg=NONE
        hi EndOfBuffer guibg=NONE ctermbg=NONE

        " Set transparency level (0-100, where 100 is fully transparent)
        let g:transparency_level = 80
        let g:transparent_enabled = v:true

        " Enhance text readability with a subtle shadow
        hi Normal guifg=#ffffff gui=NONE
        hi LineNr guifg=#888888

        " Add a slight background tint to make text more readable
        hi NormalFloat guibg=#00000033
      ]])
    end,
    keys = {
      { "<leader>tt", "<cmd>lua require('transparent').toggle_transparent()<CR>", desc = "Toggle transparency" },
      { "<leader>tc", "<cmd>lua require('transparent').clear_prefix('Normal')<CR>", desc = "Clear background" },
    },
  },
}
