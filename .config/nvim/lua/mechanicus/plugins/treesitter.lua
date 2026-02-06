return {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local treesitter = require('nvim-treesitter')
      treesitter.setup()
      -- treesitter.install({
      --   'lua',
      --   'vim',
      --   'regex',
      --   'bash',
      --   'go',
      --   'markdown',
      --   'markdown_inline',
      --   'gdscript',
      --   'html',
      --   'css',
      --   'scss',
      --   'typescript',
      --   'javascript',
      --   'git_config',
      --   'gitcommit',
      --   'gitignore'
      -- })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "*",
        callback = function(ev)
          pcall(vim.treesitter.start, ev.buf)
        end,
      }) 
    end
  }
