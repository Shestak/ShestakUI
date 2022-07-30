local T, C, L, _ = unpack(ShestakUI)
if C.actionbar.enable ~= true or C.actionbar.custom_bar_enable ~= true then return end

----------------------------------------------------------------------------------------
--	Custom ActionBar
----------------------------------------------------------------------------------------
local bar = CreateFrame("Frame", "CustomBarAnchor", UIParent)
local NumRow = ceil(C.actionbar.custom_bar_num / C.actionbar.custom_bar_row)
bar:SetWidth((C.actionbar.custom_bar_size * C.actionbar.custom_bar_row) + (C.actionbar.button_space * (C.actionbar.custom_bar_row - 1)))
bar:SetHeight((C.actionbar.custom_bar_size * NumRow) + (C.actionbar.button_space * (NumRow - 1)))
bar:SetPoint("BOTTOM", ActionBarAnchor, "TOP", 0, 3)
bar:SetFrameStrata("LOW")

local NextRowButtonAnchor
local NumPerRows = C.actionbar.custom_bar_row
local numSlots = T.class == "DRUID" and 12 or 84
for i = 1, 12 do
	local b = CreateFrame("CheckButton", "CustomBarButton"..i, bar, "ActionBarButtonTemplate")
	b:SetSize(C.actionbar.button_size, C.actionbar.button_size)
	b.id = i + numSlots
	b:SetAttribute("action", i + numSlots)
	if C.actionbar.show_grid == true then
		b.noGrid = nil
		b:SetAttribute("showgrid", 1)
		b:ShowGrid(ACTION_BUTTON_SHOW_GRID_REASON_EVENT)
		b:SetAttribute("statehidden", true)
	end
	NextRowButtonAnchor = NextRowButtonAnchor or _G["CustomBarButton1"]
	b:ClearAllPoints()
	if i <= C.actionbar.custom_bar_num then
		if i == 1 then
			b:SetPoint("TOPLEFT", bar, "TOPLEFT", 0, 0)
		elseif i == NumPerRows + 1 then
			b:SetPoint("TOPLEFT", NextRowButtonAnchor, "BOTTOMLEFT", 0, -C.actionbar.button_space)

			NumPerRows = NumPerRows + C.actionbar.custom_bar_row
			NextRowButtonAnchor = _G["CustomBarButton"..i]
		else
			b:SetPoint("LEFT", _G["CustomBarButton"..i-1], "RIGHT", T.Scale(C.actionbar.button_space), 0)
		end
	else
		b:SetPoint("TOP", UIParent, "TOP", 0, 200)
	end

	RegisterStateDriver(b, "visibility", "[petbattle][overridebar][vehicleui][possessbar,@vehicle,exists][shapeshift] hide; show")
end

-- Mouseover bar
if C.actionbar.custom_bar_mouseover then
	for i = 1, 12 do
		local b = _G["CustomBarButton"..i]
		b:SetAlpha(0)
		b:HookScript("OnEnter", function() CustomBarMouseOver(1) end)
		b:HookScript("OnLeave", function() if not HoverBind.enabled then CustomBarMouseOver(0) end end)
	end

	bar:SetScript("OnEnter", function() CustomBarMouseOver(1) end)
	bar:SetScript("OnLeave", function() if not HoverBind.enabled then CustomBarMouseOver(0) end end)
end