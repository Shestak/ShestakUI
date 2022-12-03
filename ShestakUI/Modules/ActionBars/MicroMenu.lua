local T, C, L, _ = unpack(select(2, ...))
if C.actionbar.enable ~= true or C.actionbar.micromenu ~= true then return end

----------------------------------------------------------------------------------------
--	Micro menu(by Elv22)
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame", "MicroAnchor", T_PetBattleFrameHider)
frame:SetPoint(unpack(C.position.micro_menu))
frame:SetSize(250, 25)

UpdateMicroButtonsParent(frame)
if C.actionbar.micromenu_mouseover == true then frame:SetAlpha(0) end

local MICRO_BUTTONS = {
	"CharacterMicroButton",
	"SpellbookMicroButton",
	"TalentMicroButton",
	"AchievementMicroButton",
	"QuestLogMicroButton",
	"GuildMicroButton",
	"LFDMicroButton",
	"EJMicroButton",
	"CollectionsMicroButton",
	"MainMenuMicroButton",
	"HelpMicroButton",
	"StoreMicroButton",
}

local colors = {
	[1]	= {0.35, 0.65, 1},
	[2]	= {1, 0.58, 0.65},
	[3]	= {0.21, 1, 0.95},
	[4]	= {1, 0.62, 0.1},
	[5]	= {0.96, 1, 0},
	[6]	= {0, 1, 0.1},
	[7]	= {0.7, 0.7, 1},
	[8]	= {1, 1, 1},
	[9]	= {1, 0.7, 0.58},
	[10] = {1, 0.4, 0.4},
	[11] = {1, 1, 1},
	[12] = {1, 0.83, 0.50},
}

for i, button in pairs(MICRO_BUTTONS) do
	local bu = _G[button]
	local normal = bu:GetNormalTexture()
	local pushed = bu:GetPushedTexture()
	local disabled = bu:GetDisabledTexture()
	bu:SetSize(22, 29)

	bu:SetParent(frame)
	bu.SetParent = T.dummy

	bu:SetHighlightTexture(0)
	bu.SetHighlightTexture = T.dummy

	local f = CreateFrame("Frame", nil, bu)
	f:SetFrameLevel(1)
	f:SetFrameStrata("BACKGROUND")
	f:SetPoint("BOTTOMLEFT", bu, "BOTTOMLEFT", 1, 2)
	f:SetPoint("TOPRIGHT", bu, "TOPRIGHT", -1, -2)
	f:SetTemplate("Default")
	bu.frame = f

	local flash = bu.FlashBorder
	if flash then
		flash:SetInside(f)
		flash:SetTexture(C.media.blank)
		flash:SetVertexColor(0.6, 0.6, 0.6)
	end
	if bu.FlashContent then bu.FlashContent:SetTexture(nil) end

	local highlight = bu:GetHighlightTexture()
	if highlight then
		highlight:SetInside(f)
	end

	normal:SetTexCoord(0.1, 0.85, 0.12, 0.78)
	normal:ClearAllPoints()
	normal:SetPoint("TOPLEFT", f, "TOPLEFT", 2, -2)
	normal:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -2, 2)
	normal:SetVertexColor(unpack(colors[i]))

	pushed:SetTexCoord(0.1, 0.85, 0.12, 0.78)
	pushed:ClearAllPoints()
	pushed:SetPoint("TOPLEFT", f, "TOPLEFT", 2, -2)
	pushed:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -2, 2)

	if disabled then
		disabled:SetTexCoord(0.1, 0.85, 0.12, 0.78)
		disabled:ClearAllPoints()
		disabled:SetPoint("TOPLEFT", f, "TOPLEFT", 2, -2)
		disabled:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -2, 2)
	end

	bu:HookScript("OnEnter", function(self)
		self.frame:SetBackdropBorderColor(unpack(C.media.classborder_color))
		if C.actionbar.micromenu_mouseover then
			frame:SetAlpha(1)
		end
	end)
	bu:HookScript("OnLeave", function(self)
		self.frame:SetBackdropBorderColor(unpack(C.media.border_color))
		if C.actionbar.micromenu_mouseover then
			frame:SetAlpha(0)
		end
	end)
end

-- Fix textures for buttons
hooksecurefunc("UpdateMicroButtons", function()
	CharacterMicroButton:ClearAllPoints()
	CharacterMicroButton:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", -1, -2)

	MainMenuMicroButton.MainMenuBarPerformanceBar:SetPoint("BOTTOM", MainMenuMicroButton, "BOTTOM", 0, 4)
end)

MainMenuMicroButton.MainMenuBarPerformanceBar:SetTexture(C.media.texture)
MainMenuMicroButton.MainMenuBarPerformanceBar:SetSize(16, 2)