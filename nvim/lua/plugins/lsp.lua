return {
    -- https://github.com/neovim/nvim-lspconfig
    "neovim/nvim-lspconfig",
    dependencies = {{
        -- https://github.com/williamboman/mason.nvim
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        config = true
    }, {
        -- https://github.com/williamboman/mason-lspconfig.nvim
        "williamboman/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {"lua_ls", "rust_analyzer"}
        }
    }},

    -- See :h mason-lspconfig-automatic-server-setup
    config = function()
        local lspconfig = require("lspconfig")
        local mason_lspconfig = require("mason-lspconfig")

        mason_lspconfig.setup_handlers({function(server_name)
            lspconfig[server_name].setup({})
        end})
    end
}
