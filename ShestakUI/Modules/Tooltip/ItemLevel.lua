local T, C, L, _ = unpack(select(2, ...))
if C.tooltip.enable ~= true or C.tooltip.average_lvl ~= true then return end

----------------------------------------------------------------------------------------
--	Equipped average item level(Cloudy Unit Info by Cloudyfa)
----------------------------------------------------------------------------------------
--- Variables ---
local currentUNIT, currentGUID
local GearDB, SpecDB = {}, {}

local nextInspectRequest = 0
local lastInspectRequest = 0

local prefixColor = '|cffF9D700'
local detailColor = '|cffffffff'

local gearPrefix = STAT_AVERAGE_ITEM_LEVEL .. ': '
local specPrefix = SPECIALIZATION .. ': '
local _

--- Create Frame ---
local f = CreateFrame('Frame', 'CloudyUnitInfo')
f:RegisterEvent('UNIT_INVENTORY_CHANGED')
f:RegisterEvent('INSPECT_READY')


--- Set Unit Info ---
local function SetUnitInfo(gear, spec)
	if (not gear) and (not spec) then return end

	local _, unit = GameTooltip:GetUnit()
	if (not unit) or (UnitGUID(unit) ~= currentGUID) then return end

	local gearLine, specLine
	for i = 2, GameTooltip:NumLines() do
		local line = _G['GameTooltipTextLeft' .. i]
		local text = line:GetText()

		if text and strfind(text, gearPrefix) then
			gearLine = line
		elseif text and strfind(text, specPrefix) then
			specLine = line
		end
	end

	if gear then
		gear = prefixColor .. gearPrefix .. detailColor .. gear

		if gearLine then
			gearLine:SetText(gear)
		else
			GameTooltip:AddLine(gear)
		end
	end

	if spec then
		spec = prefixColor .. specPrefix .. detailColor .. spec

		if specLine then
			specLine:SetText(spec)
		else
			GameTooltip:AddLine(spec)
		end
	end

	GameTooltip:Show()
end

--- PVP Item Detect ---
local function IsPVPItem(link)
	local itemStats = GetItemStats(link)
	for stat in pairs(itemStats) do
		if (stat == 'ITEM_MOD_RESILIENCE_RATING_SHORT') or (stat == 'ITEM_MOD_PVP_POWER_SHORT') then
			return true
		end
	end

	return false
end

-- iLevel retrieval
local S_ITEM_LEVEL = "^" .. gsub(ITEM_LEVEL, "%%d", "(%%d+)")
local scantip = CreateFrame("GameTooltip", "ItemLevelScanTooltip", nil, "GameTooltipTemplate")
scantip:SetOwner(UIParent, "ANCHOR_NONE")

local function GetItemLevel(itemLink)
	scantip:SetOwner(UIParent, "ANCHOR_NONE")
	scantip:SetHyperlink(itemLink)
	for i = 2, scantip:NumLines() do -- Line 1 = name so skip
		local text = _G["ItemLevelScanTooltipTextLeft"..i]:GetText()
		if text and text ~= "" then
			local currentLevel = strmatch(text, S_ITEM_LEVEL)
			if currentLevel then
				return currentLevel
			end
		end
	end
	scantip:Hide()
end

--- Unit Gear Info ---
local function UnitGear(unit)
	if (not unit) or (UnitGUID(unit) ~= currentGUID) then return end

	local ulvl = UnitLevel(unit)
	local class = select(2, UnitClass(unit))

	local ilvl, boa, pvp = 0, 0, 0
	local total, count, delay = 0, 16, nil
	local mainhand, offhand, twohand = 1, 1, 0

	for i = 1, 17 do
		if (i ~= 4) then
			local itemTexture = GetInventoryItemTexture(unit, i)

			if itemTexture then
				local itemLink = GetInventoryItemLink(unit, i)

				if (not itemLink) then
					delay = true
				else
					local _, _, quality, level, _, _, _, _, slot = GetItemInfo(itemLink)
					
					if (not quality) or (not level) then
						delay = true
					else
						local currentLevel = GetItemLevel(itemLink)
						if currentLevel then
							total = total + currentLevel
						else
							total = total + level
						end
						
						if quality == 7 then
							boa = boa + 1
						else
							if IsPVPItem(itemLink) then
								pvp = pvp + 1
							end
						end

						if (i >= 16) then
							if (slot == 'INVTYPE_2HWEAPON') or (slot == 'INVTYPE_RANGED') or ((slot == 'INVTYPE_RANGEDRIGHT') and (class == 'HUNTER')) then
								twohand = twohand + 1
							end
						end
					end
				end
			else
				if (i == 16) then
					mainhand = 0
				elseif (i == 17) then
					offhand = 0
				end
			end
		end
	end

	if (mainhand == 0) and (offhand == 0) or (twohand == 1) then
		count = count - 1
	end

	if (not delay) then
		if (unit == 'player') and (GetAverageItemLevel() > 0) then
			_, ilvl = GetAverageItemLevel()
		else
			ilvl = total / count
		end

		if (ilvl > 0) then ilvl = string.format('%.1f', ilvl) end
		if (boa > 0) then ilvl = ilvl .. '  |cffe6cc80' .. boa .. ' ' .. HEIRLOOMS end
		if (pvp > 0) then ilvl = ilvl .. '  |cffa335ee' .. pvp .. ' ' .. PVP end
	else
		ilvl = nil
	end

	return ilvl
