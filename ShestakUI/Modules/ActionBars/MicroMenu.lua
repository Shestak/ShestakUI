local T, C, L, _ = unpack(select(2, ...))
if C.actionbar.enable ~= true or C.actionbar.micromenu ~= true then return end

----------------------------------------------------------------------------------------
--	Micro menu(by Elv22)
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame", "MicroAnchor", T_PetBattleFrameHider)
frame:SetPoint(unpack(C.position.micro_menu))
frame:SetSize(284, 30)

UpdateMicroButtonsParent(frame)
if C.actionbar.micromenu_mouseover == true then frame:SetAlpha(0) end

for _, button in pairs(MICRO_BUTTONS) do
	local bu = _G[button]
	local normal = bu:GetNormalTexture()
	local pushed = bu:GetPushedTexture()
	local disabled = bu:GetDisabledTexture()

	bu:SetParent(frame)
	bu.SetParent = T.dummy
	_G[button.."Flash"]:SetTexture("")
	bu:SetHighlightTexture("")
	bu.SetHighlightTexture = T.dummy

	local f = CreateFrame("Frame", nil, bu)
	f:SetFrameLevel(1)
	f:SetFrameStrata("BACKGROUND")
	f:SetPoint("BOTTOMLEFT", bu, "BOTTOMLEFT", 2, 0)
	f:SetPoint("TOPRIGHT", bu, "TOPRIGHT", -2, -6)
	f:SetTemplate("Default")
	bu.frame = f

	normal:SetTexCoord(0.22, 0.81, 0.26, 0.82)
	normal:ClearAllPoints()
	normal:SetPoint("TOPLEFT", f, "TOPLEFT", 2, -2)
	normal:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -2, 2)

	pushed:SetTexCoord(0.22, 0.81, 0.26, 0.82)
	pushed:ClearAllPoints()
	pushed:SetPoint("TOPLEFT", f, "TOPLEFT", 2, -2)
	pushed:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -2, 2)

	if disabled then
		disabled:SetTexCoord(0.22, 0.81, 0.26, 0.82)
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
	MicroButtonPortrait:ClearAllPoints()
	MicroButtonPortrait:SetPoint("TOPLEFT", CharacterMicroButton.frame, "TOPLEFT", 2, -2)
	MicroButtonPortrait:SetPoint("BOTTOMRIGHT", CharacterMicroButton.frame, "BOTTOMRIGHT", -2, 2)

	CharacterMicroButton:ClearAllPoints()
	CharacterMicroButton:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", -2, 0)

	GuildMicroButtonTabard:ClearAllPoints()
	GuildMicroButtonTabard:SetPoint("TOP", GuildMicroButton.frame, "TOP", 0, 25)

	MainMenuBarPerformanceBar:SetPoint("BOTTOM", MainMenuMicroButton, "BOTTOM", 0, 0)
end)