return {
    -- https://github.com/nvim-telescope/telescope.nvim
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    branch = '0.1.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        -- https://github.com/nvim-telescope/telescope-fzf-native.nvim
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
            enabled = vim.fn.executable('make') == 1,
        }
    },
    keys = function()
        -- Reference:
        --   - https://github.com/nvim-telescope/telescope.nvim?tab=readme-ov-file#usage
        --   - https://www.lazyvim.org/extras/editor/telescope#telescopenvim
        --   - https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/editor/telescope.lua
        return {
            -- frequently used
            {
                "<leader>,",
                "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
                desc = "Buffers",
            },
            { "<leader>/",       "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search Current Buffer" },
            { "<leader>:",       "<cmd>Telescope command_history<cr>",           desc = "Search Command History" },
            { "<leader><space>", '<cmd>Telescope find_files<cr>',                desc = 'Find Files' },

            -- file
            {
                "<leader>fb",
                "<cmd>Telescope buffers sort_mru=true sort_lastused=true ignore_current_buffer=true<cr>",
                desc = "Other Buffers",
            },
            { '<leader>ff', '<cmd>Telescope find_files<cr>',                    desc = 'Find Files' },
            { '<leader>fg', '<cmd>Telescope git_files<cr>',                     desc = 'Git Files' },
            { '<leader>fr', '<cmd>Telescope oldfiles<cr>',                      desc = 'Recent Files' },

            -- git
            -- { "<leader>gc", "<cmd>Telescope git_commits<CR>",                   desc = "Git Commits" },
            { '<leader>gs', '<cmd>Telescope git_status<cr>',                    desc = 'Git Status' },

            -- search
            -- { '<leader>s"', "<cmd>Telescope registers<cr>",                     desc = "Search Registers" },
            { "<leader>sa", "<cmd>Telescope autocommands<cr>",                  desc = "Search Auto Commands" },
            { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>",     desc = "Search Current Buffer" },
            { "<leader>sc", "<cmd>Telescope command_history<cr>",               desc = "Search Command History" },
            { "<leader>sC", "<cmd>Telescope commands<cr>",                      desc = "Search Commands" },
            { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>",           desc = "Search Diagnostics" },
            { "<leader>sD", "<cmd>Telescope diagnostics<cr>",                   desc = "Search Diagnostics (Workspace)" },
            { '<leader>sg', '<cmd>Telescope live_grep<cr>',                     desc = 'Search by Grep' },
            { "<leader>sh", "<cmd>Telescope help_tags<cr>",                     desc = "Search Help Pages" },
            -- { "<leader>sH", "<cmd>Telescope highlights<cr>",                    desc = "Search Highlight Groups" },
            -- { "<leader>sj", "<cmd>Telescope jumplist<cr>",                      desc = "Search Jumplist" },
            { "<leader>sk", "<cmd>Telescope keymaps<cr>",                       desc = "Search Key Maps" },
            -- { "<leader>sl", "<cmd>Telescope loclist<cr>",                       desc = "Search Location List" },
            { "<leader>sm", "<cmd>Telescope marks<cr>",                         desc = "Search Marks" },
            -- { "<leader>sM", "<cmd>Telescope man_pages<cr>",                     desc = "Search Man Pages" },
            { "<leader>so", "<cmd>Telescope vim_options<cr>",                   desc = "Search Options" },
            { "<leader>sR", "<cmd>Telescope resume<cr>",                        desc = "Search Resume" },
            { "<leader>sq", "<cmd>Telescope quickfix<cr>",                      desc = "Search Quickfix List" },
            { '<leader>sw', '<cmd>Telescope grep_string<cr>',                   desc = 'Search Current Word' },

            { '<leader>ss', '<cmd>Telescope lsp_document_symbols<cr>',          desc = 'Search Symbols' },
            { '<leader>sS', '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>', desc = 'Search Symbols (Workspace)' },

            -- goto
            { 'gd',         '<cmd>Telescope lsp_definitions<cr>',               desc = 'Goto Definitions' },
            { 'gi',         '<cmd>Telescope lsp_implementations<cr>',           desc = 'Goto Implementations' },
            { 'gr',         '<cmd>Telescope lsp_references<cr>',                desc = 'Goto References' },
            { 'gy',         '<cmd>Telescope lsp_type_definitions<cr>',          desc = 'Goto Type Definitions' },

        }
    end,

    -- A function instead of a table for lazy loading
    opts = function()
        local ta = require('telescope.actions')
        return {
            defaults = {
                prompt_prefix = " ",
                selection_caret = " ",
                mappings = {
                    i = {
                        ['<C-j>'] = ta.move_selection_next,
                        ['<C-k>'] = ta.move_selection_previous,
                        ["<C-d>"] = ta.preview_scrolling_down,
                        ["<C-u>"] = ta.preview_scrolling_up,
                        ["<C-Down>"] = ta.cycle_history_next,
                        ["<C-Up>"] = ta.cycle_history_prev,
                    },
                    n = {
                        ['q'] = ta.close,
                    }
                },
                layout_config = {
                    horizontal = {
                        width = 0.95,
                        preview_width = 0.6
                    }
                },
            }
        }
    end,
    config = function(_, opts)
        local ts = require('telescope')
        ts.setup(opts)
        -- https://github.com/nvim-telescope/telescope-fzf-native.nvim?tab=readme-ov-file#telescope-setup-and-configuration
        -- `:lua print(vim.inspect(require("telescope").extensions))` to check
        ts.load_extension('fzf')
    end

}
