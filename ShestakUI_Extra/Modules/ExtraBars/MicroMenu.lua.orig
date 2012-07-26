local T, C, L = unpack(ShestakUI)
if C.actionbar.enable ~= true or C.extra_bar.micro_menu ~= true then return end

----------------------------------------------------------------------------------------
--	Micro menu(by Elv22)
----------------------------------------------------------------------------------------
local microbuttons = {
	"CharacterMicroButton",
	"SpellbookMicroButton",
	"TalentMicroButton",
	"QuestLogMicroButton",
	"PVPMicroButton",
	"GuildMicroButton",
	"LFDMicroButton",
	"RaidMicroButton",
	"HelpMicroButton",
	"MainMenuMicroButton",
	"AchievementMicroButton",
	"EJMicroButton"
}

local f = CreateFrame("Frame", "MicroAnchor", UIParent)
MicroAnchor.shown = false
if C.extra_bar.micro_menu_mouse == true then f:SetAlpha(0) end

UpdateMicroButtonsParent(f)

local function CheckFade(self, elapsed)
	local mouseactive
	for i, button in pairs(microbuttons) do
		local b = _G[button]
		if b.mouseover == true then
			mouseactive = true
		end
	end

	if C.extra_bar.micro_menu_mouse ~= true then return end

	if MicroAnchor.mouseover == true then
		mouseactive = true
		if GameTooltip:IsShown() then
			GameTooltip:Hide()
		end
	end

	if mouseactive == true then
		if MicroAnchor.shown ~= true then
			MicroAnchor:SetAlpha(1)
			MicroAnchor.shown = true
		end
	else
		if MicroAnchor.shown == true then
			MicroAnchor:SetAlpha(0)
			MicroAnchor.shown = false
		end
	end
end
f:SetScript("OnUpdate", CheckFade)

for i, button in pairs(microbuttons) do
	local m = _G[button]
	local pushed = m:GetPushedTexture()
	local normal = m:GetNormalTexture()
	local disabled = m:GetDisabledTexture()

	m:SetParent(MicroAnchor)
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

MicroAnchor:Point(unpack(C.extra_position.micro_menu))
MicroAnchor:Width(((CharacterMicroButton:GetWidth() + 4) * 9) + 12)
MicroAnchor:Height(CharacterMicroButton:GetHeight() - 28)
tinsert(T.MoverFrames, MicroAnchor)

CharacterMicroButton:ClearAllPoints()
CharacterMicroButton:Point("BOTTOMLEFT", MicroAnchor, "BOTTOMLEFT", -2, 0)
CharacterMicroButton.SetPoint = T.dummy
CharacterMicroButton.ClearAllPoints = T.dummy