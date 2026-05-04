return {
  'williamboman/mason.nvim',
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
    'hrsh7th/cmp-nvim-lsp',
  },
  config = function()
    require('mason').setup()

    vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH
    local mason_lspconfig = require('mason-lspconfig')
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(args)
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
      local config = {
        capabilities = capabilities
      }
      if server == 'rust_analyzer' then
        config = {
          capabilities = capabilities,
          filetypes = {'rust'},
          cmd = {'rust-analyzer'},
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
          filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
          cmd = { "typescript-language-server", "--stdio" },
          root_markers = {
            "tsconfig.json",
            "jsconfig.json", 
          }
        }
      elseif server == 'lua_ls' then
        -- 1. Determine the root directory manually to decide on settings
        local cwd = vim.fn.getcwd()
        local is_nvim_config = cwd:find('nvim') or cwd:find('.config')

        local lua_settings = {
          Lua = {
            runtime = { version = 'LuaJIT' },
            workspace = { checkThirdParty = false },
          }
        }

        if is_nvim_config then
          lua_settings.Lua.diagnostics = { globals = { 'vim' } }
          lua_settings.Lua.workspace.library = { vim.env.VIMRUNTIME }
        end

        config = {
          filetypes = { 'lua' },
          cmd = { vim.fn.stdpath("data") .. "/mason/bin/lua-language-server" },
          root_markers = { '.luarc.json', '.luarc.jsonc', 'init.lua', '.git' },
          settings = lua_settings, -- Pass the settings here directly!
          on_init = function(client)
            -- We keep this only for a visual confirmation that it started
            vim.notify("lua_ls started for: " .. client.root_dir)
            return true
          end,
        }
      elseif server == 'astro' then
        config = {
          capabilities = capabilities,
          filetypes = { 'astro' },
          cmd = { "astro-ls", "--stdio" },
          root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" }
        }
      elseif server == 'eslint' then
        config = {
          capabilities = capabilities,
          cmd = { "vscode-eslint-language-server", "--stdio" },
          filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
          root_markers = { 'package.json', '.eslintrc.js', 'eslint.config.js' },
        }
      elseif server == 'ast_grep' then
        config = {
          capabilities = capabilities,
          filetypes = { 'javascript', 'typescript', 'rust', 'lua' },
          root_markers = { 'sgconfig.yml' },
          cmd = { "ast-grep", "lsp" },
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
