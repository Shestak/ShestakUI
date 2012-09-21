local T, C, L, _ = unpack(ShestakUI)
if C.extra_bar_two.enable ~= true or C.actionbar.enable ~= true then return end

----------------------------------------------------------------------------------------
--	Custom ActionBar(ExtraBar by Cowmonster)
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
--	Extra Action Bar 2
----------------------------------------------------------------------------------------
local bar = CreateFrame("Frame", "ExtraBarTwoAnchor", UIParent)
bar:CreatePanel("Invisible", 1, 1, unpack(C.extra_position.extra_bar_two))
if C.extra_bar_two.style == "1*12" then
	bar:Width(C.actionbar.button_size)
	bar:Height((C.actionbar.button_size * 12) + (C.actionbar.button_space * 11))
elseif C.extra_bar_two.style == "12*1" then
	bar:Width((C.actionbar.button_size * 12) + (C.actionbar.button_space * 11))
	bar:Height(C.actionbar.button_size)
elseif C.extra_bar_two.style == "6*2" then
	bar:Width((C.actionbar.button_size * 6) + (C.actionbar.button_space * 5))
	bar:Height((C.actionbar.button_size * 2) + C.actionbar.button_space)
elseif C.extra_bar_two.style == "4*3" then
	bar:Width((C.actionbar.button_size * 4) + (C.actionbar.button_space * 3))
	bar:Height((C.actionbar.button_size * 3) + C.actionbar.button_space * 2)
elseif C.extra_bar_two.style == "3*4" then
	bar:Width((C.actionbar.button_size * 3) + (C.actionbar.button_space * 2))
	bar:Height((C.actionbar.button_size * 4) + C.actionbar.button_space * 3)
else
	bar:Width((C.actionbar.button_size * 12) + (C.actionbar.button_space * 11))
	bar:Height(C.actionbar.button_size)
end
bar:SetFrameStrata("LOW")
tinsert(T.MoverFrames, ExtraBarTwoAnchor)

for i = 13, 24 do
	local f = CreateFrame("CheckButton", "ExtraBarTwoButton"..(i-12), UIParent, "ActionBarButtonTemplate")

	f:Size(C.actionbar.button_size, C.actionbar.button_size)
	f:SetAttribute("action", i)
	if C.extra_bar_two.show_grid == true then
		f:SetAttribute("showgrid", 1)
	end
	f:SetID(i)
	f:ClearAllPoints()
	if C.extra_bar_two.style == "1*12" then
		if i == 13 then
			f:Point("TOPLEFT", ExtraBarTwoAnchor, "TOPLEFT", 0, 0)
		else
			f:Point("TOP", "ExtraBarTwoButton"..i-13, "BOTTOM", 0, -C.actionbar.button_space)
		end
	elseif C.extra_bar_two.style == "12*1" then
		if i == 13 then
			f:Point("TOPLEFT", ExtraBarTwoAnchor, "TOPLEFT", 0, 0)
		else
			f:Point("LEFT", "ExtraBarTwoButton"..i-13, "RIGHT", C.actionbar.button_space, 0)
		end
	elseif C.extra_bar_two.style == "6*2" then
		if i == 13 then
			f:Point("TOPLEFT", ExtraBarTwoAnchor, "TOPLEFT", 0, 0)
		elseif i == 19 then
			f:Point("TOPLEFT", "ExtraBarTwoButton1", "BOTTOMLEFT", 0, -C.actionbar.button_space)
		else
			f:Point("LEFT", "ExtraBarTwoButton"..i-13, "RIGHT", C.actionbar.button_space, 0)
		end
	elseif C.extra_bar_two.style == "4*3" then
		if i == 13 then
			f:Point("TOPLEFT", ExtraBarTwoAnchor, "TOPLEFT", 0, 0)
		elseif i == 17 then
			f:Point("TOPLEFT", "ExtraBarTwoButton1", "BOTTOMLEFT", 0, -C.actionbar.button_space)
		elseif i == 21 then
			f:Point("TOPLEFT", "ExtraBarTwoButton5", "BOTTOMLEFT", 0, -C.actionbar.button_space)
		else
			f:Point("LEFT", "ExtraBarTwoButton"..i-13, "RIGHT", C.actionbar.button_space, 0)
		end
	elseif C.extra_bar_two.style == "3*4" then
		if i == 13 then
			f:Point("TOPLEFT", ExtraBarTwoAnchor, "TOPLEFT", 0, 0)
		elseif i == 16 then
			f:Point("TOPLEFT", "ExtraBarTwoButton1", "BOTTOMLEFT", 0, -C.actionbar.button_space)
		elseif i == 19 then
			f:Point("TOPLEFT", "ExtraBarTwoButton4", "BOTTOMLEFT", 0, -C.actionbar.button_space)
		elseif i == 22 then
			f:Point("TOPLEFT", "ExtraBarTwoButton7", "BOTTOMLEFT", 0, -C.actionbar.button_space)
		else
			f:Point("LEFT", "ExtraBarTwoButton"..i-13, "RIGHT", C.actionbar.button_space, 0)
		end
	else
		if i == 13 then
			f:Point("TOPLEFT", ExtraBarTwoAnchor, "TOPLEFT", 0, 0)
		else
			f:Point("LEFT", "ExtraBarTwoButton"..i-13, "RIGHT", C.actionbar.button_space, 0)
		end
	end

	f:StyleButton()
	f:Show()
	RegisterStateDriver(f, "visibility", "[petbattle] hide;show")
