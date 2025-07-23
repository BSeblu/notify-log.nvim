# notify-log.nvim

A minimalist Neovim plugin that captures all notifications from `vim.notify` into a dedicated register.

## Motivation

Have you ever seen an important error message from your LSP or linter flash by as a notification, only for it to disappear before you could fully read or copy it?

`notify-log.nvim` solves this simple problem by acting as a silent logger. It intercepts every message sent to `vim.notify`, and in addition to letting it display normally, it appends the message to a specific register, creating a persistent log of all notifications for your current session.

## Features

- **Silent Interception:** Automatically captures all `vim.notify` messages without altering their appearance.
- **Persistent Log:** Appends all notifications to a configurable named register.
- **Log Management:** Provides simple commands to clear the log or copy its entire contents to the system clipboard.
- **Lightweight & Simple:** Does one job and does it well, with no dependencies.

## Installation

Install the plugin with your favorite package manager.

### [Lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
-- Add this to your plugins list
return {
  "BSeblu/notify-log.nvim",
  event = "VeryLazy",
  opts = {
    -- configuration options here (see below)
  },
}
```

### [Packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use {
  "BSeblu/notify-log.nvim",
  config = function()
    require("notify-log").setup({
      -- configuration options here (see below)
    })
  end,
}
```

## Usage

The plugin works automatically once installed. All notifications will be logged to the configured register (default is `"n"`).

You can then use standard Vim commands to paste the log, for example: `"np` in normal mode will paste the contents of the notification log.

### Commands

The plugin provides two commands for managing the log:

- `:ClearNotifyLog`
  - Clears all captured content from the notification register.

- `:CopyNotifyLog`
  - Copies the entire content of the notification register to your system clipboard (`+` register).

## Configuration

The plugin is plug-and-play with sensible defaults, but you can override them by passing an `opts` table in Lazy.nvim or calling the `setup` function.

Here are the default settings:

```lua
-- For Lazy.nvim, you pass these in the `opts` table.
-- For other managers, you pass them to the `setup()` function.
{
  -- The named register to store notifications in.
  register = "n",

  -- The message to display when the log is cleared.
  clear_message = "Notification log cleared.",

  -- The message to display when the log is copied.
  copy_message = "Notification log copied to clipboard.",

  -- The message to display when trying to copy an empty log.
  empty_message = "Notification log is empty.",

  -- The title used for this plugin's own notifications.
  plugin_name = "Notify Log",
}
```

### Example: Custom Configuration with Lazy.nvim

```lua
return {
  "your-username/notify-log.nvim",
  event = "VeryLazy",
  opts = {
    register = "l", -- Log to the 'l' register instead of 'n'
    plugin_name = "Logger",
  },
}
```
