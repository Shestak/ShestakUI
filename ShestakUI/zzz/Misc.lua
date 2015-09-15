local T, C, _, _ = unpack(select(2, ...))

local frame = CreateFrame('Frame')
frame:SetScript('OnEvent', function(self, event, ...)
	frame[event](self, ...)
end)

-------------------------------------------------------------------------------
-- 稀有提示
-------------------------------------------------------------------------------
if C.zzz.Misc_VignetteAlert == true then
	local vignettes = {}

	frame:RegisterEvent("VIGNETTE_ADDED")
	function frame:VIGNETTE_ADDED(id)
		if id and not vignettes[id] then
			local x, y, name, icon = C_Vignettes.GetVignetteInfoFromInstanceID(id)
			local left, right, top, bottom = GetObjectIconTextureCoords(icon)
			
			PlaySoundFile("Sound\\Interface\\RaidWarning.wav")
			local str = "|TInterface\\MINIMAP\\OBJECTICONS:0:0:0:0:256:256:"..(left*256)..":"..(right*256)..":"..(top*256)..":"..(bottom*256).."|t"
			RaidNotice_AddMessage(RaidWarningFrame, str..(name or "Unknown").." ".."出现了！", ChatTypeInfo["RAID_WARNING"])
			print(str..name,"出现了！")
			vignettes[id] = true
		end
	end
end

-------------------------------------------------------------------------------
-- 随机召唤宠物
-------------------------------------------------------------------------------
if C.zzz.Misc_autopet == true then
	local function SummonPet(fav)
		C_Timer.After(3, function() 
			local active = C_PetJournal.GetSummonedPetGUID()
			if not active and not UnitOnTaxi("player") then		
				if fav then
					C_PetJournal.SummonRandomPet(false)
				else
					C_PetJournal.SummonRandomPet(true)
				end
			end		
		end)
	end


	frame:RegisterEvent("PLAYER_ENTERING_WORLD")
	frame:RegisterEvent("PLAYER_CONTROL_GAINED")
	frame:RegisterEvent("UNIT_EXITED_VEHICLE")
	frame:RegisterEvent("PLAYER_ALIVE")

	function frame:PLAYER_ENTERING_WORLD()
		SummonPet()
	end

	function frame:PLAYER_CONTROL_GAINED()
		SummonPet()
	end

	function frame:UNIT_EXITED_VEHICLE()
		SummonPet()
	end

	function frame:PLAYER_ALIVE()
		SummonPet()
	end
end

-------------------------------------------------------------------------------
-- Flash Taskbar
-------------------------------------------------------------------------------
if C.zzz.Misc_FlashTaskBar == true then
	local flashtimer = 0

	local function DoFlash()
		if (flashtimer + 5 < GetTime()) then
			FlashClientIcon()
			flashtimer = GetTime()
		end
	end

	local DF = _G ["DetailsFramework"]
	if DF then
		hooksecurefunc ("LFGDungeonReadyStatus_ResetReadyStates", function()
			DoFlash()
		end)

		hooksecurefunc ("PVPReadyDialog_Display", function()
			DoFlash()
		end)
		
		frame:RegisterEvent("READY_CHECK")
		frame:RegisterEvent("CHAT_MSG_ADDON")

		function frame:READY_CHECK()
			DoFlash()
		end
		
		function frame:CHAT_MSG_ADDON(prefix, msg)
			if prefix == "BigWigs" and msg:find("BWPull") then
				DoFlash()
			elseif prefix == "D4" and msg:find("PT") then
				DoFlash()
			end		
		end
	end
end
