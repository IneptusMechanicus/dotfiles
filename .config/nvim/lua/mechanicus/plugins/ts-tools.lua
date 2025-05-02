return {
  "pmizio/typescript-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  opts = {},
  config = function ()
   require("typescript-tools").setup {
      on_attach = on_attach,
      filetypes = {
        "javascript",
        "typescript",
        "vue",
      },
      settings = {
        single_file_support = false,
        tsserver_plugins = {
          "@vue/typescript-plugin",
        },
      },
    }
  end
}
