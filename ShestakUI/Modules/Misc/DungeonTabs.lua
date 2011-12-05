local T, C, L = unpack(select(2, ...))
--if C.misc.dungeon_tabs ~= true then return end

----------------------------------------------------------------------------------------
--	LFD/LFR/PVP tabs on frames(SocialTabs by Califpornia)
----------------------------------------------------------------------------------------
local f = CreateFrame("Frame")
local TabArray = {}
local VisibleFrames = {}

local function ToggleFrameByType(ftype)
	if ftype == "lfd" then
		ToggleLFDParentFrame()
	elseif ftype == "lfr" then
		ToggleRaidFrame()
	elseif ftype == "pvp" then
		TogglePVPFrame()
	end
end

local function UpdateTabCheckedState(ftype, chkd)
	for k, v in pairs(TabArray) do
		if v then TabArray[k][ftype]:SetChecked(chkd) end
	end
end

local function UpdateTabEnabledState(ftype, enabled)
	for k, v in pairs(TabArray) do
		if v then
			if enabled then
				TabArray[k][ftype]:Enable()
				TabArray[k][ftype]:SetAlpha(1)
				SetDesaturation(TabArray[k][ftype]:GetNormalTexture(), false)
			else
				TabArray[k][ftype]:Disable()
				TabArray[k][ftype]:SetAlpha(0.5)
				SetDesaturation(TabArray[k][ftype]:GetNormalTexture(), true)
			end
		end
	end
end

local function UpdateTabVisibleState(ftype, enabled)
	for k, v in pairs(TabArray) do
		if v then
			if enabled then
				TabArray[k][ftype]:Show()
			else
				TabArray[k][ftype]:Hide()
			end
		end
	end
end

local function CloseAllTabs()
	-- Keep other frames open if CTRL modifier is pressed
	if not IsControlKeyDown() then
		for k, v in pairs(VisibleFrames) do
			if v then ToggleFrameByType(k) end
		end
	end
end

local function Tab_OnClick(self)
	CloseAllTabs()
	ToggleFrameByType(self.ToggleFrameType)
end

local function SkinTab(f, t)
	f:Show()
	if C.skins.blizzard_frames == true then
		f:StripTextures()
		f:SetNormalTexture(t)
		f:GetNormalTexture():ClearAllPoints()
		f:GetNormalTexture():Point("TOPLEFT", 2, -2)
		f:GetNormalTexture():Point("BOTTOMRIGHT", -2, 2)
		f:GetNormalTexture():SetTexCoord(0.1, 0.9, 0.1, 0.9)
		--if f:GetPushedTexture() then
		--	f:GetPushedTexture():SetTexture(0.9, 0.8, 0.1, 0.3)
		--	f:GetPushedTexture():SetAllPoints(f:GetNormalTexture())
		--end
		if f:GetCheckedTexture() then
			f:GetCheckedTexture():SetTexture(0, 1, 0, 0.3)
			f:GetCheckedTexture():SetAllPoints(f:GetNormalTexture())
		end
		f:GetHighlightTexture():SetTexture(1, 1, 1, 0.3)
		f:GetHighlightTexture():SetAllPoints(f:GetNormalTexture())
		f:CreateBackdrop("Default")
		f.backdrop:SetAllPoints()
		f:StyleButton(true)
	else
		f:SetNormalTexture(t)
	end
end

