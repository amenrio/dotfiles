return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('telescope').setup {
        defaults = {
          border = false,
          file_ignore_patterns = {
            "venv"
          }
        }
      }
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>\\', builtin.find_files, { desc = "Telescope [S]earch [F]iles" })
      vim.keymap.set('n', '<leader>sl', builtin.live_grep, { desc = "Telescope [S]earch [L]ive grep" })
      vim.keymap.set('n', '<leader>s/', builtin.current_buffer_fuzzy_find,
        { desc = "Telescope [S]earch [/] Current Buffer" })
      vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = "Telescope [S]earch [B]uffers" })
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = "Telescope [S]earch [H]elp" })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = "Telescope [S]earch [K]eymaps" })
    end
  }
}

