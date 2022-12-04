local T, C, L, _ = unpack(select(2, ...))
if C.actionbar.enable ~= true then return end

----------------------------------------------------------------------------------------
--	MultiBar6
----------------------------------------------------------------------------------------
local bar = CreateFrame("Frame", "Bar7Holder", UIParent)
local NumRow = ceil(C.actionbar.bar7_num / C.actionbar.bar7_row)
bar:SetWidth((C.actionbar.bar7_size * C.actionbar.bar7_row) + (C.actionbar.button_space * (C.actionbar.bar7_row - 1)))
bar:SetHeight((C.actionbar.bar7_size * NumRow) + (C.actionbar.button_space * (NumRow - 1)))
bar:SetPoint("BOTTOM", ActionBarAnchor, "TOP", 0, 3)
MultiBar6:SetParent(bar)

bar:RegisterEvent("PLAYER_ENTERING_WORLD")
bar:SetScript("OnEvent", function(self, event)
	-- self:UnregisterAllEvents()
	local NumPerRows = C.actionbar.bar7_row
	local NextRowButtonAnchor = _G["MultiBar6Button1"]
	for i = 1, 12 do
		local b = _G["MultiBar6Button"..i]
		local b2 = _G["MultiBar6Button"..i-1]
		b:ClearAllPoints()
		if i <= C.actionbar.bar7_num then
			if i == 1 then
				b:SetPoint("TOPLEFT", bar, "TOPLEFT", 0, 0)
			elseif i == NumPerRows + 1 then
				b:SetPoint("TOPLEFT", NextRowButtonAnchor, "BOTTOMLEFT", 0, -C.actionbar.button_space)

				NumPerRows = NumPerRows + C.actionbar.bar7_row
				NextRowButtonAnchor = _G["MultiBar6Button"..i]
			else
				b:SetPoint("LEFT", b2, "RIGHT", T.Scale(C.actionbar.button_space), 0)
			end
		else
			b:SetPoint("TOP", UIParent, "TOP", 0, 200)
		end
		-- b.SetPoint = T.dummy -- Prevent moving by EditMode
	end
end)

-- Hide bar
if not C.actionbar.bar7_enable then
	bar:Hide()
end

-- Mouseover bar
if C.actionbar.bar7_mouseover then
	for i = 1, 12 do
		local b = _G["MultiBar6Button"..i]
		b:SetAlpha(0)
		b:HookScript("OnEnter", function() Bar7MouseOver(1) end)
		b:HookScript("OnLeave", function() if not HoverBind.enabled then Bar7MouseOver(0) end end)
	end

	bar:SetScript("OnEnter", function() Bar7MouseOver(1) end)
	bar:SetScript("OnLeave", function() if not HoverBind.enabled then Bar7MouseOver(0) end end)
end