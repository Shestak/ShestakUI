local T, C, L, _ = unpack(select(2, ...))
if C.chat.enable ~= true then return end

----------------------------------------------------------------------------------------
--	Copy Chat
----------------------------------------------------------------------------------------
local lines = {}
local frame = nil
local editBox = nil
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

	local scrollArea = CreateFrame("ScrollFrame", "CopyScroll", frame, "UIPanelScrollFrameTemplate")
	scrollArea:SetPoint("TOPLEFT", frame, "TOPLEFT", 8, -30)
	scrollArea:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -30, 8)

	editBox = CreateFrame("EditBox", "CopyBox", frame)
	editBox:SetMultiLine(true)
	editBox:SetMaxLetters(99999)
	editBox:EnableMouse(true)
	editBox:SetAutoFocus(false)
	editBox:SetFontObject(ChatFontNormal)
	editBox:SetWidth(500)
	editBox:SetHeight(300)
	editBox:SetScript("OnEscapePressed", function() frame:Hide() end)

	scrollArea:SetScrollChild(editBox)

	editBox:SetScript("OnTextSet", function(self)
		local text = self:GetText()

		for _, size in pairs(sizes) do
			if string.find(text, size) and not string.find(text, size.."]") then
				self:SetText(string.gsub(text, size, ":12:12"))
			end
		end
	end)

	local close = CreateFrame("Button", "CopyCloseButton", frame, "UIPanelCloseButton")
	if C.skins.blizzard_frames == true then
		T.SkinCloseButton(close)
		scrollArea:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -27, 8)
	else
		close:SetPoint("TOPRIGHT", frame, "TOPRIGHT")
		scrollArea:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -30, 8)
	end

	isf = true
end

local function RemoveIcon(text)
	for i = 1, 8 do
		text = gsub(text, "|TInterface\\TargetingFrame\\UI%-RaidTargetingIcon_"..i..":0|t", "{"..strlower(_G["RAID_TARGET_"..i]).."}")
	end
	text = gsub(text, "\124T.-\124t", "")
	return text
end

local function GetLines(...)
	local ct = 1
	for i = select("#", ...), 1, -1 do
		local region = select(i, ...)
		if region:GetObjectType() == "FontString" then
			local line = tostring(region:GetText())
			lines[ct] = RemoveIcon(line)
			ct = ct + 1
		end
	end
	return ct - 1
end

local function Copy(cf)
	local id = cf:GetID()
	local _, size = FCF_GetChatWindowInfo(id)
	FCF_SetChatWindowFontSize(cf, cf, 0.01)
	local lineCt = GetLines(cf:GetRegions())
	local text = table.concat(lines, "\n", 1, lineCt)
	if size < 11 then
		FCF_SetChatWindowFontSize(cf, cf, 11)
	else
		FCF_SetChatWindowFontSize(cf, cf, size)
	end
	if not isf then CreatCopyFrame() end
	if frame:IsShown() then frame:Hide() return end
	frame:Show()
	editBox:SetText(text)
end

for i = 1, NUM_CHAT_WINDOWS do
	local cf = _G[format("ChatFrame%d", i)]
	local button = CreateFrame("Button", format("ButtonCF%d", i), cf)
	button:SetPoint("BOTTOMRIGHT", 0, 1)
	button:SetHeight(20)
	button:SetWidth(20)
	button:SetAlpha(0)
	button:SetTemplate("Transparent")
	button:SetBackdropBorderColor(T.color.r, T.color.g, T.color.b)

	local buttontexture = button:CreateTexture(nil, "BORDER")
	buttontexture:SetPoint("CENTER")
	buttontexture:SetTexture("Interface\\BUTTONS\\UI-GuildButton-PublicNote-Up")
	buttontexture:SetHeight(16)
	buttontexture:SetWidth(16)

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
end