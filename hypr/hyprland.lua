-- #######################################################################################
-- HYPRLAND CONFIG — Lua format (Hyprland 0.55+)
-- Converted from the old hyprlang (.conf) syntax to the real hl.* Lua API.
-- Docs: https://wiki.hypr.land/Configuring/Start/
-- #######################################################################################

------------------
---- MONITORS ----
------------------
-- https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output   = "HDMI-A-1",
    mode     = "1920x1080@100",
    position = "auto",
    scale    = "auto",
})

---------------------
---- MY PROGRAMS ----
---------------------
local terminal    = "kitty"
local fileManager  = "thunar"
local menu         = "wofi --show drun --layer-shell"

-------------------
---- AUTOSTART ----
-------------------
-- https://wiki.hypr.land/Configuring/Basics/Autostart/
-- exec-once no longer exists as a keyword; hook into the hyprland.start event instead.
hl.on("hyprland.start", function()
hl.exec_cmd("vicinae server")
hl.exec_cmd("hyrpidle")

hl.exec_cmd("waybar")
hl.exec_cmd("hyprpaper")
hl.exec_cmd("swww-daemon")
hl.exec_cmd("sleep 0.5 && swww img /home/ahmed-work/Pictures/wallhaven-5yd6d5_1920x1080.png --transition-type none")
hl.exec_cmd("/home/ahmed-work/.config/waybar/toggle.sh")
hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=Hyprland")
hl.exec_cmd("/usr/lib/xdg-desktop-portal-hyprland")
hl.exec_cmd("/usr/lib/xdg-desktop-portal -r")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------
-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-----------------------
----- PERMISSIONS -----
-----------------------
-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Permission changes require a Hyprland restart (not applied live, for security).
hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")

-----------------------
---- LOOK AND FEEL ----
-----------------------
-- https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    general = {
        gaps_in     = 5,
        gaps_out    = 5,
        border_size = 1,
        col = {
            active_border = { colors = { "rgba(247, 236, 190, 1)", "rgba(233, 206, 98, 1)" }, angle = 45 },
          -- inactive_border = "rgba(595959aa)",
        },
        resize_on_border = true,
        allow_tearing    = false,
        layout           = "dwindle",
    },

    decoration = {
        rounding       = 9,
        rounding_power = 4,

        active_opacity   = 1.0,
        inactive_opacity = 0.7,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = "rgba(1a1a1aee)",
        },

        blur = {
            enabled            = true,
            size               = 4,
            passes             = 2,
            ignore_opacity     = true,
            xray               = false,
            new_optimizations  = true,
            vibrancy           = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },
})

-- FIXED


-- In your hyprland config
-- Bezier curves — https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("default", { type = "bezier", points = { { 0.12, 0.92 }, { 0.08, 1.0 } } })
hl.curve("wind", { type = "bezier", points = { { 0.12, 0.92 }, { 0.08, 1.0 } } })
hl.curve("overshot", { type = "bezier", points = { { 0.18, 0.95 }, { 0.22, 1.03 } } })
hl.curve("linear", { type = "bezier", points = { { 1, 1 }, { 1, 1 } } })

