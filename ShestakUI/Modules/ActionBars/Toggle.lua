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
	if SavedOptionsPerChar.BottomBars == 1 then
		ActionBarAnchor:Height(T.buttonsize)
		ToggleBarText(1, "+ + +", true)
		Bar2Holder:Hide()
	elseif SavedOptionsPerChar.BottomBars == 2 then
		ActionBarAnchor:Height(T.buttonsize * 2 + T.buttonspacing)
		ToggleBarText(1, "- - -", false, true)
		Bar2Holder:Show()
	end
end

local RightBars = function()
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
		Bar5Holder:Show()
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
		Bar5Holder:Hide()
	end
end

for i = 1, 5 do
	ToggleBar[i] = CreateFrame("Frame", "ToggleBar"..i, ToggleBar)
	ToggleBar[i]:EnableMouse(true)
	ToggleBar[i]:SetAlpha(0)
	
	ToggleBar[i].Text = ToggleBar[i]:CreateFontString(nil, "OVERLAY")
	ToggleBar[i].Text:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
	ToggleBar[i].Text:Point("CENTER", 2, 0)
	
	if i == 1 then
		ToggleBar[i]:CreatePanel("Transparent", ActionBarAnchor:GetWidth(), T.buttonsize / 2, "BOTTOM", ActionBarAnchor, "TOP", 0, T.buttonspacing)

		ToggleBar[i]:SetScript("OnMouseDown", function()
			if InCombatLockdown() then print("|cffffff00"..ERR_NOT_IN_COMBAT..".|r") return end
			if SavedOptionsPerChar.BottomBars == nil then SavedOptionsPerChar.BottomBars = C.actionbar.bottombars end
			SavedOptionsPerChar.BottomBars = SavedOptionsPerChar.BottomBars + 1

			if SavedOptionsPerChar.BottomBars > 2 then
				SavedOptionsPerChar.BottomBars = 1
			end
			
			MainBars()
		end)
		ToggleBar[i]:SetScript("OnEvent", MainBars)
	elseif i == 2 then
		ToggleBar[i]:CreatePanel("Transparent", RightActionBarAnchor:GetWidth(), T.buttonsize / 1.5, "TOPRIGHT", RightActionBarAnchor, "BOTTOMRIGHT", 0, -T.buttonspacing)
		
		ToggleBar[i]:SetScript("OnMouseDown", function()
			if InCombatLockdown() then print("|cffffff00"..ERR_NOT_IN_COMBAT..".|r") return end
			if SavedOptionsPerChar.RightBars == nil then SavedOptionsPerChar.RightBars = C.actionbar.rightbars end
			SavedOptionsPerChar.RightBars = SavedOptionsPerChar.RightBars - 1

			if SavedOptionsPerChar.RightBars > 3 then
				SavedOptionsPerChar.RightBars = 2
			elseif SavedOptionsPerChar.RightBars > 2 then
				SavedOptionsPerChar.RightBars = 1
			elseif SavedOptionsPerChar.RightBars < 0 then
				SavedOptionsPerChar.RightBars = 3
			end
			RightBars()
		end)
		ToggleBar[i]:SetScript("OnEvent", RightBars)	
	end

	ToggleBar[i]:RegisterEvent("PLAYER_ENTERING_WORLD")
	ToggleBar[i]:RegisterEvent("PLAYER_REGEN_DISABLED")
	ToggleBar[i]:RegisterEvent("PLAYER_REGEN_ENABLED")
	
	ToggleBar[i]:SetScript("OnEnter", function()
		if InCombatLockdown() then print("|cffffff00"..ERR_NOT_IN_COMBAT..".|r") return end
		if i == 2 then
			ToggleBar[i]:SetAlpha(1)
			if C.actionbar.rightbars_mouseover == true then
				RightBarMouseOver(1)
			end
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
		else
			ToggleBar[i]:FadeOut()
		end
	end)
end