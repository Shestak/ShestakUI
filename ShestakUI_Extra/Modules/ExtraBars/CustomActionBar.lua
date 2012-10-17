local T, C, L, _ = unpack(ShestakUI)
if C.extra_bar.enable ~= true or C.actionbar.enable ~= true then return end

----------------------------------------------------------------------------------------
--	Custom ActionBar(ExtraBar by Cowmonster)
----------------------------------------------------------------------------------------
local bar = CreateFrame("Frame", "ExtraBarAnchor", UIParent)
bar:CreatePanel("Invisible", 1, 1, unpack(C.extra_position.extra_bar))
if C.extra_bar.style == "1*12" then
	bar:SetWidth(C.actionbar.button_size)
	bar:SetHeight((C.actionbar.button_size * 12) + (C.actionbar.button_space * 11))
elseif C.extra_bar.style == "12*1" then
	bar:SetWidth((C.actionbar.button_size * 12) + (C.actionbar.button_space * 11))
	bar:SetHeight(C.actionbar.button_size)
elseif C.extra_bar.style == "6*2" then
	bar:SetWidth((C.actionbar.button_size * 6) + (C.actionbar.button_space * 5))
	bar:SetHeight((C.actionbar.button_size * 2) + C.actionbar.button_space)
elseif C.extra_bar.style == "4*3" then
	bar:SetWidth((C.actionbar.button_size * 4) + (C.actionbar.button_space * 3))
	bar:SetHeight((C.actionbar.button_size * 3) + C.actionbar.button_space * 2)
elseif C.extra_bar.style == "3*4" then
	bar:SetWidth((C.actionbar.button_size * 3) + (C.actionbar.button_space * 2))
	bar:SetHeight((C.actionbar.button_size * 4) + C.actionbar.button_space * 3)
else
	bar:SetWidth((C.actionbar.button_size * 12) + (C.actionbar.button_space * 11))
	bar:SetHeight(C.actionbar.button_size)
end
bar:SetFrameStrata("LOW")
tinsert(T.MoverFrames, ExtraBarAnchor)

for i = 13, 24 do
	local f = CreateFrame("CheckButton", "ExtraBarButton"..(i-12), UIParent, "ActionBarButtonTemplate")

	f:SetSize(C.actionbar.button_size, C.actionbar.button_size)
	f:SetAttribute("action", i)
	if C.extra_bar.show_grid == true then
		f:SetAttribute("showgrid", 1)
	end
	f:SetID(i)
	f:ClearAllPoints()
	if C.extra_bar.style == "1*12" then
		if i == 13 then
			f:SetPoint("TOPLEFT", ExtraBarAnchor, "TOPLEFT", 0, 0)
		else
			f:SetPoint("TOP", "ExtraBarButton"..i-13, "BOTTOM", 0, -C.actionbar.button_space)
		end
	elseif C.extra_bar.style == "12*1" then
		if i == 13 then
			f:SetPoint("TOPLEFT", ExtraBarAnchor, "TOPLEFT", 0, 0)
		else
			f:SetPoint("LEFT", "ExtraBarButton"..i-13, "RIGHT", C.actionbar.button_space, 0)
		end
	elseif C.extra_bar.style == "6*2" then
		if i == 13 then
			f:SetPoint("TOPLEFT", ExtraBarAnchor, "TOPLEFT", 0, 0)
		elseif i == 19 then
			f:SetPoint("TOPLEFT", "ExtraBarButton1", "BOTTOMLEFT", 0, -C.actionbar.button_space)
		else
			f:SetPoint("LEFT", "ExtraBarButton"..i-13, "RIGHT", C.actionbar.button_space, 0)
		end
	elseif C.extra_bar.style == "4*3" then
		if i == 13 then
			f:SetPoint("TOPLEFT", ExtraBarAnchor, "TOPLEFT", 0, 0)
		elseif i == 17 then
			f:SetPoint("TOPLEFT", "ExtraBarButton1", "BOTTOMLEFT", 0, -C.actionbar.button_space)
		elseif i == 21 then
			f:SetPoint("TOPLEFT", "ExtraBarButton5", "BOTTOMLEFT", 0, -C.actionbar.button_space)
		else
			f:SetPoint("LEFT", "ExtraBarButton"..i-13, "RIGHT", C.actionbar.button_space, 0)
		end
	elseif C.extra_bar.style == "3*4" then
		if i == 13 then
			f:SetPoint("TOPLEFT", ExtraBarAnchor, "TOPLEFT", 0, 0)
		elseif i == 16 then
			f:SetPoint("TOPLEFT", "ExtraBarButton1", "BOTTOMLEFT", 0, -C.actionbar.button_space)
		elseif i == 19 then
			f:SetPoint("TOPLEFT", "ExtraBarButton4", "BOTTOMLEFT", 0, -C.actionbar.button_space)
		elseif i == 22 then
			f:SetPoint("TOPLEFT", "ExtraBarButton7", "BOTTOMLEFT", 0, -C.actionbar.button_space)
		else
			f:SetPoint("LEFT", "ExtraBarButton"..i-13, "RIGHT", C.actionbar.button_space, 0)
		end
	else
		if i == 13 then
			f:SetPoint("TOPLEFT", ExtraBarAnchor, "TOPLEFT", 0, 0)
		else
			f:SetPoint("LEFT", "ExtraBarButton"..i-13, "RIGHT", C.actionbar.button_space, 0)
		end
	end

	f:StyleButton()
	f:Show()
	RegisterStateDriver(f, "visibility", "[petbattle] hide;show")
