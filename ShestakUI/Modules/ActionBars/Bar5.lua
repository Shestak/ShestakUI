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
		if C.actionbar.editor then
			local NumRow = ceil(C.actionbar.bar5_num / C.actionbar.bar5_row)
			bar:SetWidth((C.actionbar.bar5_size * C.actionbar.bar5_row) + (C.actionbar.button_space * (C.actionbar.bar5_row - 1)))
			bar:SetHeight((C.actionbar.bar5_size * NumRow) + (C.actionbar.button_space * (NumRow - 1)))
			bar:SetPoint("BOTTOMLEFT", Bar2Holder, "TOPLEFT", 0, C.actionbar.button_space)
		else
			bar:SetAllPoints(ActionBarAnchor)
		end
	end
else
	if C.actionbar.editor then
		local NumRow = ceil(C.actionbar.bar5_num / C.actionbar.bar5_row)
		bar:SetWidth((C.actionbar.bar5_size * C.actionbar.bar5_row) + (C.actionbar.button_space * (C.actionbar.bar5_row - 1)))
		bar:SetHeight((C.actionbar.bar5_size * NumRow) + (C.actionbar.button_space * (NumRow - 1)))
		bar:SetPoint("TOPRIGHT", RightActionBarAnchor, "TOPRIGHT", -2 * (C.actionbar.bar4_size + C.actionbar.button_space) , 0)
	else
		bar:SetAllPoints(RightActionBarAnchor)
	end
end
MultiBarBottomRight:SetParent(bar)
bar:SetFrameStrata("LOW")

local NumPerRows = C.actionbar.bar5_row
local NextRowButtonAnchor = _G["MultiBarBottomRightButton1"]
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
			b:SetPoint("TOPLEFT", SplitBarRight, "TOPLEFT", C.actionbar.button_space, 0)
		elseif i == 10 then
			b:SetPoint("BOTTOMLEFT", SplitBarRight, "BOTTOMLEFT", C.actionbar.button_space, 0)
		else
			b:SetPoint("LEFT", b2, "RIGHT", C.actionbar.button_space, 0)
		end
	else
		if C.actionbar.editor then
			if i <= C.actionbar.bar5_num then
				if i == 1 then
					b:SetPoint("TOPLEFT", bar, "TOPLEFT", 0, 0)
				else
					if C.actionbar.rightbars < 3 then
						if i == NumPerRows + 1 then
							b:SetPoint("TOPLEFT", NextRowButtonAnchor, "BOTTOMLEFT", 0, -C.actionbar.button_space)

							NumPerRows = NumPerRows + C.actionbar.bar5_row
							NextRowButtonAnchor = _G["MultiBarBottomRightButton"..i]
						else
							b:SetPoint("LEFT", b2, "RIGHT", C.actionbar.button_space, 0)
						end
					else
						b:SetPoint("TOP", b2, "BOTTOM", 0, -C.actionbar.button_space)
					end
				end
			else
				b:SetPoint("TOP", UIParent, "TOP", 0, 200)
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
					b:SetPoint("LEFT", b2, "RIGHT", T.Scale(C.actionbar.button_space), 0)
				else
					b:SetPoint("TOP", b2, "BOTTOM", 0, -C.actionbar.button_space)
				end
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

if C.actionbar.bottombars_mouseover and C.actionbar.rightbars < 3 then
	for i = 1, 12 do
		local b = _G["MultiBarBottomRightButton"..i]
		b:SetAlpha(0)
		b:HookScript("OnEnter", function() BottomBarMouseOver(1) end)
		b:HookScript("OnLeave", function() if not HoverBind.enabled then BottomBarMouseOver(0) end end)
	end
end

if C.actionbar.editor and C.actionbar.bar5_mouseover then
	for i = 1, 12 do
		local b = _G["MultiBarBottomRightButton"..i]
		b:SetAlpha(0)
		b:HookScript("OnEnter", function() Bar5MouseOver(1) end)
		b:HookScript("OnLeave", function() if not HoverBind.enabled then Bar5MouseOver(0) end end)
	end

	bar:SetScript("OnEnter", function() Bar5MouseOver(1) end)
	bar:SetScript("OnLeave", function() if not HoverBind.enabled then Bar5MouseOver(0) end end)
end