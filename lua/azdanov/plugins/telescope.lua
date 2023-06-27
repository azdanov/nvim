return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "debugloop/telescope-undo.nvim",
    },
    config = function()
        require("telescope").setup {
            defaults = {
                mappings = {
                    i = {
                        ["<C-u>"] = false,
                        ["<C-d>"] = false,
                    },
                },
            },
            extensions = {
                undo = {
                    side_by_side = true,
                    layout_strategy = "vertical",
                    layout_config = {
                        preview_height = 0.6,
                    },
                    mappings = {
                        i = {
                            ["<s-cr>"] = require("telescope-undo.actions").yank_additions,
                            ["<c-cr>"] = require("telescope-undo.actions").yank_deletions,
                            ["<cr>"] = require("telescope-undo.actions").restore,
                        },
                    },
                },
            },
        }

        vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles,
            { desc = "[?] Find recently opened files" })
        vim.keymap.set("n", "<leader><space>", require("telescope.builtin").buffers,
            { desc = "[ ] Find existing buffers" })
        vim.keymap.set("n", "<leader>/", function()
            require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
                winblend = 10,
                previewer = false,
            })
        end, { desc = "[/] Fuzzily search in current buffer" })

        vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
        vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
        vim.keymap.set("n", "<leader>sw", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
        vim.keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })

        require("telescope").load_extension("undo")
        vim.keymap.set("n", "<leader>u", require("telescope").extensions.undo.undo, { desc = "[U]ndo tree" })
    end
}
