local T, C, L, _ = unpack(select(2, ...))
if C.chat.enable ~= true then return end

----------------------------------------------------------------------------------------
--	Tell Target
----------------------------------------------------------------------------------------
for i = 1, NUM_CHAT_WINDOWS do
	local editbox = _G["ChatFrame"..i.."EditBox"]
	editbox:HookScript("OnTextChanged", function(self)
		local text = self:GetText()
		if text:len() < 7 then
			if text:sub(1, 4) == "/tt " or text:sub(1, 6) == "/ее " then
				local unitname, realm = UnitName("target")
				if unitname then
					if unitname then unitname = gsub(unitname, " ", "") end
					if unitname and not UnitIsSameServer("player", "target") then
						unitname = unitname.."-"..gsub(realm, " ", "")
					end
					ChatFrame_SendTell((unitname), ChatFrame1)
				end
			end
		end
	end)
end

-- Slash command for macro's
SlashCmdList.TELLTARGET = function(msg)
	SendChatMessage(msg, "WHISPER")
end
SLASH_TELLTARGET1 = "/tt"
SLASH_TELLTARGET2 = "/ее"