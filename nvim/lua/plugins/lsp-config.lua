return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- Define the servers you want to configure
      -- Changed 'tsserver' to 'ts_ls' to match the recent upstream rename
      local servers = { "ts_ls", "solargraph", "html_ls", "lua_ls", "dartls" }
      
      -- Loop through the servers and use the new Neovim 0.11+ native API
      for _, lsp in ipairs(servers) do
        vim.lsp.config(lsp, {
          capabilities = capabilities
        })
        vim.lsp.enable(lsp)
      end

      -- LSP Keymaps
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
    end,
  },
}
