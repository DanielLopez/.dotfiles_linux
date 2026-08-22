-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

-- Add a new binding.
-- o.bind("SUPER + SHIFT + R", "SSH", "alacritty -e ssh your-server")

-- Change an existing binding by unbinding it first, then binding the key again.
-- This example changes SUPER+SPACE from the launcher to the Omarchy root menu.
-- hl.unbind("SUPER + SPACE")
-- o.bind("SUPER + SPACE", "Omarchy menu", "omarchy-menu toggle root")

-- Disable a default binding without replacing it.
-- hl.unbind("SUPER + SHIFT + B")

-- Logitech MX Keys examples:
-- o.bind("SUPER + SHIFT + S", nil, "omarchy-capture-screenshot")
-- o.bind("SUPER + H", nil, "voxtype record toggle")
-- o.bind("SUPER + PERIOD", nil, "omarchy-shell shell toggle omarchy.emojis")

-- Move conflicting default bindings to SUPER+ALT.
-- SUPER+J was Toggle window split; SUPER+K was Keybindings;
-- SUPER+L was Toggle workspace layout; SUPER+ALT+K was Tmux keybindings.
hl.unbind("SUPER + J")
o.bind("SUPER + ALT + J", "Toggle window split", hl.dsp.layout("togglesplit"))

hl.unbind("SUPER + K")
hl.unbind("SUPER + ALT + K")
o.bind("SUPER + ALT + K", "Keybindings", "omarchy-menu-keybindings")
o.bind("SUPER + SHIFT + CTRL + K", "Tmux keybindings", "omarchy-menu-tmux-keybindings")

hl.unbind("SUPER + L")
o.bind("SUPER + ALT + L", "Toggle workspace layout", "omarchy-hyprland-workspace-layout-toggle")

-- Move focus with uppercase Vim keys instead of the arrow keys.
hl.unbind("SUPER + LEFT")
hl.unbind("SUPER + DOWN")
hl.unbind("SUPER + UP")
hl.unbind("SUPER + RIGHT")

o.bind("SUPER + H", "Focus on left window", hl.dsp.focus({ direction = "l" }))
o.bind("SUPER + J", "Focus on below window", hl.dsp.focus({ direction = "d" }))
o.bind("SUPER + K", "Focus on above window", hl.dsp.focus({ direction = "u" }))
o.bind("SUPER + L", "Focus on right window", hl.dsp.focus({ direction = "r" }))

-- Swap windows in the tiling with SHIFT + vim keys.
o.bind("SUPER + SHIFT + H", "Swap window to the left", hl.dsp.window.swap({ direction = "l" }))
o.bind("SUPER + SHIFT + J", "Swap window down", hl.dsp.window.swap({ direction = "d" }))
o.bind("SUPER + SHIFT + K", "Swap window up", hl.dsp.window.swap({ direction = "u" }))
o.bind("SUPER + SHIFT + L", "Swap window right", hl.dsp.window.swap({ direction = "r" }))
