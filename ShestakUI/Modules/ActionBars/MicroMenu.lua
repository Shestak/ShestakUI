local T, C, L, _ = unpack(select(2, ...))
if C.actionbar.enable ~= true or C.actionbar.micromenu ~= true then return end

----------------------------------------------------------------------------------------
--	Micro menu(by Elv22)
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame", "MicroAnchor", T_PetBattleFrameHider)
frame:SetPoint(unpack(C.position.micro_menu))
frame:SetSize(284, 30)
frame.shown = false

UpdateMicroButtonsParent(frame)
if C.actionbar.micromenu_mouseover == true then frame:SetAlpha(0) end

local function CheckFade()
	local mouseactive
	for _, button in pairs(MICRO_BUTTONS) do
		local b = _G[button]
		if b.mouseover == true then
			mouseactive = true
		end
	end

	if C.actionbar.micromenu_mouseover ~= true then return end

	if frame.mouseover == true then
		mouseactive = true
		if GameTooltip:IsShown() then
			GameTooltip:Hide()
		end
	end

	if mouseactive == true then
		if frame.shown ~= true then
			frame:SetAlpha(1)
			frame.shown = true
		end
	else
		if frame.shown == true then
			frame:SetAlpha(0)
			frame.shown = false
		end
	end
end
frame:SetScript("OnUpdate", CheckFade)

for _, button in pairs(MICRO_BUTTONS) do
	local m = _G[button]
	local pushed = m:GetPushedTexture()
	local normal = m:GetNormalTexture()
	local disabled = m:GetDisabledTexture()

	m:SetParent(frame)
	m.SetParent = T.dummy
	_G[button.."Flash"]:SetTexture("")
	m:SetHighlightTexture("")
	m.SetHighlightTexture = T.dummy

	local f = CreateFrame("Frame", nil, m)
	f:SetFrameLevel(1)
	f:SetFrameStrata("BACKGROUND")
	f:SetPoint("BOTTOMLEFT", m, "BOTTOMLEFT", 2, 0)
	f:SetPoint("TOPRIGHT", m, "TOPRIGHT", -2, -6)
	f:SetTemplate("Default")
	m.frame = f

	pushed:SetTexCoord(0.22, 0.81, 0.26, 0.82)
	pushed:ClearAllPoints()
	pushed:SetPoint("TOPLEFT", m.frame, "TOPLEFT", 2, -2)
	pushed:SetPoint("BOTTOMRIGHT", m.frame, "BOTTOMRIGHT", -2, 2)

	normal:SetTexCoord(0.22, 0.81, 0.26, 0.82)
	normal:ClearAllPoints()
	normal:SetPoint("TOPLEFT", m.frame, "TOPLEFT", 2, -2)
	normal:SetPoint("BOTTOMRIGHT", m.frame, "BOTTOMRIGHT", -2, 2)

	if disabled then
		disabled:SetTexCoord(0.22, 0.81, 0.26, 0.82)
		disabled:ClearAllPoints()
		disabled:SetPoint("TOPLEFT", m.frame, "TOPLEFT", 2, -2)
		disabled:SetPoint("BOTTOMRIGHT", m.frame, "BOTTOMRIGHT", -2, 2)
	end

	m.mouseover = false
	m:HookScript("OnEnter", function(self)
		self.frame:SetBackdropBorderColor(T.color.r, T.color.g, T.color.b)
		self.mouseover = true
	end)
	m:HookScript("OnLeave", function(self)
		self.frame:SetBackdropBorderColor(unpack(C.media.border_color))
		self.mouseover = false
	end)
end

-- Fix textures for buttons
hooksecurefunc("UpdateMicroButtons", function()
	MicroButtonPortrait:ClearAllPoints()
	MicroButtonPortrait:SetPoint("TOPLEFT", CharacterMicroButton.frame, "TOPLEFT", 2, -2)
	MicroButtonPortrait:SetPoint("BOTTOMRIGHT", CharacterMicroButton.frame, "BOTTOMRIGHT", -2, 2)

	CharacterMicroButton:ClearAllPoints()
	CharacterMicroButton:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", -2, 0)

	if not T.classic then
		GuildMicroButtonTabard:ClearAllPoints()
		GuildMicroButtonTabard:SetPoint("TOP", GuildMicroButton.frame, "TOP", 0, 25)
	end

	MainMenuBarPerformanceBar:SetPoint("BOTTOM", MainMenuMicroButton, "BOTTOM", 0, 0)
end)
