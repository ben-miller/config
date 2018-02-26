local application = require "mjolnir.application"
local hotkey = require "mjolnir.hotkey"
local window = require "mjolnir.window"
local screen = require "mjolnir.screen"
local grid = require "mjolnir.sd.grid"
local fnutils = require "mjolnir.fnutils"
local appfinder = require "mjolnir.cmsj.appfinder"
local alert = require "mjolnir.alert"
local inspect = require "inspect"
local _ = require "moses"

-- Declare and call sandbox function
local sandbox = function()
  local get_screen = function(screen_name)
    return _.filter(screen.allscreens(), function(i,v)
      return v:name() == screen_name
    end)[1]
  end

  local laptop_screen = get_screen("Color LCD")
  local asus_screen = get_screen("ASUS VE278")

  local app = appfinder.app_from_name("Google Chrome")
  grid.set(app:mainwindow(), {x=0,y=0,w=3,h=2}, asus_screen)
end
--sandbox()

-- Reload this script
hotkey.bind({"cmd", "alt", "ctrl"}, "return", function()
  mjolnir.reload()
end)

-- Log info to Mjolnir console
hotkey.bind({"cmd", "alt", "ctrl"}, "L", function()
  print("Applications:")
  _.each(application.runningapplications(), function(i,v)
    print("", v:title())
  end)
  print("Current Application:", window.focusedwindow():application():title())

  print("Screens:")
  _.each(screen.allscreens(), function(k,v)
    print("  name:", v:name())
    _.each(v:frame(), function(kk,vv)
      print("", kk, vv)
    end)
  end)

  mjolnir.focus()
end)

local hold_keys = {"cmd","alt","ctrl"}
local super_hold_keys = {"shift","alt"}

-- Key bindings for app focusing
local app_keys = {
  ["J"] = "Firefox";
  ["K"] = "iTerm";
  ["H"] = "Google Chrome";
  ["D"] = "Dash";
  ["N"] = "Finder";
  ["E"] = "emacs";
  ["M"] = "Mjolnir";
}
_.each(app_keys, function(k,v)
  hotkey.bind(hold_keys, k, function()
    application.launchorfocus(v)
  end)
end)

local get_screen = function(screen_name)
  return _.filter(screen.allscreens(), function(i,v)
    return v:name() == screen_name
  end)[1]
end

local laptop_screen = get_screen("Color LCD")
local asus_screen = get_screen("ASUS VE278")

local chrome = appfinder.app_from_name("Google Chrome")
local iterm = appfinder.app_from_name("iTerm")
local ios = appfinder.app_from_name("iOS Simulator")

local to_screen = function(app, screen)
  local full_grid = {x=0,y=0,w=3,h=2}
  local win = app:mainwindow()
  if app == ios then
    win = ios:allwindows()[1]
  end
  if screen then
    grid.set(win, full_grid, screen)
    win:maximize()
  end
end

-- Snap current window to grid
hotkey.bind(hold_keys, "'", function()
  grid.snap(window.focusedwindow())
end)

-- Maximize/minimize current window
hotkey.bind(hold_keys, "=", function()
  window.focusedwindow():maximize()
end)
hotkey.bind(hold_keys, "-", function()
  window.focusedwindow():minimize()
end)

grid.GRIDWIDTH = 6

local hz_states = {
  {x=0,y=0,w=2,h=2},
  {x=0,y=0,w=3,h=2},
  {x=0,y=0,w=4,h=2},
  {x=1,y=0,w=4,h=2},
  {x=2,y=0,w=4,h=2},
  {x=3,y=0,w=3,h=2},
  {x=4,y=0,w=2,h=2}
}

local get_hz_state = function(win)
  local cell = grid.get(win)
  local state = _.filter(hz_states, function(k,v)
    return _.isEqual(cell, v)
  end)[1]
  return _.indexOf(hz_states, state)
end
local set_hz_state = function(win, state)
  local new_cell = hz_states[state]
  grid.set(win, new_cell, screen.mainscreen())
end

-- Move window to left/right two-thirds of screen
hotkey.bind(hold_keys, "left", function()
  local win = window.focusedwindow()
  local state = get_hz_state(win) or 3
  set_hz_state(win, math.max(1, state - 1))
end)
hotkey.bind(hold_keys, "right", function()
  local win = window.focusedwindow()
  local state = get_hz_state(win) or 2
  set_hz_state(win, math.min(_.count(hz_states), state + 1))
end)

-- Center current window
hotkey.bind(hold_keys, "\\", function()
  set_hz_state(window:focusedwindow(), 4)
end)

-- Browse Chrome with iTerm at bottom
hotkey.bind(super_hold_keys, "G", function()
  to_screen(chrome, asus_screen)
  to_screen(iterm, laptop_screen)
  chrome:activate()
end)

-- Use iTerm with Chrome at bottom
hotkey.bind(super_hold_keys, "I", function()
  to_screen(iterm, asus_screen)
  to_screen(chrome, laptop_screen)
  iterm:activate()
end)

-- Use both iTerm and Chrome in top screen
hotkey.bind(super_hold_keys, "=", function()
  to_screen(chrome, asus_screen)
  set_hz_state(chrome:mainwindow(), 2)
  to_screen(iterm, asus_screen)
  set_hz_state(iterm:mainwindow(), 3)
end)

-- iOS development workflow
hotkey.bind(super_hold_keys, "O", function()
  alert.show("iOS Workflow", 2)
  -- iTerm
  to_screen(iterm, asus_screen)
  local iterm_width = asus_screen:frame().w - 386 -- iOS Sim is 386 wide
  local f = iterm:mainwindow():frame()
  f.x = 0
  f.w = iterm_width
  iterm:mainwindow():setframe(f)
  iterm:activate()

  if ios and ios:allwindows() and ios:allwindows()[1] then
    -- iOS Simulator
    to_screen(ios, asus_screen)
    local ios_window = ios:allwindows()[1]
    local f = ios_window:frame()
    f.x = iterm_width
    f.y = asus_screen:frame().y
    ios_window:setframe(f)
  end
end)
