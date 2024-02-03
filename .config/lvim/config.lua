--[[
lvim is the global options object

"Linters should be"
filled in as strings with either
a global executable or a path to
an executable
]]

-- general
lvim.log.level = "warn"
lvim.format_on_save = false

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
lvim.colorscheme = 'kanagawa'
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = false
-- Disable exec mode.
lvim.keys.normal_mode["Q"] = false

-- edit a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>"

-- Keybindings vim style
-- https://www.lunarvim.org/configuration/02-keybindings.html#vim-style
-- Use Esc to return to normal mode in terminal.
vim.cmd("tnoremap <Esc> <C-\\><C-n>")
vim.cmd("au FocusGained,BufEnter * :checktime")


vim.opt.wrap = true -- display lines as one long line
vim.opt.guifont = "JetBrains Mono:h10" -- display lines as one long line
vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
vim.opt.scrolloff = 8 -- Minimal number of screen lines to keep above and below the cursor.
vim.opt.sidescrolloff = 8 -- 	The minimal number of screen columns to keep to the left and to the right of the cursor if 'nowrap' is set.
vim.opt.title = true -- set the title of window to the value of the titlestring
-- vim.opt.title = true -- set the title of window to the value of the titlestring
-- vim.opt.titlestring = "%<%F%=%l/%L - nvim" -- what the title of the window will be set to
-- vim.opt.titlestring = [[%f %h%m%r%w %{v:progname} (%{tabpagenr()} of %{tabpagenr('$')})]]


-- BUILTINS
-- Lualine
lvim.builtin.lualine.options.theme = "auto"

-- Telescope
-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
--   i = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<C-n>"] = actions.cycle_history_next,
--     ["<C-p>"] = actions.cycle_history_prev,
--   },
--   -- for normal mode
--   n = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--   },
-- }

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnostics" },
-- }

-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
-- lvim.builtin.nvimtree.show_icons.git = 0

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "css",
  "dockerfile",
  "hcl",
  "html",
  "http",
  "javascript",
  "json",
  "lua",
  "php",
  "python",
  "tsx",
  "typescript",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

lvim.builtin.indentlines.options.use_treesitter = false

-- andymass/vim-matchup
lvim.builtin.treesitter.matchup.enable = true


-- generic LSP settings
-- add `intelephense` to `skipped_servers` list
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "intelephense" })

-- remove `pylsp` from `skipped_servers` list
lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
  return server ~= "pylsp"
end, lvim.lsp.automatic_configuration.skipped_servers)

-- ---@usage disable automatic installation of servers
-- lvim.lsp.automatic_servers_installation = false

-- ---@usage Select which servers should be configured manually. Requires `:LvimCacheReset` to take effect.
-- See the full default list `:lua print(vim.inspect(lvim.lsp.override))`
-- vim.list_extend(lvim.lsp.override, { "pyright" })

-- ---@usage setup a server -- see: https://www.lunarvim.org/languages/#overriding-the-default-configuration
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pylsp", opts)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "black", filetypes = { "python" } },
--   { command = "isort", filetypes = { "python" } },
--   {
--     -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "prettier",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--print-with", "100" },
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }

-- -- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--severity", "warning" },
--   },
--   {
--     command = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- }

-- Additional Plugins
lvim.plugins = {
  { "tpope/vim-repeat" },
  -- Make Vim handle line and column numbers in file names with a minimum of fuss.
  { "wsdjeg/vim-fetch" },
  -- Vim plugin which asks for the right file to open
  { "EinfachToll/DidYouMean" },
  -- Seamless tmux/vim navigation (over SSH too!)
  { "sunaku/tmux-navigate" },
  -- surround.vim: Delete/change/add parentheses/quotes/XML-tags/much more with
  -- ease.
  { "tpope/vim-surround",
  },
  -- numbers.vim is a vim plugin for better line numbers
  { "myusuf3/numbers.vim" },
  -- Smooth scrolling neovim plugin written in lua
  {
    "karb94/neoscroll.nvim",
    event = "WinScrolled",
    config = function()
      require('neoscroll').setup({
        -- All these keys will be mapped to their corresponding default scrolling animation
        mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>',
          '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
        hide_cursor = true, -- Hide cursor while scrolling
        stop_eof = true, -- Stop at <EOF> when scrolling downwards
        use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
        respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
        cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
        easing_function = nil, -- Default easing function
        pre_hook = nil, -- Function to run before the scrolling animation starts
        post_hook = nil, -- Function to run after the scrolling animation ends
      })
    end
  },
  -- white_check_mark Highlight, list and search todo comments in your projects
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup()
    end,
  },
  -- vim match-up: even better % fist_oncoming navigate and highlight matching
  -- words fist_oncoming modern matchit and matchparen
  {
    "andymass/vim-matchup",
    event = "CursorMoved",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup", fullwidth = 1, syntax_hl = 1 }
    end,
  },
  -- sleuth.vim: Heuristically set buffer options
  {
    "tpope/vim-sleuth",
  },
  {
    "tpope/vim-fugitive",
    cmd = {
      "G",
      "Git",
      "Gdiffsplit",
      "Gread",
      "Gwrite",
      "Ggrep",
      "GMove",
      "GDelete",
      "GBrowse",
      "GRemove",
      "GRename",
      "Glgrep",
      "Gedit"
    },
    ft = { "fugitive" }
  },
  { "lambdalisue/suda.vim",
    config = function()
      vim.g.suda_smart_edit = 1
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    priority = 1000 -- Ensure it loads first
  },
  -- {
  --   'nyngwang/NeoZoom.lua',
  --   config = function()
  --     require('neo-zoom').setup {
  --       winopts = {
  --         offset = {
  --           -- NOTE: you can omit `top` and/or `left` to center the floating window.
  --           -- top = 0,
  --           -- left = 0.17,
  --           width = 200,
  --           height = 0.9,
  --         },
  --         -- NOTE: check :help nvim_open_win() for possible border values.
  --         -- border = 'double',
  --       },
  --       exclude_filetypes = { 'lspinfo', 'mason', 'lazy', 'fzf', 'qf', 'spectre-panel' },
  --       exclude_buftypes = { 'terminal' },
  --       presets = {
  --         {
  --           filetypes = { 'dapui_.*', 'dap-repl' },
  --           config = {
  --             top = 0.25,
  --             left = 0.6,
  --             width = 0.4,
  --             height = 0.65,
  --           },
  --           callbacks = {
  --             function() vim.wo.wrap = true end,
  --           },
  --         },
  --       },
  --       -- popup = {
  --       --   -- NOTE: Add popup-effect (replace the window on-zoom with a `[No Name]`).
  --       --   -- This way you won't see two windows of the same buffer
  --       --   -- got updated at the same time.
  --       --   enabled = true,
  --       --   exclude_filetypes = {},
  --       --   exclude_buftypes = {},
  --       -- },
  --     }
  --     vim.keymap.set('n', '<CR>', function() vim.cmd('NeoZoomToggle') end, { silent = true, nowait = true })
  --   end
  -- },
  {
    'towolf/vim-helm',
  },
  {
    'NoahTheDuke/vim-just',
  },
}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = { "*.json", "*.jsonc" },
--   -- enable wrap mode for json files only
--   command = "setlocal wrap",
-- })
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })
-- Update titlestring on BufEnter.
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = "*",
--   callback = function()
--    set title titlestring=%{progname}\ %f\ #%{TmuxNavigateDirections()}
--    vim.opt.titlestring = "[[%f %h%m%r%w %{v:progname} (%{tabpagenr()} of %{tabpagenr('$')})]]"
--   end,
-- })
