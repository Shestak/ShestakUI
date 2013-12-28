local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

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
		"MacroPopupOkayButton",
		"MacroPopupCancelButton",
		"MacroSaveButton",
		"MacroCancelButton"
	}

	for i = 1, #buttons do
		_G[buttons[i]]:SkinButton(true)
	end

	for i = 1, 2 do
		tab = _G[format("MacroFrameTab%s", i)]
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

	MacroPopupFrame:StripTextures()
	MacroPopupFrame:SetTemplate("Transparent")

	MacroPopupScrollFrame:StripTextures()
	MacroPopupScrollFrame:CreateBackdrop("Overlay")
	MacroPopupScrollFrame.backdrop:SetPoint("TOPLEFT", 51, 2)
	MacroPopupScrollFrame.backdrop:SetPoint("BOTTOMRIGHT", -4, 4)

	MacroPopupEditBox:StripTextures(true)
	MacroPopupEditBox:CreateBackdrop("Overlay")
	MacroPopupEditBox.backdrop:SetPoint("TOPLEFT", -3, 0)
	MacroPopupEditBox.backdrop:SetPoint("BOTTOMRIGHT", 0, 0)

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

	MacroPopupFrame:HookScript("OnShow", function(self)
		self:ClearAllPoints()
		self:SetPoint("TOPLEFT", MacroFrame, "TOPRIGHT", 3, 0)
	end)

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
		local pb = _G["MacroPopupButton"..i]
		local pt = _G["MacroPopupButton"..i.."Icon"]

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

		if pb then
			pb:StripTextures()
			pb:StyleButton(true)
			pb:SetTemplate("Default")
		end

		if pt then
			pt:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			pt:ClearAllPoints()
			pt:SetPoint("TOPLEFT", 2, -2)
			pt:SetPoint("BOTTOMRIGHT", -2, 2)
		end
	end
end

T.SkinFuncs["Blizzard_MacroUI"] = LoadSkin