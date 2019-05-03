local T, C, L, _ = unpack(select(2, ...))
if C.skins.cool_line ~= true then return end

----------------------------------------------------------------------------------------
--	CoolLine skin
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", function()
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