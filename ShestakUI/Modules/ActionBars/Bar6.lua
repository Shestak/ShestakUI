local T, C, L, _ = unpack(ShestakUI)
if C.actionbar.enable ~= true then return end

----------------------------------------------------------------------------------------
--	MultiBar5
----------------------------------------------------------------------------------------
local bar = CreateFrame("Frame", "Bar6Holder", UIParent)
if C.actionbar.editor then
	local NumRow = ceil(C.actionbar.bar6_num / C.actionbar.bar6_row)
	bar:SetWidth((C.actionbar.bar6_size * C.actionbar.bar6_row) + (C.actionbar.button_space * (C.actionbar.bar6_row - 1)))
	bar:SetHeight((C.actionbar.bar6_size * NumRow) + (C.actionbar.button_space * (NumRow - 1)))
	bar:SetPoint("TOPRIGHT", RightActionBarAnchor, "TOPRIGHT", -2 * (C.actionbar.bar6_size + C.actionbar.button_space) , 0)
else
	bar:SetAllPoints(RightActionBarAnchor)
end
MultiBar5:SetParent(bar)

bar:RegisterEvent("PLAYER_ENTERING_WORLD")
bar:SetScript("OnEvent", function(self, event)
	Settings.SetValue("PROXY_SHOW_ACTIONBAR_6", true)
	-- self:UnregisterAllEvents()
	local NumPerRows = C.actionbar.bar6_row
	local NextRowButtonAnchor = _G["MultiBar5Button1"]
	for i = 1, 12 do
		local b = _G["MultiBar5Button"..i]
		local b2 = _G["MultiBar5Button"..i-1]
		b:ClearAllPoints()
		if C.actionbar.editor then
			if i <= C.actionbar.bar6_num then
				if i == 1 then
					b:SetPoint("TOPLEFT", bar, "TOPLEFT", 0, 0)
				elseif i == NumPerRows + 1 then
					b:SetPoint("TOPLEFT", NextRowButtonAnchor, "BOTTOMLEFT", 0, -C.actionbar.button_space)

					NumPerRows = NumPerRows + C.actionbar.bar6_row
					NextRowButtonAnchor = _G["MultiBar5Button"..i]
				else
					b:SetPoint("LEFT", b2, "RIGHT", T.Scale(C.actionbar.button_space), 0)
				end
			else
				b:SetPoint("TOP", UIParent, "TOP", 0, 200)
			end
		else
			if i == 1 then
				b:SetPoint("TOPLEFT", RightActionBarAnchor, "TOPLEFT", 0, 0)
			else
				b:SetPoint("TOP", b2, "BOTTOM", 0, -C.actionbar.button_space)
			end
		end
		-- b.SetPoint = T.dummy -- Prevent moving by EditMode
	end
end)

-- Hide bar
if C.actionbar.rightbars < 3 then
	bar:Hide()
end

-- Mouseover bar
if C.actionbar.rightbars_mouseover == true then
	for i = 1, 12 do
		local b = _G["MultiBar5Button"..i]
		b:SetAlpha(0)
		b:HookScript("OnEnter", function() RightBarMouseOver(1) end)
		b:HookScript("OnLeave", function() if not HoverBind.enabled then RightBarMouseOver(0) end end)
	end
end

if C.actionbar.editor and C.actionbar.bar6_mouseover then
	for i = 1, 12 do
		local b = _G["MultiBar5Button"..i]
		b:SetAlpha(0)
		b:HookScript("OnEnter", function() Bar6MouseOver(1) end)
		b:HookScript("OnLeave", function() if not HoverBind.enabled then Bar6MouseOver(0) end end)
	end

	bar:SetScript("OnEnter", function() Bar6MouseOver(1) end)
	bar:SetScript("OnLeave", function() if not HoverBind.enabled then Bar6MouseOver(0) end end)
end