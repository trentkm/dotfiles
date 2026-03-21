-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "blossom_light",

	-- hl_override = {
	-- 	Comment = { italic = true },
	-- 	["@comment"] = { italic = true },
	-- },
}

M.nvdash = {
	load_on_startup = true,
	header = {
		"   _                   _   _               ",
		"  | |                 | | | |              ",
		"  | |_ _ __ ___ _ __  | |_| | ___ __ ___   ",
		"  | __| '__/ _ \\ '_ \\ | __| |/ / '_ ` _ \\  ",
		"  | |_| | |  __/ | | || |_|   <| | | | | | ",
		"   \\__|_|  \\___|_| |_| \\__|_|\\_\\_| |_| |_| ",
	},
}
-- M.ui = {
--       tabufline = {
--          lazyload = false
--      }
-- }

return M
