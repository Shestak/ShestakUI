local T, C, L, _ = unpack(select(2, ...))
if C.chat.enable ~= true or C.chat.chat_bar ~= true then return end

----------------------------------------------------------------------------------------
--	ChatBar(FavChatBar by Favorit)
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame", "ChatBar", UIParent)
frame:CreatePanel("Invisible", 16, C.chat.background and C.chat.height + 4 or C.chat.height - 1, "BOTTOMLEFT", UIParent, "BOTTOMLEFT", 2, C.chat.background and 24 or 20)
if C.chat.chat_bar_mouseover == true then
	frame:SetAlpha(0)
	frame:SetScript("OnEnter", function()
		frame:FadeIn()
	end)
	frame:SetScript("OnLeave", function()
		frame:FadeOut()
	end)
end

local function CreateButton(b, l, r, m)
	b:SetWidth(16)
	b:SetHeight(16)
	b:SetTemplate("Default")

	b:RegisterForClicks("AnyUp")
	b:SetScript("OnClick", function(self, b)
		if b == "LeftButton" then
			ChatFrame_OpenChat(l, SELECTED_DOCK_FRAME)
		elseif b == "RightButton" then
			ChatFrame_OpenChat(r, SELECTED_DOCK_FRAME)
		elseif m and b == "MiddleButton" then
			ChatFrame_OpenChat(m, SELECTED_DOCK_FRAME)
		end
	end)

	if C.chat.chat_bar_mouseover == true then
		b:SetScript("OnEnter", function()
			frame:FadeIn()
		end)
		b:SetScript("OnLeave", function()
			frame:FadeOut()
		end)
	end

	b.t = b:CreateTexture(nil, "ARTWORK")
	b.t:SetTexture(C.media.blank)
	b.t:SetPoint("TOPLEFT", b, "TOPLEFT", 2, -2)
	b.t:SetPoint("BOTTOMRIGHT", b, "BOTTOMRIGHT", -2, 2)
end

local b1 = CreateFrame("Button", "$parentButton1", frame)
CreateButton(b1, "/s", "/w ", "/y")
b1:SetPoint("TOP", frame, "TOP", 0, 0)
b1:SetBackdropBorderColor(0.7, 0.33, 0.82, 1)
b1.t:SetVertexColor(0.8, 0.8, 0.8, 1)

local b2 = CreateFrame("Button", "$parentButton2", frame)
CreateButton(b2, "/g", "/o")
b2:SetPoint("TOP", b1, "BOTTOM", 0, C.chat.background and -4 or -3)
b2:SetBackdropBorderColor(0, 0.54, 0, 1)
b2.t:SetVertexColor(0, 0.8, 0, 1)

local b3 = CreateFrame("Button", "$parentButton3", frame)
CreateButton(b3, "/p", "/i")
b3:SetPoint("TOP", b2, "BOTTOM", 0, C.chat.background and -4 or -3)
b3:SetBackdropBorderColor(0.8, 0.4, 0.1, 1)
b3.t:SetVertexColor(0.11, 0.5, 0.7, 1)

local b4 = CreateFrame("Button", "$parentButton4", frame)
CreateButton(b4, "/ra", "/rw")
b4:SetPoint("TOP", b3, "BOTTOM", 0, C.chat.background and -4 or -3)
b4:SetBackdropBorderColor(0.96, 0.2, 0.2, 1)
b4.t:SetVertexColor(1, 0.3, 0, 1)

local b5 = CreateFrame("Button", "$parentButton5", frame)
CreateButton(b5, "/1", "/2")
b5:SetPoint("TOP", b4, "BOTTOM", 0, C.chat.background and -4 or -3)
b5:SetBackdropBorderColor(0.7, 0.7, 0, 1)
b5.t:SetVertexColor(0.93, 0.8, 0.8, 1)

local b6 = CreateFrame("Button", "$parentButton6", frame)
CreateButton(b6, "/3", "/4")
b6:SetPoint("TOP", b5, "BOTTOM", 0, C.chat.background and -4 or -3)
b6:SetBackdropBorderColor(0.5, 1, 0.83, 1)
b6.t:SetVertexColor(1, 0.75, 0.75, 1)