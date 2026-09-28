return {
   "ellisonleao/gruvbox.nvim",
   lazy = false,
   priority = 1000,
   config = function()
      require('gruvbox').setup({
         undercurl = true,
         underline = true,
         bold = true,
         italic = {
            strings = false,
            comments = true,
            operators = false,
            folds = true,
         },
         -- gruvbox expects `inverse` as a boolean; don't pass a table
         inverse = false,
         invert_selection = false,
         invert_signs = false,
         invert_tabline = false,
         contrast = "hard",
         transparent_mode = true,
      })

      -- Load the colorscheme
      vim.cmd.colorscheme("gruvbox")

      -- Create actual transparent background for blur-capable GUIs/compositors
      local transparent_groups = {
         "Normal", "NormalNC", "LineNr", "CursorLineNr", "CursorColumn",
         "FoldColumn", "SignColumn", "EndOfBuffer", "NonText",
         "NormalFloat", "FloatBorder", "Pmenu", "PmenuSel",
         "PmenuSbar", "PmenuThumb", "StatusLine", "StatusLineNC",
         "TabLine", "TabLineSel", "TabLineFill",
      }

      for _, group in ipairs(transparent_groups) do
         vim.cmd(string.format("hi %s guibg=NONE ctermbg=NONE", group))
      end
   end,
}
