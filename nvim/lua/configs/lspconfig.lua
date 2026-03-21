require("nvchad.configs.lspconfig").defaults()

-- add the servers you want enabled here (ensure the binaries are installed)
local servers = { "html", "cssls", "ts_ls" }

vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers 
