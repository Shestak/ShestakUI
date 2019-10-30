local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Taxi skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	TaxiFrame:StripTextures()
	TaxiFrame.TitleText:SetPoint("TOP", TaxiFrame, "TOP", -4, -25)
	TaxiRouteMap:CreateBackdrop("Default")
	T.SkinCloseButton(TaxiFrame.CloseButton)
	TaxiFrame.CloseButton:SetPoint("TOPRIGHT", -9, -26)
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)