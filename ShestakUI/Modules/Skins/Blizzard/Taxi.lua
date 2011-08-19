local T, C, L = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Taxi skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	TaxiFrame:StripTextures()
	TaxiFrame:CreateBackdrop("Transparent")
	TaxiFrame.backdrop:Point("TOPLEFT", -5, 3)
	TaxiFrame.backdrop:Point("BOTTOMRIGHT", 5, -7)
	TaxiRouteMap:CreateBackdrop("Default")
	TaxiRouteMap.backdrop:Point("TOPLEFT", -2, 2)
	TaxiRouteMap.backdrop:Point("BOTTOMRIGHT", 2, -2)
	T.SkinCloseButton(TaxiFrameCloseButton)
	TaxiFrameCloseButton:Point("TOPRIGHT", -4, -1)
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)