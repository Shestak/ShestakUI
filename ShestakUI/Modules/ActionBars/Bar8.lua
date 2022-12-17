local T, C, L, _ = unpack(select(2, ...))
if C.actionbar.enable ~= true then return end

----------------------------------------------------------------------------------------
--	MultiBar7
----------------------------------------------------------------------------------------
local bar = CreateFrame("Frame", "Bar8Holder", UIParent)
local NumRow = ceil(C.actionbar.bar8_num / C.actionbar.bar8_row)
bar:SetWidth((C.actionbar.bar8_size * C.actionbar.bar8_row) + (C.actionbar.button_space * (C.actionbar.bar8_row - 1)))
bar:SetHeight((C.actionbar.bar8_size * NumRow) + (C.actionbar.button_space * (NumRow - 1)))
bar:SetPoint("BOTTOM", Bar7Holder or ActionBarAnchor, "TOP", 0, 3)
MultiBar7:SetParent(bar)

bar:RegisterEvent("PLAYER_ENTERING_WORLD")
bar:SetScript("OnEvent", function(self, event)
	Settings.SetValue("PROXY_SHOW_ACTIONBAR_8", true)
	local NumPerRows = C.actionbar.bar8_row
	local NextRowButtonAnchor = _G["MultiBar7Button1"]
	for i = 1, 12 do
		local b = _G["MultiBar7Button"..i]
		local b2 = _G["MultiBar7Button"..i-1]
		b:ClearAllPoints()
		if i <= C.actionbar.bar8_num then
			if i == 1 then
				b:SetPoint("TOPLEFT", bar, "TOPLEFT", 0, 0)
			elseif i == NumPerRows + 1 then
				b:SetPoint("TOPLEFT", NextRowButtonAnchor, "BOTTOMLEFT", 0, -C.actionbar.button_space)

				NumPerRows = NumPerRows + C.actionbar.bar8_row
				NextRowButtonAnchor = _G["MultiBar7Button"..i]
			else
				b:SetPoint("LEFT", b2, "RIGHT", T.Scale(C.actionbar.button_space), 0)
			end
		else
			b:SetPoint("TOP", UIParent, "TOP", 0, 200)
		end
	end
end)

-- Hide bar
if not C.actionbar.bar8_enable then
	bar:Hide()
end

-- Mouseover bar
if C.actionbar.bar8_mouseover then
	for i = 1, 12 do
		local b = _G["MultiBar7Button"..i]
		b:SetAlpha(0)
		b:HookScript("OnEnter", function() Bar8MouseOver(1) end)
		b:HookScript("OnLeave", function() if not HoverBind.enabled then Bar8MouseOver(0) end end)
	end

	bar:SetScript("OnEnter", function() Bar8MouseOver(1) end)
	bar:SetScript("OnLeave", function() if not HoverBind.enabled then Bar8MouseOver(0) end end)
end