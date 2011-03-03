local T, C, L = unpack(select(2, ...))
if C.chat.enable ~= true then return end

----------------------------------------------------------------------------------------
--	Play sound files system(by Tukz)
----------------------------------------------------------------------------------------
if C.chat.whisp_sound == true then
	local SoundSys = CreateFrame("Frame")
	SoundSys:RegisterEvent("CHAT_MSG_WHISPER")
	SoundSys:RegisterEvent("CHAT_MSG_BN_WHISPER")
	SoundSys:HookScript("OnEvent", function(self, event, ...)
		if event == "CHAT_MSG_WHISPER" or "CHAT_MSG_BN_WHISPER" then
			PlaySoundFile(C.media.whisp_sound, "Master")
		end
	end)
end