end


--- Unit Specialization ---
local function UnitSpec(unit)
	if (not unit) or (UnitGUID(unit) ~= currentGUID) then return end

	local specName

	if (unit == 'player') then
		local specIndex = GetSpecialization()

		if specIndex then
			_, specName = GetSpecializationInfo(specIndex)
		else
			specName = NONE
		end
	else
		local specID = GetInspectSpecialization(unit)

		if specID and (specID > 0) then
			_, specName = GetSpecializationInfoByID(specID)
		elseif (specID == 0) then
			specName = NONE
		end
	end

	return specName
end


--- Scan Current Unit ---
local function ScanUnit(unit, forced)
	local cachedGear, cachedSpec

	if UnitIsUnit(unit, 'player') then
		cachedGear = UnitGear('player')
		cachedSpec = UnitSpec('player')

		SetUnitInfo(cachedGear or CONTINUED, cachedSpec or CONTINUED)
	else
		if (not unit) or (UnitGUID(unit) ~= currentGUID) then return end

		cachedGear = GearDB[currentGUID]
		--cachedSpec = SpecDB[currentGUID]
		--always to get spec
		cachedSpec = UnitSpec('player')

		--cachedGear? ok...skip get gear
		if cachedGear and not forced then
			SetUnitInfo(cachedGear, cachedSpec or CONTINUED)
		end

		if not (IsShiftKeyDown() or forced) then
			if UnitAffectingCombat('player') then return end
		end

		if (not UnitIsVisible(unit)) then return end
		if UnitIsDeadOrGhost('player') or UnitOnTaxi('player') then return end
		if InspectFrame and InspectFrame:IsShown() then return end
		
		--press shift To refresh
		if IsShiftKeyDown() then
			SetUnitInfo(CONTINUED, CONTINUED)
		else
			SetUnitInfo(cachedGear or CONTINUED, cachedSpec or CONTINUED)
		end

		local timeSinceLastInspect = GetTime() - lastInspectRequest
		if (timeSinceLastInspect >= 1.5) then
			nextInspectRequest = 0
		else
			nextInspectRequest = 1.5 - timeSinceLastInspect
		end
		f:Show()
	end
end


--- Character Info Sheet ---
hooksecurefunc('PaperDollFrame_SetItemLevel', function(self, unit)
	if (unit ~= 'player') then return end

	local total, equip = GetAverageItemLevel()
	if (total > 0) then total = string.format('%.1f', total) end
	if (equip > 0) then equip = string.format('%.1f', equip) end

	local ilvl = equip
	if (equip ~= total) then
		ilvl = equip .. ' / ' .. total
	end

	local ilvlLine = _G[self:GetName() .. 'StatText']
	ilvlLine:SetText(ilvl)

	self.tooltip = detailColor .. STAT_AVERAGE_ITEM_LEVEL .. ' ' .. ilvl
end)


--- Handle Events ---
f:SetScript('OnEvent', function(self, event, ...)
	if (event == 'UNIT_INVENTORY_CHANGED') then
		local unit = ...
		if (UnitGUID(unit) == currentGUID) then
			ScanUnit(unit, true)
		end
	elseif (event == 'INSPECT_READY') then
		local guid = ...
		if (guid ~= currentGUID) then return end

		local gear = UnitGear(currentUNIT)
		GearDB[currentGUID] = gear

		local spec = UnitSpec(currentUNIT)
		SpecDB[currentGUID] = spec

		if (not gear) or (not spec) then
			ScanUnit(currentUNIT, true)
		else
			SetUnitInfo(gear, spec)
		end
	end
end)

f:SetScript('OnUpdate', function(self, elapsed)
	nextInspectRequest = nextInspectRequest - elapsed
	if (nextInspectRequest > 0) then return end

	self:Hide()

	if currentUNIT and (UnitGUID(currentUNIT) == currentGUID) then
		lastInspectRequest = GetTime()
		NotifyInspect(currentUNIT)
	end
end)

GameTooltip:HookScript('OnTooltipSetUnit', function(self)
	local _, unit = self:GetUnit()

	if (not unit) or (not CanInspect(unit)) then return end
	if (UnitLevel(unit) > 0) and (UnitLevel(unit) < 10) then return end

	currentUNIT, currentGUID = unit, UnitGUID(unit)
	ScanUnit(unit)
end)
