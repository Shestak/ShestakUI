local T, C, L, _ = unpack(select(2, ...))
if T.classic or C.automation.auto_role ~= true then return end

----------------------------------------------------------------------------------------
--	Automatically sets your role(Auto role setter by iSpawnAtHome)
----------------------------------------------------------------------------------------
local function SetRole()
	local spec = GetSpecialization()
	if T.level >= 10 and not InCombatLockdown() then
		if spec == nil then
			UnitSetRole("player", "No Role")
		elseif spec ~= nil then
			if GetNumGroupMembers() > 1 then
				local role = GetSpecializationRole(spec)
				if UnitGroupRolesAssigned("player") ~= role then
					UnitSetRole("player", role)
				end
			end
		end
	end
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_TALENT_UPDATE")
frame:RegisterEvent("GROUP_ROSTER_UPDATE")
frame:SetScript("OnEvent", SetRole)

RolePollPopup:UnregisterEvent("ROLE_POLL_BEGIN")