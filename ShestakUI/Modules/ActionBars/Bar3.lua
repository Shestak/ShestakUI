local T, C, L, _ = unpack(select(2, ...))
if C.actionbar.enable ~= true then return end

----------------------------------------------------------------------------------------
--	MultiBarLeft(by Tukz)
----------------------------------------------------------------------------------------
local bar = CreateFrame("Frame", "Bar3Holder", RightActionBarAnchor)
if C.actionbar.editor then
	local NumRow = ceil(C.actionbar.bar3_num / C.actionbar.bar3_row)
	bar:SetWidth((C.actionbar.bar3_size * C.actionbar.bar3_row) + (C.actionbar.button_space * (C.actionbar.bar3_row - 1)))
	bar:SetHeight((C.actionbar.bar3_size * NumRow) + (C.actionbar.button_space * (NumRow - 1)))
	bar:SetPoint("TOPRIGHT", RightActionBarAnchor, "TOPRIGHT", -(C.actionbar.bar3_size + C.actionbar.button_space) , 0)
else
	bar:SetAllPoints(RightActionBarAnchor)
end
MultiBarLeft:SetParent(bar)

local NumPerRows = C.actionbar.bar3_row
local NextRowButtonAnchor = _G["MultiBarLeftButton1"]
for i = 1, 12 do
	local b = _G["MultiBarLeftButton"..i]
	local b2 = _G["MultiBarLeftButton"..i-1]
	b:ClearAllPoints()
	if C.actionbar.editor then
		if i <= C.actionbar.bar3_num then
			if i == 1 then
				b:SetPoint("TOPLEFT", bar, "TOPLEFT", 0, 0)
			elseif i == NumPerRows + 1 then
				b:SetPoint("TOPLEFT", NextRowButtonAnchor, "BOTTOMLEFT", 0, -C.actionbar.button_space)

				NumPerRows = NumPerRows + C.actionbar.bar3_row
				NextRowButtonAnchor = _G["MultiBarLeftButton"..i]
			else
				b:SetPoint("LEFT", b2, "RIGHT", C.actionbar.button_space, 0)
			end
		else
			b:SetPoint("TOP", UIParent, "TOP", 0, 200)
		end
	else
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

if C.actionbar.editor and C.actionbar.bar3_mouseover then
	for i = 1, 12 do
		local b = _G["MultiBarLeftButton"..i]
		b:SetAlpha(0)
		b:HookScript("OnEnter", function() Bar3MouseOver(1) end)
		b:HookScript("OnLeave", function() if not HoverBind.enabled then Bar3MouseOver(0) end end)
	end

	bar:SetScript("OnEnter", function() Bar3MouseOver(1) end)
	bar:SetScript("OnLeave", function() if not HoverBind.enabled then Bar3MouseOver(0) end end)
end