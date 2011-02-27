if SettingsCF.chat.enable ~= true then return end

----------------------------------------------------------------------------------------
--	Play sound files system(by Tukz)
----------------------------------------------------------------------------------------
if SettingsCF.chat.whisp_sound == true then
	local SoundSys = CreateFrame("Frame")
	SoundSys:RegisterEvent("CHAT_MSG_WHISPER")
	SoundSys:RegisterEvent("CHAT_MSG_BN_WHISPER")
	SoundSys:HookScript("OnEvent", function(self, event, ...)
		if event == "CHAT_MSG_WHISPER" or "CHAT_MSG_BN_WHISPER" then
			PlaySoundFile(SettingsCF.media.whisp_sound, "Master")
		end
	end)
end