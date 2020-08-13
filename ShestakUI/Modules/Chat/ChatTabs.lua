local T, C, L, _ = unpack(select(2, ...))
if C.chat.enable ~= true then return end

----------------------------------------------------------------------------------------
--	Based on Fane(by Haste)
----------------------------------------------------------------------------------------
if C.chat.tabs_mouseover == true then
	CHAT_FRAME_TAB_SELECTED_NOMOUSE_ALPHA = 0
	CHAT_FRAME_TAB_NORMAL_NOMOUSE_ALPHA = 0
	CHAT_FRAME_TAB_ALERTING_NOMOUSE_ALPHA = 1
	CHAT_FRAME_TAB_SELECTED_MOUSEOVER_ALPHA = 1
	CHAT_FRAME_TAB_NORMAL_MOUSEOVER_ALPHA = 1
	CHAT_FRAME_TAB_ALERTING_MOUSEOVER_ALPHA = 1
end

local Fane = CreateFrame("Frame")

local updateFS = function(self, _, ...)
	local fstring = self:GetFontString()

	fstring:SetFont(C.font.chat_tabs_font, C.font.chat_tabs_font_size, C.font.chat_tabs_font_style)
	fstring:SetShadowOffset(C.font.chat_tabs_font_shadow and 1 or 0, C.font.chat_tabs_font_shadow and -1 or 0)

	if (...) then
		fstring:SetTextColor(...)
	end
end

local OnEnter = function(self)
	local emphasis = _G["ChatFrame"..self:GetID().."TabFlash"]:IsShown()
	updateFS(self, emphasis, unpack(C.media.classborder_color))
end

local OnLeave = function(self)
	local r, g, b
	local id = self:GetID()
	local emphasis = _G["ChatFrame"..id.."TabFlash"]:IsShown()

	if _G["ChatFrame"..id] == SELECTED_CHAT_FRAME then
		r, g, b = unpack(C.media.classborder_color)
	elseif emphasis then
		r, g, b = 1, 0, 0
	else
		r, g, b = 1, 1, 1
	end

	updateFS(self, emphasis, r, g, b)
end

local ChatFrame2_SetAlpha = function(_, alpha)
	if CombatLogQuickButtonFrame_Custom then
		CombatLogQuickButtonFrame_Custom:SetAlpha(alpha)
	end
end

local ChatFrame2_GetAlpha = function()
	if CombatLogQuickButtonFrame_Custom then
		return CombatLogQuickButtonFrame_Custom:GetAlpha()
	end
end

local faneifyTab = function(frame, selected)
	local i = frame:GetID()

	if frame:GetParent() == _G.ChatConfigFrameChatTabManager then
		if selected then
			frame.Text:SetTextColor(1, 1, 1)
		end

		frame:SetAlpha(1)
	else
		if not frame.Fane then
			frame:HookScript("OnEnter", OnEnter)
			frame:HookScript("OnLeave", OnLeave)
			if C.chat.tabs_mouseover ~= true then
				frame:SetAlpha(1)

				if i ~= 2 then
					-- Might not be the best solution, but we avoid hooking into the UIFrameFade
					-- system this way.
					frame.SetAlpha = UIFrameFadeRemoveFrame
				else
					frame.SetAlpha = ChatFrame2_SetAlpha
					frame.GetAlpha = ChatFrame2_GetAlpha

					-- We do this here as people might be using AddonLoader together with Fane
					if CombatLogQuickButtonFrame_Custom then
						CombatLogQuickButtonFrame_Custom:SetAlpha(0.4)
					end
				end
			end

			frame.Fane = true
		end

		-- We can't trust sel
		if i == SELECTED_CHAT_FRAME:GetID() then
			updateFS(frame, nil, unpack(C.media.classborder_color))
		else
			updateFS(frame, nil, 1, 1, 1)
		end
	end
end

hooksecurefunc("FCF_StartAlertFlash", function(frame)
	local tab = _G["ChatFrame"..frame:GetID().."Tab"]
	updateFS(tab, true, 1, 0, 0)
end)

hooksecurefunc("FCFTab_UpdateColors", faneifyTab)

for i = 1, NUM_CHAT_WINDOWS do
	faneifyTab(_G["ChatFrame"..i.."Tab"])
end

function Fane:ADDON_LOADED(event, addon)
	if addon == "Blizzard_CombatLog" then
		self:UnregisterEvent(event)
		self[event] = nil

		return CombatLogQuickButtonFrame_Custom:SetAlpha(0.4)
	end
end
Fane:RegisterEvent("ADDON_LOADED")