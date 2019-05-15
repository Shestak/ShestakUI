local T, C, L, _ = unpack(select(2, ...))
if T.classic or C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	BindingUI skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local buttons = {
		"defaultsButton",
		"unbindButton",
		"okayButton",
		"cancelButton",
	}

	for _, v in pairs(buttons) do
		KeyBindingFrame[v]:SkinButton(true)
	end

	KeyBindingFrame:StripTextures()
	KeyBindingFrame:SetTemplate("Transparent")

	KeyBindingFrame.header:StripTextures()
	KeyBindingFrame.header:ClearAllPoints()
	KeyBindingFrame.header:SetPoint("TOP", KeyBindingFrame, "TOP", 0, -4)

	KeyBindingFrame.bindingsContainer:StripTextures()
	KeyBindingFrame.bindingsContainer:SetTemplate("Overlay")
	KeyBindingFrame.bindingsContainer:SetFrameLevel(1)

	KeyBindingFrameCategoryList:StripTextures()
	KeyBindingFrameCategoryList:SetTemplate("Overlay")

	T.SkinCheckBox(KeyBindingFrame.characterSpecificButton)

	KeyBindingFrameScrollFrame:StripTextures()
	T.SkinScrollBar(KeyBindingFrameScrollFrameScrollBar)

	KeyBindingFrame.defaultsButton:ClearAllPoints()
	KeyBindingFrame.defaultsButton:SetPoint("TOPLEFT", KeyBindingFrameCategoryList, "BOTTOMLEFT", 0, -14)
	KeyBindingFrame.unbindButton:ClearAllPoints()
	KeyBindingFrame.unbindButton:SetPoint("TOPRIGHT", KeyBindingFrame.bindingsContainer, "BOTTOMRIGHT", 0, -14)
	KeyBindingFrame.okayButton:ClearAllPoints()
	KeyBindingFrame.okayButton:SetPoint("RIGHT", KeyBindingFrame.unbindButton, "LEFT", -4, 0)
	KeyBindingFrame.cancelButton:ClearAllPoints()
	KeyBindingFrame.cancelButton:SetPoint("RIGHT", KeyBindingFrame.okayButton, "LEFT", -4, 0)

	for i = 1, KEY_BINDINGS_DISPLAYED do
		local button1 = _G["KeyBindingFrameKeyBinding"..i.."Key1Button"]
		local button2 = _G["KeyBindingFrameKeyBinding"..i.."Key2Button"]

		button2:SetPoint("LEFT", button1, "RIGHT", 2, 0)
	end

	hooksecurefunc("BindingButtonTemplate_SetupBindingButton", function(_, button)
		if not button.IsSkinned then
			button:SetHeight(button:GetHeight() - 1)
			button:StripTextures(true)
			button:StyleButton()
			button:SetTemplate("Overlay")

			local selected = button.selectedHighlight
			selected:SetPoint("TOPLEFT", 2, -2)
			selected:SetPoint("BOTTOMRIGHT", -2, 2)
			selected:SetColorTexture(1, 0.82, 0, 0.3)

			button.IsSkinned = true
		end
	end)
end

T.SkinFuncs["Blizzard_BindingUI"] = LoadSkin