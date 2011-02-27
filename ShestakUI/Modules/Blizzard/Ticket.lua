----------------------------------------------------------------------------------------
--	GM ticket position
----------------------------------------------------------------------------------------
local GMFrameAnchor = CreateFrame("Button", "GMFrameAnchor", UIParent)
GMFrameAnchor:SetFrameStrata("TOOLTIP")
GMFrameAnchor:SetFrameLevel(20)
GMFrameAnchor:SetHeight(40)
GMFrameAnchor:SetWidth(TicketStatusFrameButton:GetWidth())
GMFrameAnchor:SetClampedToScreen(true)
GMFrameAnchor:SetMovable(true)
SettingsDB.SkinFadedPanel(GMFrameAnchor)
GMFrameAnchor:SetBackdropBorderColor(1, 0, 0, 1)
GMFrameAnchor:SetPoint(unpack(SettingsCF.position.ticket))
GMFrameAnchor.text = GMFrameAnchor:CreateFontString("GMFrameAnchorText", "OVERLAY", nil)
GMFrameAnchor.text:SetFont(SettingsCF.media.pixel_font, SettingsCF.media.pixel_font_size, SettingsCF.media.pixel_font_style)
GMFrameAnchor.text:SetPoint("CENTER")
GMFrameAnchor.text:SetText("GMFrame Anchor")
GMFrameAnchor.text:SetParent(GMFrameAnchor)
GMFrameAnchor:Hide()

TicketStatusFrame:ClearAllPoints()
TicketStatusFrame:SetPoint("TOP", GMFrameAnchor, "TOP", -1, 0)

----------------------------------------------------------------------------------------
--	GM toggle command
----------------------------------------------------------------------------------------
SLASH_GM1 = "/gm"
SlashCmdList["GM"] = function() ToggleHelpFrame() end