-- wezterm configuration
local wezterm = require 'wezterm'

local config = {}

-- Font size adjustment
config.font_size = 10.0 -- Default is often 11 or 12, reduce to make smaller

-- You can also adjust DPI scaling or use specific font
config.font = wezterm.font('HackGen35 Console NF')
-- config.dpi = 96.0

return config