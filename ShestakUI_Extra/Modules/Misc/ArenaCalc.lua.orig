local T, C, L = unpack(ShestakUI)
if C.extra_general.arena_calc ~= true then return end

----------------------------------------------------------------------------------------
--	Arena conquest point Calculator(by Hydra & fraz0816)
----------------------------------------------------------------------------------------
local buttonSize = 20
local buttonSpacing = 5
local textValue = "0"
local error = "|cff00AAFFError: invalid|r"

local buttonValues = {
	[1] = "1",
	[2] = "2",
	[3] = "3",
	[4] = "4",
	[5] = "5",
	[6] = "6",
	[7] = "7",
	[8] = "8",
	[9] = "9",
	[10] = "0",
	[11] = "=",
	[12] = "|cff00AAFFC|r",
}

-- Create Buttons
local function SetButton(obj, value)
	obj:EnableMouse(true)
	obj:SetScript("OnMouseDown", value)
end

local CalcAnchor = CreateFrame("Frame", "CalcAnchor", UIParent)
CalcAnchor:SetPoint(unpack(C.extra_position.arena_calc))
CalcAnchor:SetWidth((buttonSize * 4) + (buttonSpacing * 5))
CalcAnchor:SetHeight((buttonSize * 4) + (buttonSpacing * 5))
tinsert(T.MoverFrames, CalcAnchor)

local function CreateModule()
	-- Background Frame
	local hCalcBG = CreateFrame("Frame", "CalcBG", UIParent)
	hCalcBG:CreatePanel("Transparent", 1, 1, "TOPLEFT", CalcAnchor, "TOPLEFT", 0, 0)

	-- Make all the buttons
	hCalcButton = CreateFrame("Button", "CalcButton", hCalcBG)
	for i = 1, getn(buttonValues) do
		hCalcButton[i] = CreateFrame("Button", "CalcButton"..i, hCalcBG)
		hCalcButton[i]:CreatePanel("Overlay", buttonSize, buttonSize, "BOTTOMLEFT", hCalcBG, "BOTTOMLEFT", 1, 1)
		hCalcButton[i]:ClearAllPoints()
		if i == 1 then
			hCalcButton[i]:SetPoint("BOTTOMLEFT", hCalcBG, "BOTTOMLEFT", buttonSpacing, buttonSpacing)
		elseif i == 5 then
			hCalcButton[i]:SetPoint("BOTTOM", hCalcButton[1], "TOP", 0, buttonSpacing)
		elseif i == 9 then
			hCalcButton[i]:SetPoint("BOTTOM", hCalcButton[5], "TOP", 0, buttonSpacing)
		else
			hCalcButton[i]:SetPoint("LEFT", hCalcButton[i-1], "RIGHT", buttonSpacing, 0)
		end
		
		hCalcButton[i]:HookScript("OnEnter", T.SetModifiedBackdrop)
		hCalcButton[i]:HookScript("OnLeave", T.SetOriginalBackdrop)
	end

	-- Add the text to buttons
	for number, text in pairs(buttonValues) do
		hCalcButtonText = hCalcButton:CreateFontString(nil, "LOW")
		hCalcButtonText:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
		hCalcButtonText:SetPoint("CENTER", hCalcButton[number], 0, 0)
		hCalcButtonText:SetText(text)
	end

	-- Auto size the background
	hCalcBG:SetWidth((buttonSize * 4) + (buttonSpacing * 5))
	hCalcBG:SetHeight((buttonSize * 4) + (buttonSpacing * 5))

	-- Text box
	hCalcTextFrame = CreateFrame("Button", "CalcTextFrame", hCalcBG)
	hCalcTextFrame:CreatePanel(nil, hCalcBG:GetWidth() - (buttonSpacing * 2), buttonSize, "TOP", hCalcBG, "TOP", 0, -buttonSpacing)

	-- Text box texture
	hTextFrameTex = hCalcTextFrame:CreateTexture(nil, "ARTWORK")
	hTextFrameTex:SetVertexColor(0.3, 0.3, 0.3)
	hTextFrameTex:Point("TOPLEFT", hCalcTextFrame, 2, -2)
	hTextFrameTex:Point("BOTTOMRIGHT", hCalcTextFrame, -2, 2)
	hTextFrameTex:SetTexture(C.media.blank)

	-- Text
	hCalcText = hCalcTextFrame:CreateFontString(nil, "OVERLAY")
	hCalcText:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
	hCalcText:SetPoint("Right", hCalcTextFrame, -4, -0.5)
	hCalcText:SetText(textValue)
	hCalcText:SetTextColor(0, 0.7, 1)

	for i, text in pairs(buttonValues) do
		SetButton(CalcButton[i], function()
			if hCalcText:GetText() ~= "0" then
				local old = hCalcText:GetText()
				textValue = (old..text)
			else
				textValue = text
			end

			if i == 12 then
				textValue = "0"
			end
		end)
	end

	SetButton(CalcButton[11], function()
		local rating = hCalcText:GetText()
		local value = -(101/97200000000000)*rating^5+(247/19440000000)*rating^4-(39557/648000000)*rating^3+(154351/1080000)*rating^2-(1446533/9000)*rating+70461
		textValue = math.ceil(value)
	end)

	-- Update Text
	CreateFrame("Frame"):SetScript("OnUpdate", function(self)
		hCalcText:SetText(textValue)
		local old = hCalcText:GetText()
		if string.len(old) > 4 then
			textValue = error
		end
	end)
end

local function ToggleCalc()
	if not CalcBG then
		CreateModule()
	else
		ToggleFrame(CalcBG)
	end
end
SLASH_CONQUESTCALC1 = "/calc"
SlashCmdList.CONQUESTCALC = ToggleCalc