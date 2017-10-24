local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Clear UIErrorsFrame(module from Kousei by Haste)
----------------------------------------------------------------------------------------
if C.error.white == true or C.error.black == true then
	local frame = CreateFrame("Frame")
	frame:SetScript("OnEvent", function(self, event, _, text)
		if C.error.white == true and C.error.black == false then
			if T.white_list[text] then
				UIErrorsFrame:AddMessage(text, 1, 0, 0)
			else
				L_INFO_ERRORS = text
			end
		elseif C.error.black == true and C.error.white == false then
			if T.black_list[text] then
				L_INFO_ERRORS = text
			else
				UIErrorsFrame:AddMessage(text, 1, 0, 0)
			end
		end
	end)
	SlashCmdList.ERROR = function()
		UIErrorsFrame:AddMessage(L_INFO_ERRORS, 1, 0, 0)
	end
	SLASH_ERROR1 = "/error"
	UIErrorsFrame:UnregisterEvent("UI_ERROR_MESSAGE")
	frame:RegisterEvent("UI_ERROR_MESSAGE")
end

----------------------------------------------------------------------------------------
--	Clear all UIErrors frame in combat
----------------------------------------------------------------------------------------
if C.error.combat == true then
	local frame = CreateFrame("Frame")
	local OnEvent = function(self, event, ...) self[event](self, event, ...) end
	frame:SetScript("OnEvent", OnEvent)
	local function PLAYER_REGEN_DISABLED()
		UIErrorsFrame:Hide()
	end
	local function PLAYER_REGEN_ENABLED()
		UIErrorsFrame:Show()
	end
	frame:RegisterEvent("PLAYER_REGEN_DISABLED")
	frame["PLAYER_REGEN_DISABLED"] = PLAYER_REGEN_DISABLED
	frame:RegisterEvent("PLAYER_REGEN_ENABLED")
	frame["PLAYER_REGEN_ENABLED"] = PLAYER_REGEN_ENABLED
end