  local env = _G
  pcall(function()
      env = getgenv()
  end)

  env.__LP_STATE = env.__LP_STATE or {}
  local state = env.__LP_STATE

  if state.running or state.loaded then
      return warn("[Loader] Already running or loaded.")
  end

  state.running = true

  local ok, err = xpcall(function()
      ("LuaProt V2 Loader - Unauthorized tampering or debugging of protected scripts is strictly prohibited and will result in a global blacklist from all LuaProt protected scripts."):sub(1,1);local f=("86781581214316278603");if(not lp_key)then lp_key="x"; end;local c=(http and http.request) or request;local v=function(h) while(task.wait())do pcall(function() game:GetService("Players").LocalPlayer:Kick(h);local v=game:GetService("CoreGui").RobloxPromptGui.promptOverlay.ErrorPrompt;v.TitleFrame.ErrorTitle.Text="LuaProt";v.MessageArea.ErrorFrame.ErrorMessage.Text=h; end); end; end;if(not f)then return v("Missing script id."); end;local b;local o={"eu-1","eu-2","us-1"};local h,k=pcall(function() return c({Url="https://eu-1.luaprot.net/api/v1/nodes/get"}); end);if(h and k and k.StatusCode==200)then local b;pcall(function() b=game:GetService("HttpService"):JSONDecode(k.Body); end);if(b and b.success and b.node)then for i,n in o do if(n==b.node)then table.remove(o,i);table.insert(o,1,b.node);break; end; end; end; end;for _,p in o do local r=os.clock();local y;task.spawn(pcall,function() y=c({Url="https://"..p..".luaprot.net/api/v2/loader/get?key="..lp_key.."&scriptId="..f}); end);repeat task.wait(); until(os.clock()-r>15 or y);if(y and ({[200]=true,[201]=true})[y.StatusCode])then LP_NODE=p;b=loadstring(y.Body);if(b)then break; end; end; end;if(b and LP_NODE)then b(LP_NODE); else v("V2 loader failed to load script. Report this and try again later!"); end;
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
