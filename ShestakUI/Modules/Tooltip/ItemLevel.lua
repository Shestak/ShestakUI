local T, C, L, _ = unpack(select(2, ...))
if C.tooltip.enable ~= true or C.tooltip.average_lvl ~= true then return end

----------------------------------------------------------------------------------------
--	Equipped average item level(Cloudy Unit Info by Cloudyfa)
----------------------------------------------------------------------------------------
--- Variables
local currentUNIT, currentGUID
local GearDB = {}

local nextInspectRequest = 0
local lastInspectRequest = 0

local prefixColor = "|cffF9D700"
local detailColor = "|cffffffff"

local gearPrefix = STAT_AVERAGE_ITEM_LEVEL..": "

--- Create Frame
local f = CreateFrame("Frame", "CloudyUnitInfo")
f:RegisterEvent("UNIT_INVENTORY_CHANGED")
f:RegisterEvent("INSPECT_READY")

--- Set Unit Info
local function SetUnitInfo(gear)
	if not gear then return end

	local _, unit = GameTooltip:GetUnit()
	if (not unit) or (UnitGUID(unit) ~= currentGUID) then return end

	local gearLine
	for i = 2, GameTooltip:NumLines() do
		local line = _G["GameTooltipTextLeft" .. i]
		local text = line:GetText()

		if text and strfind(text, gearPrefix) then
			gearLine = line
		end
	end

	if gear then
		gear = prefixColor..gearPrefix..detailColor..gear

		if gearLine then
			gearLine:SetText(gear)
		else
			GameTooltip:AddLine(gear)
		end
	end

	GameTooltip:Show()
end

--- PVP Item Detect
local function IsPVPItem(link)
	local itemStats = GetItemStats(link)
	for stat in pairs(itemStats) do
		if stat == "ITEM_MOD_RESILIENCE_RATING_SHORT" or stat == "ITEM_MOD_PVP_POWER_SHORT" then
			return true
		end
	end

	return false
end

local upgrades = {
	["1"] = 8, ["373"] = 4, ["374"] = 8, ["375"] = 4, ["376"] = 4, ["377"] = 4,
	["379"] = 4, ["380"] = 4, ["446"] = 4, ["447"] = 8, ["452"] = 8, ["454"] = 4,
	["455"] = 8, ["457"] = 8, ["459"] = 4, ["460"] = 8, ["461"] = 12, ["462"] = 16,
	["466"] = 4, ["467"] = 8, ["469"] = 4, ["470"] = 8, ["471"] = 12, ["472"] = 16,
	["477"] = 4, ["478"] = 8, ["480"] = 8, ["492"] = 4, ["493"] = 8, ["495"] = 4,
	["496"] = 8, ["497"] = 12, ["498"] = 16, ["504"] = 12, ["505"] = 16, ["506"] = 20,
	["507"] = 24, ["530"] = 5, ["531"] = 10, ["535"] = 15, ["536"] = 30, ["537"] = 45
}

local legionUpgrades = {
	["664"] = 689, ["767"] = 685, ["768"] = 693, ["1735"] = 705, ["1736"] = 699, ["1738"] = 709,
	["1739"] = 703, ["1741"] = 713, ["1792"] = 699, ["1793"] = 703, ["1794"] = 695, ["1795"] = 700,
}

local function BOALevel(level, id)
	if level > 97 then
		if id == 133585 or id == 133595 or id == 133596 or id == 133597 or id == 133598 then
			level = 815 - (110 - level) * 10
		else
			level = 605 - (100 - level) * 5
		end
	elseif level > 90 then
		level = 590 - (97 - level) * 10
	elseif level > 85 then
		level = 463 - (90 - level) * 19.75
	elseif level > 80 then
		level = 333 - (85 - level) * 13.5
	elseif level > 67 then
		level = 187 - (80 - level) * 4
	elseif level > 57 then
		level = 105 - (67 - level) * 2.9
	elseif level > 5 then
		level = level + 5
	else
		level = 10
	end

	return floor(level + 0.5)
end

local timewarped = {
	["615"] = 660, -- Dungeon drops
	["692"] = 675, -- Timewarped badge vendors
	["656"] = 675, -- Warforged Dungeon drops
}

