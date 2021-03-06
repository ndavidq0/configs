local out = {}
local actions = require('telescope.actions')

require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ['<esc>'] = actions.close,
      }
    },
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
    prompt_position = "top",
    prompt_prefix = " > ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    layout_strategy = "flex",
    layout_defaults = {
      horizontal = {
        width_padding = 0.08,
        height_padding = 0.1,
        preview_width = 0.45,
      },
      vertical = {
        width_padding = 0.05,
        height_padding = 1,
        preview_height = 0.5,
      }
    },
    file_sorter =  require'telescope.sorters'.get_fzy_sorter,
    file_ignore_patterns = {'%%'}, -- previewer doesn't work well with %'s
    generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
    shorten_path = true,
    winblend = 0,
    width = 0.75,
    preview_cutoff = 120,
    results_height = 1,
    results_width = 0.1,
    border = {},
    borderchars = {"─", "│", "─", "│", "╭", "╮", "╯", "╰"},
    color_devicons = true,
    use_less = true,
    set_env = { ['COLORTERM'] = 'truecolor' },
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker,
  },
  extensions = {
    frecency = {
      show_scores = true,
    },
    fzy_native = {
      override_generic_sorter = false,
      override_file_sorter = true,
    }
  }
}

-- Load extensions
require'telescope'.load_extension("frecency")
require'telescope'.load_extension("fzy_native")

-- Search config dir
out.search_config = function()
  require('telescope.builtin').find_files({
    prompt_title = 'CONFIG',
    cwd = vim.fn.stdpath('config')
  })
end

-- Git branches
out.git_branches = function()
  require('telescope.builtin').git_branches({
    attach_mappings = function(_, map)
      map('i', '<c-e>', actions.git_delete_branch)
      map('n', '<c-e>', actions.git_delete_branch)
      return true
    end
  })
end

return out
