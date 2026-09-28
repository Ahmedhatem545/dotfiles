return  {
   "nvim-telescope/telescope.nvim",
   version = "*",
   dependencies = {
      "nvim-lua/plenary.nvim",
      {
         "nvim-telescope/telescope-fzf-native.nvim",
         build = "make",
      },
   },

   config = function()
      require("telescope").setup()

      -- Optimize sorting with the fzf native extension
      require("telescope").load_extension("fzf")

      local builtin = require("telescope.builtin")

      vim.keymap.set(
         "n",
         "<leader>ff",
         builtin.find_files,
         { desc = "Find files" }
      )

      vim.keymap.set(
         "n",
         "<leader>fg",
         builtin.live_grep,
         { desc = "Live grep" }
      )

      vim.keymap.set(
         "n",
         "<leader>fb",
         builtin.buffers,
         { desc = "Buffers" }
      )

      vim.keymap.set(
         "n",
         "<leader>fh",
         builtin.help_tags,
         { desc = "Help tags" }
      )
   end,
   {
      "nvim-telescope/telescope-ui-select.nvim",
      config = function()
         require("telescope").setup {
            extensions = {
               ["ui-select"] = {
                  require("telescope.themes").get_dropdown {
                     -- even more opts
                  }

               }
            }
         }

         require("telescope").load_extension("ui-select")
      end
   },
}
