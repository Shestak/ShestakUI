local T, C, L, _ = unpack(select(2, ...))
if C.automation.auto_role ~= true then return end

----------------------------------------------------------------------------------------
--	Automatically sets your role(Auto role setter by iSpawnAtHome)
----------------------------------------------------------------------------------------
local prev = 0
local function SetRole()
	if T.level >= 10 and not InCombatLockdown() and IsInGroup() and not IsPartyLFG() then
		local spec = GetSpecialization()
		if spec then
			local role = GetSpecializationRole(spec)
			if UnitGroupRolesAssigned("player") ~= role then
				local t = GetTime()
				if t - prev > 2 then
					prev = t
					UnitSetRole("player", role)
				end
			end
		else
			UnitSetRole("player", "No Role")
		end
	end
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_TALENT_UPDATE")
frame:RegisterEvent("GROUP_ROSTER_UPDATE")
frame:SetScript("OnEvent", SetRole)

RolePollPopup:UnregisterEvent("ROLE_POLL_BEGIN")