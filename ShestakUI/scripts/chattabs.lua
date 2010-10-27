----------------------------------------------------------------------------------------
--	Based on Fane
----------------------------------------------------------------------------------------
if SettingsCF.chat.enable ~= true then return end

local Fane = CreateFrame"Frame"
local db = SettingsCF["font"]

local updateFS = function(self, inc, flags, ...)
	local fstring = self:GetFontString()

	if(inc) then
		fstring:SetFont(db.chat_tabs_font, db.chat_tabs_font_size, db.chat_tabs_font_style);
		fstring:SetShadowOffset(db.chat_tabs_font_shadow and 1 or 0, db.chat_tabs_font_shadow and -1 or 0)
	else
		fstring:SetFont(db.chat_tabs_font, db.chat_tabs_font_size, db.chat_tabs_font_style);
		fstring:SetShadowOffset(db.chat_tabs_font_shadow and 1 or 0, db.chat_tabs_font_shadow and -1 or 0)
	end

	if((...)) then
		fstring:SetTextColor(...)
	end
end

local OnEnter = function(self)
	local emphasis = _G["ChatFrame"..self:GetID().."TabFlash"]:IsShown()
	updateFS(self, emphasis, SettingsCF["chat"].tab_font_style, SettingsDB.color.r, SettingsDB.color.g, SettingsDB.color.b)
end

local OnLeave = function(self)
	local r, g, b
	local id = self:GetID()
	local emphasis = _G["ChatFrame"..id.."TabFlash"]:IsShown()

	if (_G["ChatFrame"..id] == SELECTED_CHAT_FRAME) then
		r, g, b = SettingsDB.color.r, SettingsDB.color.g, SettingsDB.color.b
	elseif emphasis then
		r, g, b = 1, 0, 0
	else
		r, g, b = 1, 1, 1
	end

	updateFS(self, emphasis, nil, r, g, b)
end

local ChatFrame2_SetAlpha = function(self, alpha)
	if(CombatLogQuickButtonFrame_Custom) then
		CombatLogQuickButtonFrame_Custom:SetAlpha(alpha)
	end
end

local ChatFrame2_GetAlpha = function(self)
	if(CombatLogQuickButtonFrame_Custom) then
		return CombatLogQuickButtonFrame_Custom:GetAlpha()
	end
end

local faneifyTab = function(frame, sel)
	local i = frame:GetID()

	if(not frame.Fane) then
		frame.leftTexture:Hide()
		frame.middleTexture:Hide()
		frame.rightTexture:Hide()

		frame.leftSelectedTexture:Hide()
		frame.middleSelectedTexture:Hide()
		frame.rightSelectedTexture:Hide()

		frame.leftSelectedTexture.Show = frame.leftSelectedTexture.Hide
		frame.middleSelectedTexture.Show = frame.middleSelectedTexture.Hide
		frame.rightSelectedTexture.Show = frame.rightSelectedTexture.Hide

		frame.leftHighlightTexture:Hide()
		frame.middleHighlightTexture:Hide()
		frame.rightHighlightTexture:Hide()

		frame:HookScript("OnEnter", OnEnter)
		frame:HookScript("OnLeave", OnLeave)

		frame:SetAlpha(1)

		if(i ~= 2) then
			-- Might not be the best solution, but we avoid hooking into the UIFrameFade
			-- system this way.
			frame.SetAlpha = UIFrameFadeRemoveFrame
		else
			frame.SetAlpha = ChatFrame2_SetAlpha
			frame.GetAlpha = ChatFrame2_GetAlpha

			-- We do this here as people might be using AddonLoader together with Fane
			if(CombatLogQuickButtonFrame_Custom) then
				CombatLogQuickButtonFrame_Custom:SetAlpha(0.4)
			end
		end

		frame.Fane = true
	end

	-- We can't trust sel
	if(i == SELECTED_CHAT_FRAME:GetID()) then
		updateFS(frame, nil, nil, SettingsDB.color.r, SettingsDB.color.g, SettingsDB.color.b)
	else
		updateFS(frame, nil, nil, 1, 1, 1)
	end
end

hooksecurefunc("FCF_StartAlertFlash", function(frame)
	local tab = _G["ChatFrame" .. frame:GetID() .. "Tab"]
	updateFS(tab, true, nil, 1, 0, 0)
end)

hooksecurefunc("FCFTab_UpdateColors", faneifyTab)

for i = 1, 7 do
	faneifyTab(_G["ChatFrame" .. i .. "Tab"])
end

function Fane:ADDON_LOADED(event, addon)
	if(addon == "Blizzard_CombatLog") then
		self:UnregisterEvent(event)
		self[event] = nil

		return CombatLogQuickButtonFrame_Custom:SetAlpha(.4)
	end
end
Fane:RegisterEvent"ADDON_LOADED"

Fane:SetScript("OnEvent", function(self, event, ...)
	return self[event](self, event, ...)
end)