----------------------------------------------------------------------------------------
--	BattlefieldMinimap style
----------------------------------------------------------------------------------------
if SettingsCF.map.bg_map_stylization then
	local bm = CreateFrame("Frame")
	bm:RegisterEvent("ADDON_LOADED")
	bm:SetScript("OnEvent", function(self, event, addon)
		if not BattlefieldMinimap_Update then return end
		self:SetParent(BattlefieldMinimap)
		self:SetScript("OnShow", function()
			BattlefieldMinimapCorner:Hide()
			BattlefieldMinimapBackground:Hide()
			BattlefieldMinimapCloseButton:Hide()
		end)
		local background = CreateFrame("Frame", "BACKGROUND", BattlefieldMinimap)
		SettingsDB.CreateTemplate(background)
		background:SetFrameLevel(0)
		background:SetPoint("TOPLEFT", SettingsDB.Scale(-2), SettingsDB.Scale(2))
		background:SetPoint("BOTTOMRIGHT", SettingsDB.Scale(-4), SettingsDB.Scale(2))
		background:SetBackdropBorderColor(SettingsDB.color.r, SettingsDB.color.g, SettingsDB.color.b)
		
		self:UnregisterEvent("ADDON_LOADED")
		self:SetScript("OnEvent", nil)
	end)
end