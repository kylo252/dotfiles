

--      ██╗  ██╗███████╗██╗   ██╗███████╗
--      ██║ ██╔╝██╔════╝╚██╗ ██╔╝██╔════╝
--      █████╔╝ █████╗   ╚████╔╝ ███████╗
--      ██╔═██╗ ██╔══╝    ╚██╔╝  ╚════██║
--      ██║  ██╗███████╗   ██║   ███████║
--      ╚═╝  ╚═╝╚══════╝   ╚═╝   ╚══════╝


-- ===================================================================
-- Initialization
-- ===================================================================

local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local lain          = require("lain")
local hotkeys_popup = require("awful.hotkeys_popup")
                      require("awful.hotkeys_popup.keys")

-- Define mod keys
local modkey = "Mod4"
local altkey = "Mod1"

local vi_focus     = false -- vi-like client focus https://github.com/lcpz/awesome-copycats/issues/275
local cycle_prev   = true  -- cycle with only the previously focused client or all https://github.com/lcpz/awesome-copycats/issues/274

-- define module table
local keys = {}

local apps = {
    terminal = "kitty",
    browser = "flatpak run com.github.Eloston.UngoogledChromium --enable-features=WebUIDarkMode --force-dark-mode --enable-native-gpu-memory-buffers %U --incognito",
    edge = "microsoft-edge",
    teams = "teams",
    launcher = "rofi -show combi",
    quickmenue = "rofi -show run -theme dmenu ",
    filemanager = "pcmanfm",
    screenshot = "flameshot gui"
}

-- ===================================================================
-- Movement Functions (Called by some keybinds)
-- ===================================================================

-- Move given client to given direction
local function move_client(c, direction)
   -- If client is floating, move to edge
   if c.floating or (awful.layout.get(mouse.screen) == awful.layout.suit.floating) then
      local workarea = awful.screen.focused().workarea
      if direction == "up" then
         c:geometry({nil, y = workarea.y + beautiful.useless_gap * 2, nil, nil})
      elseif direction == "down" then
         c:geometry({nil, y = workarea.height + workarea.y - c:geometry().height - beautiful.useless_gap * 2 - beautiful.border_width * 2, nil, nil})
      elseif direction == "left" then
         c:geometry({x = workarea.x + beautiful.useless_gap * 2, nil, nil, nil})
      elseif direction == "right" then
         c:geometry({x = workarea.width + workarea.x - c:geometry().width - beautiful.useless_gap * 2 - beautiful.border_width * 2, nil, nil, nil})
      end
   -- Otherwise swap the client in the tiled layout
   elseif awful.layout.get(mouse.screen) == awful.layout.suit.max then
      if direction == "up" or direction == "left" then
         awful.client.swap.byidx(-1, c)
      elseif direction == "down" or direction == "right" then
         awful.client.swap.byidx(1, c)
      end
   else
      awful.client.swap.bydirection(direction, c, nil)
   end
end


-- Resize client in given direction
local floating_resize_amount = dpi(20)
local tiling_resize_factor = 0.05

local function resize_client(c, direction)
   if awful.layout.get(mouse.screen) == awful.layout.suit.floating or (c and c.floating) then
      if direction == "up" then
         c:relative_move(0, 0, 0, -floating_resize_amount)
      elseif direction == "down" then
         c:relative_move(0, 0, 0, floating_resize_amount)
      elseif direction == "left" then
         c:relative_move(0, 0, -floating_resize_amount, 0)
      elseif direction == "right" then
         c:relative_move(0, 0, floating_resize_amount, 0)
      end
   else
      if direction == "up" then
         awful.client.incwfact(-tiling_resize_factor)
      elseif direction == "down" then
         awful.client.incwfact(tiling_resize_factor)
      elseif direction == "left" then
         awful.tag.incmwfact(-tiling_resize_factor)
      elseif direction == "right" then
         awful.tag.incmwfact(tiling_resize_factor)
      end
   end
end


-- raise focused client
local function raise_client()
   if client.focus then
      client.focus:raise()
   end
end


-- ===================================================================
-- Mouse bindings
-- ===================================================================


-- Mouse buttons on the desktop
keys.desktopbuttons = gears.table.join(
   -- left click on desktop to hide notification
   awful.button({}, 1,
      function ()
         naughty.destroy_all_notifications()
      end
   ),
   awful.button({ }, 4, awful.tag.viewnext),
   awful.button({ }, 5, awful.tag.viewprev)
)

