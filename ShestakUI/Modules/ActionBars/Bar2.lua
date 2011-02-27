if not SettingsCF["actionbar"].enable == true then return end

----------------------------------------------------------------------------------------
--	Setup MultiBarBottomLeft as bar #2 by Tukz
----------------------------------------------------------------------------------------
local Bar2Holder = CreateFrame("Frame", "Bar2Holder", UIParent)
Bar2Holder:SetAllPoints(ActionBarAnchor)
MultiBarBottomLeft:SetParent(Bar2Holder)

for i = 1, 12 do
	local b = _G["MultiBarBottomLeftButton"..i]
	local b2 = _G["MultiBarBottomLeftButton"..i-1]
	b:ClearAllPoints()
	if i == 1 then
		b:SetPoint("BOTTOM", ActionButton1, "TOP", 0, SettingsDB.buttonspacing)
	else
		b:SetPoint("LEFT", b2, "RIGHT", SettingsDB.buttonspacing, 0)
	end
end

-- Hide it if needed
if (SettingsCF.actionbar.bottombars == 1) then
	Bar2Holder:Hide()
end