local function CreateTabs(fr, frtype)
	local frametabs = {}

	-- LFD tab
	frametabs["lfd"] = CreateFrame("CheckButton", "LFDSideTab", fr, "SpellBookSkillLineTabTemplate")
	SkinTab(frametabs["lfd"], "Interface\\LFGFrame\\UI-LFG-PORTRAIT")
	if C.skins.blizzard_frames == true then
		frametabs["lfd"]:SetPoint("TOPLEFT", fr, "TOPRIGHT", 1, 0)
	else
		frametabs["lfd"]:SetPoint("TOPLEFT", fr, "TOPRIGHT", 0, -30)
	end
	frametabs["lfd"].tooltip = LOOKING_FOR_DUNGEON
	frametabs["lfd"].ToggleFrame = LFDParentFrame
	frametabs["lfd"].ToggleFrameType = "lfd"
	frametabs["lfd"]:SetScript("OnClick", Tab_OnClick)
	if T.level < SHOW_LFD_LEVEL then
		frametabs["lfd"]:SetAlpha(0.5)
		SetDesaturation(frametabs["lfd"]:GetNormalTexture(), true)
		frametabs["lfd"]:Disable()
	end

	-- LFR tab
	frametabs["lfr"] = CreateFrame("CheckButton", "LFRSideTab", fr, "SpellBookSkillLineTabTemplate")
	SkinTab(frametabs["lfr"], "Interface\\LFGFrame\\UI-LFR-PORTRAIT")
	frametabs["lfr"]:SetPoint("TOPLEFT", frametabs["lfd"], "BOTTOMLEFT", 0, -12)
	frametabs["lfr"].tooltip = RAID_FINDER
	frametabs["lfr"].ToggleFrame = RaidParentFrame
	frametabs["lfr"].ToggleFrameType = "lfr"
	frametabs["lfr"]:SetScript("OnClick", Tab_OnClick)

	-- PVP tab
	frametabs["pvp"] = CreateFrame("CheckButton", "PVPSideTab", fr, "SpellBookSkillLineTabTemplate")
	SkinTab(frametabs["pvp"], "Interface\\BattlefieldFrame\\UI-Battlefield-Icon")
	frametabs["pvp"]:SetPoint("TOPLEFT", frametabs["lfr"], "BOTTOMLEFT", 0, -12)
	frametabs["pvp"].tooltip = PLAYER_V_PLAYER
	frametabs["pvp"].ToggleFrame = PvpFrame
	frametabs["pvp"].ToggleFrameType = "pvp"
	frametabs["pvp"]:SetScript("OnClick", Tab_OnClick)
	if T.level < SHOW_PVP_LEVEL then
		frametabs["pvp"]:SetAlpha(0.5)
		SetDesaturation(frametabs["pvp"]:GetNormalTexture(), true)
		frametabs["pvp"]:Disable()
	end

	-- First show
	CloseAllTabs()
	VisibleFrames[frtype] = true

	fr:HookScript("OnShow", function()
		VisibleFrames[frtype] = true
		UpdateTabCheckedState(frtype, true)
	end)

	fr:HookScript("OnHide", function()
		VisibleFrames[frtype] = false
		UpdateTabCheckedState(frtype, false)
	end)

	TabArray[fr:GetName()] = frametabs
	UpdateTabCheckedState(frtype, true)
end

LFDParentFrame:HookScript("OnShow", function()
	if not TabArray[LFDParentFrame:GetName()] then
		CreateTabs(LFDParentFrame, "lfd")
	end
end)

RaidParentFrame:HookScript("OnShow", function()
	if not TabArray[RaidParentFrame:GetName()] then
		CreateTabs(RaidParentFrame, "lfr")

		LFRParentFrameSideTab1:SetPoint("TOPLEFT", "PVPSideTab", "BOTTOMLEFT", 0, -12)
	end
end)

PVPFrame:HookScript("OnShow", function()
	if not TabArray[PVPFrame:GetName()] then
		CreateTabs(PVPFrame, "pvp")
	end
end)

f:SetScript("OnEvent", function(self, event, addon)
	if event == "PLAYER_LEVEL_UP" then
		if T.level >= SHOW_LFD_LEVEL then
			UpdateTabEnabledState("lfd", true)
		end
		if T.level >= SHOW_PVP_LEVEL then
			UpdateTabEnabledState("pvp", true)
		end
	end
end)

f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("PLAYER_LEVEL_UP")