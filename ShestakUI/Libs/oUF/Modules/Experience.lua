local T, C, L = unpack(select(2, ...))
if C.unitframe.enable ~= true or C.unitframe.plugins_experience_bar ~= true then return end

----------------------------------------------------------------------------------------
--	Based on oUF_Experience(by p3lim)
----------------------------------------------------------------------------------------
local _, ns = ...
local oUF = ns.oUF

local function GetXP(unit)
	return UnitXP(unit), UnitXPMax(unit)
end

local function SetTooltip(self)
	local unit = self:GetParent().unit
	local min, max = GetXP(unit)

	local bar = 20

	GameTooltip:SetOwner(self, "ANCHOR_BOTTOM", 0, -5)
	GameTooltip:AddLine(COMBAT_XP_GAIN.." "..format(LEVEL_GAINED, T.level))
	GameTooltip:AddLine(" ")
	GameTooltip:AddLine(string.format(L_STATS_CURRENT_XP..": %d / %d (%d%% - %d/%d)", min, max, min / max * 100, bar - (bar * (max - min) / max), bar))
	GameTooltip:AddLine(string.format(L_STATS_REMAINING_XP..": %d (%d%% - %d/%d)", max - min, (max - min) / max * 100, 1 + bar * (max - min) / max, bar))

	if self.rested then
		GameTooltip:AddLine(string.format("|cff0090ff"..L_STATS_RESTED_XP..": +%d (%d%%)", self.rested, self.rested / max * 100))
	end

	GameTooltip:Show()
end

local function Update(self, event, unit)
	if self.unit ~= unit then return end

	local experience = self.Experience

	if UnitLevel(unit) == MAX_PLAYER_LEVEL or UnitHasVehicleUI("player") then
		experience:Hide()
	else
		experience:Show()
	end

	local min, max = GetXP(unit)
	experience:SetMinMaxValues(0, max)
	experience:SetValue(min)

	if experience.Text then
		experience.Text:SetFormattedText("%d / %d", min, max)
	end

	if experience.Rested then
		local rested = GetXPExhaustion() or 0
		experience.Rested:SetMinMaxValues(0, max)
		experience.Rested:SetValue(math.min(min + rested, max))
		experience.rested = rested
	end

	if experience.PostUpdate then
		return experience:PostUpdate(unit, min, max)
	end
end

local function Enable(self, unit)
	local experience = self.Experience
	if experience then
		local Update = experience.Update or Update

		self:RegisterEvent("PLAYER_XP_UPDATE", Update)
		self:RegisterEvent("PLAYER_LEVEL_UP", Update)

		if experience.Rested then
			self:RegisterEvent("UPDATE_EXHAUSTION", Update)
			experience.Rested:SetFrameLevel(1)
		end

		if not experience.noTooltip then
			experience:EnableMouse()
			experience:HookScript("OnLeave", GameTooltip_Hide)
			experience:HookScript("OnEnter", SetTooltip)
		end

		return true
	end
end

local function Disable(self)
	local experience = self.Experience
	if experience then
		local Update = experience.Update or Update

		self:UnregisterEvent("PLAYER_XP_UPDATE", Update)
		self:UnregisterEvent("PLAYER_LEVEL_UP", Update)

		if experience.Rested then
			self:UnregisterEvent("UPDATE_EXHAUSTION", Update)
		end
	end
end

oUF:AddElement("Experience", Update, Enable, Disable)