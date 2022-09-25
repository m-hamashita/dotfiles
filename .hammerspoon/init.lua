-- https://github.com/ipatch/dotfiles/blob/master/jobs/macos/Users/mr-fancy/hammerspoon/ctrlDoublePress.lua
local timer = require("hs.timer")
local eventtap = require("hs.eventtap")

local events = eventtap.event.types
local module = {}

raw_arch_name = io.popen('uname -m','r'):read('*l')
local spaces = require("hs._asm.undocumented.spaces_x86_64")
if raw_arch_name == 'arm64' then
    local spaces = require("hs._asm.undocumented.spaces") -- for arm64(M1)
end

-- double tap の間隔[s]
module.timeFrame = 1


function MoveFullScreenWindow(app)
    local activeSpace = spaces.activeSpace()
    local win = app:focusedWindow()
    win = win:toggleFullScreen()
    win = win:toggleFullScreen()
    app:hide()
    win:spacesMoveTo(activeSpace)
    win:focus()
end

-- double tap で toggle で kitty を表示/非表示する
module.action = function()
    local appName = "kitty"
    local app = hs.application.get(appName)

    if app == nil then
        hs.application.launchOrFocus(appName)
    elseif app:isFrontmost() then
        app:hide()
    else -- すでに存在する場合、window を activeSpace に移動させて focus する
        local activeSpace = spaces.activeSpace()
        local win = app:focusedWindow()
        win:spacesMoveTo(activeSpace)
        hs.application.launchOrFocus(appName)
    end
end


hs.hotkey.bind({"ctrl"}, "m", function()
    local appName = "Code"
    local activeSpace = spaces.activeSpace()
    local app = hs.application.find(appName)
    if app == nil then
        hs.application.launchOrFocus("Visual Studio Code")
    elseif app:isFrontmost() then
        app:hide()
    else
        local win = app:focusedWindow()
        win:spacesMoveTo(activeSpace)
        hs.application.launchOrFocus("Visual Studio Code")
    end
end)


-- module.action = function()
--     local appName = "Alacritty"
--     local activeSpace = spaces.activeSpace()
--     local app = hs.application.find(appName)
--     if app == nil then
--         hs.application.launchOrFocus(appName)
--     elseif app:isFrontmost() then
--         app:hide()
--     else
--         local win = app:focusedWindow()
--         win:spacesMoveTo(activeSpace)
--         hs.application.launchOrFocus(appName)
--     end
-- end

-- hs.hotkey.bind({"ctrl"}, "m", function()
--     local appName = "Spotify"
--     local activeSpace = spaces.activeSpace()
--     local app = hs.application.find(appName)
--     if app == nil then
--         hs.application.launchOrFocus(appName)
--     elseif app:isFrontmost() then
--         app:hide()
--     else
--         local win = app:focusedWindow()
--         win:spacesMoveTo(activeSpace)
--         hs.application.launchOrFocus(appName)
--     end
-- end)

hs.hotkey.bind({"ctrl"}, ",", function()
    local appName = "Slack"
    local activeSpace = spaces.activeSpace()
    local app = hs.application.find(appName)
    if app == nil then
        hs.application.launchOrFocus(appName)
    elseif app:isFrontmost() then
        app:hide()
    else
        local win = app:focusedWindow()
        win:spacesMoveTo(activeSpace)
        hs.application.launchOrFocus(appName)
    end
end)


hs.hotkey.bind({"ctrl"}, ".", function()
    local appName = "Google Chrome"
    local activeSpace = spaces.activeSpace()
    local app = hs.application.find(appName)
    if app == nil then
        hs.application.launchOrFocus(appName)
    elseif app:isFrontmost() then
        app:hide()
    else
        local win = app:focusedWindow()
        win:spacesMoveTo(activeSpace)
        hs.application.launchOrFocus(appName)
    end
end)


local timeFirstControl, firstDown, secondDown = 0, false, false
local noFlags = function(ev)
    local result = true
    for _, v in pairs(ev:getFlags()) do
        if v then
            result = false
            break
        end
    end
    return result
end

-- control だけ押されているか確認. 例えば shift+control 等は無視するようにする
local onlyCtrl = function(ev)
    local result = ev:getFlags().ctrl
    for k, v in pairs(ev:getFlags()) do
        if k ~= "ctrl" and v then
            result = false
            break
        end
    end
    return result
end

-- module.timeFrame 秒以内に2回 ctrl を押したらダブルタップとみなす
module.eventWatcher = eventtap.new({events.flagsChanged, events.keyDown}, function(ev)
    if (timer.secondsSinceEpoch() - timeFirstControl) > module.timeFrame then
        timeFirstControl, firstDown, secondDown = 0, false, false
    end

    if ev:getType() == events.flagsChanged then
        if noFlags(ev) and firstDown and secondDown then
            if module.action then module.action() end
            timeFirstControl, firstDown, secondDown = 0, false, false
        elseif onlyCtrl(ev) and not firstDown then
            firstDown = true
            timeFirstControl = timer.secondsSinceEpoch()
        elseif onlyCtrl(ev) and firstDown then
            secondDown = true
        elseif not noFlags(ev) then
            timeFirstControl, firstDown, secondDown = 0, false, false
        end
    else
        timeFirstControl, firstDown, secondDown = 0, false, false
    end
    return false
end):start()
