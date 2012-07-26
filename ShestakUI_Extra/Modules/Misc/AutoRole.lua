local T, C, L = unpack(ShestakUI)
if C.extra_general.auto_role ~= true then return end

----------------------------------------------------------------------------------------
--	Automatically sets your role(Corporation auto role setter by iSpawnAtHome)
----------------------------------------------------------------------------------------
local ATT = GetActiveTalentGroup(false, false)
local PTT = GetPrimaryTalentTree(false, false, ATT)
local SetRole = CreateFrame("Frame")

local function roleSetter()
	ATT = GetActiveTalentGroup(false, false)
	PTT = GetPrimaryTalentTree(false, false, ATT)

	if T.level >= 10 then
		if PTT == nil then
			UnitSetRole("player", "No Role")
		elseif PTT ~= nil then
			if GetNumPartyMembers() > 0 or GetNumRaidMembers() > 0 then
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

SetRole:RegisterEvent("PLAYER_ENTERING_BATTLEGROUND")
SetRole:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
SetRole:RegisterEvent("PARTY_MEMBERS_CHANGED")
SetRole:RegisterEvent("PLAYER_TALENT_UPDATE")
SetRole:SetScript("OnEvent", roleSetter)