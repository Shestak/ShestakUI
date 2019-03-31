local T, C, L, _ = unpack(select(2, ...))
if C.chat.enable ~= true then return end

----------------------------------------------------------------------------------------
--	Copy Chat
----------------------------------------------------------------------------------------
local frame = nil
local editBox = nil
local font = nil
local isf = nil
local sizes = {
	":14:14",
	":15:15",
	":16:16",
	":12:20",
	":14"
}

local function CreatCopyFrame()
	frame = CreateFrame("Frame", "CopyFrame", UIParent)
	frame:SetTemplate("Transparent")
	frame:SetWidth(540)
	frame:SetHeight(300)
	frame:SetPoint("CENTER", UIParent, "CENTER", 0, 100)
	frame:SetFrameStrata("DIALOG")
	tinsert(UISpecialFrames, "CopyFrame")
	frame:Hide()

	editBox = CreateFrame("EditBox", "CopyBox", frame)
	editBox:SetMultiLine(true)
	editBox:SetMaxLetters(99999)
	editBox:EnableMouse(true)
	editBox:SetAutoFocus(false)
	editBox:SetFontObject(ChatFontNormal)
	editBox:SetWidth(500)
	editBox:SetHeight(300)
	editBox:SetScript("OnEscapePressed", function() frame:Hide() end)

	editBox:SetScript("OnTextSet", function(self)
		local text = self:GetText()

		for _, size in pairs(sizes) do
			if string.find(text, size) and not string.find(text, size.."]") then
				self:SetText(string.gsub(text, size, ":12:12"))
			end
		end
	end)

	local scrollArea = CreateFrame("ScrollFrame", "CopyScroll", frame, "UIPanelScrollFrameTemplate")
	scrollArea:SetPoint("TOPLEFT", frame, "TOPLEFT", 8, -30)
	scrollArea:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -27, 8)
	scrollArea:SetScrollChild(editBox)
	T.SkinScrollBar(CopyScrollScrollBar)

	local close = CreateFrame("Button", "CopyCloseButton", frame, "UIPanelCloseButton")
	T.SkinCloseButton(close)

	font = frame:CreateFontString(nil, nil, "GameFontNormal")
	font:Hide()

	isf = true
end

local function MessageIsProtected(message)
	return strmatch(message, '[^|]-|K[vq]%d-[^|]-|k')
end

local function Copy(cf)
	if not isf then CreatCopyFrame() end
	local text = ""
	for i = 1, cf:GetNumMessages() do
		local line = cf:GetMessageInfo(i)
		if not MessageIsProtected(line) then
			font:SetFormattedText("%s\n", line)
			local cleanLine = font:GetText() or ""
			text = text..cleanLine
		end
	end
	text = text:gsub("|T[^\\]+\\[^\\]+\\[Uu][Ii]%-[Rr][Aa][Ii][Dd][Tt][Aa][Rr][Gg][Ee][Tt][Ii][Nn][Gg][Ii][Cc][Oo][Nn]_(%d)[^|]+|t", "{rt%1}")
	text = text:gsub("|T13700([1-8])[^|]+|t", "{rt%1}")
	text = text:gsub("|T[^|]+|t", "")
	if frame:IsShown() then frame:Hide() return end
	frame:Show()
	editBox:SetText(text)

	editBox:SetScript("OnTextChanged", function(_, userInput)
		if userInput then return end
		local _, max = CopyScrollScrollBar:GetMinMaxValues()
		for _ = 1, max do
			ScrollFrameTemplate_OnMouseWheel(CopyScroll, -1)
		end
	end)
end

for i = 1, NUM_CHAT_WINDOWS do
	local cf = _G[format("ChatFrame%d", i)]
	local button = CreateFrame("Button", format("ButtonCF%d", i), cf)
	button:SetPoint("BOTTOMRIGHT", 0, 1)
	button:SetSize(20, 20)
	button:SetAlpha(0)
	button:SetTemplate("Transparent")
	button:SetBackdropBorderColor(T.color.r, T.color.g, T.color.b)

	local icon = button:CreateTexture(nil, "BORDER")
	icon:SetPoint("CENTER")
	icon:SetTexture("Interface\\BUTTONS\\UI-GuildButton-PublicNote-Up")
	icon:SetSize(16, 16)

	button:SetScript("OnMouseUp", function(self, btn)
		if btn == "RightButton" then
			ToggleFrame(ChatMenu)
		elseif btn == "MiddleButton" then
			RandomRoll(1, 100)
		else
			Copy(cf)
		end
	end)
	button:SetScript("OnEnter", function() button:FadeIn() end)
	button:SetScript("OnLeave", function() button:FadeOut() end)

	SlashCmdList.COPY_CHAT = function()
		Copy(_G["ChatFrame1"])
	end
end