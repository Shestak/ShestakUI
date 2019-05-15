local T, C, L, _ = unpack(select(2, ...))
if not T.classic or C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	WorldMap skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	if IsAddOnLoaded("Mapster") then return end

	WorldMapFrame:StripTextures()
	WorldMapFrame:CreateBackdrop("Transparent")
	-- WorldMapFrame:SetScale(0.75) -- needs a fix for mouse position

	T.SkinDropDownBox(WorldMapContinentDropDown)
	T.SkinDropDownBox(WorldMapZoneDropDown)

	WorldMapZoneDropDown:SetPoint("LEFT", WorldMapContinentDropDown, "RIGHT", -24, 0)
	WorldMapZoomOutButton:SetPoint("LEFT", WorldMapZoneDropDown, "RIGHT", -4, 3)

	WorldMapZoomOutButton:SkinButton()

	T.SkinCloseButton(WorldMapFrameCloseButton, WorldMapFrame.backdrop)

	WorldMapFrame:RegisterEvent("PLAYER_LOGIN")
	WorldMapFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
	WorldMapFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
	WorldMapFrame:HookScript("OnEvent", function(self, event)
		if event == "PLAYER_LOGIN" then
			WorldMapFrame:Show()
			WorldMapFrame:Hide()
		elseif event == "PLAYER_REGEN_DISABLED" then
			if WorldMapFrame:IsShown() then
				HideUIPanel(WorldMapFrame)
			end
		end
	end)
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)