local T, C, L, _ = unpack(select(2, ...))
if C.actionbar.enable ~= true then return end

----------------------------------------------------------------------------------------
--	MultiBarRight(by Tukz)
----------------------------------------------------------------------------------------
local bar = CreateFrame("Frame", "Bar4Holder", RightActionBarAnchor)
if C.actionbar.editor then
	local NumRow = ceil(C.actionbar.bar4_num / C.actionbar.bar4_row)
	bar:SetWidth((C.actionbar.bar4_size * C.actionbar.bar4_row) + (C.actionbar.button_space * (C.actionbar.bar4_row - 1)))
	bar:SetHeight((C.actionbar.bar4_size * NumRow) + (C.actionbar.button_space * (NumRow - 1)))
	bar:SetPoint("TOPRIGHT", RightActionBarAnchor, "TOPRIGHT", 0, 0)
else
	bar:SetAllPoints(RightActionBarAnchor)
end
MultiBarRight:SetParent(bar)

bar:RegisterEvent("PLAYER_ENTERING_WORLD")
bar:SetScript("OnEvent", function(self, event)
	local NumPerRows = C.actionbar.bar4_row
	local NextRowButtonAnchor = _G["MultiBarRightButton1"]
	for i = 1, 12 do
		local b = _G["MultiBarRightButton"..i]
		local b2 = _G["MultiBarRightButton"..i-1]
		b:ClearAllPoints()
		if C.actionbar.editor then
			if i <= C.actionbar.bar4_num then
				if i == 1 then
					b:SetPoint("TOPLEFT", bar, "TOPLEFT", 0, 0)
				elseif i == NumPerRows + 1 then
					b:SetPoint("TOPLEFT", NextRowButtonAnchor, "BOTTOMLEFT", 0, -C.actionbar.button_space)

					NumPerRows = NumPerRows + C.actionbar.bar4_row
					NextRowButtonAnchor = _G["MultiBarRightButton"..i]
				else
					b:SetPoint("LEFT", b2, "RIGHT", T.Scale(C.actionbar.button_space), 0)
				end
			else
				b:SetPoint("TOP", UIParent, "TOP", 0, 200)
			end
		else
			if i == 1 then
				b:SetPoint("TOPRIGHT", RightActionBarAnchor, "TOPRIGHT", 0, 0)
			else
				b:SetPoint("TOP", b2, "BOTTOM", 0, -C.actionbar.button_space)
			end
		end
	end
end)

-- Hide bar
if C.actionbar.rightbars < 1 then
	bar:Hide()
end

-- Mouseover bar
if C.actionbar.rightbars_mouseover == true then
	for i = 1, 12 do
		local b = _G["MultiBarRightButton"..i]
		b:SetAlpha(0)
		b:HookScript("OnEnter", function() RightBarMouseOver(1) end)
		b:HookScript("OnLeave", function() if not HoverBind.enabled then RightBarMouseOver(0) end end)
	end
end

if C.actionbar.editor and C.actionbar.bar4_mouseover then
	for i = 1, 12 do
		local b = _G["MultiBarRightButton"..i]
		b:SetAlpha(0)
		b:HookScript("OnEnter", function() Bar4MouseOver(1) end)
		b:HookScript("OnLeave", function() if not HoverBind.enabled then Bar4MouseOver(0) end end)
	end

	bar:SetScript("OnEnter", function() Bar4MouseOver(1) end)
	bar:SetScript("OnLeave", function() if not HoverBind.enabled then Bar4MouseOver(0) end end)
end