local T, C, L = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	GuildRegistrar skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	GuildRegistrarFrame:StripTextures(true)
	GuildRegistrarFrame:CreateBackdrop("Transparent")
	GuildRegistrarFrame.backdrop:SetAllPoints()
	GuildRegistrarGreetingFrame:StripTextures()
	GuildRegistrarFrameInset:StripTextures()

	GuildRegistrarFramePurchaseButton:SkinButton()
	GuildRegistrarFrameCancelButton:SkinButton()
	GuildRegistrarFrameGoodbyeButton:SkinButton()
	GuildRegistrarFramePurchaseButton:ClearAllPoints()
	GuildRegistrarFramePurchaseButton:Point("BOTTOMLEFT", GuildRegistrarFrame.backdrop, "BOTTOMLEFT", 4, 4)
	GuildRegistrarFrameCancelButton:ClearAllPoints()
	GuildRegistrarFrameCancelButton:Point("BOTTOMRIGHT", GuildRegistrarFrame.backdrop, "BOTTOMRIGHT", -4, 4)
	GuildRegistrarFrameGoodbyeButton:ClearAllPoints()
	GuildRegistrarFrameGoodbyeButton:Point("BOTTOMRIGHT", GuildRegistrarFrame.backdrop, "BOTTOMRIGHT", -4, 4)

	T.SkinCloseButton(GuildRegistrarFrameCloseButton, GuildRegistrarFrame.backdrop)

	GuildRegistrarFrameEditBox:StripTextures(true)
	T.SkinEditBox(GuildRegistrarFrameEditBox)
	GuildRegistrarFrameEditBox:Height(GuildRegistrarFrameEditBox:GetHeight() - 15)

	for i = 1, 2 do
		_G["GuildRegistrarButton"..i]:GetFontString():SetTextColor(1, 1, 1)
	end

	GuildRegistrarPurchaseText:SetTextColor(1, 1, 1)
	AvailableServicesText:SetTextColor(1, 0.8, 0)
	AvailableServicesText:SetShadowColor(0, 0, 0)
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)