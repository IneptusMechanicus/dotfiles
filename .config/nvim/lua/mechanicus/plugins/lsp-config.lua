return {
  'williamboman/mason.nvim',
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
    'hrsh7th/cmp-nvim-lsp',
  },
  config = function()
    require('mason').setup()

    local vim = vim
    local mason_lspconfig = require('mason-lspconfig')
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(args)
        print('Should Attach');
        local opts = { buffer = args.buf }
        -- Disable semanticTokensProvider if causing issues (as in your original config)
        if vim.lsp.get_client_by_id(args.data.client_id) then
          vim.lsp.get_client_by_id(args.data.client_id).server_capabilities.semanticTokensProvider = nil
        end

        -- Keymaps (these remain largely the same)
        vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, { desc = 'Code Action', buffer = args.buf })
        vim.keymap.set('n', '<leader>lc', vim.lsp.buf.declaration, { desc = 'Go To Declaration', buffer = args.buf })
        vim.keymap.set('n', '<leader>lf', vim.lsp.buf.definition, { desc = 'Go To Definition', buffer = args.buf })
        vim.keymap.set('n', '<leader>li', vim.lsp.buf.implementation, { desc = 'Go To Implementation', buffer = args.buf })
        vim.keymap.set('n', '<leader>ll', vim.diagnostic.open_float, { desc = 'Show Diagnostic Message', buffer = args.buf })
        vim.keymap.set('n', '<leader>lr', vim.lsp.buf.references, { desc = 'List References', buffer = args.buf })
        vim.keymap.set('n', '<leader>lh', vim.lsp.buf.hover, { desc = 'Hover', buffer = args.buf })
        vim.keymap.set('n', '<leader>ls', vim.lsp.buf.signature_help, { desc = 'Signature Help', buffer = args.buf })
        vim.keymap.set('n', '<leader>l[', vim.diagnostic.goto_prev, { desc = 'Previous Diagnostic', buffer = args.buf })
        vim.keymap.set('n', '<leader>l]', vim.diagnostic.goto_next, { desc = 'Next Diagnostic', buffer = args.buf })
      end
    })

    for key, server in ipairs(mason_lspconfig.get_installed_servers()) do
        if server == 'rust_analyzer' then
          config = {
            capabilities = capabilities,
            filetypes = {'rust'},
            cmd = {'rust_analyzer'},
            settings = {
              ['rust-analyzer'] = {
                diagnostics = {
                  enable = true,
                  disabled = { 'unresolved-proc-macro' },
                  enableExperimental = true,
                },
              },
            },
          }
        elseif server == 'ts_ls' then
          config = {
            capabilities = capabilities,
            filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
            cmd = { "typescript-language-server", "--stdio" },
            root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" }
          }
        elseif server == 'lua_ls' then
          config = {
             on_init = function(client)
              if client.workspace_folders then
                local path = client.workspace_folders[1].name
                if
                  path ~= vim.fn.stdpath('config')
                  and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
                then
                  return
                end
              end

              client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                runtime = {
                  version = 'LuaJIT',
                  path = { 'lua/?.lua', 'lua/?/init.lua' },
                },
                workspace = {
                  checkThirdParty = false,
                  library = {
                    vim.env.VIMRUNTIME
                  }
                }
              })
            end,
            settings = { Lua = {} }
          }
        elseif server == 'astro' then
          config = {
            capabilities = capabilities,
            filetypes = { 'astro' },
            cmd = { "astro-ls", "--stdio" },
            root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" }
          }
        end
        vim.lsp.config(server, config);
        vim.lsp.enable(server)
    end

    -- Enable all Mason-installed servers
    vim.diagnostic.config({
      virtual_text = false,
      severity_sort = true,
      float = {
        border = 'rounded',
        source = 'always',
      },
    })

    local signs = { Error = ' ', Warn = ' ', Hint = '󰌶 ', Info = ' ' }
    for type, icon in pairs(signs) do
      local hl = 'DiagnosticSign' .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end
    print('LSP setup done with native APIs!')
  end,
}