end

-- Correct bindinng names
_G["BINDING_HEADER_EXTRABAR_HEADER"] = L_EXTRA_HEADER_EXTRABAR
_G["BINDING_NAME_CLICK ExtraBarButton1:LeftButton"] = "Extra ActionBar Button 1"
_G["BINDING_NAME_CLICK ExtraBarButton2:LeftButton"] = "Extra ActionBar Button 2"
_G["BINDING_NAME_CLICK ExtraBarButton3:LeftButton"] = "Extra ActionBar Button 3"
_G["BINDING_NAME_CLICK ExtraBarButton4:LeftButton"] = "Extra ActionBar Button 4"
_G["BINDING_NAME_CLICK ExtraBarButton5:LeftButton"] = "Extra ActionBar Button 5"
_G["BINDING_NAME_CLICK ExtraBarButton6:LeftButton"] = "Extra ActionBar Button 6"
_G["BINDING_NAME_CLICK ExtraBarButton7:LeftButton"] = "Extra ActionBar Button 7"
_G["BINDING_NAME_CLICK ExtraBarButton8:LeftButton"] = "Extra ActionBar Button 8"
_G["BINDING_NAME_CLICK ExtraBarButton9:LeftButton"] = "Extra ActionBar Button 9"
_G["BINDING_NAME_CLICK ExtraBarButton10:LeftButton"] = "Extra ActionBar Button 10"
_G["BINDING_NAME_CLICK ExtraBarButton11:LeftButton"] = "Extra ActionBar Button 11"
_G["BINDING_NAME_CLICK ExtraBarButton12:LeftButton"] = "Extra ActionBar Button 12"

-- Mouseover bar
if C.extra_bar.mouseover ~= true then return end

function ExtraBarMouseOver(alpha)
	for i = 1, 12 do
		local b = _G["ExtraBarButton"..i]
		b:SetAlpha(alpha)
	end
	ExtraBarAnchor:SetAlpha(alpha)
end

do
	ExtraBarAnchor:SetAlpha(0)
	ExtraBarAnchor:SetScript("OnEnter", function() ExtraBarMouseOver(1) end)
	ExtraBarAnchor:SetScript("OnLeave", function() ExtraBarMouseOver(0) end)
	for i = 1, 12 do
		local b = _G["ExtraBarButton"..i]
		b:SetAlpha(0)
		b:HookScript("OnEnter", function() ExtraBarMouseOver(1) end)
		b:HookScript("OnLeave", function() ExtraBarMouseOver(0) end)
	end
end