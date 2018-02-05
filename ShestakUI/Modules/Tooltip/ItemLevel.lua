local T, C, L, _ = unpack(select(2, ...))
if C.tooltip.enable ~= true or C.tooltip.average_lvl ~= true then return end

----------------------------------------------------------------------------------------
--	Equipped average item level(Cloudy Unit Info by Cloudyfa)
----------------------------------------------------------------------------------------
--- Variables
local currentUNIT, currentGUID
local GearDB, SpecDB, ItemDB = {}, {}, {}

local prefixColor = "|cffF9D700"
local detailColor = "|cffffffff"

local gearPrefix = STAT_AVERAGE_ITEM_LEVEL..": "

local furySpec = GetSpecializationNameForSpecID(72)

--- Create Frame
local f = CreateFrame("Frame", "CloudyUnitInfo")
f:RegisterEvent("UNIT_INVENTORY_CHANGED")

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

-- Tooltip and scanning by Phanx @ http://www.wowinterface.com/forums/showthread.php?p=271406
local S_ITEM_LEVEL = "^" .. gsub(ITEM_LEVEL, "%%d", "(%%d+)")

local scantip = CreateFrame("GameTooltip", "iLvlScanningTooltip", nil, "GameTooltipTemplate")
scantip:SetOwner(UIParent, "ANCHOR_NONE")

local function _getRealItemLevel(slotId, unit, link, forced)
	if (not forced) and ItemDB[link] then return ItemDB[link] end

	local realItemLevel
	local hasItem = scantip:SetInventoryItem(unit, slotId)
	if not hasItem then return nil end -- With this we don't get ilvl for offhand if we equip 2h weapon

	for i = 2, scantip:NumLines() do -- Line 1 is always the name so you can skip it.
		local text = _G["iLvlScanningTooltipTextLeft"..i]:GetText()
		if text and text ~= "" then
			realItemLevel = realItemLevel or strmatch(text, S_ITEM_LEVEL)

			if realItemLevel then
				ItemDB[link] = tonumber(realItemLevel)
				return tonumber(realItemLevel)
			end
		end
	end

	return realItemLevel
end

--- Unit Gear Info
local function UnitGear(unit)
	if (not unit) or (UnitGUID(unit) ~= currentGUID) then return end

	local class = select(2, UnitClass(unit))

	local ilvl, boa, pvp = 0, 0, 0
	local total, delay = 0, nil
	local wlvl, wslot = 0, 0

	for i = 1, 17 do
		if i ~= 4 then
			local id = GetInventoryItemID(unit, i)

			if id then
				local itemLink = GetInventoryItemLink(unit, i)

				if not itemLink then
					delay = true
				else
					local _, _, quality, level, _, _, _, _, slot = GetItemInfo(itemLink)

					if (not quality) or (not level) then
						delay = true
					else
						if (quality == 6) and (i == 16 or i == 17) then
							local relics = {select(4, strsplit(":", itemLink))}
							for i = 1, 3 do
								local relicID = relics[i] ~= "" and relics[i]
								local relicLink = select(2, GetItemGem(itemLink, i))
								if relicID and not relicLink then
									delay = true
									break
								end
							end
							level = _getRealItemLevel(i, unit, itemLink, true) or level
							if level >= 900 and ScannedGUID ~= UnitGUID('player') then
								level = level + 15
							end	
						elseif quality == 7 then
							level = _getRealItemLevel(i, unit, itemLink) or level
							boa = boa + 1
						else
							level = _getRealItemLevel(i, unit, itemLink) or level
							if IsPVPItem(itemLink) then
								pvp = pvp + 1
							end
						end

						if i == 16 then
							if (SpecDB[currentGUID] == furySpec) or (quality == 6) then
								wlvl = level
								wslot = slot
							end
							if (slot == "INVTYPE_2HWEAPON") or (slot == "INVTYPE_RANGED") or ((slot == "INVTYPE_RANGEDRIGHT") and (class == "HUNTER")) then
								level = level * 2
							end
						end

						if i == 17 then
							if SpecDB[currentGUID] == furySpec then
								if (wslot ~= "INVTYPE_2HWEAPON") and (slot == "INVTYPE_2HWEAPON") then
									if (level > wlvl) then
										level = level * 2 - wlvl
									end
								elseif (wslot == "INVTYPE_2HWEAPON") then
									if (level > wlvl) then
										if (slot == "INVTYPE_2HWEAPON") then
											level = level * 2 - wlvl * 2
										else
											level = level - wlvl
										end
									else
										level = 0
									end
								end
							elseif quality == 6 and wlvl then
								if level > wlvl then
									level = level * 2 - wlvl
								else
									level = wlvl
								end
							end
						end

						total = total + level
					end
				end
			end
		end
	end

	if not delay then
		if unit == "player" and GetAverageItemLevel() > 0 then
			_, ilvl = GetAverageItemLevel()
		else
			ilvl = total / 16
		end

		if ilvl > 0 then ilvl = string.format("%.1f", ilvl) end
		if boa > 0 then ilvl = ilvl.."  |cffe6cc80"..boa.." "..HEIRLOOMS end
		if pvp > 0 then ilvl = ilvl.."  |cffa335ee"..pvp.." "..PVP end
	else
		ilvl = nil
	end

	return ilvl
end

--- Unit Specialization
local function UnitSpec(unit)
	if (not unit) or (UnitGUID(unit) ~= currentGUID) then return end

	local specName
	if (unit == "player") then
		local specIndex = GetSpecialization()
		if specIndex then
			specName = select(2, GetSpecializationInfo(specIndex))
		end
	else
		local specID = GetInspectSpecialization(unit)
		if specID and (specID > 0) then
			specName = GetSpecializationNameForSpecID(specID)
		end
	end

	return specName
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

		local lastRequest = GetTime() - (f.lastUpdate or 0)
		if (lastRequest >= 1.5) then
			f.nextUpdate = 0
		else
			f.nextUpdate = 1.5 - lastRequest
		end
		f:Show()
	end
end

--- Character Info Sheet
MIN_PLAYER_LEVEL_FOR_ITEM_LEVEL_DISPLAY = 1
hooksecurefunc("PaperDollFrame_SetItemLevel", function(self, unit)
	if unit ~= "player" then return end

	local total, equip = GetAverageItemLevel()
	if total > 0 then total = string.format("%.1f", total) end
	if equip > 0 then equip = string.format("%.1f", equip) end

	local ilvl = equip
	if equip ~= total then
		ilvl = equip.." / "..total
	end

	self.Value:SetText(ilvl)

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
		if guid == currentGUID then
			local spec = UnitSpec(currentUNIT)
			SpecDB[guid] = spec

			local gear = UnitGear(currentUNIT)
			GearDB[guid] = gear

			if (not gear) or (not spec) then
				ScanUnit(currentUNIT, true)
			else
				SetUnitInfo(gear, spec)
			end
		end
		self:UnregisterEvent("INSPECT_READY")
	end
end)

f:SetScript("OnUpdate", function(self, elapsed)
	self.nextUpdate = (self.nextUpdate or 0) - elapsed
	if (self.nextUpdate > 0) then return end

	self:Hide()
	ClearInspectPlayer()

	if currentUNIT and (UnitGUID(currentUNIT) == currentGUID) then
		self.lastUpdate = GetTime()
		self:RegisterEvent("INSPECT_READY")
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