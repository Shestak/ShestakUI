local T, C, L, _ = unpack(select(2, ...))
if not T.classic or C.skins.blizzard_frames ~= true then return else return end -- incomplete

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