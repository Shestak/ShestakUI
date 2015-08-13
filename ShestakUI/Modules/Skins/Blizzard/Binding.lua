local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

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
	KeyBindingFrame.scrollFrame.scrollBorderTop:SetTexture("")
	KeyBindingFrame.scrollFrame.scrollBorderBottom:SetTexture("")
	KeyBindingFrame.scrollFrame.scrollBorderMiddle:SetTexture("")
	KeyBindingFrame.scrollFrame.scrollFrameScrollBarBackground:SetTexture("")

	T.SkinScrollBar(KeyBindingFrameScrollFrameScrollBar)

	for i = 1, KEY_BINDINGS_DISPLAYED do
		local button1 = _G["KeyBindingFrameKeyBinding"..i.."Key1Button"]
		local button2 = _G["KeyBindingFrameKeyBinding"..i.."Key2Button"]

		button1:StripTextures(true)
		button1:StyleButton()
		button1:SetTemplate("Overlay")

		button2:StripTextures(true)
		button2:StyleButton()
		button2:SetTemplate("Overlay")
		button2:SetPoint("LEFT", button1, "RIGHT", 1, 0)
	end
end

T.SkinFuncs["Blizzard_BindingUI"] = LoadSkin