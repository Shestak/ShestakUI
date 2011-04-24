local T, C, L = unpack(select(2, ...))
if not C.chat.enable == true then return end

----------------------------------------------------------------------------------------
--	Copy Chat
----------------------------------------------------------------------------------------
local lines = {}
local frame = nil
local editBox = nil
local isf = nil

local function CreatCopyFrame()
	frame = CreateFrame("Frame", "CopyFrame", UIParent)
	frame:SetTemplate("Transparent")
	frame:Width(500)
	frame:Height(300)
	frame:Point("CENTER", UIParent, "CENTER", 0, 100)
	frame:SetFrameStrata("DIALOG")
	tinsert(UISpecialFrames, "CopyFrame")
	frame:Hide()

	local scrollArea = CreateFrame("ScrollFrame", "CopyScroll", frame, "UIPanelScrollFrameTemplate")
	scrollArea:Point("TOPLEFT", frame, "TOPLEFT", 8, -30)
	scrollArea:Point("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -30, 8)

	editBox = CreateFrame("EditBox", "CopyBox", frame)
	editBox:SetMultiLine(true)
	editBox:SetMaxLetters(99999)
	editBox:EnableMouse(true)
	editBox:SetAutoFocus(false)
	editBox:SetFontObject(ChatFontNormal)
	editBox:Width(500)
	editBox:Height(300)
	editBox:SetScript("OnEscapePressed", function() frame:Hide() end)

	scrollArea:SetScrollChild(editBox)

	local close = CreateFrame("Button", "CopyCloseButton", frame, "UIPanelCloseButton")
	close:SetPoint("TOPRIGHT", frame, "TOPRIGHT")

	isf = true
end

local function GetLines(...)
	-- Grab all those lines
	local ct = 1
	for i = select("#", ...), 1, -1 do
		local region = select(i, ...)
		if region:GetObjectType() == "FontString" then
			lines[ct] = tostring(region:GetText())
			ct = ct + 1
		end
	end
	return ct - 1
end

local function Copy(cf)
	local _, size = cf:GetFont()
	FCF_SetChatWindowFontSize(cf, cf, 0.01)
	local lineCt = GetLines(cf:GetRegions())
	local text = table.concat(lines, "\n", 1, lineCt)
	FCF_SetChatWindowFontSize(cf, cf, size)
	if not isf then CreatCopyFrame() end
	if frame:IsShown() then frame:Hide() return end
	frame:Show()
	editBox:SetText(text)
end

function T.ChatCopyButtons()
	for i = 1, NUM_CHAT_WINDOWS do
		local cf = _G[format("ChatFrame%d", i)]
		local button = CreateFrame("Button", format("ButtonCF%d", i), cf)
		button:Point("BOTTOMRIGHT", 0, 1)
		button:Height(20)
		button:Width(20)
		button:SetAlpha(0)
		button:SetTemplate("Transparent")
		button:SetBackdropBorderColor(T.color.r, T.color.g, T.color.b)

		local buttontexture = button:CreateTexture(nil, "BORDER")
		buttontexture:SetPoint("CENTER")
		buttontexture:SetTexture("Interface\\BUTTONS\\UI-GuildButton-PublicNote-Up")
		buttontexture:Height(16)
		buttontexture:Width(16)

		button:SetScript("OnMouseUp", function(self, btn)
			if i == 1 and btn == "RightButton" then
				ToggleFrame(ChatMenu)
			else
				Copy(cf)
			end
		end)
		button:SetScript("OnEnter", function() button:FadeIn() end)
		button:SetScript("OnLeave", function() button:FadeOut() end)
	end
end
T.ChatCopyButtons()