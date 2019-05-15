local T, C, L, _ = unpack(select(2, ...))
if T.classic or C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Flight Map skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	FlightMapFrame:CreateBackdrop("Transparent")
	FlightMapFrame.BorderFrame:StripTextures()

	FlightMapFrame.ScrollContainer:ClearAllPoints()
	FlightMapFrame.ScrollContainer:SetPoint("TOPLEFT")
	FlightMapFrame.ScrollContainer:SetPoint("BOTTOMRIGHT")

	T.SkinCloseButton(FlightMapFrameCloseButton)
end

T.SkinFuncs["Blizzard_FlightMap"] = LoadSkin