local T, C, L = unpack(select(2, ...))
if C.actionbar.enable ~= true then return end

----------------------------------------------------------------------------------------
--	Setup MultiBarBottomLeft as bar #2 by Tukz
----------------------------------------------------------------------------------------
local bar = CreateFrame("Frame", "Bar2Holder", UIParent)
bar:SetAllPoints(ActionBarAnchor)
bar:SetFrameStrata("BACKGROUND")
MultiBarBottomLeft:SetParent(bar)

for i = 1, 12 do
	local b = _G["MultiBarBottomLeftButton"..i]
	local b2 = _G["MultiBarBottomLeftButton"..i-1]
	b:ClearAllPoints()
	if i == 1 then
		b:Point("BOTTOM", ActionButton1, "TOP", 0, C.actionbar.button_space)
	else
		b:Point("LEFT", b2, "RIGHT", C.actionbar.button_space, 0)
	end
end

-- Hide it if needed
if C.actionbar.bottombars == 1 then
	bar:Hide()
end