hl.animation({ leaf = "windows", enabled = true, speed = 5, bezier = "wind", style = "popin 60%" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 6, bezier = "overshot", style = "popin 60%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 4, bezier = "overshot", style = "popin 60%" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 4, bezier = "overshot", style = "slide" })
hl.animation({ leaf = "layers", enabled = true, speed = 4, bezier = "default", style = "popin" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 7, bezier = "default" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 7, bezier = "default" })
hl.animation({ leaf = "fadeSwitch", enabled = true, speed = 7, bezier = "default" })
hl.animation({ leaf = "fadeShadow", enabled = true, speed = 7, bezier = "default" })
hl.animation({ leaf = "fadeDim", enabled = true, speed = 7, bezier = "default" })
hl.animation({ leaf = "fadeLayers", enabled = true, speed = 7, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 4, bezier = "overshot", style = "slide" })
hl.animation({
    leaf = "specialWorkspace",
    enabled = true,
    speed = 5,
    bezier = "overshot",
    style = "slidefadevert 100%",
})
hl.animation({ leaf = "border", enabled = true, speed = 1, bezier = "linear" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 24, bezier = "linear", style = "loop" })

-- Smart gaps / "no gaps when only" — uncomment if you want it
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]", gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({ name = "no-gaps-wtv1", match = { float = false, workspace = "w[tv1]" }, border_size = 0, rounding = 0 })
-- hl.window_rule({ name = "no-gaps-f1", match = { float = false, workspace = "f[1]" }, border_size = 0, rounding = 0 })

-- Dwindle layout — https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/
hl.config({
    dwindle = {
        preserve_split = true,
    },
})

-- Master layout — https://wiki.hypr.land/Configuring/Layouts/Master-Layout/
hl.config({
    master = {
        new_status = "master",
    },
})

----------------
---- MISC -----
----------------
hl.config({
    misc = {
        force_default_wallpaper  = -1,
            disable_hyprland_logo    = false,
    },
})

---------------
---- INPUT ----
---------------
hl.config({
    input = {
        kb_layout    = "us,ara",
        kb_variant   = "",
        kb_options   = "grp:win_space_toggle",
        follow_mouse = 1,
        sensitivity  = 0,
        touchpad = {
            natural_scroll = false,
        },
    },
})

-- accel_profile is a per-device setting in the new API, not a global `input` key.
-- Run `hyprctl devices` to find your real pointer device name and swap it in below.
hl.device({
    name          = "your-mouse-device-name",
    accel_profile = "flat",
})

-- Gestures — https://wiki.hypr.land/Configuring/Advanced-and-Cool/Gestures/
hl.gesture({
    fingers   = 3,
    direction = "horizontal",
    action    = "workspace",
})

-- Example per-device config
hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})

---------------------
---- KEYBINDINGS ----
---------------------
local mainMod = "SUPER"

hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))

hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("vicinae toggle"))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())          -- dwindle
hl.bind(mainMod .. " + S", hl.dsp.layout("swapsplit"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("zen-browser"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))

-- Screenshots
hl.bind(mainMod .. " + PRINT", hl.dsp.exec_cmd("hyprshot -m window"))
hl.bind("PRINT",               hl.dsp.exec_cmd("hyprshot -m output"))
hl.bind("SHIFT + PRINT",       hl.dsp.exec_cmd("hyprshot -m region"))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9], move window with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,          hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key,  hl.dsp.window.move({ workspace = i }))
    end

    -- Special workspace (scratchpad)
    -- NOTE: your original .conf also bound mainMod+S to this, colliding with swapsplit above.
    -- I moved it to mainMod+SHIFT+S here so both actually work; adjust as you like.
    hl.bind(mainMod .. " + SHIFT + S", hl.dsp.workspace.toggle_special("magic"))

    -- Scroll through workspaces with mainMod + scroll
    hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
    hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

    -- Move/resize windows with mainMod + LMB/RMB drag
    hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
    hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

    -- Multimedia keys (volume / brightness)
    hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
    hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),       { locked = true, repeating = true })
    hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),      { locked = true, repeating = true })
    hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),    { locked = true, repeating = true })
    hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                   { locked = true, repeating = true })
    hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                   { locked = true, repeating = true })

    -- Media keys (require playerctl)
    hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
    hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
    hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
    hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

    --------------------------------
    ---- WINDOWS AND WORKSPACES ----
    --------------------------------
    -- https://wiki.hypr.land/Configuring/Basics/Window-Rules/
    -- https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

    -- Ignore maximize requests from apps (uncomment to enable)
    -- hl.window_rule({ name = "suppress-maximize", match = { class = ".*" }, suppress_event = "maximize" })

    -- Fix XWayland drag issues (uncomment to enable)
    -- hl.window_rule({
    --     name = "fix-xwayland-drags",
--     match = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false },
--     no_focus = true,
-- })

-- Thunar transparency (background-only via GTK CSS)
hl.window_rule({
    match = { class = "^(thunar)$" },
    opacity = "1.0 override 1.0 override",
})

-- Layer rule: blur the wofi launcher
hl.layer_rule({
    name  = "wofi-blur",
    match = { namespace = "^(wofi)$" },
              blur  = true,
})

hl.layer_rule({
    name = "vicinae-blur",
    match = { namespace = "vicinae" },
    blur = true,
})

layerrule = blur,vicinae

-- Add this to your window rules section
-- In your hyprland.lua
-- In your hyprland.lua
