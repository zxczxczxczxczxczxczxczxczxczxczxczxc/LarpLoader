game.Players.LocalPlayer.PlayerScripts.ClientActor.ClientManager.Enabled = false

local env = _G
pcall(function()
	env = getgenv()
end)

env.__LP_STATE = env.__LP_STATE or {}
local state = env.__LP_STATE

local player = game:GetService("Players").LocalPlayer
local identify_executor = env.identifyexecutor or identifyexecutor
local executor_name = type(identify_executor) == "function" and identify_executor()

if executor_name == "Potassium" then
	player:Kick("Unsupported executor - potassium")
	return
end

if game.PlaceId == 4111023553 then
	player:Kick("Dont execute in menu")
	return
end

if state.running or state.loaded then
	return warn("[Loader] Already running or loaded.")
end

state.running = true

local ok, err = xpcall(function()
	loadstring(game:HttpGet("https://luaprot.net/api/v3/loaders/get/31295326910987464335"))()
end, function(err)
	return debug and debug.traceback and debug.traceback(tostring(err), 2) or tostring(err)
end)

state.running = false
state.loaded = ok

if not ok then
	state.error = err
	return warn("[Loader] Error:\n" .. err)
end

warn("[Loader] Loaded.")