-- Mouse buttons on the client
keys.clientbuttons = gears.table.join(
   -- Raise client
   awful.button({}, 1,
      function(c)
         client.focus = c
         c:raise()
      end
   ),

   -- Move and Resize Client
   awful.button({modkey}, 1, awful.mouse.client.move),
   awful.button({modkey}, 3, awful.mouse.client.resize)
)


-- ===================================================================
-- Desktop Key bindings
-- ===================================================================
keys.globalkeys = gears.table.join(
   -- =========================================
   -- LAUNCHER
   -- =========================================
 
    -- Take a screenshot
    -- https://github.com/lcpz/dots/blob/master/bin/screenshot
    awful.key({ altkey }, "p", function() os.execute("screenshot") end,
              {description = "take a screenshot", group = "hotkeys"}),

    awful.key({ modkey }, "p", function() awful.spawn(apps.screenshot) end,
              {description = "open flameshot", group = "hotkeys"}),

    awful.key({modkey}, "x", function() awful.spawn(apps.terminal) end,
            {description = "open a terminal", group = "launcher"}),

    awful.key({modkey}, "r", function() awful.spawn(apps.launcher) end,
            {description = "rofi launcher", group = "launcher"}),
 
    awful.key({modkey}, "t", function() awful.spawn(apps.quickmenue) end,
            {description = "rofi menu", group = "launcher"}),

    awful.key({ modkey }, "g", function () awful.spawn(apps.browser) end,
            {description = "run browser", group = "launcher"}),

    awful.key({ modkey }, "e", function () awful.spawn(apps.filemanager) end,
            {description = "run file manager", group = "launcher"}),


   -- =========================================
   -- GENERAL
   -- =========================================

    -- Show/hide wibox
    awful.key({ modkey }, "b",
        function ()
            for s in screen do
                s.mywibox.visible = not s.mywibox.visible
                if s.mybottomwibox then
                    s.mybottomwibox.visible = not s.mybottomwibox.visible
                end
            end
        end,
        {description = "toggle wibox", group = "awesome"}
    ),

    -- Reload Awesome
    awful.key({modkey, "Control"}, "r",
       awesome.restart,
       {description = "reload awesome", group = "awesome"}
    ),

    -- Quit Awesome
    awful.key({modkey}, "F4",
       function()
          -- emit signal to show the exit screen
          awesome.emit_signal("show_exit_screen")
       end,
       {description = "toggle exit screen", group = "awesome"}
    ),


    -- Show help
    awful.key({ modkey }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),

  -- Non-empty tag browsing
    awful.key({ modkey, altkey }, "Left", function () lain.util.tag_view_nonempty(-1) end,
            {description = "view  previous nonempty", group = "awesome"}),

    awful.key({ modkey, altkey }, "Right", function () lain.util.tag_view_nonempty(1) end,
            {description = "view  previous nonempty", group = "awesome"}),

    -- X screen locker
    awful.key({ altkey, "Control" }, "l", function () os.execute(scrlocker) end,
              {description = "lock screen", group = "awesome"}),

    -- Dropdown application
    awful.key({ modkey, }, "z", function () awful.screen.focused().quake:toggle() end,
              {description = "dropdown application", group = "awesome"}),

   -- =========================================
   -- CLIENT FOCUSING
   -- =========================================

   -- Focus client by direction (arrow keys)
    awful.key({modkey}, "Down",
       function()
          awful.client.focus.bydirection("down")
          raise_client()
       end,
       {description = "focus down", group = "focus"}
    ),
    awful.key({modkey}, "Up",
       function()
          awful.client.focus.bydirection("up")
          raise_client()
       end,
       {description = "focus up", group = "focus"}
    ),
    awful.key({modkey}, "Left",
       function()
          awful.client.focus.bydirection("left")
          raise_client()
       end,
       {description = "focus left", group = "focus"}
    ),
    awful.key({modkey}, "Right",
       function()
          awful.client.focus.bydirection("right")
          raise_client()
       end,
       {description = "focus right", group = "focus"}
    ),

    -- Focus client by index (cycle through clients)
    awful.key({altkey}, "Tab", function() awful.client.focus.byidx(1) end,
       {description = "focus next by index", group = "focus"}),

    awful.key({altkey, "Shift"}, "Tab", function() awful.client.focus.byidx(-1) end,
       {description = "focus previous by index", group = "focus"}),

   -- Focus screen by index (cycle through screens)
    awful.key({modkey}, "t", function() awful.screen.focus_relative(1) end,
        {description = "focus previous by index", group = "focus"}),



   -- =========================================
   -- LAYOUT CONTROL
   -- =========================================

   -- Number of master clients
   awful.key({modkey, altkey}, "h",
      function()
         awful.tag.incnmaster( 1, nil, true)
      end,
      {description = "increase the number of master clients", group = "layout"}
   ),
   awful.key({ modkey, altkey }, "l",
      function()
         awful.tag.incnmaster(-1, nil, true)
      end,
      {description = "decrease the number of master clients", group = "layout"}
   ),
   -- awful.key({ modkey, altkey }, "Left",
   --    function()
   --       awful.tag.incnmaster( 1, nil, true)
   --    end,
   --    {description = "increase the number of master clients", group = "layout"}
   -- ),
   -- awful.key({ modkey, altkey }, "Right",
   --    function()
   --       awful.tag.incnmaster(-1, nil, true)
   --    end,
   --    {description = "decrease the number of master clients", group = "layout"}
   -- ),

   -- Number of columns
   awful.key({modkey, altkey}, "k",
      function()
         awful.tag.incncol(1, nil, true)
      end,
      {description = "increase the number of columns", group = "layout"}
   ),
   awful.key({modkey, altkey}, "j",
      function()
         awful.tag.incncol(-1, nil, true)
      end,
      {description = "decrease the number of columns", group = "layout"}
   ),
   -- awful.key({modkey, altkey}, "Up",
   --    function()
   --       awful.tag.incncol(1, nil, true)
   --    end,
   --    {description = "increase the number of columns", group = "layout"}
   -- ),
   -- awful.key({modkey, altkey}, "Down",
   --    function()
   --       awful.tag.incncol(-1, nil, true)
   --    end,
   --    {description = "decrease the number of columns", group = "layout"}
   -- ),

    -- On-the-fly useless gaps change
    awful.key({ altkey, "Control" }, "+", function () lain.util.useless_gaps_resize(1) end,
        {description = "increment useless gaps", group = "layout"}),
    awful.key({ altkey, "Control" }, "-", function () lain.util.useless_gaps_resize(-1) end,
        {description = "decrement useless gaps", group = "layout"}),

    -- select next layout
    awful.key({modkey}, "space", function() awful.layout.inc(1) end,
        {description = "select next", group = "layout"}),

    -- select previous layout
    awful.key({modkey, "Shift"}, "space", function() awful.layout.inc(-1) end,
        {description = "select previous", group = "layout"})
)


