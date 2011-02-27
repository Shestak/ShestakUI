if SettingsCF.chat.enable ~= true then return end

----------------------------------------------------------------------------------------
--	Tell Target
----------------------------------------------------------------------------------------
for i = 1, NUM_CHAT_WINDOWS do
	local editBox = _G["ChatFrame"..i.."EditBox"]
	editBox:HookScript("OnTextChanged", function(self)
		local text = self:GetText()
		if text:len() < 5 then
			if text:sub(1, 4) == "/tt " or text:sub(1, 4) == "/ее " then
				local unitname, realm
				unitname, realm = UnitName("target")
				if unitname then unitname = gsub(unitname, " ", "") end
				if unitname and not UnitIsSameServer("player", "target") then
					unitname = unitname .. "-" .. gsub(realm, " ", "")
				end
				ChatFrame_SendTell((unitname or SPELL_FAILED_BAD_TARGETS), ChatFrame1)
			end
		end
	end)
end

-- Slash command for macro's
SLASH_TELLTARGET1 = "/tt"
SLASH_TELLTARGET2 = "/telltarget"
SlashCmdList.TELLTARGET = function(msg)
	local unitname, realm
	unitname, realm = UnitName("target")
	if not unitname then return end
	if unitname then unitname = gsub(unitname, " ", "") end
	if unitname and not UnitIsSameServer("player", "target") then
		unitname = unitname .. "-" .. gsub(realm, " ", "")
	end
	SendChatMessage(msg, "WHISPER", nil, unitname)
end