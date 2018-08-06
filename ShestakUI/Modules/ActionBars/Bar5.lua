local T, C, L, _ = unpack(select(2, ...))
if C.actionbar.enable ~= true then return end

----------------------------------------------------------------------------------------
--	MultiBarBottomRight(by Tukz)
----------------------------------------------------------------------------------------
local bar = CreateFrame("Frame", "Bar5Holder", T_PetBattleFrameHider)
if C.actionbar.rightbars < 3 then
	if C.actionbar.split_bars == true then
		bar:SetAllPoints(SplitBarLeft)
	else
		bar:SetAllPoints(ActionBarAnchor)
	end
else
	bar:SetAllPoints(RightActionBarAnchor)
end
MultiBarBottomRight:SetParent(bar)
bar:SetFrameStrata("LOW")

for i = 1, 12 do
	local b = _G["MultiBarBottomRightButton"..i]
	local b2 = _G["MultiBarBottomRightButton"..i-1]
	b:ClearAllPoints()
	if C.actionbar.split_bars == true and C.actionbar.rightbars < 3 then
		if i == 1 then
			b:SetPoint("TOPLEFT", SplitBarLeft, "TOPLEFT", 0, 0)
		elseif i == 4 then
			b:SetPoint("BOTTOMLEFT", SplitBarLeft, "BOTTOMLEFT", 0, 0)
		elseif i == 7 then
			b:SetPoint("TOPLEFT", SplitBarRight, "TOPLEFT", 0, 0)
		elseif i == 10 then
			b:SetPoint("BOTTOMLEFT", SplitBarRight, "BOTTOMLEFT", 0, 0)
		else
			b:SetPoint("LEFT", b2, "RIGHT", C.actionbar.button_space, 0)
		end
	else
		if i == 1 then
			if C.actionbar.rightbars < 3 then
				b:SetPoint("TOPLEFT", Bar1Holder, 0, 0)
			else
				b:SetPoint("TOPLEFT", RightActionBarAnchor, "TOPLEFT", 0, 0)
			end
		else
			if C.actionbar.rightbars < 3 then
				b:SetPoint("LEFT", b2, "RIGHT", C.actionbar.button_space, 0)
			else
				b:SetPoint("TOP", b2, "BOTTOM", 0, -C.actionbar.button_space)
			end
		end
	end
end

-- Hide bar
if C.actionbar.rightbars < 3 and C.actionbar.bottombars < 3 then
	bar:Hide()
end

-- Mouseover bar
if C.actionbar.rightbars_mouseover == true and C.actionbar.rightbars > 2 then
	for i = 1, 12 do
		local b = _G["MultiBarBottomRightButton"..i]
		b:SetAlpha(0)
		b:HookScript("OnEnter", function() RightBarMouseOver(1) end)
		b:HookScript("OnLeave", function() if not HoverBind.enabled then RightBarMouseOver(0) end end)
	end
end