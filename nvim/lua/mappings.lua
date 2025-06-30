require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
--
-- Select entire file
map("n", "<C-a>", "ggVG", { desc = "Select all content" })

-- Mapeo para abrir Telescope (buscador de archivos)
map({ "n", "i", "v" }, "<C-z>", "<cmd>Telescope find_files<cr>", { desc = "Telescope find files" })

-- Mapeo para alternar NvimTree
map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle NvimTree" })

-- Mapeo para guardar con Ctrl+s en todos los modos
map({ "n", "i", "v" }, "<C-s>", "<cmd>w<cr>", { desc = "Save file" })

-- Mapeo para copiar al portapapeles del sistema
map("v", "<leader>y", '"+y', { desc = "Copy to system clipboard" })

-- Mapeo para salir con Ctrl+e en modos normal, inserción y visual
map({ "n", "i", "v" }, "<C-e>", "<cmd>q!<cr>", { desc = "Quit Neovim" })


map("n", "<C-Left>", "<C-w>h", { desc = "Mover a la ventana izquierda" })
map("n", "<C-Down>", "<C-w>j", { desc = "Mover a la ventana inferior" })
map("n", "<C-Up>", "<C-w>k", { desc = "Mover a la ventana superior" })
map("n", "<C-Right>", "<C-w>l", { desc = "Mover a la ventana derecha" })


map("n", "<C-S-Right>", "<cmd>vsplit<cr>", { desc = "Crear split vertical" })
map("n", "<C-S-Down>", "<cmd>split<cr>", { desc = "Crear split horizontal" })

map("n", "<C-A-Up>", ":resize +2<CR>", { desc = "Aumentar altura" })
map("n", "<C-A-Down>", ":resize -2<CR>", { desc = "Reducir altura" })
map("n", "<C-A-Left>", ":vertical resize -2<CR>", { desc = "Reducir ancho" })
map("n", "<C-A-Right>", ":vertical resize +2<CR>", { desc = "Aumentar ancho" })
map("n", "<leader>r", "<cmd>source $MYVIMRC<CR>", { desc = "Recargar config" })
-- Salir del modo terminal insert con Esc
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Salir del modo terminal" })

