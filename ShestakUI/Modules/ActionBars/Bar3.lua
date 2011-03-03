local T, C, L = unpack(select(2, ...))
if not C.actionbar.enable == true then return end

----------------------------------------------------------------------------------------
--	Setup MultiBarLeft as bar #3 by Tukz
----------------------------------------------------------------------------------------
local Bar3Holder = CreateFrame("Frame", "Bar3Holder", UIParent)
Bar3Holder:SetAllPoints(ActionBarAnchor)
Bar3Holder:SetFrameStrata("LOW")
MultiBarLeft:SetParent(Bar3Holder)

for i = 1, 12 do
	local b = _G["MultiBarLeftButton"..i]
	local b2 = _G["MultiBarLeftButton"..i-1]
	b:ClearAllPoints()
	if i == 1 then
		if C.actionbar.rightbars == 3 then
			b:Point("TOP", RightActionBarAnchor, "TOP", 0, 0)
		else
			b:Point("TOPLEFT", RightActionBarAnchor, "TOPLEFT", 0, 0)
		end
	else
		b:Point("TOP", b2, "BOTTOM", 0, -T.buttonspacing)
	end
end

-- Hide bar
if C.actionbar.rightbars < 2 then
	Bar3Holder:Hide()
end

-- Mouseover bar
if C.actionbar.rightbars_mouseover == true then
	for i = 1, 12 do
		local b = _G["MultiBarLeftButton"..i]
		b:SetAlpha(0)
		b:HookScript("OnEnter", function() RightBarMouseOver(1) end)
		b:HookScript("OnLeave", function() RightBarMouseOver(0) end)
	end
end