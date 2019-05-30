local T, C, L, _ = unpack(select(2, ...))
if C.tooltip.enable ~= true then return end

----------------------------------------------------------------------------------------
--	Based on aTooltip(by ALZA)
----------------------------------------------------------------------------------------
local StoryTooltip, WarCampaignTooltip
if not T.classic then
	StoryTooltip = QuestScrollFrame.StoryTooltip
	StoryTooltip:SetFrameLevel(4)

	WarCampaignTooltip = QuestScrollFrame.WarCampaignTooltip
end

local tooltips = {
	GameTooltip,
	ItemRefTooltip,
	ShoppingTooltip1,
	ShoppingTooltip2,
	FriendsTooltip,
	ItemRefShoppingTooltip1,
	ItemRefShoppingTooltip2,
	AtlasLootTooltip,
	QuestHelperTooltip,
	QuestGuru_QuestWatchTooltip,
	StoryTooltip,
	ReputationParagonTooltip,
	WarCampaignTooltip,
	EmbeddedItemTooltip
}

local backdrop = {
	bgFile = C.media.blank, edgeFile = C.media.blank, edgeSize = T.mult,
	insets = {left = -T.mult, right = -T.mult, top = -T.mult, bottom = -T.mult}
}

for _, tt in pairs(tooltips) do
	if not IsAddOnLoaded("Aurora") then
		tt:SetBackdrop(nil)
		tt.SetBackdrop = T.dummy
		if tt.BackdropFrame then
			tt.BackdropFrame:SetBackdrop(nil)
		end
		local bg = CreateFrame("Frame", nil, tt)
		bg:SetPoint("TOPLEFT")
		bg:SetPoint("BOTTOMRIGHT")
		bg:SetFrameLevel(tt:GetFrameLevel() - 1)
		bg:SetTemplate("Transparent")

		tt.GetBackdrop = function() return backdrop end
		tt.GetBackdropColor = function() return C.media.backdrop_color[1], C.media.backdrop_color[2], C.media.backdrop_color[3], C.media.backdrop_alpha end
		tt.GetBackdropBorderColor = function() return unpack(C.media.border_color) end
	end
end

-- Extra tooltip's skin
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", function(self)
	if not IsAddOnLoaded("Auc-Advanced") then return end

	local LT = LibStub("LibExtraTip-1")
	for _, Tooltip in pairs({GameTooltip, ItemRefTooltip}) do
		Tooltip:HookScript("OnUpdate", function(self)
			if not LT then return end
			local ExtraTip = LT:GetExtraTip(self)
			if ExtraTip then
				if not ExtraTip.IsDone then
					ExtraTip:StripTextures()
					ExtraTip:CreateBackdrop("Transparent")
					ExtraTip.backdrop:SetPoint("TOPLEFT", 0, -3)
					ExtraTip.backdrop:SetPoint("BOTTOMRIGHT", 0, 2)
					ExtraTip:HookScript("OnShow", function()
						ExtraTip.backdrop:SetFrameLevel(0)
					end)
					ExtraTip.IsDone = true
				end
			end
		end)
	end
end)

local anchor = CreateFrame("Frame", "TooltipAnchor", UIParent)
anchor:SetSize(200, 40)
anchor:SetPoint(unpack(C.position.tooltip))

-- Hide PVP text
PVP_ENABLED = ""

-- Statusbar
GameTooltipStatusBar:SetStatusBarTexture(C.media.texture)
GameTooltipStatusBar:SetHeight(4)
GameTooltipStatusBar:ClearAllPoints()
GameTooltipStatusBar:SetPoint("TOPLEFT", GameTooltip, "BOTTOMLEFT", 2, 6)
GameTooltipStatusBar:SetPoint("TOPRIGHT", GameTooltip, "BOTTOMRIGHT", -2, 6)

-- Raid icon
local ricon = GameTooltip:CreateTexture("GameTooltipRaidIcon", "OVERLAY")
ricon:SetHeight(18)
ricon:SetWidth(18)
ricon:SetPoint("BOTTOM", GameTooltip, "TOP", 0, 5)

