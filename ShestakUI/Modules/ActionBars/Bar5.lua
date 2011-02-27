if not SettingsCF["actionbar"].enable == true then return end

----------------------------------------------------------------------------------------
--	Setup MultiBarBottomRight as bar #5 by Tukz
----------------------------------------------------------------------------------------
local Bar5Holder = CreateFrame("Frame", "Bar5Holder", UIParent)
Bar5Holder:SetAllPoints(ActionBarAnchor)
MultiBarBottomRight:SetParent(Bar5Holder)

for i = 1, 12 do
	local b = _G["MultiBarBottomRightButton"..i]
	local b2 = _G["MultiBarBottomRightButton"..i-1]
	b:ClearAllPoints()
	if i == 1 then
		if SettingsCF.actionbar.bottombars == 3 then
			b:SetPoint("BOTTOM", ActionButton1, "TOP", 0, SettingsDB.buttonsize + (SettingsDB.buttonspacing * 2))
		else
			b:SetPoint("TOPLEFT", RightActionBarAnchor, "TOPLEFT", 0, 0)
		end
	else
		if SettingsCF.actionbar.bottombars == 3 then
			b:SetPoint("LEFT", b2, "RIGHT", SettingsDB.buttonspacing, 0)
		else
			b:SetPoint("TOP", b2, "BOTTOM", 0, -SettingsDB.buttonspacing)
		end
	end
end

-- Hide bar
if SettingsCF.actionbar.rightbars < 3 and SettingsCF.actionbar.bottombars < 3 then
	Bar5Holder:Hide()
end

-- Mouseover bar
if SettingsCF.actionbar.rightbars_mouseover == true and SettingsCF.actionbar.bottombars ~= 3 then
	for i = 1, 12 do
		local b = _G["MultiBarBottomRightButton"..i]
		b:SetAlpha(0)
		b:HookScript("OnEnter", function() RightBarMouseOver(1) end)
		b:HookScript("OnLeave", function() RightBarMouseOver(0) end)
	end
end