return {
  {
    "akinsho/flutter-tools.nvim",
    dependencies = {"nvim-lua/plenary.nvim", "mfussenegger/nvim-dap"},
    lazy = false,
    config = function()
      local ok, flutter_tools = pcall(require, "flutter-tools")
      if not ok then
        return
      end

      flutter_tools.setup({
        lsp = {
          -- `lsp.color` (plugin-managed document colors) is deprecated.
          -- Prefer using Neovim's native API when available.
          on_attach = function(client, bufnr)
            -- Enable native document color support if available
            if vim.lsp and vim.lsp.document_color and type(vim.lsp.document_color.enable) == "function" then
              pcall(vim.lsp.document_color.enable)
            end

            vim.keymap.set("n", "<leader>fr", "<cmd>FlutterReload<CR>", { buffer = bufnr })
            vim.keymap.set("n", "<leader>fs", "<cmd>FlutterRestart<CR>", { buffer = bufnr })
            vim.keymap.set("n", "<leader>fp", "<cmd>FlutterRun<CR>", { buffer = bufnr })
          end,
        },
      })
    end,
  },
  {
    "dart-lang/dart-vim-plugin",
    ft = { "dart" },
  },
}
