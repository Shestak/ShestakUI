local T, C, L, _ = unpack(select(2, ...))
if C.actionbar.enable ~= true or C.actionbar.micromenu ~= true then return end

----------------------------------------------------------------------------------------
--	Micro menu(by Elv22)
----------------------------------------------------------------------------------------
local microbuttons = {
	"CharacterMicroButton",
	"SpellbookMicroButton",
	"TalentMicroButton",
	"AchievementMicroButton",
	"QuestLogMicroButton",
	"GuildMicroButton",
	"PVPMicroButton",
	"LFDMicroButton",
	"CompanionsMicroButton",
	"EJMicroButton",
	"MainMenuMicroButton",
	"HelpMicroButton"
}

local frame = CreateFrame("Frame", "MicroAnchor", UIParent)
frame:Point(unpack(C.position.micro_menu))
frame:Width(((CharacterMicroButton:GetWidth() + 4) * 9) + 12)
frame:Height(CharacterMicroButton:GetHeight() - 28)
frame.shown = false
if C.actionbar.micromenu_mouseover == true then frame:SetAlpha(0) end

UpdateMicroButtonsParent(frame)

local function CheckFade(self, elapsed)
	local mouseactive
	for i, button in pairs(microbuttons) do
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

for i, button in pairs(microbuttons) do
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
	f:Point("BOTTOMLEFT", m, "BOTTOMLEFT", 2, 0)
	f:Point("TOPRIGHT", m, "TOPRIGHT", -2, -28)
	f:SetTemplate("Default", true)
	m.frame = f

	pushed:SetTexCoord(0.17, 0.87, 0.5, 0.908)
	pushed:ClearAllPoints()
	pushed:Point("TOPLEFT", m.frame, "TOPLEFT", 2, -2)
	pushed:Point("BOTTOMRIGHT", m.frame, "BOTTOMRIGHT", -2, 2)

	normal:SetTexCoord(0.17, 0.87, 0.5, 0.908)
	normal:ClearAllPoints()
	normal:Point("TOPLEFT", m.frame, "TOPLEFT", 2, -2)
	normal:Point("BOTTOMRIGHT", m.frame, "BOTTOMRIGHT", -2, 2)

	if disabled then
		disabled:SetTexCoord(0.17, 0.87, 0.5, 0.908)
		disabled:ClearAllPoints()
		disabled:Point("TOPLEFT", m.frame, "TOPLEFT", 2, -2)
		disabled:Point("BOTTOMRIGHT", m.frame, "BOTTOMRIGHT", -2, 2)
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

-- Fix/Create textures for buttons
do
	MicroButtonPortrait:ClearAllPoints()
	MicroButtonPortrait:Point("TOPLEFT", CharacterMicroButton.frame, "TOPLEFT", 2, -2)
	MicroButtonPortrait:Point("BOTTOMRIGHT", CharacterMicroButton.frame, "BOTTOMRIGHT", -2, 2)

	GuildMicroButtonTabard:ClearAllPoints()
	GuildMicroButtonTabard:Point("TOP", GuildMicroButton.frame, "TOP", 0, 25)
	GuildMicroButtonTabard.SetPoint = T.dummy
	GuildMicroButtonTabard.ClearAllPoints = T.dummy
end

CharacterMicroButton:ClearAllPoints()
CharacterMicroButton:Point("BOTTOMLEFT", frame, "BOTTOMLEFT", -2, 0)
CharacterMicroButton.SetPoint = T.dummy
CharacterMicroButton.ClearAllPoints = T.dummy