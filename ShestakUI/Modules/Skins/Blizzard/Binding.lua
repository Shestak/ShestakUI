local T, C, L = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	BindingUI skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local buttons = {
		"KeyBindingFrameDefaultButton",
		"KeyBindingFrameUnbindButton",
		"KeyBindingFrameOkayButton",
		"KeyBindingFrameCancelButton",
	}

	for _, v in pairs(buttons) do
		_G[v]:StripTextures()
		_G[v]:SkinButton()
	end

	T.SkinCheckBox(KeyBindingFrameCharacterButton)
	KeyBindingFrameHeaderText:ClearAllPoints()
	KeyBindingFrameHeaderText:Point("TOP", KeyBindingFrame, "TOP", 0, -4)
	KeyBindingFrame:StripTextures()
	KeyBindingFrame:CreateBackdrop("Transparent")
	KeyBindingFrame.backdrop:Point("TOPLEFT", 0, 0)
	KeyBindingFrame.backdrop:Point("BOTTOMRIGHT", -40, 10)

	for i = 1, KEY_BINDINGS_DISPLAYED do
		local button1 = _G["KeyBindingFrameBinding"..i.."Key1Button"]
		local button2 = _G["KeyBindingFrameBinding"..i.."Key2Button"]
		button1:StripTextures(true)
		button1:StyleButton(false)
		button1:SetTemplate("Overlay", true)
		button2:StripTextures(true)
		button2:StyleButton(false)
		button2:SetTemplate("Overlay", true)
		button2:Point("LEFT", button1, "RIGHT", 1, 0)
	end

	KeyBindingFrameUnbindButton:Point("RIGHT", KeyBindingFrameOkayButton, "LEFT", -3, 0)
	KeyBindingFrameOkayButton:Point("RIGHT", KeyBindingFrameCancelButton, "LEFT", -3, 0)
end

T.SkinFuncs["Blizzard_BindingUI"] = LoadSkin