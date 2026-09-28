return {
   "nvimtools/none-ls.nvim",
   config = function()
      local null_ls = require("null-ls")
      local b = null_ls.builtins

      null_ls.setup({
         sources = {
            -- Formatters only (keep it simple)
            b.formatting.prettier,
            b.formatting.black,
            b.formatting.clang_format,
            b.completion.spell,
         },
      })

      -- Format with null-ls explicitly
      vim.keymap.set('n', '<leader>gf', function()
         vim.lsp.buf.format({ filter = function(client) return client.name == "null-ls" end })
      end, {})
   end
}
