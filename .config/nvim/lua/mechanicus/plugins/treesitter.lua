return {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local treesitter = require('nvim-treesitter')
      treesitter.setup()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "*",
        callback = function(ev)
          pcall(vim.treesitter.start)
          vim.bo[ev.buf].indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
        end,
      }) 
    end
  }