local itemLevelPattern = gsub(ITEM_LEVEL, "%%d", "(%%d+)")
local tooltipLines = {
	"ShestakUI_ItemScanningTooltipTextLeft2",
	"ShestakUI_ItemScanningTooltipTextLeft3",
	"ShestakUI_ItemScanningTooltipTextLeft4",
}
local tooltip = CreateFrame("GameTooltip", "ShestakUI_ItemScanningTooltip", UIParent, "GameTooltipTemplate")
tooltip:SetOwner(UIParent, "ANCHOR_NONE")

-- Scan tooltip for item level information
local function GetItemLevel(itemLink)
	if not itemLink or not GetItemInfo(itemLink) then
		return
	end

	tooltip:ClearLines()
	tooltip:SetHyperlink(itemLink)

	local text, itemLevel
	for index = 1, #tooltipLines do
		text = _G[tooltipLines[index]]:GetText()

		if text then
			itemLevel = tonumber(string.match(text, itemLevelPattern))
			if itemLevel then
				return itemLevel
			end
		end
	end
end

--- Unit Gear Info
local function UnitGear(unit)
	if (not unit) or (UnitGUID(unit) ~= currentGUID) then return end

	local ulvl = UnitLevel(unit)
	local class = select(2, UnitClass(unit))

	local ilvl, boa, pvp = 0, 0, 0
	local total, count, delay = 0, 16, nil
	local mainhand, offhand, twohand = 1, 1, 0

	for i = 1, 17 do
		if i ~= 4 then
			local itemTexture = GetInventoryItemTexture(unit, i)

			if itemTexture then
				local itemLink = GetInventoryItemLink(unit, i)

				if not itemLink then
					delay = true
				else
					local _, _, quality, level, _, _, _, _, slot = GetItemInfo(itemLink)

					if (not quality) or (not level) then
						delay = true
					else
						if quality == 7 then
							boa = boa + 1
							local id = tonumber(strmatch(itemLink, "item:(%d+)"))
							total = total + BOALevel(ulvl, id)
						else
							if IsPVPItem(itemLink) then
								pvp = pvp + 1
							end

							local tid = strmatch(itemLink, ".+:512:22.+:(%d+):100")
							if timewarped[tid] then
								level = timewarped[tid]
							end

							local uid = strmatch(itemLink, ".+:(%d+)")
							if upgrades[uid] then
								level = level + upgrades[uid]
							end

							local numBonusIDs = tonumber(strmatch(itemLink, ".+:%d+:512:%d*:(%d+).+"))
							if numBonusIDs then
								if numBonusIDs == 1 then
									local bid1, levelLootedAt = strmatch(itemLink, ".+:%d+:512:%d*:%d+:(%d+):(%d+).+")
									if levelLootedAt == "110" then
										levelLootedAt = levelLootedAt - 1
									end
									if legionUpgrades[bid1] == nil then
										level = GetItemLevel(itemLink) or level
										--print("|cffff0000WARNING: Unkhown item bonus ID: " .. bid1 .. ". Item: " .. itemLink)
										--print(itemLink)
										--local printable = gsub(itemLink, "\124", "\124\124");
										--ChatFrame1:AddMessage("Itemlink: \"" .. printable .. "\"");
									else
										level = legionUpgrades[bid1] + (levelLootedAt - 100) * 10
									end
								elseif numBonusIDs == 2 then
									local bid1, bid2, levelLootedAt = strmatch(itemLink, ".+:%d+:512:%d*:%d+:(%d+):(%d+):(%d+).+")
									if levelLootedAt == "110" then
										levelLootedAt = levelLootedAt - 1
									end
									if legionUpgrades[bid1] == nil then
										level = GetItemLevel(itemLink) or level
										--print("|cffff0000WARNING: Unkhown item bonus ID: " .. bid1 .. ". Item: " .. itemLink)
									elseif legionUpgrades[bid2] == nil then
										level = GetItemLevel(itemLink) or level
										--print("|cffff0000WARNING: Unkhown item bonus ID: " .. bid2 .. ". Item: " .. itemLink)
									else
										if legionUpgrades[bid1] > legionUpgrades[bid2] then
											level = legionUpgrades[bid1] + (levelLootedAt - 100) * 10
										else
											level = legionUpgrades[bid2] + (levelLootedAt - 100) * 10
										end
									end
								end
							end

							local artifact = tonumber(strmatch(itemLink, ".+:" .. ulvl .. ":%d+:(256):"))
							if artifact then
								level = GetItemLevel(itemLink) or level
							end

							total = total + level
						end

						if i >= 16 then
							if (slot == "INVTYPE_2HWEAPON") or (slot == "INVTYPE_RANGED") or ((slot == "INVTYPE_RANGEDRIGHT") and (class == "HUNTER")) then
								twohand = twohand + 1
							end
						end
					end
				end
			else
				if i == 16 then
					mainhand = 0
				elseif i == 17 then
					offhand = 0
				end
			end
		end
	end

	if (mainhand == 0) and (offhand == 0) or (twohand == 1) then
		count = count - 1
	end

	if not delay then
		if unit == "player" and GetAverageItemLevel() > 0 then
			_, ilvl = GetAverageItemLevel()
		else
			ilvl = total / count
		end

		if ilvl > 0 then ilvl = string.format("%.1f", ilvl) end
		if boa > 0 then ilvl = ilvl.."  |cffe6cc80"..boa.." "..HEIRLOOMS end
		if pvp > 0 then ilvl = ilvl.."  |cffa335ee"..pvp.." "..PVP end
	else
		ilvl = nil
	end

	return ilvl
