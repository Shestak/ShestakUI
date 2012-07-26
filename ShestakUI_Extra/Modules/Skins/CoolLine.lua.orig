local T, C, L = unpack(ShestakUI)
if C.extra_skins.cool_line ~= true then return end

----------------------------------------------------------------------------------------
--	CoolLine skin
----------------------------------------------------------------------------------------
local CLSkin = CreateFrame("Frame")
CLSkin:RegisterEvent("PLAYER_LOGIN")
CLSkin:SetScript("OnEvent", function(self, event, addon)
	if not IsAddOnLoaded("CoolLine") then return end

	CoolLineDB.border = "None"
	CoolLineDB.bgcolor.a = 0
	CoolLineDB.inactivealpha = 1
	CoolLineDB.activealpha = 1
	CoolLineDB.font = "Hooge"
	CoolLineDB.fontsize = C.font.stylization_font_size
	CoolLineDB.w = (C.actionbar.button_size * 12) + (C.actionbar.button_space * 11) - 4
	CoolLineDB.h = C.actionbar.button_size - 4

	local CoolLineBar = CreateFrame("Frame", "CoolLineBar", CoolLine)
	CoolLineBar:SetPoint("TOPLEFT", CoolLine, "TOPLEFT", -2, 2)
	CoolLineBar:SetPoint("BOTTOMRIGHT", CoolLine, "BOTTOMRIGHT", 2, -2)
	CoolLineBar:SetTemplate("Transparent")
	CoolLineBar:SetFrameStrata("BACKGROUND")
end)