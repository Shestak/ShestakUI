local T, C, L = unpack(select(2, ...))
if C.tooltip.enable ~= true or C.tooltip.unit_role ~= true then return end

----------------------------------------------------------------------------------------
--	Displays a players LFD/LFR role(gTooltipRoles by g0st)
----------------------------------------------------------------------------------------
local function GetLFDRole(unit)
	local role = UnitGroupRolesAssigned(unit)

	if role == "NONE" then
		return "|cFFB5B5B5"..NO_ROLE.."|r"
	elseif role == "TANK" then
		return "|cFFE06D1B"..TANK.."|r"
	elseif role == "HEALER" then
		return "|cFF1B70E0"..HEALER.."|r"
	else
		return "|cFFE01B35"..DAMAGER.."|r"
	end
end

GameTooltip:HookScript("OnTooltipSetUnit", function(self, ...)
	local name, unit = GameTooltip:GetUnit()
	if unit and UnitIsPlayer(unit) and ((UnitInParty(unit) and GetNumSubgroupMembers() > 0) or (UnitInRaid(unit) and GetNumGroupMembers() > 0)) then
		GameTooltip:AddLine(ROLE..": "..GetLFDRole(unit))
	end
end)