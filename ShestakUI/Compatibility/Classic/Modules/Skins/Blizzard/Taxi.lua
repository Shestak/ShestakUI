local T, C, L, _ = unpack(select(2, ...))
if not T.classic or C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Taxi skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	TaxiFrame:StripTextures()
	TaxiFrame:CreateBackdrop("Transparent")
	TaxiFrame.backdrop:SetPoint("TOPLEFT", 10, -12)
	TaxiFrame.backdrop:SetPoint("BOTTOMRIGHT", -32, 76)

	TaxiRouteMap:CreateBackdrop("Default")

	T.SkinCloseButton(TaxiCloseButton, TaxiFrame.backdrop)

	TaxiMerchant:ClearAllPoints()
	TaxiMerchant:SetPoint("TOP", TaxiFrame.backdrop, "TOP", 0, -6)

end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)