GameTooltip:HookScript("OnHide", function(self) ricon:SetTexture(nil) end)

-- Add "Targeted By" line
local targetedList = {}
local ClassColors = {}
local token
for class, color in next, RAID_CLASS_COLORS do
	ClassColors[class] = ("|cff%.2x%.2x%.2x"):format(color.r * 255, color.g * 255, color.b * 255)
end

local function AddTargetedBy()
	local numParty, numRaid = GetNumSubgroupMembers(), GetNumGroupMembers()
	if numParty > 0 or numRaid > 0 then
		for i = 1, (numRaid > 0 and numRaid or numParty) do
			local unit = (numRaid > 0 and "raid"..i or "party"..i)
			if UnitIsUnit(unit.."target", token) and not UnitIsUnit(unit, "player") then
				local _, class = UnitClass(unit)
				targetedList[#targetedList + 1] = ClassColors[class]
				targetedList[#targetedList + 1] = UnitName(unit)
				targetedList[#targetedList + 1] = "|r, "
			end
		end
		if #targetedList > 0 then
			targetedList[#targetedList] = nil
			GameTooltip:AddLine(" ", nil, nil, nil, 1)
			local line = _G["GameTooltipTextLeft"..GameTooltip:NumLines()]
			if not line then return end
			line:SetFormattedText(L_TOOLTIP_WHO_TARGET.." (|cffffffff%d|r): %s", (#targetedList + 1) / 3, table.concat(targetedList))
			wipe(targetedList)
		end
	end
end

----------------------------------------------------------------------------------------
--	Unit tooltip styling
----------------------------------------------------------------------------------------
function GameTooltip_UnitColor(unit)
	if not unit then return end
	local r, g, b

	if UnitIsPlayer(unit) then
		local _, class = UnitClass(unit)
		local color = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class]
		if color then
			r, g, b = color.r, color.g, color.b
		else
			r, g, b = 1, 1, 1
		end
	elseif UnitIsTapDenied(unit) or UnitIsDead(unit) then
		r, g, b = 0.6, 0.6, 0.6
	else
		local reaction = T.oUF_colors.reaction[UnitReaction(unit, "player")]
		if reaction then
			r, g, b = reaction[1], reaction[2], reaction[3]
		else
			r, g, b = 1, 1, 1
		end
	end

	return r, g, b
end

local function GameTooltipDefault(tooltip, parent)
	if C.tooltip.cursor == true then
		tooltip:SetOwner(parent, "ANCHOR_CURSOR_RIGHT", 20, 20)
	else
		tooltip:SetOwner(parent, "ANCHOR_NONE")
		tooltip:ClearAllPoints()
		tooltip:SetPoint("BOTTOMRIGHT", TooltipAnchor, "BOTTOMRIGHT", 0, 0)
		tooltip.default = 1
	end
end
hooksecurefunc("GameTooltip_SetDefaultAnchor", GameTooltipDefault)

if C.tooltip.shift_modifer == true then
	local ShiftShow = function()
		if IsShiftKeyDown() then
			GameTooltip:Show()
		else
			if not HoverBind.enabled then
				GameTooltip:Hide()
			end
		end
	end
	GameTooltip:SetScript("OnShow", ShiftShow)
	local EventShow = function()
		if arg1 == "LSHIFT" and arg2 == 1 then
			GameTooltip:Show()
		elseif arg1 == "LSHIFT" and arg2 == 0 then
			GameTooltip:Hide()
		end
	end
	local sh = CreateFrame("Frame")
	sh:RegisterEvent("MODIFIER_STATE_CHANGED")
	sh:SetScript("OnEvent", EventShow)
else
	if C.tooltip.cursor == true then
		hooksecurefunc("GameTooltip_SetDefaultAnchor", function(self, parent)
			if InCombatLockdown() and C.tooltip.hide_combat and not IsShiftKeyDown() then
				self:Hide()
			else
				self:SetOwner(parent, "ANCHOR_CURSOR_RIGHT", 20, 20)
			end
		end)
	else
		hooksecurefunc("GameTooltip_SetDefaultAnchor", function(self)
			if InCombatLockdown() and C.tooltip.hide_combat and not IsShiftKeyDown() then
				self:Hide()
			else
				self:SetPoint("BOTTOMRIGHT", TooltipAnchor, "BOTTOMRIGHT", 0, 0)
			end
		end)
	end
end

if C.tooltip.health_value == true then
	GameTooltipStatusBar:SetScript("OnValueChanged", function(self, value)
		if not value then return end
		local min, max = self:GetMinMaxValues()
		if (value < min) or (value > max) then return end
		self:SetStatusBarColor(0, 1, 0)
		local _, unit = GameTooltip:GetUnit()
		if unit then
			min, max = UnitHealth(unit), UnitHealthMax(unit)
			local hpRMH, maxhpRMH
			if T.classic and IsAddOnLoaded("RealMobHealth") then
				hpRMH, maxhpRMH = RealMobHealth.GetHealth(unit, true)

				if hpRMH and maxhpRMH then
					min, max = hpRMH, maxhpRMH
				end
			end
			if not self.text then
				self.text = self:CreateFontString(nil, "OVERLAY", "Tooltip_Med")
				self.text:SetPoint("CENTER", GameTooltipStatusBar, 0, 1.5)
			end
			self.text:Show()
			local hp = T.ShortValue(min).." / "..T.ShortValue(max)
			self.text:SetText(hp)
		end
	end)
end

local OnTooltipSetUnit = function(self)
	local lines = self:NumLines()
	local unit = (select(2, self:GetUnit())) or (GetMouseFocus() and GetMouseFocus().GetAttribute and GetMouseFocus():GetAttribute("unit")) or (UnitExists("mouseover") and "mouseover") or nil

	if not unit then return end

	local name, realm = UnitName(unit)
	local race, englishRace = UnitRace(unit)
	local level = UnitLevel(unit)
	local levelColor = GetCreatureDifficultyColor(level)
	local classification = UnitClassification(unit)
	local creatureType = UnitCreatureType(unit)
	local _, faction = UnitFactionGroup(unit)
	local _, playerFaction = UnitFactionGroup("player")
	local UnitPVPName = UnitPVPName

	if level and level == -1 then
		if classification == "worldboss" then
			level = "|cffff0000|r"..ENCOUNTER_JOURNAL_ENCOUNTER
		else
			level = "|cffff0000??|r"
		end
	end

	if classification == "rareelite" then classification = " R+"
	elseif classification == "rare" then classification = " R"
	elseif classification == "elite" then classification = "+"
	else classification = "" end


	if UnitPVPName(unit) and C.tooltip.title then
		name = UnitPVPName(unit)
	end

	_G["GameTooltipTextLeft1"]:SetText(name)
	if realm and realm ~= "" and C.tooltip.realm then
		self:AddLine(FRIENDS_LIST_REALM.."|cffffffff"..realm.."|r")
	end


	if UnitIsPlayer(unit) then
		if UnitIsAFK(unit) then
			self:AppendText((" %s"):format("|cffE7E716"..L_CHAT_AFK.."|r"))
		elseif UnitIsDND(unit) then
			self:AppendText((" %s"):format("|cffFF0000"..L_CHAT_DND.."|r"))
		end

		if UnitIsPlayer(unit) and englishRace == "Pandaren" and faction ~= nil and faction ~= playerFaction then
			local hex = "cffff3333"
			if faction == "Alliance" then
				hex = "cff69ccf0"
			end
			self:AppendText((" [|%s%s|r]"):format(hex, faction:sub(1, 2)))
		end

		if GetGuildInfo(unit) then
			_G["GameTooltipTextLeft2"]:SetFormattedText("%s", GetGuildInfo(unit))
			if UnitIsInMyGuild(unit) then
				_G["GameTooltipTextLeft2"]:SetTextColor(1, 1, 0)
			else
				_G["GameTooltipTextLeft2"]:SetTextColor(0, 1, 1)
			end
		end

		local n = GetGuildInfo(unit) and 3 or 2
		-- thx TipTac for the fix above with color blind enabled
		if GetCVar("colorblindMode") == "1" then n = n + 1 end
		_G["GameTooltipTextLeft"..n]:SetFormattedText("|cff%02x%02x%02x%s|r %s", levelColor.r * 255, levelColor.g * 255, levelColor.b * 255, level, race or UNKNOWN)

		for i = 2, lines do
			local line = _G["GameTooltipTextLeft"..i]
			if not line or not line:GetText() then return end
			if line and line:GetText() and (line:GetText() == FACTION_HORDE or line:GetText() == FACTION_ALLIANCE) then
				line:SetText()
				break
			end
		end
	else
		for i = 2, lines do
			local line = _G["GameTooltipTextLeft"..i]
			if not line or not line:GetText() or UnitIsBattlePetCompanion(unit) then return end
			if (level and line:GetText():find("^"..LEVEL)) or (creatureType and line:GetText():find("^"..creatureType)) then
				line:SetFormattedText("|cff%02x%02x%02x%s%s|r %s", levelColor.r * 255, levelColor.g * 255, levelColor.b * 255, level, classification, creatureType or "")
				break
			end
		end
	end

	if C.tooltip.target == true and UnitExists(unit.."target") then
		local r, g, b = GameTooltip_UnitColor(unit.."target")
		local text = ""

		if UnitIsEnemy("player", unit.."target") then
			r, g, b = unpack(T.oUF_colors.reaction[1])
		elseif not UnitIsFriend("player", unit.."target") then
			r, g, b = unpack(T.oUF_colors.reaction[4])
		end

		if UnitName(unit.."target") == UnitName("player") then
			text = "|cfffed100"..STATUS_TEXT_TARGET..":|r ".."|cffff0000> "..UNIT_YOU.." <|r"
		else
			text = "|cfffed100"..STATUS_TEXT_TARGET..":|r "..UnitName(unit.."target")
		end

		self:AddLine(text, r, g, b)
	end

	if C.tooltip.raid_icon == true then
		local raidIndex = GetRaidTargetIndex(unit)
		if raidIndex then
			ricon:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcon_"..raidIndex)
		end
	end

	if C.tooltip.who_targetting == true then
		token = unit AddTargetedBy()
	end
end

GameTooltip:HookScript("OnTooltipSetUnit", OnTooltipSetUnit)

----------------------------------------------------------------------------------------
--	Adds guild rank to tooltips(GuildRank by Meurtcriss)
----------------------------------------------------------------------------------------
if C.tooltip.rank == true then
	GameTooltip:HookScript("OnTooltipSetUnit", function(self, ...)
		-- Get the unit
		local _, unit = self:GetUnit()
		if not unit then
			local mFocus = GetMouseFocus()
			if mFocus and mFocus.unit then
				unit = mFocus.unit
			end
		end
		-- Get and display guild rank
		if UnitIsPlayer(unit) then
			local guildName, guildRank = GetGuildInfo(unit)
			if guildName then
				self:AddLine(RANK..": |cffffffff"..guildRank.."|r")
			end
		end
	end)
end

----------------------------------------------------------------------------------------
--	Hide tooltips in combat for action bars, pet bar and stance bar
----------------------------------------------------------------------------------------
if C.tooltip.hidebuttons == true then
	local CombatHideActionButtonsTooltip = function(self)
		if not IsShiftKeyDown() then
			self:Hide()
		end
	end

	hooksecurefunc(GameTooltip, "SetAction", CombatHideActionButtonsTooltip)
	hooksecurefunc(GameTooltip, "SetPetAction", CombatHideActionButtonsTooltip)
	hooksecurefunc(GameTooltip, "SetShapeshift", CombatHideActionButtonsTooltip)
end

----------------------------------------------------------------------------------------
--	Fix compare tooltips(by Blizzard)(../FrameXML/GameTooltip.lua)
----------------------------------------------------------------------------------------
hooksecurefunc("GameTooltip_ShowCompareItem", function(self, anchorFrame)
	if not self then
		self = GameTooltip
	end

	if not anchorFrame then
		anchorFrame = self.overrideComparisonAnchorFrame or self
	end

	if self.needsReset then
		self:ResetSecondaryCompareItem()
		GameTooltip_AdvanceSecondaryCompareItem(self)
		self.needsReset = false
	end

	local shoppingTooltip1, shoppingTooltip2 = unpack(self.shoppingTooltips)
	local primaryItemShown, secondaryItemShown = shoppingTooltip1:SetCompareItem(shoppingTooltip2, self)
	local leftPos = anchorFrame:GetLeft()
	local rightPos = anchorFrame:GetRight()

	local side
	local anchorType = self:GetAnchorType()
	local totalWidth = 0
	if primaryItemShown then
		totalWidth = totalWidth + shoppingTooltip1:GetWidth()
	end
	if secondaryItemShown then
		totalWidth = totalWidth + shoppingTooltip2:GetWidth()
	end
	if self.overrideComparisonAnchorSide then
		side = self.overrideComparisonAnchorSide
	else
		-- Find correct side
		local rightDist = 0
		if not rightPos then
			rightPos = 0
		end
		if not leftPos then
			leftPos = 0
		end

		rightDist = GetScreenWidth() - rightPos

		if anchorType and totalWidth < leftPos and (anchorType == "ANCHOR_LEFT" or anchorType == "ANCHOR_TOPLEFT" or anchorType == "ANCHOR_BOTTOMLEFT") then
			side = "left"
		elseif anchorType and totalWidth < rightDist and (anchorType == "ANCHOR_RIGHT" or anchorType == "ANCHOR_TOPRIGHT" or anchorType == "ANCHOR_BOTTOMRIGHT") then
			side = "right"
		elseif rightDist < leftPos then
			side = "left"
		else
			side = "right"
		end
	end

	-- See if we should slide the tooltip
	if anchorType and anchorType ~= "ANCHOR_PRESERVE" then
		if (side == "left") and (totalWidth > leftPos) then
			self:SetAnchorType(anchorType, (totalWidth - leftPos), 0)
		elseif (side == "right") and (rightPos + totalWidth) > GetScreenWidth() then
			self:SetAnchorType(anchorType, -((rightPos + totalWidth) - GetScreenWidth()), 0)
		end
	end

	if secondaryItemShown then
		shoppingTooltip2:SetOwner(self, "ANCHOR_NONE")
		shoppingTooltip2:ClearAllPoints()
		shoppingTooltip1:SetOwner(self, "ANCHOR_NONE")
		shoppingTooltip1:ClearAllPoints()

		if side and side == "left" then
			shoppingTooltip1:SetPoint("TOPRIGHT", anchorFrame, "TOPLEFT", -3, -10)
		else
			shoppingTooltip2:SetPoint("TOPLEFT", anchorFrame, "TOPRIGHT", 3, -10)
		end

		if side and side == "left" then
			shoppingTooltip2:SetPoint("TOPRIGHT", shoppingTooltip1, "TOPLEFT", -3, 0)
		else
			shoppingTooltip1:SetPoint("TOPLEFT", shoppingTooltip2, "TOPRIGHT", 3, 0)
		end
	else
		shoppingTooltip1:SetOwner(self, "ANCHOR_NONE")
		shoppingTooltip1:ClearAllPoints()

		if side and side == "left" then
			shoppingTooltip1:SetPoint("TOPRIGHT", anchorFrame, "TOPLEFT", -3, -10)
		else
			shoppingTooltip1:SetPoint("TOPLEFT", anchorFrame, "TOPRIGHT", 3, -10)
		end

		shoppingTooltip2:Hide()
	end

	-- We have to call this again because :SetOwner clears the tooltip.
	shoppingTooltip1:SetCompareItem(shoppingTooltip2, self)
	shoppingTooltip1:Show()
end)

----------------------------------------------------------------------------------------
--	Fix GameTooltipMoneyFrame font size
----------------------------------------------------------------------------------------
local function FixFont(self)
	for i = 1, 2 do
		if _G["GameTooltipMoneyFrame"..i] then
			_G["GameTooltipMoneyFrame"..i.."PrefixText"]:SetFontObject("GameTooltipText")
			_G["GameTooltipMoneyFrame"..i.."SuffixText"]:SetFontObject("GameTooltipText")
			_G["GameTooltipMoneyFrame"..i.."GoldButton"]:SetNormalFontObject("GameTooltipText")
			_G["GameTooltipMoneyFrame"..i.."SilverButton"]:SetNormalFontObject("GameTooltipText")
			_G["GameTooltipMoneyFrame"..i.."CopperButton"]:SetNormalFontObject("GameTooltipText")
		end
	end
	for i = 1, 2 do
		if _G["ItemRefTooltipMoneyFrame"..i] then
			_G["ItemRefTooltipMoneyFrame"..i.."PrefixText"]:SetFontObject("GameTooltipText")
			_G["ItemRefTooltipMoneyFrame"..i.."SuffixText"]:SetFontObject("GameTooltipText")
			_G["ItemRefTooltipMoneyFrame"..i.."GoldButton"]:SetNormalFontObject("GameTooltipText")
			_G["ItemRefTooltipMoneyFrame"..i.."SilverButton"]:SetNormalFontObject("GameTooltipText")
			_G["ItemRefTooltipMoneyFrame"..i.."CopperButton"]:SetNormalFontObject("GameTooltipText")
		end
	end
end

GameTooltip:HookScript("OnTooltipSetItem", FixFont)
ItemRefTooltip:HookScript("OnTooltipSetItem", FixFont)

----------------------------------------------------------------------------------------
--	Skin GameTooltip.ItemTooltip and EmbeddedItemTooltip
----------------------------------------------------------------------------------------
if not T.classic then
	GameTooltip.ItemTooltip.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	hooksecurefunc(GameTooltip.ItemTooltip.IconBorder, "SetVertexColor", function(self, r, g, b)
		self:GetParent().backdrop:SetBackdropBorderColor(r, g, b)
		self:SetTexture("")
	end)

	hooksecurefunc(GameTooltip.ItemTooltip.IconBorder, "Hide", function(self)
		self:GetParent().backdrop:SetBackdropBorderColor(unpack(C.media.border_color))
	end)

	GameTooltip.ItemTooltip:CreateBackdrop("Default")
	GameTooltip.ItemTooltip.backdrop:SetPoint("TOPLEFT", GameTooltip.ItemTooltip.Icon, "TOPLEFT", -2, 2)
	GameTooltip.ItemTooltip.backdrop:SetPoint("BOTTOMRIGHT", GameTooltip.ItemTooltip.Icon, "BOTTOMRIGHT", 2, -2)
	GameTooltip.ItemTooltip.Count:ClearAllPoints()
	GameTooltip.ItemTooltip.Count:SetPoint("BOTTOMRIGHT", GameTooltip.ItemTooltip.Icon, "BOTTOMRIGHT", 1, 0)
end

local reward = EmbeddedItemTooltip.ItemTooltip
local icon = reward.Icon
if icon then
	icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	reward:CreateBackdrop("Default")
	reward.backdrop:SetPoint("TOPLEFT", icon, "TOPLEFT", -2, 2)
	reward.backdrop:SetPoint("BOTTOMRIGHT", icon, "BOTTOMRIGHT", 2, -2)

	hooksecurefunc(reward.IconBorder, "SetVertexColor", function(self, r, g, b)
		self:GetParent().backdrop:SetBackdropBorderColor(r, g, b)
		self:SetTexture("")
	end)

	hooksecurefunc(reward.IconBorder, "Hide", function(self)
		self:GetParent().backdrop:SetBackdropBorderColor(unpack(C.media.border_color))
	end)
end

hooksecurefunc("GameTooltip_ShowProgressBar", function(tt)
	if not tt or tt:IsForbidden() or not tt.progressBarPool then return end

	local frame = tt.progressBarPool:GetNextActive()
	if (not frame or not frame.Bar) or frame.Bar.backdrop then return end

	local bar = frame.Bar
	local label = bar.Label
	if bar then
		bar:StripTextures()
		bar:CreateBackdrop("Transparent")
		bar:SetStatusBarTexture(C.media.texture)
		label:ClearAllPoints()
		label:SetPoint("CENTER", bar, 0, 0)
		label:SetDrawLayer("OVERLAY")
		label:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
	end
end)