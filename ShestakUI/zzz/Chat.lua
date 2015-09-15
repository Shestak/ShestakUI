local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	聊天內容自動滾動到底部
----------------------------------------------------------------------------------------
if C.zzz.Chat_scrolldown == true then
	local Runtime = 20  -- Change this value if you want a different delay between your last scroll and the time the frame resets.  This value is in seconds.

	local frame, handlers, running = CreateFrame("Frame"), {}, {}
	frame.name = "TheLowDown"
	frame:Hide()

	frame:SetScript("OnUpdate", function (frame, elapsed)
		for name,v in pairs(handlers) do
			if running[name] then
				v.elapsed = v.elapsed + elapsed
				if v.elapsed >= v.rate then
					v.func(unpack(v))
					v.elapsed = 0
				end
			end
		end
	end)

	local function Register(name, func, rate, ...)
		handlers[name] = {
			name = name,
			func = func,
			rate = rate or 0,
			...
		}
	end

	local function Start(name)
		handlers[name].elapsed = 0
		running[name] = true
		frame:Show()
	end

	local function Stop(name)
		running[name] = nil
		if not next(running) then frame:Hide() end
	end

	local scrolldowns = {}
	local delay = Runtime  

	local function ResetFrame(name, frame)
		Stop(name.."DownTimeout")
		Start(name.."DownTick")
	end

	local function ScrollOnce(name, frame)
		if frame:AtBottom() then Stop(name.."DownTick")
		else scrolldowns[name](frame) end
	end

	local _G = getfenv(0)
	local funcs = {"ScrollUp", "ScrollDown", "ScrollToTop", "PageUp", "PageDown"}

	local channels = {GetChannelList()}
	for i = 1, #channels do
		local name = "ChatFrame" .. i
		local frame = _G[name]
		scrolldowns[name] = frame.ScrollDown
		Register(name.."DownTick", ScrollOnce, 0.1, name, frame)
		Register(name.."DownTimeout", ResetFrame, delay, name, frame)
		for _,func in ipairs(funcs) do
			local orig = frame[func]
			frame[func] = function(...)
				Stop(name.."DownTick")
				Start(name.."DownTimeout", 1)
				orig(...)
			end
		end
	end
end


---------------------------------------------------------------
-- 移动/隐藏聊天输入框语言按鈕
---------------------------------------------------------------
if C.zzz.Chat_HideLanguage == true then
	local f = CreateFrame("Frame")
	f:RegisterEvent("PLAYER_ENTERING_WORLD") 
	f:SetScript("OnEvent", function(self, event, ...)
		local channels = {GetChannelList()}
		for i = 1, 10 do --#channels do
			_G[format("ChatFrame%sEditBoxLanguage", i)]:ClearAllPoints()
			_G[format("ChatFrame%sEditBoxLanguage", i)]:SetPoint("right",ChatFrame1EditBox,"LEFT",17,0)
			_G[format("ChatFrame%sEditBoxLanguage", i)]:SetAlpha(0) 
		end
		
		if event == "PLAYER_ENTERING_WORLD" then 
			self:UnregisterEvent("PLAYER_ENTERING_WORLD")
			
		end
	end)
end


---------------------------------------------------------------
-- 輸入/bn直接發送通告
---------------------------------------------------------------
SLASH_BN1 = '/bn' 
function SlashCmdList.BN(msg, editbox) 
  BNSetCustomMessage(msg) 
end

---------------------------------------------------------------
-- 輸入/bn直接發送通告
---------------------------------------------------------------