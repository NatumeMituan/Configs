return
---@type LazySpec
{
    -- https://github.com/mikavilpas/yazi.nvim
    "mikavilpas/yazi.nvim",
    dependencies = {
        -- https://github.com/folke/snacks.nvim
        "folke/snacks.nvim"
    },
    -- https://github.com/mikavilpas/yazi.nvim?tab=readme-ov-file#using-lazynvim
    keys = {
        {
            "<leader>fy",
            "<cmd>Yazi<cr>",
            desc = "Open yazi",
        },
        {
            "<leader>y",
            "<cmd>Yazi<cr>",
            desc = "Open yazi",
        },
        {
            "<leader>fY",
            "<cmd>Yazi cwd<cr>",
            desc = "Open yazi (cwd)",
        },
        {
            "<c-y>",
            "<cmd>Yazi toggle<cr>",
            desc = "Resume the last yazi session",
        },
    },
    config = true,
}
