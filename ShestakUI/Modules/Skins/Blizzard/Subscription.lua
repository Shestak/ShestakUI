local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	SubscriptionInterstitialUI skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local frame = SubscriptionInterstitialFrame
	T.SkinCloseButton(frame.CloseButton)

	frame:StripTextures()
	frame:SetTemplate("Transparent")
	frame.ShadowOverlay:Hide()

	frame.ClosePanelButton:SkinButton()
end

T.SkinFuncs["Blizzard_SubscriptionInterstitialUI"] = LoadSkin