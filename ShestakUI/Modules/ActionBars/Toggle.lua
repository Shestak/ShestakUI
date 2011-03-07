local T, C, L = unpack(select(2, ...))
if not C.actionbar.enable == true then return end

local ToggleBar = CreateFrame("Frame", "ToggleActionbar", UIParent)

local ToggleBarText = function(i, text, plus, neg)
	if plus then
		ToggleBar[i].Text:SetText(text)
		ToggleBar[i].Text:SetTextColor(0.3, 0.3, 0.9)
	elseif neg then
		ToggleBar[i].Text:SetText(text)
		ToggleBar[i].Text:SetTextColor(0.9, 0.3, 0.3)
	end
end

local MainBars = function()
	if C.actionbar.rightbars > 2 then
		if SavedOptionsPerChar.BottomBars == 1 then
			ActionBarAnchor:Height(T.buttonsize)
			ToggleBarText(1, "+ + +", true)
			Bar2Holder:Hide()
		elseif SavedOptionsPerChar.BottomBars == 2 then
			ActionBarAnchor:Height(T.buttonsize * 2 + T.buttonspacing)
			ToggleBarText(1, "- - -", false, true)
			Bar2Holder:Show()
		end
	elseif C.actionbar.rightbars < 3 and C.actionbar.split_bars ~= true then
		if SavedOptionsPerChar.BottomBars == 1 then
			ActionBarAnchor:Height(T.buttonsize)
			ToggleBarText(1, "+ + +", true)
			Bar2Holder:Hide()
			Bar5Holder:Hide()
		elseif SavedOptionsPerChar.BottomBars == 2 then
			ActionBarAnchor:Height(T.buttonsize * 2 + T.buttonspacing)
			ToggleBarText(1, "+ + +", true)
			Bar2Holder:Show()
			Bar5Holder:Hide()
		elseif SavedOptionsPerChar.BottomBars == 3 then
			ActionBarAnchor:Height((T.buttonsize * 3) + (T.buttonspacing * 2))
			ToggleBarText(1, "- - -", false, true)
			Bar2Holder:Show()
			Bar5Holder:Show()
		end
	elseif C.actionbar.rightbars < 3 and C.actionbar.split_bars == true then
		if SavedOptionsPerChar.BottomBars == 1 then
			ActionBarAnchor:Height(T.buttonsize)
			ToggleBarText(1, "+ + +", true)
			Bar2Holder:Hide()
			ToggleBar[3]:Height(T.buttonsize)
			ToggleBar[4]:Height(T.buttonsize)
			for i = 1, 3 do
				local b = _G["MultiBarBottomRightButton"..i]
				b:SetAlpha(0)
				b:SetScale(0.000001)
			end
			for i = 7, 9 do
				local b = _G["MultiBarBottomRightButton"..i]
				b:SetAlpha(0)
				b:SetScale(0.000001)
			end
		elseif SavedOptionsPerChar.BottomBars == 2 then
			ActionBarAnchor:Height(T.buttonsize * 2 + T.buttonspacing)
			ToggleBarText(1, "- - -", false, true)
			Bar2Holder:Show()
			ToggleBar[3]:Height(T.buttonsize * 2 + T.buttonspacing)
			ToggleBar[4]:Height(T.buttonsize * 2 + T.buttonspacing)
			for i = 1, 3 do
				local b = _G["MultiBarBottomRightButton"..i]
				b:SetAlpha(1)	
				b:SetScale(1)
			end
			for i = 7, 9 do
				local b = _G["MultiBarBottomRightButton"..i]
				b:SetAlpha(1)	
				b:SetScale(1)
			end
		end	
	end
end

