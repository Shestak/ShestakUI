local T, C, L, _ = unpack(select(2, ...))
if C.automation.tab_binder ~= true then return end

----------------------------------------------------------------------------------------
--	Auto change Tab key to only target enemy players(RE/TabBinder by Veev/AcidWeb)
----------------------------------------------------------------------------------------
local TabBinder = CreateFrame("Frame")
TabBinder:RegisterEvent("PLAYER_ENTERING_WORLD")
TabBinder:RegisterEvent("ZONE_CHANGED_NEW_AREA")
TabBinder:RegisterEvent("PLAYER_REGEN_ENABLED")
TabBinder:RegisterEvent("DUEL_REQUESTED")
TabBinder:RegisterEvent("DUEL_FINISHED")
TabBinder:RegisterEvent("CHAT_MSG_SYSTEM")

local RTB_Fail, RTB_DefaultKey, LastTargetKey, TargetKey, CurrentBind, Success = false, true

TabBinder:SetScript("OnEvent", function(self, event, ...)
	if event == "CHAT_MSG_SYSTEM" then
		local RTBChatMessage = ...
		if RTBChatMessage == ERR_DUEL_REQUESTED then
			event = "DUEL_REQUESTED"
		end
	elseif event == "ZONE_CHANGED_NEW_AREA" or event == "PLAYER_ENTERING_WORLD" or (event == "PLAYER_REGEN_ENABLED" and RTB_Fail) or event == "DUEL_REQUESTED" or event == "DUEL_FINISHED" then
		local BindSet = GetCurrentBindingSet()
		if BindSet ~= 1 and BindSet ~= 2 then
			return
		end

		if InCombatLockdown() then
			RTB_Fail = true
			return
		end

		local PVPType = GetZonePVPInfo()
		local _, ZoneType = IsInInstance()

		TargetKey = GetBindingKey("TARGETNEARESTENEMYPLAYER")
		if TargetKey == nil then
			TargetKey = GetBindingKey("TARGETNEARESTENEMY")
		end
		if TargetKey == nil and RTB_DefaultKey then
			TargetKey = "TAB"
		end

		LastTargetKey = GetBindingKey("TARGETPREVIOUSENEMYPLAYER")
		if LastTargetKey == nil then
			LastTargetKey = GetBindingKey("TARGETPREVIOUSENEMY")
		end
		if LastTargetKey == nil and RTB_DefaultKey then
			LastTargetKey = "SHIFT-TAB"
		end

		if TargetKey then
			CurrentBind = GetBindingAction(TargetKey)
		end

		if ZoneType == "arena" or ZoneType == "pvp" or PVPType == "combat" or event == "DUEL_REQUESTED" then
			if CurrentBind ~= "TARGETNEARESTENEMYPLAYER" then
				if TargetKey == nil then
					Success = true
				else
					Success = SetBinding(TargetKey, "TARGETNEARESTENEMYPLAYER")
				end
				if LastTargetKey then
					SetBinding(LastTargetKey, "TARGETPREVIOUSENEMYPLAYER")
				end
				if Success then
					SaveBindings(BindSet)
					RTB_Fail = false
				else
					RTB_Fail = true
				end
			end
		else
			if CurrentBind ~= "TARGETNEARESTENEMY" then
				if TargetKey == nil then
					Success = true
				else
					Success = SetBinding(TargetKey, "TARGETNEARESTENEMY")
				end
				if LastTargetKey then
					SetBinding(LastTargetKey, "TARGETPREVIOUSENEMY")
				end
				if Success then
					SaveBindings(BindSet)
					RTB_Fail = false
				else
					RTB_Fail = true
				end
			end
		end
	end
end)