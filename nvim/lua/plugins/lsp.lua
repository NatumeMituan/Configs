local icons = {
    Error = " ",
    Warn  = " ",
    Hint  = " ",
    Info  = " ",
}

return {
    -- https://github.com/neovim/nvim-lspconfig
    'neovim/nvim-lspconfig',
    version = "*",
    event = "VeryLazy",
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
            ensure_installed = { 'clangd', 'lua_ls', 'pylsp', 'rust_analyzer', 'taplo' }
        }
    } },
    opts = {
        -- https://github.com/LazyVim/LazyVim/blob/ec5981dfb1222c3bf246d9bcaa713d5cfa486fbd/lua/lazyvim/plugins/lsp/init.lua#L15
        diagnostics = {
            underline = true,
            update_in_insert = false,
            severity_sort = true,
            virtual_text = {
                spacing = 4,
            },
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = icons.Error,
                    [vim.diagnostic.severity.WARN] = icons.Warn,
                    [vim.diagnostic.severity.HINT] = icons.Hint,
                    [vim.diagnostic.severity.INFO] = icons.Info,
                },
            },
        },
    },
    config = function(_, opts)
        opts.diagnostics.virtual_text.prefix = function(diagnostic)
            for d, icon in pairs(icons) do
                if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
                    return icon
                end
            end
        end

        vim.diagnostic.config(opts.diagnostics)

        -- See `h: LspAttach`
        vim.api.nvim_create_autocmd('LspAttach', {
            callback = function(args)
                local nmap = function(keys, func, desc)
                    vim.keymap.set('n', keys, func, {
                        buffer = args.buf,
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
                -- nmap('gy', vim.lsp.buf.type_definition, 'Goto Type Definition')
                nmap('K', function() vim.lsp.buf.hover({ border = 'rounded' }) end, 'Hover Documentation')
                nmap('gK', vim.lsp.buf.signature_help, 'Signature Help')
                nmap('<leader>ca', vim.lsp.buf.code_action, 'Code Action')
                nmap('<leader>cl', '<cmd>LspInfo<cr>', 'Lsp Info')
                nmap('<leader>cr', vim.lsp.buf.rename, 'Code Rename')

                -- words
                -- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/lsp/keymaps.lua
                nmap("]]", function() Snacks.words.jump(vim.v.count1, true) end, "Next Reference")
                nmap("[[", function() Snacks.words.jump(-vim.v.count1, true) end, "Prev Reference")
                vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
            end
        })

        -- https://github.com/hrsh7th/cmp-nvim-lsp?tab=readme-ov-file#setup
        vim.lsp.config('*', {
            capabilities = require('cmp_nvim_lsp').default_capabilities(),
        })

        -- See `:h lsp-quickstart`
        -- https://rust-analyzer.github.io/book/other_editors.html#nvim-lsp
        vim.lsp.config('rust_analyzer', {
            settings = {
                ["rust-analyzer"] = {
                    imports = {
                        granularity = {
                            group = "module",
                        },
                        prefix = "self",
                    },
                    cargo = {
                        buildScripts = {
                            enable = true,
                        },
                    },
                    procMacro = {
                        enable = true
                    },
                },
            },
        })
    end
}
