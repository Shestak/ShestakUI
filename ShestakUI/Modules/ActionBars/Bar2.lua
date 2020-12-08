local T, C, L, _ = unpack(select(2, ...))
if C.actionbar.enable ~= true then return end

----------------------------------------------------------------------------------------
--	MultiBarBottomLeft(by Tukz)
----------------------------------------------------------------------------------------
local bar = CreateFrame("Frame", "Bar2Holder", ActionBarAnchor)
if C.actionbar.editor then
	local NumRow = ceil(C.actionbar.bar2_num / C.actionbar.bar2_row)
	bar:SetWidth((C.actionbar.bar2_size * C.actionbar.bar2_row) + (C.actionbar.button_space * (C.actionbar.bar2_row - 1)))
	bar:SetHeight((C.actionbar.bar2_size * NumRow) + (C.actionbar.button_space * (NumRow - 1)))
	bar:SetPoint("BOTTOMLEFT", Bar1Holder, "TOPLEFT", 0, C.actionbar.button_space)
else
	bar:SetAllPoints(ActionBarAnchor)
end
MultiBarBottomLeft:SetParent(bar)

local NumPerRows = C.actionbar.bar2_row
local NextRowButtonAnchor = _G["MultiBarBottomLeftButton1"]
for i = 1, 12 do
	local b = _G["MultiBarBottomLeftButton"..i]
	local b2 = _G["MultiBarBottomLeftButton"..i-1]
	b:ClearAllPoints()
	if C.actionbar.editor then
		if i <= C.actionbar.bar2_num then
			if i == 1 then
				b:SetPoint("TOPLEFT", bar, "TOPLEFT", 0, 0)
			elseif i == NumPerRows + 1 then
				b:SetPoint("TOPLEFT", NextRowButtonAnchor, "BOTTOMLEFT", 0, -C.actionbar.button_space)

				NumPerRows = NumPerRows + C.actionbar.bar2_row
				NextRowButtonAnchor = _G["MultiBarBottomLeftButton"..i]
			else
				b:SetPoint("LEFT", b2, "RIGHT", C.actionbar.button_space, 0)
			end
		else
			b:SetPoint("TOP", UIParent, "TOP", 0, 200)
		end
	else
		if i == 1 then
			b:SetPoint("BOTTOM", ActionButton1, "TOP", 0, C.actionbar.button_space)
		else
			b:SetPoint("LEFT", b2, "RIGHT", C.actionbar.button_space, 0)
		end
	end
end

-- Hide bar
if C.actionbar.bottombars == 1 then
	bar:Hide()
end

if C.actionbar.bottombars_mouseover then
	for i = 1, 12 do
		local b = _G["MultiBarBottomLeftButton"..i]
		b:SetAlpha(0)
		b:HookScript("OnEnter", function() BottomBarMouseOver(1) end)
		b:HookScript("OnLeave", function() if not HoverBind.enabled then BottomBarMouseOver(0) end end)
	end
end

if C.actionbar.editor and C.actionbar.bar2_mouseover then
	local function BarMouseOver(alpha)
		if MultiBarRight:IsShown() then
			for i = 1, 12 do
				local pb = _G["MultiBarBottomLeftButton"..i]
				pb:SetAlpha(alpha)
				local g = _G["MultiBarBottomLeftButton"..i.."Cooldown"]
				T.HideSpiral(g, alpha)
			end
			bar:SetAlpha(alpha)
		end
	end

	for i = 1, 12 do
		local b = _G["MultiBarBottomLeftButton"..i]
		b:SetAlpha(0)
		b:HookScript("OnEnter", function() BarMouseOver(1) end)
		b:HookScript("OnLeave", function() if not HoverBind.enabled then BarMouseOver(0) end end)
	end

	bar:SetAlpha(0)
	bar:SetScript("OnEnter", function() BarMouseOver(1) end)
	bar:SetScript("OnLeave", function() if not HoverBind.enabled then BarMouseOver(0) end end)
end