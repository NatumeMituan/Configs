return {
    -- https://github.com/lewis6991/gitsigns.nvim
    "lewis6991/gitsigns.nvim",
    event = "LazyFile",
    opts = {
        -- Reference:
        --   - https://github.com/lewis6991/gitsigns.nvim?tab=readme-ov-file#%EF%B8%8F-installation--usage
        --   - https://www.lazyvim.org/plugins/editor#gitsignsnvim
        signs = {
            add = { text = "▎" },
            change = { text = "▎" },
            delete = { text = "" },
            topdelete = { text = "" },
            changedelete = { text = "▎" },
            untracked = { text = "▎" },
        },
        signs_staged = {
            add = { text = "▎" },
            change = { text = "▎" },
            delete = { text = "" },
            topdelete = { text = "" },
            changedelete = { text = "▎" },
        },
        current_line_blame = true,
        -- word_diff = true,
        on_attach = function(buffer)
            local gs = package.loaded.gitsigns

            local function map(mode, l, r, desc)
                vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
            end

            -- Navigation
            map("n", "]c", function()
                -- Git diff mode, `bang=true` to force the cursor movement
                if vim.wo.diff then
                    vim.cmd.normal({ "]c", bang = true })
                else
                    gs.nav_hunk("next")
                end
            end, "Next Hunk")
            map("n", "[c", function()
                if vim.wo.diff then
                    vim.cmd.normal({ "[c", bang = true })
                else
                    gs.nav_hunk("prev")
                end
            end, "Prev Hunk")
            map("n", "]C", function() gs.nav_hunk("last") end, "Last Hunk")
            map("n", "[C", function() gs.nav_hunk("first") end, "First Hunk")

            -- Actions
            map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
            map("n", "<leader>ghB", gs.blame, "Blame Buffer")
            map("n", "<leader>ghd", gs.diffthis, "Diff against Index")
            map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff against HEAD")
            map("n", "<leader>ghr", gs.reset_hunk, "Reset Hunk")
            map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
            map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
            map("n", "<leader>ghP", gs.preview_hunk, "Preview Hunk")
            map("n", "<leader>ghs", gs.stage_hunk, "Stage Hunk")
            map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
            map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")

            -- Toggle
            map("n", "<leader>ghl", gs.toggle_linehl, "Toggle Git Line Highlight")
            -- e.g. `yih` to yank the hunk
            map({ "o", "x" }, "ih", gs.select_hunk, "GitSigns Select Hunk")
        end,
    },
}