end

--- Scan Current Unit
local function ScanUnit(unit, forced)
	local cachedGear

	if UnitIsUnit(unit, "player") then
		cachedGear = UnitGear("player")

		SetUnitInfo(cachedGear or CONTINUED)
	else
		if (not unit) or (UnitGUID(unit) ~= currentGUID) then return end

		cachedGear = GearDB[currentGUID]

		-- cachedGear? ok...skip get gear
		if cachedGear and not forced then
			SetUnitInfo(cachedGear)
		end

		if not (IsShiftKeyDown() or forced) then
			if UnitAffectingCombat("player") then return end
		end

		if not UnitIsVisible(unit) then return end
		if UnitIsDeadOrGhost("player") or UnitOnTaxi("player") then return end
		if InspectFrame and InspectFrame:IsShown() then return end

		-- Press SHIFT to refresh
		if IsShiftKeyDown() then
			SetUnitInfo(CONTINUED, CONTINUED)
		else
			SetUnitInfo(cachedGear or CONTINUED)
		end

		local timeSinceLastInspect = GetTime() - lastInspectRequest
		if timeSinceLastInspect >= 1.5 then
			nextInspectRequest = 0
		else
			nextInspectRequest = 1.5 - timeSinceLastInspect
		end
		f:Show()
	end
end

--- Character Info Sheet
hooksecurefunc("PaperDollFrame_SetItemLevel", function(self, unit)
	if unit ~= "player" then return end

	local total, equip = GetAverageItemLevel()
	if total > 0 then total = string.format("%.1f", total) end
	if equip > 0 then equip = string.format("%.1f", equip) end

	local ilvl = equip
	if equip ~= total then
		ilvl = equip.." / "..total
	end

	CharacterStatsPane.ItemLevelFrame.Value:SetText(ilvl)

	self.tooltip = detailColor..STAT_AVERAGE_ITEM_LEVEL.." "..ilvl
end)

--- Handle Events
f:SetScript("OnEvent", function(self, event, ...)
	if event == "UNIT_INVENTORY_CHANGED" then
		local unit = ...
		if UnitGUID(unit) == currentGUID then
			ScanUnit(unit, true)
		end
	elseif event == "INSPECT_READY" then
		local guid = ...
		if guid ~= currentGUID then return end

		local gear = UnitGear(currentUNIT)
		GearDB[currentGUID] = gear

		if not gear then
			ScanUnit(currentUNIT, true)
		else
			SetUnitInfo(gear)
		end
	end
end)

f:SetScript("OnUpdate", function(self, elapsed)
	nextInspectRequest = nextInspectRequest - elapsed
	if nextInspectRequest > 0 then return end

	self:Hide()

	if currentUNIT and (UnitGUID(currentUNIT) == currentGUID) then
		lastInspectRequest = GetTime()
		NotifyInspect(currentUNIT)
	end
end)

GameTooltip:HookScript("OnTooltipSetUnit", function(self)
	local _, unit = self:GetUnit()

	if (not unit) or (not CanInspect(unit)) then return end
	if (UnitLevel(unit) > 0) and (UnitLevel(unit) < 10) then return end

	currentUNIT, currentGUID = unit, UnitGUID(unit)
	ScanUnit(unit)
end)
