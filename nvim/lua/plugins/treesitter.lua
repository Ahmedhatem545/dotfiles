return {
   "nvim-treesitter/nvim-treesitter",
   build = ":TSUpdate",
   lazy = false,

   config = function()
      local ok, configs = pcall(require, "nvim-treesitter")
      if not ok then return end

      configs.setup({
         ensure_installed = {
            "html",
            "tsx",
            "typescript",
            "javascript",
            "ecma",
            "jsx",
            "svelte",
            "vue",
            "dart",
         },
         auto_install = true,
         sync_install = false,
      })

      local function attach_treesitter_highlighter(bufnr)
         if vim.treesitter.highlighter.active[bufnr] then
            return
         end
         local ft = vim.bo[bufnr].filetype
         if ft == nil or ft == "" then
            return
         end
         local ok, parser = pcall(vim.treesitter.get_parser, bufnr, ft)
         if not ok or not parser then
            return
         end
         pcall(vim.treesitter.highlighter.new, parser)
      end

      vim.api.nvim_create_autocmd({"BufReadPost", "BufNewFile", "FileType"}, {
            pattern = { "javascript", "typescript", "tsx", "jsx", "dart" },
         callback = function(args)
            attach_treesitter_highlighter(args.buf)
         end,
      })
   end,
}
