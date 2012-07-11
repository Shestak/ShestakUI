local T, C, L = unpack(select(2, ...))
if C.tooltip.enable ~= true or C.tooltip.arena_experience ~= true then return end
if T.MOPVersion then return end

----------------------------------------------------------------------------------------
--	Arena function(ArenaExp by Fernir)
----------------------------------------------------------------------------------------
local isGTTActive = false
local GTT = _G["GameTooltip"]
local needStatistic = {
	370,	-- Highest 2 man personal rating
	595,	-- Highest 3 man personal rating
	596,	-- Highest 5 man personal rating
}

strGradient = function(val, low, high)
	local percent, r, g
	if high > low then
		percent = val / (high - low)
	else 
		percent = 1 - val / (low - high)
	end
	if percent > 1 then percent = 1 end
	if percent < 0 then percent = 0 end
	if percent < 0.5 then
		r, g = 1, 2 * percent
	else
		r, g = (1 - percent) * 2, 1
	end
	return format("|cff%02x%02x%02x%s|r", r * 255, g * 255, 0, val)
end

local skillf = CreateFrame("Frame")
skillf:RegisterEvent("ADDON_LOADED")
skillf:SetScript("OnEvent", function(self, event, ...)
	if event == "ADDON_LOADED" then
		if ... then
			skillf:UnregisterEvent("ADDON_LOADED")
			GTT:HookScript("OnTooltipSetUnit", function()
				if InCombatLockdown() and InCombatLockdown() == 1 then return end
				if AchievementFrame and AchievementFrame:IsShown() then return end

				self.unit = select(2, GTT:GetUnit())
				if not UnitIsPlayer(self.unit) then return end

				if _G.GearScore then
					_G.GearScore:UnregisterEvent("INSPECT_ACHIEVEMENT_READY")
				end
				ClearAchievementComparisonUnit()
				skillf:RegisterEvent("INSPECT_ACHIEVEMENT_READY")
				SetAchievementComparisonUnit(self.unit)
			end)
			GTT:HookScript("OnTooltipCleared", function()
				if skillf:IsEventRegistered("INSPECT_ACHIEVEMENT_READY") and skillf:IsEventRegistered("INSPECT_ACHIEVEMENT_READY") then
					skillf:UnregisterEvent("INSPECT_ACHIEVEMENT_READY")
					ClearAchievementComparisonUnit()
				end
				isGTTActive = false
			end)
		end
	elseif event == "INSPECT_ACHIEVEMENT_READY" then
		if not GetComparisonAchievementPoints() then return end

		isGTTActive = false

		for index, Achievement in pairs(needStatistic) do
			if tonumber(GetComparisonStatistic(Achievement)) and tonumber(GetComparisonStatistic(Achievement)) > 0 then
				GTT:AddDoubleLine(select(2, GetAchievementInfo(Achievement)), strGradient(tonumber(GetComparisonStatistic(Achievement)), 0, 100))
				isGTTActive = true
			end
		end

		if isGTTActive then GTT:Show() end

		if _G.GearScore then
			_G.GearScore:RegisterEvent("INSPECT_ACHIEVEMENT_READY")
		end

		skillf:UnregisterEvent("INSPECT_ACHIEVEMENT_READY")
		ClearAchievementComparisonUnit()
	end
end)