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
				if UnitCanAssist("player", "target") then
					ChatFrame_SendTell((GetUnitName("target", true)), ChatFrame1)
				end
			end
		end
	end)
end

-- Slash command
SlashCmdList.TELLTARGET = function(msg)
	local name = GetUnitName("target", true)
	if name then
		SendChatMessage(msg, "WHISPER", nil, name)
	end
end
SLASH_TELLTARGET1 = "/tt"
SLASH_TELLTARGET2 = "/ее"