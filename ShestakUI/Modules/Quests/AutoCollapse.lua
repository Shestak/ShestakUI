local T, C, L = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Collapse WatchFrame during boss encounters(oWatchFrameToggler by Haste)
----------------------------------------------------------------------------------------
local addon = CreateFrame("Frame")
addon:RegisterEvent("PLAYER_ENTERING_WORLD")
addon:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT")
addon:RegisterEvent("UNIT_TARGETABLE_CHANGED")
addon:RegisterEvent("PLAYER_REGEN_ENABLED")

local BossExists = function()
	for i = 1, MAX_BOSS_FRAMES do
		if (UnitExists("boss" .. i)) then return true
		end
	end
end

addon:SetScript("OnEvent", function(self, event)
	if (BossExists()) then
		if (not WatchFrame.collapsed) then
			WatchFrame_CollapseExpandButton_OnClick(WatchFrame_CollapseExpandButton)
		end
	elseif (WatchFrame.collapsed and not InCombatLockdown()) then
		WatchFrame_CollapseExpandButton_OnClick(WatchFrame_CollapseExpandButton)
	end
end)