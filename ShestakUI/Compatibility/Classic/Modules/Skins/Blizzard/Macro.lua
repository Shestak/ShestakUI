local T, C, L, _ = unpack(select(2, ...))
if not T.classic or C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	MacroUI skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local buttons = {
		"MacroDeleteButton",
		"MacroNewButton",
		"MacroExitButton",
		"MacroEditButton",
		"MacroFrameTab1",
		"MacroFrameTab2",
		"MacroSaveButton",
		"MacroCancelButton"
	}

	for i = 1, #buttons do
		_G[buttons[i]]:SkinButton(true)
	end

	for i = 1, 2 do
		local tab = _G[format("MacroFrameTab%s", i)]
		tab:SetHeight(22)
	end
	MacroFrameTab1:SetPoint("TOPLEFT", MacroFrame, "TOPLEFT", 10, -39)
	MacroFrameTab2:SetPoint("LEFT", MacroFrameTab1, "RIGHT", 4, 0)

	-- General
	MacroFrame:StripTextures()
	MacroFrame:CreateBackdrop("Transparent")
	MacroFrame.backdrop:SetPoint("TOPLEFT", 0, 0)
	MacroFrame.backdrop:SetPoint("BOTTOMRIGHT", 0, 0)
	MacroFrameInset:StripTextures()

	MacroFrameTextBackground:StripTextures()
	MacroFrameTextBackground:CreateBackdrop("Overlay")
	MacroFrameTextBackground.backdrop:SetPoint("TOPLEFT", 4, -3)
	MacroFrameTextBackground.backdrop:SetPoint("BOTTOMRIGHT", -23, 0)

	MacroButtonScrollFrame:CreateBackdrop("Overlay")

	T.SkinCloseButton(MacroFrameCloseButton, MacroFrame.backdrop)

	-- Reposition buttons
	MacroEditButton:ClearAllPoints()
	MacroEditButton:SetPoint("BOTTOMLEFT", MacroFrameSelectedMacroButton, "BOTTOMRIGHT", 10, 0)
	MacroDeleteButton:ClearAllPoints()
	MacroDeleteButton:SetPoint("BOTTOMLEFT", MacroFrame.backdrop, "BOTTOMLEFT", 9, 4)
	MacroNewButton:ClearAllPoints()
	MacroNewButton:SetPoint("RIGHT", MacroExitButton, "LEFT", -3, 0)

	-- Regular scroll bar
	T.SkinScrollBar(MacroButtonScrollFrame)
	T.SkinScrollBar(MacroButtonScrollFrameScrollBar)
	T.SkinScrollBar(MacroFrameScrollFrameScrollBar)
	T.SkinScrollBar(MacroPopupScrollFrameScrollBar)

	-- Big icon
	MacroFrameSelectedMacroButton:StripTextures()
	MacroFrameSelectedMacroButton:StyleButton(true)
	MacroFrameSelectedMacroButton:GetNormalTexture():SetTexture(nil)
	MacroFrameSelectedMacroButton:SetTemplate("Default")
	MacroFrameSelectedMacroButtonIcon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	MacroFrameSelectedMacroButtonIcon:ClearAllPoints()
	MacroFrameSelectedMacroButtonIcon:SetPoint("TOPLEFT", 2, -2)
	MacroFrameSelectedMacroButtonIcon:SetPoint("BOTTOMRIGHT", -2, 2)

	-- Moving text
	MacroFrameCharLimitText:ClearAllPoints()
	MacroFrameCharLimitText:SetPoint("BOTTOM", MacroFrameTextBackground, 0, -12)

	-- Skin all buttons
	for i = 1, MAX_ACCOUNT_MACROS do
		local b = _G["MacroButton"..i]
		local t = _G["MacroButton"..i.."Icon"]
		if b then
			b:StripTextures()
			b:StyleButton(true)
			b:SetTemplate("Default")
		end

		if t then
			t:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			t:ClearAllPoints()
			t:SetPoint("TOPLEFT", 2, -2)
			t:SetPoint("BOTTOMRIGHT", -2, 2)
		end
	end

	-- Icon selection frame
	T.SkinIconSelectionFrame(MacroPopupFrame, NUM_MACRO_ICONS_SHOWN, nil, "MacroPopup")
end

T.SkinFuncs["Blizzard_MacroUI"] = LoadSkin