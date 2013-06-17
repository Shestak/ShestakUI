local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	BindingUI skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local buttons = {
		"KeyBindingFrameDefaultButton",
		"KeyBindingFrameUnbindButton",
		"KeyBindingFrameOkayButton",
		"KeyBindingFrameCancelButton"
	}

	for _, v in pairs(buttons) do
		_G[v]:SkinButton(true)
	end

	T.SkinCheckBox(KeyBindingFrameCharacterButton)
	KeyBindingFrameHeaderText:ClearAllPoints()
	KeyBindingFrameHeaderText:SetPoint("TOP", KeyBindingFrame, "TOP", 0, -4)
	KeyBindingFrame:StripTextures()
	KeyBindingFrame:CreateBackdrop("Transparent")
	KeyBindingFrame.backdrop:SetPoint("TOPLEFT", 0, 0)
	KeyBindingFrame.backdrop:SetPoint("BOTTOMRIGHT", -40, 10)

	for i = 1, KEY_BINDINGS_DISPLAYED do
		local button1 = _G["KeyBindingFrameBinding"..i.."Key1Button"]
		local button2 = _G["KeyBindingFrameBinding"..i.."Key2Button"]

		button1:StripTextures(true)
		button1:StyleButton()
		button1:SetTemplate("Overlay")

		button2:StripTextures(true)
		button2:StyleButton()
		button2:SetTemplate("Overlay")
		button2:SetPoint("LEFT", button1, "RIGHT", 1, 0)
	end

	KeyBindingFrameUnbindButton:SetPoint("RIGHT", KeyBindingFrameOkayButton, "LEFT", -3, 0)
	KeyBindingFrameOkayButton:SetPoint("RIGHT", KeyBindingFrameCancelButton, "LEFT", -3, 0)
end

T.SkinFuncs["Blizzard_BindingUI"] = LoadSkin