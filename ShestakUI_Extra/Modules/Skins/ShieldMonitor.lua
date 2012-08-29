local T, C, L = unpack(ShestakUI)
if C.extra_skins.shield_monitor ~= true then return end

----------------------------------------------------------------------------------------
--	ShieldMonitor skin
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", function(self, event, addon)
	if not IsAddOnLoaded("shieldmonitor") then return end

	Shieldmonitor_Options.scale = 1

	shieldmonitor_Frame:SetTemplate("Default")
	shieldmonitor_Frame:HookScript("OnShow", function(self)
		self:SetBackdropBorderColor(unpack(C.media.border_color))
	end)
	shieldmonitor_Frame:SetSize(150, 18)

	shieldmonitor_Bar:SetStatusBarTexture(C.media.texture)
	shieldmonitor_Bar:ClearAllPoints()
	shieldmonitor_Bar:SetPoint("TOPLEFT", shieldmonitor_Frame, "TOPLEFT", 2, -2)
	shieldmonitor_Bar:SetPoint("BOTTOMRIGHT", shieldmonitor_Frame, "BOTTOMRIGHT", -2, 2)

	local IconBorder = CreateFrame("Frame", "ShieldIconBorder", shieldmonitor_Frame)
	IconBorder:SetTemplate("Default")
	IconBorder:SetFrameStrata("BACKGROUND")
	IconBorder:SetSize(18, 18)
	IconBorder:SetPoint("RIGHT", shieldmonitor_Frame, "LEFT", -3, 0)

	shieldmonitor_FrameIcon1:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	shieldmonitor_FrameIcon1:ClearAllPoints()
	shieldmonitor_FrameIcon1:SetPoint("TOPLEFT", IconBorder, "TOPLEFT", 2, -2)
	shieldmonitor_FrameIcon1:SetPoint("BOTTOMRIGHT", IconBorder, "BOTTOMRIGHT", -2, 2)

	shieldmonitor_BarText:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
	shieldmonitor_BarText:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)
	shieldmonitor_BarText:SetPoint("CENTER", shieldmonitor_Bar, "CENTER", 0, 0)

	shieldmonitor_FrameDuration:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
	shieldmonitor_FrameDuration:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)
	shieldmonitor_FrameDuration:SetParent(shieldmonitor_Bar)
	shieldmonitor_FrameDuration:ClearAllPoints()
	shieldmonitor_FrameDuration:SetPoint("RIGHT", shieldmonitor_Frame, "RIGHT", -2, 0)
end)