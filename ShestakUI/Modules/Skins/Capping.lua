local T, C, L, _ = unpack(select(2, ...))
if C.skins.capping ~= true then return end

----------------------------------------------------------------------------------------
--	Capping skin
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", function()
	if not IsAddOnLoaded("Capping") then return end

	local db = CappingFrame.db.profile
	db.barTexture = "Smooth"
	db.spacing = 7
	db.font = "Hooge"
	db.fontSize = C.font.stylization_font_size

	CappingFrame:HookScript('OnUpdate', function(self)
		for bar in pairs(self.bars) do
			if not bar.backdrop then
				bar:CreateBackdrop("Default")
			end
		end
	end)
end)