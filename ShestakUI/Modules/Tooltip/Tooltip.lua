local T, C, L = unpack(select(2, ...))
if C.tooltip.enable ~= true then return end

----------------------------------------------------------------------------------------
--	Based on aTooltip(by ALZA)
----------------------------------------------------------------------------------------
local tooltips = {
	GameTooltip,
	ItemRefTooltip,
	ShoppingTooltip1,
	ShoppingTooltip2,
	ShoppingTooltip3,
	WorldMapTooltip,
	WorldMapCompareTooltip1,
	WorldMapCompareTooltip2,
	WorldMapCompareTooltip3,
	FriendsTooltip,
	ConsolidatedBuffsTooltip,
	AtlasLootTooltip,
	QuestHelperTooltip,
	QuestGuru_QuestWatchTooltip,
	ItemRefShoppingTooltip1,
	ItemRefShoppingTooltip2,
	ItemRefShoppingTooltip3
}

for _, tt in pairs(tooltips) do
	if not IsAddOnLoaded("Aurora") then
		tt:SetTemplate("Transparent")
		tt:HookScript("OnShow", function(self)
			self:SetBackdropColor(unpack(C.media.overlay_color))
			self:SetBackdropBorderColor(unpack(C.media.border_color))
		end)
	end
end

local anchor = CreateFrame("Frame", "TooltipAnchor", UIParent)
anchor:SetSize(200, 40)
anchor:SetPoint(unpack(C.position.tooltip))

-- Hide PVP text
PVP_ENABLED = ""

-- Statusbar
GameTooltipStatusBar:SetStatusBarTexture(C.media.texture)
GameTooltipStatusBar:Height(4)
GameTooltipStatusBar:ClearAllPoints()
GameTooltipStatusBar:Point("TOPLEFT", GameTooltip, "BOTTOMLEFT", 2, 6)
GameTooltipStatusBar:Point("TOPRIGHT", GameTooltip, "BOTTOMRIGHT", -2, 6)

-- Raid icon
local ricon = GameTooltip:CreateTexture("GameTooltipRaidIcon", "OVERLAY")
ricon:Height(18)
ricon:Width(18)
ricon:Point("BOTTOM", "GameTooltip", "TOP", 0, 5)

GameTooltip:HookScript("OnHide", function(self)
	ricon:SetTexture(nil)
end)

-- Add "Targeted By" line
local targetedList = {}
local ClassColors = {}
local token
for class, color in next, RAID_CLASS_COLORS do
	ClassColors[class] = ("|cff%.2x%.2x%.2x"):format(color.r*255,color.g*255,color.b*255)
end

