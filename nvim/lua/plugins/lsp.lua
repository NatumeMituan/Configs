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
                if desc then
                    desc = 'LSP: ' .. desc
                end

                vim.keymap.set('n', keys, func, {
                    buffer = bufnr,
                    desc = desc
                })
            end

            nmap('gd', vim.lsp.buf.definition, '[g]oto [d]efinition')
            nmap('gD', vim.lsp.buf.declaration, '[d]oto [D]eclaration')
            nmap('gi', vim.lsp.buf.implementation, '[g]oto [i]mplementation')
            nmap('gr', vim.lsp.buf.references, '[g]oto [r]eferences')
            nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
            nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
            nmap('<leader>rn', vim.lsp.buf.rename, '[r]e[n]ame')
            nmap('<leader>ca', vim.lsp.buf.code_action, '[c]ode [a]ction')
            nmap('<leader>f',
                function()
                    vim.lsp.buf.format({
                        async = false
                    })
                    vim.diagnostic.show(bufnr)
                end, '[f]ormat')
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
