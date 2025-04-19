return {
    -- https://github.com/neovim/nvim-lspconfig
    'neovim/nvim-lspconfig',
    version = "*",
    event = "LazyFile",
    dependencies = { {
        -- https://github.com/williamboman/mason.nvim
        'williamboman/mason.nvim',
        build = ':MasonUpdate',
        config = true
    }, {
        -- https://github.com/williamboman/mason-lspconfig.nvim
        'williamboman/mason-lspconfig.nvim',
        dependencies = {
            -- https://github.com/hrsh7th/cmp-nvim-lsp
            "hrsh7th/cmp-nvim-lsp"
        },
        opts = {
            ensure_installed = { 'clangd', 'lua_ls', 'rust_analyzer' }
        }
    } },
    config = function()
        local lspconfig = require('lspconfig')
        local mason_lspconfig = require('mason-lspconfig')

        -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

        -- This function is called when an LSP server is attached to a buffer
        local on_attach = function(_, bufnr)
            local nmap = function(keys, func, desc)
                vim.keymap.set('n', keys, func, {
                    buffer = bufnr,
                    desc = desc
                })
            end
            -- Reference:
            --   - https://www.lazyvim.org/keymaps#lsp
            --   - https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/lsp/keymaps.lua
            -- nmap('gd', vim.lsp.buf.definition, 'Goto Definition')
            nmap('gD', vim.lsp.buf.declaration, 'Goto Declaration')
            -- nmap('gi', vim.lsp.buf.implementation, 'Goto Implementation')
            -- nmap('gr', vim.lsp.buf.references, 'Goto References')
            -- nmap('gt', vim.lsp.buf.type_definition, 'Goto Type Definition')
            nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
            nmap('gK', vim.lsp.buf.signature_help, 'Signature Help')
            nmap('<leader>ca', vim.lsp.buf.code_action, 'Code Action')
            nmap('<leader>cl', '<cmd>LspInfo<cr>', 'Lsp Info')
            nmap('<leader>cr', vim.lsp.buf.rename, 'Code Rename')
        end

        -- See `:h mason-lspconfig-automatic-server-setup`
        mason_lspconfig.setup_handlers({
            function(server_name)
                lspconfig[server_name].setup({
                    capabilities = capabilities,
                    on_attach = on_attach
                })
            end
        })
    end
}
