local T, C, L, _ = unpack(select(2, ...))
if C.tooltip.enable ~= true or C.tooltip.arena_experience ~= true then return end

----------------------------------------------------------------------------------------
--	Arena function(ArenaExp by Fernir)
----------------------------------------------------------------------------------------
local active = false
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
frame:SetScript("OnEvent", function(_, event)
	if event == "INSPECT_ACHIEVEMENT_READY" then
		if not GetComparisonAchievementPoints() then return end

		active = false

		for _, id in pairs(statistic) do
			local rating = tonumber(GetComparisonStatistic(id))
			if rating and rating > 0 then
				local _, name = GetAchievementInfo(id)
				GameTooltip:AddDoubleLine(name, gradient(rating, 0, 100))
				active = true
			end
		end

		if active then
			GameTooltip:Show()
		end

		frame:UnregisterEvent("INSPECT_ACHIEVEMENT_READY")
		ClearAchievementComparisonUnit()
	end
end)

GameTooltip:HookScript("OnTooltipSetUnit", function(self)
	if InCombatLockdown() then return end
	if AchievementFrame and AchievementFrame:IsShown() then return end

	local _, unitID = self:GetUnit()
	if UnitIsPlayer(unitID) then
		ClearAchievementComparisonUnit()
		frame:RegisterEvent("INSPECT_ACHIEVEMENT_READY")
		SetAchievementComparisonUnit(unitID)
	end
end)

GameTooltip:HookScript("OnTooltipCleared", function()
	if frame:IsEventRegistered("INSPECT_ACHIEVEMENT_READY") then
		frame:UnregisterEvent("INSPECT_ACHIEVEMENT_READY")
		ClearAchievementComparisonUnit()
	end
	active = false
end)