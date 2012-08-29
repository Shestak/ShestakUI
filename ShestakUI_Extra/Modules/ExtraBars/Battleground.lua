local T, C, L = unpack(ShestakUI)
if C.extra_bar.battleground ~= true then return end

----------------------------------------------------------------------------------------
--	Battleground Defence Announcer(by Azmara)
----------------------------------------------------------------------------------------
-- Create Main Button Frame
local buttonframe = CreateFrame("Frame", "BGAnnouncerButtonFrame", UIParent)
buttonframe:CreatePanel("Invisible", 313, 20, unpack(C.extra_position.bg_announce))
if C.extra_bar.battleground_two_row == true then
	buttonframe:Size(156, 43)
end
buttonframe:Hide()
buttonframe:SetFrameStrata("BACKGROUND")
tinsert(T.MoverFrames, buttonframe)

-- Button 1
local button1 = CreateFrame("Button", "BGAnnouncerButton1", buttonframe)
button1:CreatePanel("Transparent", 50, 20, "TOPLEFT", buttonframe, "TOPLEFT", 0, 0)
button1:SetScript("OnEnter", T.SetModifiedBackdrop)
button1:SetScript("OnLeave", T.SetOriginalBackdrop)
button1:SetScript("OnMouseUp", function()
	SendChatMessage(L_EXTRA_ANNOUNCE_BG_LIGHT..GetMinimapZoneText(), "BATTLEGROUND")
end)

button1.t = button1:CreateFontString(nil, "OVERLAY")
button1.t:SetFont(C.font.stats_font, C.font.stats_font_size, C.font.stats_font_style)
button1.t:Point("CENTER", 0, 0)
button1.t:SetText("Low")

-- Button 2
local button2 = CreateFrame("Button", "BGAnnouncerButton2", buttonframe)
button2:CreatePanel("Transparent", 50, 20, "LEFT", button1, "RIGHT", 3, 0)
button2:SetScript("OnEnter", T.SetModifiedBackdrop)
button2:SetScript("OnLeave", T.SetOriginalBackdrop)
button2:SetScript("OnMouseUp", function()
	SendChatMessage(L_EXTRA_ANNOUNCE_BG_MEDIUM..GetMinimapZoneText(), "BATTLEGROUND")
end)

button2.t = button2:CreateFontString(nil, "OVERLAY")
button2.t:SetFont(C.font.stats_font, C.font.stats_font_size, C.font.stats_font_style)
button2.t:Point("CENTER", 0, 0)
button2.t:SetText("Med")

-- Button 3
local button3 = CreateFrame("Button", "BGAnnouncerButton3", buttonframe)
button3:CreatePanel("Transparent", 50, 20, "LEFT", button2, "RIGHT", 3, 0)
button3:SetScript("OnEnter", T.SetModifiedBackdrop)
button3:SetScript("OnLeave", T.SetOriginalBackdrop)
button3:SetScript("OnMouseUp", function()
	SendChatMessage(L_EXTRA_ANNOUNCE_BG_HEAVY..GetMinimapZoneText(), "BATTLEGROUND")
end)

button3.t = button3:CreateFontString(nil, "OVERLAY")
button3.t:SetFont(C.font.stats_font, C.font.stats_font_size, C.font.stats_font_style)
button3.t:Point("CENTER", 0, 0)
button3.t:SetText("High")

-- Button 4
local button4 = CreateFrame("Button", "BGAnnouncerButton4", buttonframe)
button4:CreatePanel("Transparent", 50, 20, "LEFT", button3, "RIGHT", 3, 0)
if C.extra_bar.battleground_two_row == true then
	button4:Point("TOPLEFT", button1, "BOTTOMLEFT", 0, -3)
end
button4:SetScript("OnEnter", T.SetModifiedBackdrop)
button4:SetScript("OnLeave", T.SetOriginalBackdrop)
button4:SetScript("OnMouseUp", function()
	SendChatMessage(L_EXTRA_ANNOUNCE_BG_FOCUS.."%t", "SAY")
end)

button4.t = button4:CreateFontString(nil, "OVERLAY")
button4.t:SetFont(C.font.stats_font, C.font.stats_font_size, C.font.stats_font_style)
button4.t:Point("CENTER", 0, 0)
button4.t:SetText("Focus")

-- Button 5
local button5 = CreateFrame("Button", "BGAnnouncerButton5", buttonframe)
button5:CreatePanel("Transparent", 50, 20, "LEFT", button4, "RIGHT", 3, 0)
button5:SetScript("OnEnter", T.SetModifiedBackdrop)
button5:SetScript("OnLeave", T.SetOriginalBackdrop)
button5:SetScript("OnMouseUp", function()
	SendChatMessage(L_EXTRA_ANNOUNCE_BG_STEALTH, "SAY")
end)

button5.t = button5:CreateFontString(nil, "OVERLAY")
button5.t:SetFont(C.font.stats_font, C.font.stats_font_size, C.font.stats_font_style)
button5.t:Point("CENTER", 0, 0)
button5.t:SetText("Hidden")

-- Button 6
local button6 = CreateFrame("Button", "BGAnnouncerButton6", buttonframe)
button6:CreatePanel("Transparent", 50, 20, "LEFT", button5, "RIGHT", 3, 0)
button6:SetScript("OnEnter", T.SetModifiedBackdrop)
button6:SetScript("OnLeave", T.SetOriginalBackdrop)
button6:SetScript("OnMouseUp", function()
	SendChatMessage(L_EXTRA_ANNOUNCE_BG_CLEAR..GetMinimapZoneText(), "BATTLEGROUND")
end)

button6.t = button6:CreateFontString(nil, "OVERLAY")
button6.t:SetFont(C.font.stats_font, C.font.stats_font_size, C.font.stats_font_style)
button6.t:Point("CENTER", 0, 0)
button6.t:SetText("Secure")

local UpdateZone = CreateFrame("Frame")
local function OnEvent(self, event)
	if event == "PLAYER_ENTERING_WORLD" then
		local inInstance, instanceType = IsInInstance()
		if inInstance and instanceType == "pvp" then
			buttonframe:Show()
		else
			buttonframe:Hide()
		end
	end
end

UpdateZone:RegisterEvent("PLAYER_ENTERING_WORLD")
UpdateZone:SetScript("OnEvent", OnEvent)