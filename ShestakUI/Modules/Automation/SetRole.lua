local T, C, L = unpack(ShestakUI)
if C.automation.auto_role ~= true then return end

----------------------------------------------------------------------------------------
--	Automatically sets your role(Auto role setter by iSpawnAtHome)
----------------------------------------------------------------------------------------
local ATT = GetActiveSpecGroup(false, false)
local PTT = GetSpecialization(false, false, ATT)
local frame = CreateFrame("Frame")

local function SetRole()
	ATT = GetActiveSpecGroup(false, false)
	PTT = GetSpecialization(false, false, ATT)

	if T.level >= 10 then
		if PTT == nil then
			UnitSetRole("player", "No Role")
		elseif PTT ~= nil then
			if GetNumSubgroupMembers() > 0 or GetNumGroupMembers() > 0 then
				if T.Role == "Tank" then
					UnitSetRole("player", "TANK")
				elseif T.Role == "Healer" then
					UnitSetRole("player", "HEALER")
				elseif T.Role == "Melee" or T.Role == "Caster" then
					UnitSetRole("player", "DAMAGER")
				end
			end
		end
	end
end

frame:RegisterEvent("PLAYER_ENTERING_BATTLEGROUND")
frame:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
frame:RegisterEvent("GROUP_ROSTER_UPDATE")
frame:RegisterEvent("PLAYER_TALENT_UPDATE")
frame:SetScript("OnEvent", SetRole)