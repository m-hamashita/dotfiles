-- https://github.com/ipatch/dotfiles/blob/master/jobs/macos/Users/mr-fancy/hammerspoon/ctrlDoublePress.lua
local alert    = require("hs.alert")
local timer    = require("hs.timer")
local eventtap = require("hs.eventtap")

local events   = eventtap.event.types

local module   = {}

-- how quickly must the two single ctrl taps occur?
module.timeFrame = 1

-- what to do when the double tap of ctrl occurs
module.action = function()
    local spaces = require("hs._asm.undocumented.spaces")
    local kitty = hs.application.get("kitty")

    local activeSpace = spaces.activeSpace()
    local spaceArray = spaces.query(spaces.masks.allspaces, true)

    local activeSpaceIndex
    -- hs.alert.show(activeSpace)
    for i, v in pairs(spaceArray) do
        -- hs.alert.show(v)
        if v == activeSpace then
            activeSpaceIndex = #spaceArray-i+1
        end
    end
    -- hs.alert.show(activeSpaceIndex)

    if kitty == nil then
        hs.application.launchOrFocus("/Applications/kitty.app")
    elseif kitty:isFrontmost() then
        kitty:hide()
    else -- すでに存在する場合、window を activeSpace に移動させて focus する
        local win = kitty:focusedWindow()
        local uuid = win:screen():spacesUUID()
        local spaceID = spaces.layout()[uuid][activeSpaceIndex]
        spaces.moveWindowToSpace(win:id(), spaceID)
        hs.application.launchOrFocus("/Applications/kitty.app")
    end
end

hs.hotkey.bind({"ctrl"}, ".", function()
  local vscode = hs.application.find('Code')
  -- hs.alert.show(vscode)
  if vscode:isFrontmost() then
    vscode:hide()
  else
    hs.application.launchOrFocus("Visual Studio Code")
  end
end)

-- Synopsis:

-- what we're looking for is 4 events within a set time period and no intervening other key events:
--  flagsChanged with only ctrl = true
--  flagsChanged with all = false
--  flagsChanged with only ctrl = true
--  flagsChanged with all = false


local timeFirstControl, firstDown, secondDown = 0, false, false

-- verify that no keyboard flags are being pressed
local noFlags = function(ev)
    local result = true
    for k,v in pairs(ev:getFlags()) do
        if v then
            result = false
            break
        end
    end
    return result
end

-- verify that *only* the ctrl key flag is being pressed
local onlyCtrl = function(ev)
    local result = ev:getFlags().ctrl
    for k,v in pairs(ev:getFlags()) do
        if k ~= "ctrl" and v then
            result = false
            break
        end
    end
    return result
end

-- the actual workhorse

module.eventWatcher = eventtap.new({events.flagsChanged, events.keyDown}, function(ev)
    -- if it's been too long; previous state doesn't matter
    if (timer.secondsSinceEpoch() - timeFirstControl) > module.timeFrame then
        timeFirstControl, firstDown, secondDown = 0, false, false
    end

    if ev:getType() == events.flagsChanged then
        if noFlags(ev) and firstDown and secondDown then -- ctrl up and we've seen two, so do action
            if module.action then module.action() end
            timeFirstControl, firstDown, secondDown = 0, false, false
        elseif onlyCtrl(ev) and not firstDown then         -- ctrl down and it's a first
            firstDown = true
            timeFirstControl = timer.secondsSinceEpoch()
        elseif onlyCtrl(ev) and firstDown then             -- ctrl down and it's the second
            secondDown = true
        elseif not noFlags(ev) then                        -- otherwise reset and start over
            timeFirstControl, firstDown, secondDown = 0, false, false
        end
    else -- it was a key press, so not a lone ctrl char -- we don't care about it
        timeFirstControl, firstDown, secondDown = 0, false, false
    end
    return false
end):start()

return module