end

-- Correct bindinng names
_G["BINDING_HEADER_ExtraBarTwo_HEADER"] = L_EXTRA_HEADER_ExtraBarTwo
_G["BINDING_NAME_CLICK ExtraBarTwoButton1:LeftButton"] = "Extra ActionBar Button 1"
_G["BINDING_NAME_CLICK ExtraBarTwoButton2:LeftButton"] = "Extra ActionBar Button 2"
_G["BINDING_NAME_CLICK ExtraBarTwoButton3:LeftButton"] = "Extra ActionBar Button 3"
_G["BINDING_NAME_CLICK ExtraBarTwoButton4:LeftButton"] = "Extra ActionBar Button 4"
_G["BINDING_NAME_CLICK ExtraBarTwoButton5:LeftButton"] = "Extra ActionBar Button 5"
_G["BINDING_NAME_CLICK ExtraBarTwoButton6:LeftButton"] = "Extra ActionBar Button 6"
_G["BINDING_NAME_CLICK ExtraBarTwoButton7:LeftButton"] = "Extra ActionBar Button 7"
_G["BINDING_NAME_CLICK ExtraBarTwoButton8:LeftButton"] = "Extra ActionBar Button 8"
_G["BINDING_NAME_CLICK ExtraBarTwoButton9:LeftButton"] = "Extra ActionBar Button 9"
_G["BINDING_NAME_CLICK ExtraBarTwoButton10:LeftButton"] = "Extra ActionBar Button 10"
_G["BINDING_NAME_CLICK ExtraBarTwoButton11:LeftButton"] = "Extra ActionBar Button 11"
_G["BINDING_NAME_CLICK ExtraBarTwoButton12:LeftButton"] = "Extra ActionBar Button 12"

-- Mouseover bar
if C.extra_bar_two.mouseover ~= true then return end

function ExtraBarTwoMouseOver(alpha)
	for i = 1, 12 do
		local b = _G["ExtraBarTwoButton"..i]
		b:SetAlpha(alpha)
	end
	ExtraBarTwoAnchor:SetAlpha(alpha)
end

do
	ExtraBarTwoAnchor:SetAlpha(0)
	ExtraBarTwoAnchor:SetScript("OnEnter", function() ExtraBarTwoMouseOver(1) end)
	ExtraBarTwoAnchor:SetScript("OnLeave", function() ExtraBarTwoMouseOver(0) end)
	for i = 1, 12 do
		local b = _G["ExtraBarTwoButton"..i]
		b:SetAlpha(0)
		b:HookScript("OnEnter", function() ExtraBarTwoMouseOver(1) end)
		b:HookScript("OnLeave", function() ExtraBarTwoMouseOver(0) end)
	end
end

-- Edit by Oz of shestak.org --
