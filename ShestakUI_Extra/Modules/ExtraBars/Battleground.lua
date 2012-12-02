local T, C, L, _ = unpack(ShestakUI)
if C.extra_bar.battleground ~= true then return end

----------------------------------------------------------------------------------------
--	Battleground Defence Announcer(by Azmara)
----------------------------------------------------------------------------------------
-- Create Main Button Frame
local bar = CreateFrame("Frame", "BGAnnouncerBar", UIParent)
bar:CreatePanel("Invisible", 313, 20, unpack(C.extra_position.bg_announce))
if C.extra_bar.battleground_two_row == true then
	bar:SetSize(156, 43)
end
tinsert(T.MoverFrames, bar)

-- Button 1
local button1 = CreateFrame("Button", "$parentButton1", bar)
button1:CreatePanel("Transparent", 50, 20, "TOPLEFT", bar, "TOPLEFT", 0, 0)
button1:SetScript("OnEnter", T.SetModifiedBackdrop)
button1:SetScript("OnLeave", T.SetOriginalBackdrop)
button1:SetScript("OnMouseUp", function()
	SendChatMessage(L_EXTRA_ANNOUNCE_BG_LIGHT..GetMinimapZoneText(), "INSTANCE_CHAT")
end)

button1.t = button1:CreateFontString(nil, "OVERLAY")
button1.t:SetFont(C.font.stats_font, C.font.stats_font_size, C.font.stats_font_style)
button1.t:SetPoint("CENTER", 0, 0)
button1.t:SetText("Low")

-- Button 2
local button2 = CreateFrame("Button", "$parentButton2", bar)
button2:CreatePanel("Transparent", 50, 20, "LEFT", button1, "RIGHT", 3, 0)
button2:SetScript("OnEnter", T.SetModifiedBackdrop)
button2:SetScript("OnLeave", T.SetOriginalBackdrop)
button2:SetScript("OnMouseUp", function()
	SendChatMessage(L_EXTRA_ANNOUNCE_BG_MEDIUM..GetMinimapZoneText(), "INSTANCE_CHAT")
end)

button2.t = button2:CreateFontString(nil, "OVERLAY")
button2.t:SetFont(C.font.stats_font, C.font.stats_font_size, C.font.stats_font_style)
button2.t:SetPoint("CENTER", 0, 0)
button2.t:SetText("Med")

-- Button 3
local button3 = CreateFrame("Button", "$parentButton3", bar)
button3:CreatePanel("Transparent", 50, 20, "LEFT", button2, "RIGHT", 3, 0)
button3:SetScript("OnEnter", T.SetModifiedBackdrop)
button3:SetScript("OnLeave", T.SetOriginalBackdrop)
button3:SetScript("OnMouseUp", function()
	SendChatMessage(L_EXTRA_ANNOUNCE_BG_HEAVY..GetMinimapZoneText(), "INSTANCE_CHAT")
end)

button3.t = button3:CreateFontString(nil, "OVERLAY")
button3.t:SetFont(C.font.stats_font, C.font.stats_font_size, C.font.stats_font_style)
button3.t:SetPoint("CENTER", 0, 0)
button3.t:SetText("High")

-- Button 4
local button4 = CreateFrame("Button", "$parentButton4", bar)
button4:CreatePanel("Transparent", 50, 20, "LEFT", button3, "RIGHT", 3, 0)
if C.extra_bar.battleground_two_row == true then
	button4:SetPoint("TOPLEFT", button1, "BOTTOMLEFT", 0, -3)
end
button4:SetScript("OnEnter", T.SetModifiedBackdrop)
button4:SetScript("OnLeave", T.SetOriginalBackdrop)
button4:SetScript("OnMouseUp", function()
	SendChatMessage(L_EXTRA_ANNOUNCE_BG_FOCUS.."%t", "SAY")
end)

button4.t = button4:CreateFontString(nil, "OVERLAY")
button4.t:SetFont(C.font.stats_font, C.font.stats_font_size, C.font.stats_font_style)
button4.t:SetPoint("CENTER", 0, 0)
button4.t:SetText("Focus")

-- Button 5
local button5 = CreateFrame("Button", "$parentButton5", bar)
button5:CreatePanel("Transparent", 50, 20, "LEFT", button4, "RIGHT", 3, 0)
button5:SetScript("OnEnter", T.SetModifiedBackdrop)
button5:SetScript("OnLeave", T.SetOriginalBackdrop)
button5:SetScript("OnMouseUp", function()
	SendChatMessage(L_EXTRA_ANNOUNCE_BG_STEALTH, "SAY")
end)

button5.t = button5:CreateFontString(nil, "OVERLAY")
button5.t:SetFont(C.font.stats_font, C.font.stats_font_size, C.font.stats_font_style)
button5.t:SetPoint("CENTER", 0, 0)
button5.t:SetText("Hidden")

-- Button 6
local button6 = CreateFrame("Button", "$parentButton6", bar)
button6:CreatePanel("Transparent", 50, 20, "LEFT", button5, "RIGHT", 3, 0)
button6:SetScript("OnEnter", T.SetModifiedBackdrop)
button6:SetScript("OnLeave", T.SetOriginalBackdrop)
button6:SetScript("OnMouseUp", function()
	SendChatMessage(L_EXTRA_ANNOUNCE_BG_CLEAR..GetMinimapZoneText(), "INSTANCE_CHAT")
end)

button6.t = button6:CreateFontString(nil, "OVERLAY")
button6.t:SetFont(C.font.stats_font, C.font.stats_font_size, C.font.stats_font_style)
button6.t:SetPoint("CENTER", 0, 0)
button6.t:SetText("Secure")

local UpdateZone = CreateFrame("Frame")
local function OnEvent(self, event)
	if event == "PLAYER_ENTERING_WORLD" then
		local inInstance, instanceType = IsInInstance()
		if inInstance and instanceType == "pvp" then
			bar:Show()
		else
			bar:Hide()
		end
	end
end

UpdateZone:RegisterEvent("PLAYER_ENTERING_WORLD")
UpdateZone:SetScript("OnEvent", OnEvent)