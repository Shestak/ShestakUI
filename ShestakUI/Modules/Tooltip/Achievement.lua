local T, C, L, _ = unpack(select(2, ...))
if C.tooltip.enable ~= true or C.tooltip.achievements ~= true then return end

----------------------------------------------------------------------------------------
--	Your achievement status in tooltip(Enhanced Achievements by Syzgyn)
----------------------------------------------------------------------------------------
local function SetHyperlink(tooltip, refString)
	if select(3, string.find(refString, "(%a-):")) ~= "achievement" then return end

	local _, _, achievementID = string.find(refString, ":(%d+):")
	local _, _, GUID = string.find(refString, ":%d+:(.-):")

	if GUID == UnitGUID("player") then
		tooltip:Show()
		return
	end

	tooltip:AddLine(" ")
	local _, _, _, completed, _, _, _, _, _, _, _, _, wasEarnedByMe, earnedBy = GetAchievementInfo(achievementID)

	if completed then
		if earnedBy then
			if earnedBy ~= "" then
				tooltip:AddLine(format(ACHIEVEMENT_EARNED_BY, earnedBy))
			end
			if not wasEarnedByMe then
				tooltip:AddLine(format(ACHIEVEMENT_NOT_COMPLETED_BY, T.name))
			elseif T.name ~= earnedBy then
				tooltip:AddLine(format(ACHIEVEMENT_COMPLETED_BY, T.name))
			end
		end
	end
	tooltip:Show()
end

hooksecurefunc(GameTooltip, "SetHyperlink", SetHyperlink)
hooksecurefunc(ItemRefTooltip, "SetHyperlink", SetHyperlink)