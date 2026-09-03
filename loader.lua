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
	("LuaProt V2 Loader - Unauthorized tampering or debugging of protected scripts is strictly prohibited and will result in a global blacklist from all LuaProt protected scripts."):sub(1,1);local f,c,v="31295326910987464335",http and http.request or request,function(h) while(task.wait())do pcall(function() game:GetService("Players").LocalPlayer:Kick(h);local v=game:GetService("CoreGui").RobloxPromptGui.promptOverlay.ErrorPrompt;v.TitleFrame.ErrorTitle.Text="LuaProt";v.MessageArea.ErrorFrame.ErrorMessage.Text=h; end); end; end;lp_key=lp_key or "x";local b,o,h,k,d;o={"eu-1","as-1","us-1"};h,k=pcall(c,{Url="https://eu-1.luaprot.net/api/v1/nodes/get"});if(h and k and k.StatusCode==200)then pcall(function() d=game:GetService("HttpService"):JSONDecode(k.Body); end);if(d and d.success and d.node)then for i,n in o do if(n==d.node)then table.insert(o,1,table.remove(o,i));break; end; end; end; end;for i=1,5 do if(b)then break; end;for _,p in o do local r,y=os.clock();task.spawn(pcall,function() y=c({Url="https://"..p..".luaprot.net/api/v2/loader/get?key="..lp_key.."&scriptId="..f}); end);repeat task.wait(); until(os.clock()-r>5 or y);if(y and ({[200]=i,[201]=i})[y.StatusCode])then LP_NODE=p;b=loadstring(y.Body);if(b)then break; end; end; end; end;if(b)then b(LP_NODE); else v("V2 loader failed to load script.\nReport this and try again later!"); end
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
