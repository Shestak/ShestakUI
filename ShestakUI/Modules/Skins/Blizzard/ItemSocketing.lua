local T, C, L = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	ItemSocketingUI skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	ItemSocketingFrame:StripTextures()
	ItemSocketingFrame:CreateBackdrop("Transparent")
	ItemSocketingFrame.backdrop:Point("TOPLEFT", 16, -12)
	ItemSocketingFrame.backdrop:Point("BOTTOMRIGHT", 0, 20)
	ItemSocketingScrollFrame:StripTextures()
	ItemSocketingScrollFrame:CreateBackdrop("Overlay")

	for i = 1, MAX_NUM_SOCKETS  do
		local button = _G["ItemSocketingSocket"..i]
		local button_bracket = _G["ItemSocketingSocket"..i.."BracketFrame"]
		local button_bg = _G["ItemSocketingSocket"..i.."Background"]
		local button_icon = _G["ItemSocketingSocket"..i.."IconTexture"]
		button:StripTextures()
		button:StyleButton(false)
		button:SetTemplate("Overlay", true)
		button_bracket:Kill()
		button_bg:Kill()
		button_icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		button_icon:ClearAllPoints()
		button_icon:Point("TOPLEFT", 2, -2)
		button_icon:Point("BOTTOMRIGHT", -2, 2)
		ItemSocketingFrame:HookScript("OnUpdate", function(self)
			gemColor = GetSocketTypes(i)
			local color = GEM_TYPE_INFO[gemColor]
			button:SetBackdropBorderColor(color.r, color.g, color.b)
			button.overlay:SetVertexColor(color.r, color.g, color.b, 0.35)
		end)
	end

	ItemSocketingFramePortrait:Kill()
	ItemSocketingSocketButton:ClearAllPoints()
	ItemSocketingSocketButton:Point("BOTTOMRIGHT", ItemSocketingFrame.backdrop, "BOTTOMRIGHT", -5, 5)
	ItemSocketingSocketButton:SkinButton()
	T.SkinCloseButton(ItemSocketingCloseButton, ItemSocketingFrame.backdrop)
end

T.SkinFuncs["Blizzard_ItemSocketingUI"] = LoadSkin