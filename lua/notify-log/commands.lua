local M = {}

--- Creates the user-facing commands for the plugin.
-- @param config The plugin's configuration table (used for command descriptions).
function M.setup(config)
	-- We require the core module to get access to its functions.
	local core = require("notify-log.core")

	-- Create the command to clear the log.
	-- Notice the second argument is now just a reference to the core.clear function.
	vim.api.nvim_create_user_command("ClearNotifyLog", core.clear, {
		desc = "Clears the notification log from the '" .. config.register .. "' register",
	})

	-- Create the command to copy the log.
	vim.api.nvim_create_user_command("CopyNotifyLog", core.copy, {
		desc = "Copies the notification log to the system clipboard",
	})
end

return M
