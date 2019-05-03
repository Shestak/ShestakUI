local T, C, L, _ = unpack(select(2, ...))
if C.tooltip.enable ~= true or C.tooltip.arena_experience ~= true then return end

----------------------------------------------------------------------------------------
--	Arena function(ArenaExp by Fernir)
----------------------------------------------------------------------------------------
local active = false
local tooltip = _G["GameTooltip"]
local statistic = {
	370,	-- Highest 2 man personal rating
	595,	-- Highest 3 man personal rating
}

local gradient = function(val, low, high)
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

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, ...)
	if event == "ADDON_LOADED" then
		if ... then
			frame:UnregisterEvent("ADDON_LOADED")
			tooltip:HookScript("OnTooltipSetUnit", function()
				if InCombatLockdown() then return end
				if AchievementFrame and AchievementFrame:IsShown() then return end

				self.unit = select(2, tooltip:GetUnit())
				if not UnitIsPlayer(self.unit) then return end

				if _G.GearScore then
					_G.GearScore:UnregisterEvent("INSPECT_ACHIEVEMENT_READY")
				end
				ClearAchievementComparisonUnit()
				frame:RegisterEvent("INSPECT_ACHIEVEMENT_READY")
				SetAchievementComparisonUnit(self.unit)
			end)
			tooltip:HookScript("OnTooltipCleared", function()
				if frame:IsEventRegistered("INSPECT_ACHIEVEMENT_READY") and frame:IsEventRegistered("INSPECT_ACHIEVEMENT_READY") then
					frame:UnregisterEvent("INSPECT_ACHIEVEMENT_READY")
					ClearAchievementComparisonUnit()
				end
				active = false
			end)
		end
	elseif event == "INSPECT_ACHIEVEMENT_READY" then
		if not GetComparisonAchievementPoints() then return end

		active = false

		for _, Achievement in pairs(statistic) do
			if tonumber(GetComparisonStatistic(Achievement)) and tonumber(GetComparisonStatistic(Achievement)) > 0 then
				tooltip:AddDoubleLine(select(2, GetAchievementInfo(Achievement)), gradient(tonumber(GetComparisonStatistic(Achievement)), 0, 100))
				active = true
			end
		end

		if active then tooltip:Show() end

		if _G.GearScore then
			_G.GearScore:RegisterEvent("INSPECT_ACHIEVEMENT_READY")
		end

		frame:UnregisterEvent("INSPECT_ACHIEVEMENT_READY")
		ClearAchievementComparisonUnit()
	end
end)