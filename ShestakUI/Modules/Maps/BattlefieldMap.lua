local T, C, L = unpack(select(2, ...))
if not C.map.bg_map_stylization == true then return end

----------------------------------------------------------------------------------------
--	BattlefieldMinimap style
----------------------------------------------------------------------------------------
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
	background:SetTemplate("ClassColor")
	background:SetFrameLevel(0)
	background:Point("TOPLEFT", -2, 2)
	background:Point("BOTTOMRIGHT", -4, 2)
	
	self:UnregisterEvent("ADDON_LOADED")
	self:SetScript("OnEvent", nil)
end)