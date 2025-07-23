local M = {}

--- The main setup function for the entire plugin.
-- This function orchestrates the setup of all sub-modules.
-- @param opts A table of configuration options provided by the user.
function M.setup(opts)
	-- 1. Define the default configuration
	local defaults = {
		register = "n",
		clear_message = "Notification log cleared.",
		copy_message = "Notification log copied to clipboard.",
		empty_message = "Notification log is empty.",
		plugin_name = "Notify Log",
	}

	-- 2. Create the final configuration by merging user opts with defaults
	local config = vim.tbl_deep_extend("force", opts or {}, defaults)

	-- 3. Initialize the sub-modules with the final config
	require("notify-log.core").setup(config)
	require("notify-log.commands").setup(config)
end

return M
