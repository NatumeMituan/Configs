return {
    -- https://github.com/lukas-reineke/indent-blankline.nvim
    "lukas-reineke/indent-blankline.nvim",
    event = 'LazyFile',
    main = "ibl",
    cond = false,
    ---@module "ibl"
    ---@type ibl.config
    opts = {}
}
