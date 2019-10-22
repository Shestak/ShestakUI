local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	ItemSocketingUI skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	ItemSocketingFrame:StripTextures()
	ItemSocketingFrame:CreateBackdrop("Transparent")
	ItemSocketingFrame.backdrop:SetPoint("TOPLEFT", 0, 0)
	ItemSocketingFrame.backdrop:SetPoint("BOTTOMRIGHT", 0, 0)
	ItemSocketingFrameInset:StripTextures()
	ItemSocketingScrollFrame:StripTextures()
	ItemSocketingScrollFrame:CreateBackdrop("Overlay")
	T.SkinScrollBar(ItemSocketingScrollFrameScrollBar)
	ItemSocketingDescription:DisableDrawLayer("BORDER")
	ItemSocketingDescription:DisableDrawLayer("BACKGROUND")

	for i = 1, MAX_NUM_SOCKETS do
		local button = _G["ItemSocketingSocket"..i]
		local button_bracket = _G["ItemSocketingSocket"..i.."BracketFrame"]
		local button_bg = _G["ItemSocketingSocket"..i.."Background"]
		local button_icon = _G["ItemSocketingSocket"..i.."IconTexture"]

		button:StripTextures()
		button:StyleButton()
		button:SetTemplate("Overlay")
		button_bracket:Kill()
		button_bg:Kill()

		button_icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		button_icon:ClearAllPoints()
		button_icon:SetPoint("TOPLEFT", 2, -2)
		button_icon:SetPoint("BOTTOMRIGHT", -2, 2)
	end

	local GEM_TYPE_INFO = {
		Yellow = {r = 0.97, g = 0.82, b = 0.29},
		Red = {r = 1, g = 0.47, b = 0.47},
		Blue = {r = 0.47, g = 0.67, b = 1},
		PunchcardRed = {r = 1, g = 0.47, b = 0.47},
		PunchcardYellow = {r = 0.97, g = 0.82, b = 0.29},
		PunchcardBlue = {r = 0.47, g = 0.67, b = 1}
	}

	hooksecurefunc("ItemSocketingFrame_Update", function()
		for i, socket in ipairs(_G.ItemSocketingFrame.Sockets) do
			local gemColor = GetSocketTypes(i)
			local color = GEM_TYPE_INFO[gemColor]
			if color then
				socket:SetBackdropBorderColor(color.r, color.g, color.b)
				socket.overlay:SetVertexColor(color.r, color.g, color.b, 0.35)
			else
				socket:SetBackdropBorderColor(unpack(C.media.border_color))
				socket.overlay:SetVertexColor(0.1, 0.1, 0.1, 1)
			end
		end
	end)

	ItemSocketingFramePortrait:Kill()
	ItemSocketingSocketButton:ClearAllPoints()
	ItemSocketingSocketButton:SetPoint("BOTTOMRIGHT", ItemSocketingFrame.backdrop, "BOTTOMRIGHT", -5, 5)
	ItemSocketingSocketButton:SkinButton()
	T.SkinCloseButton(ItemSocketingFrameCloseButton, ItemSocketingFrame.backdrop)
end

T.SkinFuncs["Blizzard_ItemSocketingUI"] = LoadSkin