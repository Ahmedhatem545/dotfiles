return {
   "lukas-reineke/indent-blankline.nvim",
   main = "ibl",
   config = function()
      local hooks = require("ibl.hooks")
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
         vim.api.nvim_set_hl(0, "IblIndent", { fg = "#5A4C3F" })
      end)

      require("ibl").setup({
         indent = {
            char = "│",
            highlight = { "IblIndent" },
         },
         scope = { enabled = true },
      })
   end,
}
