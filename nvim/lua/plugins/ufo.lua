-- https://github.com/kevinhwang91/nvim-ufo?tab=readme-ov-file#customize-fold-text
local handler = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix = (' 󰁂 %d '):format(endLnum - lnum)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0
    for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
        else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
        end
        curWidth = curWidth + chunkWidth
    end
    table.insert(newVirtText, { suffix, 'MoreMsg' })
    return newVirtText
end

return {
    -- https://github.com/kevinhwang91/nvim-ufo
    'kevinhwang91/nvim-ufo',
    event = "VeryLazy",
    dependencies = {
        'kevinhwang91/promise-async',
    },
    opts = {
        provider_selector = function(_, _, _)
            return { 'treesitter', 'indent' }
        end,
        fold_virt_text_handler = handler,
    },
    config = function(_, opts)
        vim.o.foldlevel = 99;
        vim.opt.foldlevelstart = 99;

        require('ufo').setup(opts);
        vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
        vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
        vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds)
        vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)

        local ufo = require('ufo')
        for i = 1, 9 do
            vim.keymap.set('n', '<A-' .. i .. '>', function() ufo.closeFoldsWith(i - 1) end)
        end
        vim.keymap.set('n', '<A-0>', ufo.openAllFolds)
    end,
}
