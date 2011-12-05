local T, C, L = unpack(select(2, ...))
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
		_G[buttons[i]]:StripTextures()
		_G[buttons[i]]:SkinButton()
	end

	for i = 1, 2 do
		tab = _G[format("MacroFrameTab%s", i)]
		tab:Height(22)
	end
	MacroFrameTab1:Point("TOPLEFT", MacroFrame, "TOPLEFT", 85, -39)
	MacroFrameTab2:Point("LEFT", MacroFrameTab1, "RIGHT", 4, 0)

	-- General
	MacroFrame:Width(360)
	MacroFrame:StripTextures()
	MacroFrame:CreateBackdrop("Transparent")
	MacroFrame.backdrop:Point("TOPLEFT", 0, -12)
	MacroFrame.backdrop:Point("BOTTOMRIGHT", 0, 30)
	MacroFrameTextBackground:StripTextures()
	MacroFrameTextBackground:CreateBackdrop("Overlay")
	MacroButtonScrollFrame:CreateBackdrop("Overlay")
	MacroPopupFrame:StripTextures()
	MacroPopupFrame:SetTemplate("Transparent")
	MacroPopupScrollFrame:StripTextures()
	MacroPopupScrollFrame:CreateBackdrop("Overlay")
	MacroPopupScrollFrame.backdrop:Point("TOPLEFT", 51, 2)
	MacroPopupScrollFrame.backdrop:Point("BOTTOMRIGHT", -4, 4)
	MacroPopupEditBox:CreateBackdrop("Overlay")
	MacroPopupEditBox:StripTextures(true)
	T.SkinCloseButton(MacroFrameCloseButton, MacroFrame.backdrop)

	-- Reposition edit button
	MacroEditButton:ClearAllPoints()
	MacroEditButton:Point("BOTTOMLEFT", MacroFrameSelectedMacroButton, "BOTTOMRIGHT", 10, 0)

	-- Regular scroll bar
	T.SkinScrollBar(MacroButtonScrollFrame)

	MacroPopupFrame:HookScript("OnShow", function(self)
		self:ClearAllPoints()
		self:Point("TOPLEFT", MacroFrame, "TOPRIGHT", 3, -12)
	end)

	-- Big icon
	MacroFrameSelectedMacroButton:StripTextures()
	MacroFrameSelectedMacroButton:StyleButton(true)
	MacroFrameSelectedMacroButton:GetNormalTexture():SetTexture(nil)
	MacroFrameSelectedMacroButton:SetTemplate("Default")
	MacroFrameSelectedMacroButtonIcon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	MacroFrameSelectedMacroButtonIcon:ClearAllPoints()
	MacroFrameSelectedMacroButtonIcon:Point("TOPLEFT", 2, -2)
	MacroFrameSelectedMacroButtonIcon:Point("BOTTOMRIGHT", -2, 2)

	-- Moving text
	MacroFrameCharLimitText:ClearAllPoints()
	MacroFrameCharLimitText:Point("BOTTOM", MacroFrameTextBackground, 0, -70)

	-- Skin all buttons
	for i = 1, MAX_ACCOUNT_MACROS do
		local b = _G["MacroButton"..i]
		local t = _G["MacroButton"..i.."Icon"]
		local pb = _G["MacroPopupButton"..i]
		local pt = _G["MacroPopupButton"..i.."Icon"]

		if b then
			b:StripTextures()
			b:StyleButton(true)

			b:SetTemplate("Default", true)
		end

		if t then
			t:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			t:ClearAllPoints()
			t:Point("TOPLEFT", 2, -2)
			t:Point("BOTTOMRIGHT", -2, 2)
		end

		if pb then
			pb:StripTextures()
			pb:StyleButton(true)

			pb:SetTemplate("Default")
		end

		if pt then
			pt:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			pt:ClearAllPoints()
			pt:Point("TOPLEFT", 2, -2)
			pt:Point("BOTTOMRIGHT", -2, 2)
		end
	end
end

T.SkinFuncs["Blizzard_MacroUI"] = LoadSkin