local function AddTargetedBy()
	local numParty, numRaid = GetNumPartyMembers(), GetNumRaidMembers()
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
aTooltip = CreateFrame("Frame", "aTooltip", UIParent)
aTooltip:RegisterEvent("ADDON_LOADED")
aTooltip:SetScript("OnEvent", function(self, event, addon)
	if addon == "QuestHelper" then self.QH_found = true end
	if addon ~= "ShestakUI" then return end

	local function GameTooltipDefault(tooltip, parent)
		if C.tooltip.cursor == true then
			tooltip:SetOwner(parent, "ANCHOR_CURSOR")
		else
			tooltip:SetOwner(parent, "ANCHOR_NONE")
			tooltip:ClearAllPoints()
			tooltip:Point("BOTTOMRIGHT", TooltipAnchor, "BOTTOMRIGHT", 0, 0)
			tooltip.default = 1
		end
	end
	hooksecurefunc("GameTooltip_SetDefaultAnchor", GameTooltipDefault)

	if C.tooltip.shift_modifer == true then
		local ShiftShow = function()
			if IsShiftKeyDown() then
				GameTooltip:Show()
				GameTooltip:SetBackdropColor(unpack(C.media.overlay_color))
				GameTooltip:SetBackdropBorderColor(unpack(C.media.border_color))
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
				GameTooltip:SetBackdropColor(unpack(C.media.overlay_color))
				GameTooltip:SetBackdropBorderColor(unpack(C.media.border_color))
			elseif arg1 == "LSHIFT" and arg2 == 0 then
				GameTooltip:Hide()
			end
		end
		local sh = CreateFrame("Frame")
		sh:RegisterEvent("MODIFIER_STATE_CHANGED")
		sh:SetScript("OnEvent", EventShow)
	else
		if C.tooltip.cursor == true then
			hooksecurefunc("GameTooltip_SetDefaultAnchor", function(GameTooltip, parent)
				if InCombatLockdown() and C.tooltip.hide_combat and not IsShiftKeyDown() then
					GameTooltip:Hide()
				else
					GameTooltip:SetOwner(parent,"ANCHOR_CURSOR")
				end
			end)
		else
			hooksecurefunc("GameTooltip_SetDefaultAnchor", function(self)
				if InCombatLockdown() and C.tooltip.hide_combat and not IsShiftKeyDown() then
					GameTooltip:Hide()
				else
					self:Point("BOTTOMRIGHT", TooltipAnchor, "BOTTOMRIGHT", 0, 0)
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
			local unit = select(2, GameTooltip:GetUnit())
			if unit then
				min, max = UnitHealth(unit), UnitHealthMax(unit)
				if not self.text then
					self.text = self:CreateFontString(nil, "OVERLAY", "Tooltip_Med")
					self.text:Point("CENTER", GameTooltipStatusBar, 0, 1.5)
					self.text:SetShadowColor(0, 0, 0, 1)
					self.text:SetShadowOffset(1, -1)
				end
				self.text:Show()
				local hp = T.ShortValue(min).." / "..T.ShortValue(max)
				self.text:SetText(hp)
			end
		end)
	end

	local OnTooltipSetUnit = function(self)
		local lines = self:NumLines()
		local name, unit = self:GetUnit()

		if not unit then return end

		local race = UnitRace(unit)
		local level = UnitLevel(unit)
		local levelColor = GetQuestDifficultyColor(level)
		local classification = UnitClassification(unit)
		local creatureType = UnitCreatureType(unit)

		if level and level == -1 then
			if classification == "worldboss" then
				level = "|cffff0000|r"..BOSS
			else
				level = "|cffff0000??|r"
			end
		end

		if classification == "rareelite" then classification = " R+"
		elseif classification == "rare" then classification = " R"
		elseif classification == "elite" then classification = "+"
		else classification = "" end

		if not C.tooltip.title then _G["GameTooltipTextLeft1"]:SetText(name) end

		if UnitIsPlayer(unit) then
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
			_G["GameTooltipTextLeft"..n]:SetFormattedText("|cff%02x%02x%02x%s|r %s", levelColor.r * 255, levelColor.g * 255, levelColor.b * 255, level, race)
		else
			for i = 2, lines do
				local line = _G["GameTooltipTextLeft"..i]
				if not line or not line:GetText() then return end -- damn QuestHelper!
				if (level and line:GetText():find("^"..LEVEL)) or (creatureType and line:GetText():find("^"..creatureType)) then
					local r, g, b = GameTooltip_UnitColor(unit)
					line:SetFormattedText("|cff%02x%02x%02x%s%s|r %s", levelColor.r * 255, levelColor.g * 255, levelColor.b * 255, level, classification, creatureType or "")
					break
				end
			end
		end

		if C.tooltip.target == true and UnitExists(unit.."target") then
			local r, g, b = GameTooltip_UnitColor(unit.."target")
			local text = ""

			if UnitIsEnemy("player", unit.."target") then
				r, g, b = 1, 0, 0
			elseif not UnitIsFriend("player", unit.."target") then
				r, g, b = 1, 1, 0
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
end)

function GameTooltip_UnitColor(unit)
	if not unit then return end
	local r, g, b

	if UnitIsPlayer(unit) then
		local _, class = UnitClass(unit)
		r, g, b = RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b
	elseif UnitIsTapped(unit) and not UnitIsTappedByPlayer(unit) or UnitIsDead(unit) then
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

