local T, C, L = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	GM ticket position
----------------------------------------------------------------------------------------
local GMFrameAnchor = CreateFrame("Button", "GMFrameAnchor", UIParent)
GMFrameAnchor:SetFrameStrata("TOOLTIP")
GMFrameAnchor:SetFrameLevel(20)
GMFrameAnchor:Width(TicketStatusFrameButton:GetWidth())
GMFrameAnchor:Height(TicketStatusFrame:GetHeight())
GMFrameAnchor:SetClampedToScreen(true)
GMFrameAnchor:SetMovable(true)
GMFrameAnchor:SetTemplate("Transparent")
GMFrameAnchor:SetBackdropBorderColor(1, 0, 0, 1)
GMFrameAnchor:Point(unpack(C.position.ticket))
GMFrameAnchor.text = GMFrameAnchor:CreateFontString("GMFrameAnchorText", "OVERLAY")
GMFrameAnchor.text:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
GMFrameAnchor.text:SetPoint("CENTER")
GMFrameAnchor.text:SetText("TicketStatus Anchor")
GMFrameAnchor.text:SetParent(GMFrameAnchor)
GMFrameAnchor:Hide()

TicketStatusFrame:ClearAllPoints()
TicketStatusFrame:Point("TOP", GMFrameAnchor, "TOP", -1, 0)

----------------------------------------------------------------------------------------
--	GM toggle command
----------------------------------------------------------------------------------------
SLASH_GM1 = "/gm"
SlashCmdList["GM"] = function() ToggleHelpFrame() end