-- ===================================================================
-- Client Key bindings
-- ===================================================================

keys.clientkeys = gears.table.join(

   -- Client resizing
   awful.key({modkey, "Control"}, "Down",
      function(c)
         resize_client(client.focus, "down")
      end
   ),
   awful.key({modkey, "Control"}, "Up",
      function(c)
         resize_client(client.focus, "up")
      end
   ),
   awful.key({modkey, "Control"}, "Left",
      function(c)
         resize_client(client.focus, "left")
      end
   ),
   awful.key({modkey, "Control"}, "Right",
      function(c)
         resize_client(client.focus, "right")
      end
   ),

   -- Move to edge or swap by direction
   awful.key({modkey, "Shift"}, "Down",
      function(c)
         move_client(c, "down")
      end
   ),
   awful.key({modkey, "Shift"}, "Up",
      function(c)
         move_client(c, "up")
      end
   ),
   awful.key({modkey, "Shift"}, "Left",
      function(c)
         move_client(c, "left")
      end
   ),
   awful.key({modkey, "Shift"}, "Right",
      function(c)
         move_client(c, "right")
      end
   ),
   awful.key({modkey, "Shift"}, "j",
      function(c)
         move_client(c, "down")
      end
   ),
   awful.key({modkey, "Shift"}, "k",
      function(c)
         move_client(c, "up")
      end
   ),
   awful.key({modkey, "Shift"}, "h",
      function(c)
         move_client(c, "left")
      end
   ),
   awful.key({modkey, "Shift"}, "l",
      function(c)
         move_client(c, "right")
      end
   ),

   -- toggle fullscreen
   awful.key({modkey}, "f",
      function(c)
         c.fullscreen = not c.fullscreen
      end,
      {description = "toggle fullscreen", group = "client"}
   ),
    -- restore minimized client
    awful.key({modkey, "Shift"}, "n",
       function()
          local c = awful.client.restore()
          -- Focus restored client
          if c then
             client.focus = c
             c:raise()
          end
       end,
       {description = "restore minimized", group = "client"}
    ),
   -- close client
    awful.key({modkey}, "q",
        function(c)
            c:kill()
        end,
        {description = "close", group = "client"}
    ),

    -- Max-Min
    awful.key({modkey}, "d",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({modkey}, "Return",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),
    awful.key({ modkey, "Shift" }, "Return",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),
    awful.key({ modkey, "Control"   }, "Return",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"}),

    -- on top
    awful.key({ modkey }, "t", function (c) c.ontop = not c.ontop end,
        {description = "toggle keep on top", group = "client"}),

   -- =========================================
   -- FUNCTION KEYS
   -- =========================================

   -- Brightness
    awful.key({}, "XF86MonBrightnessUp",
       function()
          awful.spawn("xbacklight -inc 10", false)
       end,
       {description = "+10%", group = "hotkeys"}
    ),
    awful.key({}, "XF86MonBrightnessDown",
       function()
          awful.spawn("xbacklight -dec 10", false)
       end,
       {description = "-10%", group = "hotkeys"}
    ),
    awful.key({}, "XF86PowerOff",
       function()
          -- emit signal to show the exit screen
          awesome.emit_signal("show_exit_screen")
       end,
       {description = "toggle exit screen", group = "awesome"}
    ),
    -- ALSA volume control
    awful.key({}, "XF86AudioRaiseVolume",
       function()
          awful.spawn("amixer -D pulse sset Master 5%+", false)
          awesome.emit_signal("volume_change")
       end,
       {description = "volume up", group = "hotkeys"}
    ),
    awful.key({}, "XF86AudioLowerVolume",
       function()
          awful.spawn("amixer -D pulse sset Master 5%-", false)
          awesome.emit_signal("volume_change")
       end,
       {description = "volume down", group = "hotkeys"}
    ),
    awful.key({}, "XF86AudioMute",
       function()
          awful.spawn("amixer -D pulse set Master 1+ toggle", false)
          awesome.emit_signal("volume_change")
       end,
       {description = "toggle mute", group = "hotkeys"}
    ),
    awful.key({}, "XF86AudioNext",
       function()
          awful.spawn("mpc next", false)
       end,
       {description = "next music", group = "hotkeys"}
    ),
    awful.key({}, "XF86AudioPrev",
       function()
          awful.spawn("mpc prev", false)
       end,
       {description = "previous music", group = "hotkeys"}
    ),
    awful.key({}, "XF86AudioPlay",
       function()
          awful.spawn("mpc toggle", false)
       end,
       {description = "play/pause music", group = "hotkeys"}
    ),

   -- Screenshot on prtscn using scrot
   awful.key({}, "Print",
      function()
         awful.util.spawn(apps.screenshot, false)
      end,
    {description = "play/pause music", group = "hotkeys"}),

    -- Copy primary to clipboard (terminals to gtk)
    awful.key({ modkey }, "c", function () awful.spawn.with_shell("xsel | xsel -i -b") end,
              {description = "copy terminal to gtk", group = "hotkeys"}),
    -- Copy clipboard to primary (gtk to terminals)
    awful.key({ modkey }, "v", function () awful.spawn.with_shell("xsel -b | xsel") end,
              {description = "copy gtk to terminal", group = "hotkeys"})

)
   -- =========================================
   -- TAG BUTTONS
   -- =========================================


-- Bind all key numbers to tags
for i = 1, 9 do
   keys.globalkeys = gears.table.join(keys.globalkeys,
      -- Switch to tag
      awful.key({modkey}, "#" .. i + 9,
         function()
            local screen = awful.screen.focused()
            local tag = screen.tags[i]
            if tag then
               tag:view_only()
            end
         end,
         {description = "view tag #"..i, group = "tag"}),
      -- Move client to tag
      awful.key({modkey, "Shift"}, "#" .. i + 9,
         function()
            if client.focus then
               local tag = client.focus.screen.tags[i]
               if tag then
                  client.focus:move_to_tag(tag)
               end
            end
         end,
         {description = "move focused client to tag #"..i, group = "tag"})
   )
end

-- }}}
return keys