----------------------------------------------------------------------------------------
--	Adds guild rank to tooltips(GuildRank by Meurtcriss)
----------------------------------------------------------------------------------------
if C.tooltip.rank == true then
	local GTT = GameTooltip
	-- HOOK: OnTooltipSetUnit
	GTT:HookScript("OnTooltipSetUnit", function(self, ...)
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
--	Hide tooltips in combat for action bars, pet bar and shapeshift bar
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
--	Fix compare tooltips(by Elv22)
----------------------------------------------------------------------------------------
hooksecurefunc("GameTooltip_ShowCompareItem", function(self, shift)
	if not self then
		self = GameTooltip
	end
	local item, link = self:GetItem()
	if not link then return end

	local shoppingTooltip1, shoppingTooltip2, shoppingTooltip3 = unpack(self.shoppingTooltips)

	local item1 = nil
	local item2 = nil
	local item3 = nil
	local side = "left"
	if shoppingTooltip1:SetHyperlinkCompareItem(link, 1, shift, self) then
		item1 = true
	end
	if shoppingTooltip2:SetHyperlinkCompareItem(link, 2, shift, self) then
		item2 = true
	end
	if shoppingTooltip3:SetHyperlinkCompareItem(link, 3, shift, self) then
		item3 = true
	end

	-- Find correct side
	local rightDist = 0
	local leftPos = self:GetLeft()
	local rightPos = self:GetRight()
	if not rightPos then
		rightPos = 0
	end
	if not leftPos then
		leftPos = 0
	end

	rightDist = GetScreenWidth() - rightPos

	if leftPos and (rightDist < leftPos) then
		side = "left"
	else
		side = "right"
	end

	-- See if we should slide the tooltip
	if self:GetAnchorType() and self:GetAnchorType() ~= "ANCHOR_PRESERVE" then
		local totalWidth = 0

		if item1 then
			totalWidth = totalWidth + shoppingTooltip1:GetWidth()
		end
		if item2 then
			totalWidth = totalWidth + shoppingTooltip2:GetWidth()
		end
		if item3 then
			totalWidth = totalWidth + shoppingTooltip3:GetWidth()
		end

		if side == "left" and totalWidth > leftPos then
			self:SetAnchorType(self:GetAnchorType(), totalWidth - leftPos, 0)
		elseif side == "right" and (rightPos + totalWidth) > GetScreenWidth() then
			self:SetAnchorType(self:GetAnchorType(), -((rightPos + totalWidth) - GetScreenWidth()), 0)
		end
	end

	-- Anchor the compare tooltips
	if item3 then
		shoppingTooltip3:SetOwner(self, "ANCHOR_NONE")
		shoppingTooltip3:ClearAllPoints()
		if side and side == "left" then
			shoppingTooltip3:Point("TOPRIGHT", self, "TOPLEFT", -3, -10)
		else
			shoppingTooltip3:Point("TOPLEFT", self, "TOPRIGHT", 3, -10)
		end
		shoppingTooltip3:SetHyperlinkCompareItem(link, 3, shift, self)
		shoppingTooltip3:Show()
	end

	if item1 then
		if item3 then
			shoppingTooltip1:SetOwner(shoppingTooltip3, "ANCHOR_NONE")
		else
			shoppingTooltip1:SetOwner(self, "ANCHOR_NONE")
		end
		shoppingTooltip1:ClearAllPoints()
		if side and side == "left" then
			if item3 then
				shoppingTooltip1:Point("TOPRIGHT", shoppingTooltip3, "TOPLEFT", -3, 0)
			else
				shoppingTooltip1:Point("TOPRIGHT", self, "TOPLEFT", -3, -10)
			end
		else
			if item3 then
				shoppingTooltip1:Point("TOPLEFT", shoppingTooltip3, "TOPRIGHT", 3, 0)
			else
				shoppingTooltip1:Point("TOPLEFT", self, "TOPRIGHT", 3, -10)
			end
		end
		shoppingTooltip1:SetHyperlinkCompareItem(link, 1, shift, self)
		shoppingTooltip1:Show()

		if item2 then
			shoppingTooltip2:SetOwner(shoppingTooltip1, "ANCHOR_NONE")
			shoppingTooltip2:ClearAllPoints()
			if side and side == "left" then
				shoppingTooltip2:Point("TOPRIGHT", shoppingTooltip1, "TOPLEFT", -3, 0)
			else
				shoppingTooltip2:Point("TOPLEFT", shoppingTooltip1, "TOPRIGHT", 3, 0)
			end
			shoppingTooltip2:SetHyperlinkCompareItem(link, 2, shift, self)
			shoppingTooltip2:Show()
		end
	end
end)

----------------------------------------------------------------------------------------
--	Proper color for world objects tooltip
----------------------------------------------------------------------------------------
local function BackdropFix(self)
	if self:GetAnchorType() == "ANCHOR_CURSOR" and self:IsOwned(UIParent) and not self:GetUnit() then
		self:SetBackdropColor(unpack(C.media.overlay_color))
	end
end

if C.tooltip.cursor ~= true and C.tooltip.shift_modifer ~= true then 
	GameTooltip:HookScript("OnUpdate", BackdropFix)
end