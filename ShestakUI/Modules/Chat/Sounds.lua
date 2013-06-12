local T, C, L, _ = unpack(select(2, ...))
if C.chat.enable ~= true or C.chat.whisp_sound ~= true then return end

----------------------------------------------------------------------------------------
--	Play sound files system(by Tukz)
----------------------------------------------------------------------------------------
local SoundSys = CreateFrame("Frame")
SoundSys:RegisterEvent("CHAT_MSG_WHISPER")
SoundSys:RegisterEvent("CHAT_MSG_BN_WHISPER")
SoundSys:HookScript("OnEvent", function(self, event, msg, ...)
	if event == "CHAT_MSG_WHISPER" or event == "CHAT_MSG_BN_WHISPER" then
		if (msg:sub(1,3) == "OQ,") then return false, msg, ... end
		PlaySoundFile(C.media.whisp_sound, "Master")
	end
end)