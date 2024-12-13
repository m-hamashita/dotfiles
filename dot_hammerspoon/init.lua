-- https://github.com/ipatch/dotfiles/blob/master/jobs/macos/Users/mr-fancy/hammerspoon/ctrlDoublePress.lua
local timer = require("hs.timer")
local eventtap = require("hs.eventtap")

local events = eventtap.event.types
local module = {}

raw_arch_name = io.popen("uname -m", "r"):read("*l")
local spaces = require("hs._asm.undocumented.spaces_x86_64")
if raw_arch_name == "arm64" then
	local spaces = require("hs._asm.undocumented.spaces") -- for arm64(M1)
end

-- double tap の間隔[s]
module.timeFrame = 0.3

function MoveFullScreenWindow(app)
	local activeSpace = spaces.activeSpace()
	local win = app:focusedWindow()
	win = win:toggleFullScreen()
	win = win:toggleFullScreen()
	app:hide()
	win:spacesMoveTo(activeSpace)
	win:focus()
end

function FocusApp(app)
	local targetScreenUUID = hs.screen.primaryScreen():getUUID()
	if app == nil then
		hs.application.launchOrFocus(appName)
	elseif app:isFrontmost() then
		app:hide()
	else -- すでに存在する場合、window を activeSpace に移動させて focus する
		local activeSpace = spaces.activeSpace()
		-- primaryScreen のときは、activeSpace に移動させる
		if spaces.spaceScreenUUID(activeSpace) == targetScreenUUID then
			local win = app:focusedWindow()
			hs.spaces.moveWindowToSpace(win, activeSpace)
			app:setFrontmost()
		else
			app:unhide()
			app:activate()
			app:setFrontmost(true)
		end
	end
end

-- double tap で toggle で kitty を表示/非表示する
module.action = function()
	local appName = "kitty"
	local app = hs.application.get(appName)
	FocusApp(app)
end

hs.hotkey.bind({ "ctrl" }, "/", function()
	local appName = "Google Chrome"
	local app = hs.application.find(appName)
	FocusApp(app)
end)

hs.hotkey.bind({ "ctrl" }, "m", function()
	local appName = "Code"
	local app = hs.application.find(appName)
	FocusApp(app)
end)

hs.hotkey.bind({ "ctrl" }, ",", function()
	local appName = "Slack"
	local app = hs.application.find(appName)
	FocusApp(app)
end)

hs.hotkey.bind({ "ctrl" }, ".", function()
	local appName = "cursor"
	local app = hs.application.find(appName)
	FocusApp(app)
end)

local function inspectActiveWindow()
	local win = hs.window.focusedWindow()
	if not win then
		hs.alert("No active window found!")
		return
	end

	local frame = win:frame()
	print("x:", frame.x, "y:", frame.y, "w:", frame.w, "h:", frame.h)
	local application = win:application()
	print("application:", application:name())
	print("applidcation path:", application:path())
	print("bundleID:", application:bundleID())
	print("window title:", win:title())
	print("window size:", win:size())
end
-- hs.hotkey.bind({ "cmd", "shift" }, "I", inspectActiveWindow)

local function maximizeActiveWindow()
	local win = hs.window.focusedWindow()
	if not win then
		hs.alert("No active window found!")
		return
	end

	local frame = win:frame()
	frame.x = 0
	-- frame.y = 25
	frame.w = 2160
	-- frame.h = 1920
	win:setFrame(frame)
end
hs.hotkey.bind({ "cmd", "shift" }, "M", maximizeActiveWindow)

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
module.eventWatcher = eventtap
	.new({ events.flagsChanged, events.keyDown }, function(ev)
		if (timer.secondsSinceEpoch() - timeFirstControl) > module.timeFrame then
			timeFirstControl, firstDown, secondDown = 0, false, false
		end

		if ev:getType() == events.flagsChanged then
			if noFlags(ev) and firstDown and secondDown then
				if module.action then
					module.action()
				end
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
	end)
	:start()

-- hs.window.animationDuration = 0
--
-- units = {
-- 	left50 = { x = 0.00, y = 0.00, w = 0.50, h = 1.00 },
-- 	right50 = { x = 0.50, y = 0.00, w = 0.50, h = 1.00 },
-- 	top50 = { x = 0.00, y = 0.00, w = 1.00, h = 0.50 },
-- 	bot50 = { x = 0.00, y = 0.50, w = 1.00, h = 0.50 },
-- }
--
-- windowResizeOrPush = {
-- 	previousRect = {
-- 		up = hs.geometry.rect(units.top50),
-- 		down = hs.geometry.rect(units.bot50),
-- 		left = hs.geometry.rect(units.left50),
-- 		right = hs.geometry.rect(units.right50),
-- 	},
-- 	units = {
-- 		up = units.top50,
-- 		down = units.bot50,
-- 		left = units.left50,
-- 		right = units.right50,
-- 	},
-- }
--
-- function windowResizeOrPush:getNextScreen(window, cursor)
-- 	local nextScreen = nil
-- 	if cursor == "up" then
-- 		nextScreen = window:screen():toNorth()
-- 	elseif cursor == "down" then
-- 		nextScreen = window:screen():toSouth()
-- 	elseif cursor == "left" then
-- 		nextScreen = window:screen():toWest()
-- 	elseif cursor == "right" then
-- 		nextScreen = window:screen():toEast()
-- 	end
-- 	return nextScreen
-- end
--
-- function windowResizeOrPush:exec(cursor)
-- 	return function()
-- 		local window = hs.window.focusedWindow()
-- 		local nextScreen = self:getNextScreen(window, cursor)
--
-- 		if window:frame():equals(self.previousRect[cursor]) and nextScreen ~= nil then
-- 			window:moveToScreen(nextScreen, false, true)
-- 		else
-- 			window:moveToUnit(self.units[cursor])
-- 			self.previousRect[cursor] = window:frame()
-- 		end
-- 	end
-- end
--
-- hs.hotkey.bind({ "command" }, "left", windowResizeOrPush:exec("left"))
-- hs.hotkey.bind({ "command" }, "right", windowResizeOrPush:exec("right"))
-- hs.hotkey.bind({ "command", "ctrl" }, "left", windowResizeOrPush:exec("left"))
-- hs.hotkey.bind({ "command", "ctrl" }, "right", windowResizeOrPush:exec("right"))
-- hs.hotkey.bind({ "command", "ctrl" }, "up", windowResizeOrPush:exec("up"))
-- hs.hotkey.bind({ "command", "ctrl" }, "down", windowResizeOrPush:exec("down"))
-- hs.hotkey.bind({ "command", "shift" }, "up", function()
-- 	hs.window.focusedWindow():maximize()
-- end)