local RightBars = function()
	if C.actionbar.rightbars > 2 then
		if SavedOptionsPerChar.RightBars == 1 then
			RightActionBarAnchor:Width(T.buttonsize)
			if not C.actionbar.petbar_horizontal == true then
				PetActionBarAnchor:ClearAllPoints()
				PetActionBarAnchor:Point("RIGHT", RightActionBarAnchor, "LEFT", 0, 0)
			end
			ToggleBar[2]:Width(T.buttonsize)
			ToggleBarText(2, "> > >", false, true)
			Bar3Holder:Hide()
			Bar4Holder:Hide()
		elseif SavedOptionsPerChar.RightBars == 2 then
			RightActionBarAnchor:Width(T.buttonsize * 2 + T.buttonspacing)
			if not C.actionbar.petbar_horizontal == true then
				PetActionBarAnchor:ClearAllPoints()
				PetActionBarAnchor:Point("RIGHT", RightActionBarAnchor, "LEFT", 0, 0)
			end
			ToggleBar[2]:Width(T.buttonsize * 2 + T.buttonspacing)
			ToggleBarText(2, "> > >", false, true)
			Bar3Holder:Hide()
			Bar4Holder:Show()
		elseif SavedOptionsPerChar.RightBars == 3 then
			RightActionBarAnchor:Width((T.buttonsize * 3) + (T.buttonspacing * 2))
			if not C.actionbar.petbar_horizontal == true then
				PetActionBarAnchor:ClearAllPoints()
				PetActionBarAnchor:Point("RIGHT", RightActionBarAnchor, "LEFT", 0, 0)
			end
			ToggleBar[2]:Width((T.buttonsize * 3) + (T.buttonspacing * 2))
			ToggleBarText(2, "> > >", false, true)
			Bar3Holder:Show()
			Bar4Holder:Show()
			if C.actionbar.rightbars > 2 then
				Bar5Holder:Show()
			end
		elseif SavedOptionsPerChar.RightBars == 0 then
			if not C.actionbar.petbar_horizontal == true then
				PetActionBarAnchor:ClearAllPoints()
				PetActionBarAnchor:Point("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -18, 320)
			end
			ToggleBar[2]:Width(T.buttonsize)
			ToggleBarText(2, "< < <", true)
			RightActionBarAnchor:Hide()
			Bar3Holder:Hide()
			Bar4Holder:Hide()
			if C.actionbar.rightbars > 2 then
				Bar5Holder:Hide()
			end
		end
	elseif C.actionbar.rightbars < 3 then
		if SavedOptionsPerChar.RightBars == 1 then
			RightActionBarAnchor:Width(T.buttonsize)
			if not C.actionbar.petbar_horizontal == true then
				PetActionBarAnchor:ClearAllPoints()
				PetActionBarAnchor:Point("RIGHT", RightActionBarAnchor, "LEFT", 0, 0)
			end
			ToggleBar[2]:Width(T.buttonsize)
			ToggleBarText(2, "> > >", false, true)
			Bar3Holder:Show()
			Bar4Holder:Hide()
		elseif SavedOptionsPerChar.RightBars == 2 then
			RightActionBarAnchor:Width(T.buttonsize * 2 + T.buttonspacing)
			if not C.actionbar.petbar_horizontal == true then
				PetActionBarAnchor:ClearAllPoints()
				PetActionBarAnchor:Point("RIGHT", RightActionBarAnchor, "LEFT", 0, 0)
			end
			ToggleBar[2]:Width(T.buttonsize * 2 + T.buttonspacing)
			ToggleBarText(2, "> > >", false, true)
			Bar3Holder:Show()
			Bar4Holder:Show()
		elseif SavedOptionsPerChar.RightBars == 0 then
			if not C.actionbar.petbar_horizontal == true then
				PetActionBarAnchor:ClearAllPoints()
				PetActionBarAnchor:Point("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -18, 320)
			end
			ToggleBar[2]:Width(T.buttonsize)
			ToggleBarText(2, "< < <", true)
			RightActionBarAnchor:Hide()
			Bar3Holder:Hide()
			Bar4Holder:Hide()
			if C.actionbar.rightbars > 2 then
				Bar5Holder:Hide()
			end
		end
	end
end

local SplitBars = function()
	if C.actionbar.split_bars == true and C.actionbar.rightbars ~= 3 then
		if SavedOptionsPerChar.SplitBars == true then
			ToggleBar[3]:ClearAllPoints()
			ToggleBar[3]:Point("BOTTOMLEFT", SplitBarRight, "BOTTOMRIGHT", T.buttonspacing, 0)
			ToggleBar[4]:ClearAllPoints()
			ToggleBar[4]:Point("BOTTOMRIGHT", SplitBarLeft, "BOTTOMLEFT", -T.buttonspacing, 0)
			VehicleButton:ClearAllPoints()
			VehicleButton:Point("BOTTOMRIGHT", SplitBarLeft, "BOTTOMLEFT", -T.buttonspacing, 0)
			if SavedOptionsPerChar.BottomBars == 2 then
				ToggleBarText(3, "<\n<\n<", false, true)
				ToggleBarText(4, ">\n>\n>", false, true)
			else
				ToggleBarText(3, "<\n<", false, true)
				ToggleBarText(4, ">\n>", false, true)
			end
			Bar5Holder:Show()
		elseif SavedOptionsPerChar.SplitBars == false then
			ToggleBar[3]:ClearAllPoints()
			ToggleBar[3]:Point("BOTTOMLEFT", ActionBarAnchor, "BOTTOMRIGHT", T.buttonspacing, 0)
			ToggleBar[4]:ClearAllPoints()
			ToggleBar[4]:Point("BOTTOMRIGHT", ActionBarAnchor, "BOTTOMLEFT", -T.buttonspacing, 0)
			VehicleButton:ClearAllPoints()
			VehicleButton:Point("BOTTOMRIGHT", ActionBarAnchor, "BOTTOMLEFT", -T.buttonspacing, 0)
			if SavedOptionsPerChar.BottomBars == 2 then
				ToggleBarText(3, ">\n>\n>", true)
				ToggleBarText(4, "<\n<\n<", true)
			else
				ToggleBarText(3, ">\n>", true)
				ToggleBarText(4, "<\n<", true)
			end
			Bar5Holder:Hide()
			SplitBarLeft:Hide()
			SplitBarRight:Hide()
		end
	end
end

for i = 1, 4 do
	ToggleBar[i] = CreateFrame("Frame", "ToggleBar"..i, ToggleBar)
	ToggleBar[i]:EnableMouse(true)
	ToggleBar[i]:SetAlpha(0)
	
	ToggleBar[i].Text = ToggleBar[i]:CreateFontString(nil, "OVERLAY")
	ToggleBar[i].Text:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
	ToggleBar[i].Text:Point("CENTER", 2, 0)
	
	if i == 1 then
		ToggleBar[i]:CreatePanel("Transparent", ActionBarAnchor:GetWidth(), T.buttonsize / 1.5, "BOTTOM", ActionBarAnchor, "TOP", 0, T.buttonspacing)
		ToggleBarText(i, "- - -", false, true)

		ToggleBar[i]:SetScript("OnMouseDown", function()
			if InCombatLockdown() then print("|cffffff00"..ERR_NOT_IN_COMBAT..".|r") return end
			if SavedOptionsPerChar.BottomBars == nil then SavedOptionsPerChar.BottomBars = C.actionbar.bottombars end
			SavedOptionsPerChar.BottomBars = SavedOptionsPerChar.BottomBars + 1

			if C.actionbar.rightbars > 2 then
				if SavedOptionsPerChar.BottomBars > 2 then
					SavedOptionsPerChar.BottomBars = 1
				end
			elseif C.actionbar.rightbars < 3 and C.actionbar.split_bars ~= true then
				if SavedOptionsPerChar.BottomBars > 3 then
					SavedOptionsPerChar.BottomBars = 1
				elseif SavedOptionsPerChar.BottomBars > 2 then
					SavedOptionsPerChar.BottomBars = 3
				elseif SavedOptionsPerChar.BottomBars < 1 then
					SavedOptionsPerChar.BottomBars = 3
				end
			elseif C.actionbar.rightbars < 3 and C.actionbar.split_bars == true then
				if SavedOptionsPerChar.BottomBars > 2 then
					SavedOptionsPerChar.BottomBars = 1
				end
			end
			
			MainBars()
		end)
		ToggleBar[i]:SetScript("OnEvent", MainBars)
	elseif i == 2 then
		ToggleBar[i]:CreatePanel("Transparent", RightActionBarAnchor:GetWidth(), T.buttonsize / 1.5, "TOPRIGHT", RightActionBarAnchor, "BOTTOMRIGHT", 0, -T.buttonspacing)
		ToggleBarText(i, "> > >", false, true)
		
		ToggleBar[i]:SetScript("OnMouseDown", function()
			if InCombatLockdown() then print("|cffffff00"..ERR_NOT_IN_COMBAT..".|r") return end
			if SavedOptionsPerChar.RightBars == nil then SavedOptionsPerChar.RightBars = C.actionbar.rightbars end
			SavedOptionsPerChar.RightBars = SavedOptionsPerChar.RightBars - 1

			if C.actionbar.rightbars > 2 then
				if SavedOptionsPerChar.RightBars > 3 then
					SavedOptionsPerChar.RightBars = 2
				elseif SavedOptionsPerChar.RightBars > 2 then
					SavedOptionsPerChar.RightBars = 1
				elseif SavedOptionsPerChar.RightBars < 0 then
					SavedOptionsPerChar.RightBars = 3
				end
			elseif C.actionbar.rightbars < 3 then
				if SavedOptionsPerChar.RightBars > 2 then
					SavedOptionsPerChar.RightBars = 1
				elseif SavedOptionsPerChar.RightBars < 0 then
					SavedOptionsPerChar.RightBars = 2
				end
			end
			
			RightBars()
		end)
		ToggleBar[i]:SetScript("OnEvent", RightBars)
	elseif i == 3 then
		if C.actionbar.split_bars == true and C.actionbar.rightbars ~= 3 then
			ToggleBar[i]:CreatePanel("Transparent", T.buttonsize / 1.5, ActionBarAnchor:GetHeight(), "BOTTOMLEFT", SplitBarRight, "BOTTOMRIGHT", T.buttonspacing, 0)
			ToggleBarText(i, "<\n<", false, true)
			ToggleBar[i]:SetFrameLevel(SplitBarRight:GetFrameLevel() + 1)
		end
	elseif i == 4 then
		if C.actionbar.split_bars == true and C.actionbar.rightbars ~= 3 then
			ToggleBar[i]:CreatePanel("Transparent", T.buttonsize / 1.5, ActionBarAnchor:GetHeight(), "BOTTOMRIGHT", SplitBarLeft, "BOTTOMLEFT", -T.buttonspacing, 0)
			ToggleBarText(i, ">\n>", false, true)
			ToggleBar[i]:SetFrameLevel(SplitBarLeft:GetFrameLevel() + 1)
		end
	end

	if i == 3 or i == 4 then
		ToggleBar[i]:SetScript("OnMouseDown", function()
			if InCombatLockdown() then print("|cffffff00"..ERR_NOT_IN_COMBAT..".|r") return end
			if SavedOptionsPerChar.SplitBars == nil then SavedOptionsPerChar.SplitBars = false end
			
			if SavedOptionsPerChar.SplitBars == false then
				SavedOptionsPerChar.SplitBars = true
			elseif SavedOptionsPerChar.SplitBars == true then
				SavedOptionsPerChar.SplitBars = false
			end
			SplitBars()
		end)
		ToggleBar[i]:SetScript("OnEvent", SplitBars)
	end
	
	ToggleBar[i]:RegisterEvent("PLAYER_ENTERING_WORLD")
	ToggleBar[i]:RegisterEvent("PLAYER_REGEN_DISABLED")
	ToggleBar[i]:RegisterEvent("PLAYER_REGEN_ENABLED")
	
	ToggleBar[i]:SetScript("OnEnter", function()
		if InCombatLockdown() then return end
		if i == 2 then
			ToggleBar[i]:SetAlpha(1)
			if C.actionbar.rightbars_mouseover == true then
				RightBarMouseOver(1)
			end
		elseif i == 3 or i == 4 then
			ToggleBar[3]:FadeIn()
			ToggleBar[4]:FadeIn()
			VehicleButton:ClearAllPoints()
			VehicleButton:Point("BOTTOMRIGHT", ToggleBar[4], "BOTTOMLEFT", -T.buttonspacing, 0)
		else
			ToggleBar[i]:FadeIn()
		end
	end)

	ToggleBar[i]:SetScript("OnLeave", function()
		if i == 2 then
			ToggleBar[i]:SetAlpha(0)
			if C.actionbar.rightbars_mouseover == true then
				RightBarMouseOver(0)
			end
		elseif i == 3 or i == 4 then
			ToggleBar[3]:FadeOut()
			ToggleBar[4]:FadeOut()
			VehicleButton:ClearAllPoints()
			if SavedOptionsPerChar.SplitBars == true then
				VehicleButton:Point("BOTTOMRIGHT", SplitBarLeft, "BOTTOMLEFT", -T.buttonspacing, 0)
			else
				VehicleButton:Point("BOTTOMRIGHT", ActionBarAnchor, "BOTTOMLEFT", -T.buttonspacing, 0)
			end
		else
			ToggleBar[i]:FadeOut()
		end
	end)
end