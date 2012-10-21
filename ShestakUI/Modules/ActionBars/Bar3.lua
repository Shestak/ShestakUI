local T, C, L, _ = unpack(select(2, ...))
if C.actionbar.enable ~= true then return end

----------------------------------------------------------------------------------------
--	MultiBarLeft(by Tukz)
----------------------------------------------------------------------------------------
local bar = CreateFrame("Frame", "Bar3Holder", RightActionBarAnchor)
bar:SetAllPoints(RightActionBarAnchor)
MultiBarLeft:SetParent(bar)

for i = 1, 12 do
	local b = _G["MultiBarLeftButton"..i]
	local b2 = _G["MultiBarLeftButton"..i-1]
	b:ClearAllPoints()
	if i == 1 then
		if C.actionbar.rightbars == 3 then
			b:SetPoint("TOP", RightActionBarAnchor, "TOP", 0, 0)
		else
			b:SetPoint("TOPLEFT", RightActionBarAnchor, "TOPLEFT", 0, 0)
		end
	else
		b:SetPoint("TOP", b2, "BOTTOM", 0, -C.actionbar.button_space)
	end
end

-- Hide bar
if C.actionbar.rightbars < 2 then
	bar:Hide()
end

-- Mouseover bar
if C.actionbar.rightbars_mouseover == true then
	for i = 1, 12 do
		local b = _G["MultiBarLeftButton"..i]
		b:SetAlpha(0)
		b:HookScript("OnEnter", function() RightBarMouseOver(1) end)
		b:HookScript("OnLeave", function() if not HoverBind.enabled then RightBarMouseOver(0) end end)
	end
end