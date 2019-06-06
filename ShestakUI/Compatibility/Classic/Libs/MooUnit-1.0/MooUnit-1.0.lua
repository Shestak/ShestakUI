if not IsClassicBuild() then return end

--[[--------------------------------------------------------------------
    Copyright (C) 2012 Sidoine De Wispelaere.
    Copyright (C) 2012, 2013, 2015, 2018 Johnny C. Lam.
    See the file LICENSE.txt for copying permission.
--]]--------------------------------------------------------------------

local MAJOR, MINOR = "MooUnit-1.0", 6
assert(LibStub, MAJOR .. " requires LibStub")
assert(LibStub("CallbackHandler-1.0", true), MAJOR .. " requires CallbackHandler-1.0")
local lib, oldminor = LibStub:NewLibrary(MAJOR, MINOR)
if not lib then return end

------------------------------------------------------------------------

local assert = assert
local floor = math.floor
local format = string.format
local ipairs = ipairs
local next = next
local pairs = pairs
local setmetatable = setmetatable
local strfind = string.find
local strjoin = strjoin
local strmatch = string.match
local tinsert = table.insert
local tonumber = tonumber
local tostring = tostring
local tostringall = tostringall
local tremove = table.remove
local type = type
local unpack = unpack
local wipe = wipe
-- GLOBALS: _G
-- GLOBALS: GetAddOnMetadata
local FONT_COLOR_CODE_CLOSE = FONT_COLOR_CODE_CLOSE
local GREEN_FONT_COLOR_CODE = GREEN_FONT_COLOR_CODE
local NORMAL_FONT_COLOR_CODE = NORMAL_FONT_COLOR_CODE
local MAX_ARENA_MEMBERS = 5
local MAX_BOSS_FRAMES = MAX_BOSS_FRAMES
local MAX_PARTY_MEMBERS = MAX_PARTY_MEMBERS
local MAX_RAID_MEMBERS = MAX_RAID_MEMBERS

--[[--------------------------------------------------------------------
    Debugging code from LibResInfo-1.0 by Phanx.
    https://github.com/Phanx/LibResInfo
--]]--------------------------------------------------------------------

local isAddon = GetAddOnMetadata(MAJOR, "Version")

local DEBUG_LEVEL = isAddon and 2 or 0
local DEBUG_FRAME = ChatFrame3

local function debug(level, text, ...)
	if level <= DEBUG_LEVEL then
		if ... then
			if type(text) == "string" and strfind(text, "%%[dfqsx%d%.]") then
				text = format(text, ...)
			else
				text = strjoin(" ", tostringall(text, ...))
			end
		else
			text = tostring(text)
		end
		DEBUG_FRAME:AddMessage(GREEN_FONT_COLOR_CODE .. MAJOR .. FONT_COLOR_CODE_CLOSE .. " " .. text)
	end
end

if isAddon then
	-- GLOBALS: SLASH_MOOUNIT1
	-- GLOBALS: SlashCmdList
	SLASH_MOOUNIT1 = "/moounit"
	SlashCmdList.MOOUNIT = function(input)
		input = tostring(input or "")

		local CURRENT_CHAT_FRAME
		for i = 1, 10 do
			local cf = _G["ChatFrame"..i]
			if cf and cf:IsVisible() then
				CURRENT_CHAT_FRAME = cf
				break
			end
		end

		local of = DEBUG_FRAME
		DEBUG_FRAME = CURRENT_CHAT_FRAME

		if strmatch(input, "^%s*[0-9]%s*$") then
			local v = tonumber(input)
			debug(0, "Debug level set to", input)
			DEBUG_LEVEL = v
			DEBUG_FRAME = of
			return
		end

		local f = _G[input]
		if type(f) == "table" and type(f.AddMessage) == "function" then
			debug(0, "Debug frame set to", input)
			DEBUG_FRAME = f
			return
		end

		debug(0, "Version " .. MINOR .. " loaded. Usage:")
		debug(0, format("%s%s %s%s - change debug verbosity, valid range is 0-6",
			NORMAL_FONT_COLOR_CODE, SLASH_MOOUNIT1, DEBUG_LEVEL, FONT_COLOR_CODE_CLOSE))
		debug(0, format("%s%s %s%s -- change debug output frame",
			NORMAL_FONT_COLOR_CODE, SLASH_MOOUNIT1, of:GetName(), FONT_COLOR_CODE_CLOSE))

		DEBUG_FRAME = of
	end
end

------------------------------------------------------------------------
-- Simple table pool, preserved across library upgrades.
local pool = lib.pool or {}
lib.pool = pool

local function newTable()
	return tremove(pool) or {}
end

local function removeTable(t)
	tinsert(pool, t)
end

------------------------------------------------------------------------

local callbacks = lib.callbacks or LibStub("CallbackHandler-1.0"):New(lib)
lib.callbacks = callbacks
lib.callbacksInUse = lib.callbacksInUse or {}

local eventFrame = lib.eventFrame or CreateFrame("Frame")
lib.eventFrame = eventFrame
eventFrame:UnregisterAllEvents()

eventFrame:SetScript("OnEvent", function(self, event, ...)
	return self[event] and self[event](self, event, ...)
end)

function callbacks:OnUsed(lib, callback)
	if not next(lib.callbacksInUse) then
		debug(1, "Callbacks in use! Starting up...")
		eventFrame:RegisterEvent("ARENA_OPPONENT_UPDATE")
		eventFrame:RegisterEvent("FORBIDDEN_NAME_PLATE_UNIT_ADDED")
		eventFrame:RegisterEvent("FORBIDDEN_NAME_PLATE_UNIT_REMOVED")
		eventFrame:RegisterEvent("GROUP_ROSTER_UPDATE")
		eventFrame:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT")
		eventFrame:RegisterEvent("NAME_PLATE_UNIT_ADDED")
		eventFrame:RegisterEvent("NAME_PLATE_UNIT_REMOVED")
		eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
		eventFrame:RegisterEvent("PLAYER_FOCUS_CHANGED")
		eventFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
		eventFrame:RegisterEvent("UNIT_NAME_UPDATE")
		eventFrame:RegisterEvent("UNIT_PET")
		eventFrame:RegisterEvent("UNIT_PORTRAIT_UPDATE")
		eventFrame:RegisterEvent("UNIT_TARGET")
	end
	lib.callbacksInUse[callback] = true
end

function callbacks:OnUnused(lib, callback)
	lib.callbacksInUse[callback] = nil
	if not next(lib.callbacksInUse) then
		debug(1, "No callbacks in use. Shutting down...")
		eventFrame:UnregisterAllEvents()
	end
end

------------------------------------------------------------------------

-- Preserve mappings across library upgrades.
local guidByUnit = lib.guidByUnit or {} -- a unit ID has one GUID
local unitByGUID = lib.unitByGUID or {} -- a GUID can have multiple unit IDs
local nameByUnit = lib.nameByUnit or {} -- a unit ID has one name
local unitByName = lib.unitByName or {} -- a name can have multiple unit IDs
local nameByGUID = lib.nameByGUID or {} -- a GUID has one name
local guidByName = lib.guidByName or {} -- a name can have multiple GUIDs
local roster = lib.roster or {} -- roster[guid] = unit if the GUID is on the group roster
local ownerGUIDByGUID = lib.ownerGUIDByGUID or lib.ownerByGUID or {} -- a GUID can have one owner

lib.guidByUnit = guidByUnit
lib.unitByGUID = unitByGUID
lib.nameByUnit = nameByUnit
lib.unitByName = unitByName
lib.nameByGUID = nameByGUID
lib.guidByName = guidByName
lib.roster = roster
lib.ownerGUIDByGUID = ownerGUIDByGUID
lib.ownerByGUID = ownerGUIDByGUID -- DEPRECATED: ownerByGUID

-- Return the GUID of the given unit.
function lib:GetGUIDByUnit(unit)
	return guidByUnit[unit] or UnitGUID(unit)
end

-- Return a list of units for the given GUID.
function lib:GetUnitByGUID(guid)
	if unitByGUID[guid] then
		return unpack(unitByGUID[guid])
	end
	return nil
end

-- Return the name of the given unit.
function lib:GetNameByUnit(unit)
	return nameByUnit[unit] or UnitName(unit)
end

-- Return a list of units with the given name.
function lib:GetUnitByName(name)
	if unitByName[name] then
		return unpack(unitByName[name])
	end
	return nil
end

-- Return the name of the given GUID.
function lib:GetNameByGUID(guid)
	return nameByGUID[guid]
end

-- Return a list of GUIDs with the given name.
function lib:GetGUIDByName(name)
	if guidByName[name] then
		return unpack(guidByName[name])
	end
	return nil
end

-- Return the GUID of the owner of the given pet/vehicle GUID.
function lib:GetOwnerGUIDByGUID(guid)
	return ownerGUIDByGUID[guid]
end
lib.GetOwnerByGUID = lib.GetOwnerGUIDByGUID -- DEPRECATED: GetOwnerByGUID

-- Return true if the GUID is on the roster.
function lib:IsGUIDInGroup(guid)
	return roster[guid] ~= nil
end
lib.UnitInGroup = lib.IsGUIDInGroup -- DEPRECATED: UnitInGroup

-- Return an iterator over the group roster that gives key-value pairs of GUID and unit ID.
function lib:IterateRoster()
	return pairs(roster)
end

--[[--------------------------------------------------------------------
	Keep a circular buffer of the most recently unmapped GUIDs.
	These GUIDs retain their GUID-to-name mappings until they expire
	off of the circular buffer.
--]]--------------------------------------------------------------------

-- Preserve circular buffer across library upgrades.
local mruGUIDs = lib.mruGUIDs or {}
lib.mruGUIDs = mruGUIDs

function mruGUIDs:Initialize(size)
	if not self.size or self.size < size then
		self.size = size
	end
	self.index = self.index or 1
end

function mruGUIDs:GetOldestGUID()
	return self[self.index]
end

function mruGUIDs:PutNewestGUID(guid)
	self[self.index] = guid
	self.index = self.index % self.size + 1
end

mruGUIDs:Initialize(1000)

------------------------------------------------------------------------

-- petUnitByUnit[unit] = pet unit ID
local petUnitByUnit = {}
do
	petUnitByUnit["player"] = "pet"
	for i = 1, MAX_ARENA_MEMBERS do
		petUnitByUnit["arena" .. i] = "arenapet" .. i
	end
	for i = 1, MAX_PARTY_MEMBERS do
		petUnitByUnit["party" .. i] = "partypet" .. i
	end
	for i = 1, MAX_RAID_MEMBERS do
		petUnitByUnit["raid" .. i] = "raidpet" .. i
	end
end

function lib:GetPetUnitByUnit(unit)
	return petUnitByUnit[unit] or unit .. "pet"
end

------------------------------------------------------------------------

-- targetUnitByUnit[unit] = target unit ID
local targetUnitByUnit = {}
do
	targetUnitByUnit["player"] = "target"
end

function lib:GetTargetUnitByUnit(unit)
	return targetUnitByUnit[unit] or unit .. "target"
end

------------------------------------------------------------------------

-- eventfulUnits is an ordered list of unit IDs that receive unit events.
local eventfulUnits = {}
do
	tinsert(eventfulUnits, "player")
	tinsert(eventfulUnits, "pet")
	for i = 1, MAX_RAID_MEMBERS do
		local unit = "raid" .. i
		local petUnit = lib:GetPetUnitByUnit(unit)
		tinsert(eventfulUnits, unit)
		tinsert(eventfulUnits, petUnit)
	end
	for i = 1, MAX_PARTY_MEMBERS do
		local unit = "party" .. i
		local petUnit = lib:GetPetUnitByUnit(unit)
		tinsert(eventfulUnits, unit)
		tinsert(eventfulUnits, petUnit)
	end
	for i = 1, MAX_BOSS_FRAMES do
		local unit = "boss" .. i
		tinsert(eventfulUnits, unit)
	end
	for i = 1, MAX_ARENA_MEMBERS do
		local unit = "arena" .. i
		local petUnit = lib:GetPetUnitByUnit(unit)
		tinsert(eventfulUnits, unit)
		tinsert(eventfulUnits, petUnit)
	end
	tinsert(eventfulUnits, "vehicle")
	tinsert(eventfulUnits, "target")
	tinsert(eventfulUnits, "focus")
end
local numUnits = #eventfulUnits

local unitPriority = {}
do
	for i, unit in ipairs(eventfulUnits) do
		unitPriority[unit] = i
	end
	-- Default unit priority is after all listed units.
	setmetatable(unitPriority, { __index = function(t, unit) return numUnits + 1 end })
end

-- Comparator for units based on their unit priorities.
local function CompareUnit(a, b)
	return unitPriority[a] < unitPriority[b]
end

-- Returns true if the given unit can receive unit events.
function lib:HasUnitEvents(unit)
	local priority = unitPriority[unit]
	return priority <= numUnits
end

------------------------------------------------------------------------

-- GLOBALS: IsInRaid
-- GLOBALS: UnitExists

-- Unit IDs for party and raid.
do
	local partyUnits = {}
	local raidUnits = {}
	do
		tinsert(partyUnits, "player")
		tinsert(partyUnits, "pet")
		for i = 1, MAX_PARTY_MEMBERS do
			local unit = "party" .. i
			tinsert(partyUnits, unit)
			-- Allow both partypetN and partyNpet.
			tinsert(partyUnits, unit .. "pet")
			tinsert(partyUnits, "partypet" .. i)
		end
		for i = 1, MAX_RAID_MEMBERS do
			local unit = "raid" .. i
			tinsert(raidUnits, unit)
			-- Allow both raidpetN and raidNpet.
			tinsert(raidUnits, unit .. "pet")
			tinsert(raidUnits, "raidpet" .. i)
		end
	end

	-- Return true if the unit exists and is a group unit ID.
	function lib:IsGroupUnit(unit)
		local units = IsInRaid() and raidUnits or partyUnits
		return (units[unit] ~= nil) and UnitExists(unit)
	end
end

------------------------------------------------------------------------

-- Preserve mappings of units to child units across library upgrades.
-- childrenByUnit[unit][childUnit] = true
local childrenByUnit = lib.childrenByUnit or {}
lib.childrenByUnit = childrenByUnit

local function AddChildUnit(unit, childUnit)
	local t = childrenByUnit[unit] or newTable()
	if not t[childUnit] then
		debug(5, "AddChildUnit", unit, childUnit)
		t[childUnit] = true
		childrenByUnit[unit] = t
	end
end

local function RemoveChildUnit(unit, childUnit)
	local t = childrenByUnit[unit]
	if t then
		debug(5, "RemoveChildUnit", unit, childUnit)
		t[childUnit] = nil
		if not next(t) then
			removeTable(t)
			childrenByUnit[unit] = nil
		end
	end
end

------------------------------------------------------------------------
-- Binary search algorithm pseudocode from: http://rosettacode.org/wiki/Binary_search

local function CompareDefault(a, b)
	return a < b
end

-- Return the index of the value in a sorted array using binary search.
local function BinarySearch(t, value, compare)
	compare = compare or CompareDefault
	local low, high = 1, #t
	while low <= high do
		-- invariants: value >= t[i] for all i < low
		--             value < t[i]  for all i > high
		local mid = floor((low + high) / 2)
		if compare(value, t[mid]) then
			high = mid - 1
		elseif compare(t[mid], value) then
			low = mid + 1
		else
			return mid
		end
	end
	return nil
end

-- Insert the value at the rightmost insertion point of a sorted array using binary search.
local function BinaryInsert(t, value, unique, compare)
	if type(unique) == "function" then
		unique, compare = nil, unique
	end
	compare = compare or CompareDefault
	local low, high = 1, #t
	while low <= high do
		-- invariants: value >= t[i] for all i < low
		--             value < t[i]  for all i > high
		local mid = floor((low + high) / 2)
		if compare(value, t[mid]) then
			high = mid - 1
		elseif not unique or compare(t[mid], value) then
			low = mid + 1
		else
			return mid
		end
	end
	tinsert(t, low, value)
	return low
end

-- Remove the value in a sorted array using binary search.
local function BinaryRemove(t, value, compare)
	compare = compare or CompareDefault
	local index = BinarySearch(t, value, compare)
	if index then
		tremove(t, index)
	end
	return index
end

------------------------------------------------------------------------

local function UnmapNameToUnit(name, unit)
	nameByUnit[unit] = nil
	local list = unitByName[name]
	if list then
		debug(6, "UnmapNameToUnit", name, unit)
		BinaryRemove(list, unit, CompareUnit)
		if #list == 0 then
			removeTable(list)
			unitByName[name] = nil
		end
	end
end

local function UnmapNameToGUID(name, guid)
	nameByGUID[guid] = nil
	local list = guidByName[name]
	if list then
		debug(6, "UnmapNameToGUID", name, guid)
		BinaryRemove(list, guid)
		if #list == 0 then
			removeTable(list)
			guidByName[name] = nil
		end
	end
end

local function UnmapGUIDToUnit(guid, unit)
	guidByUnit[unit] = nil
	local list = unitByGUID[guid]
	if list then
		debug(6, "UnmapGUIDToUnit", guid, unit)
		BinaryRemove(list, unit, CompareUnit)
		if #list == 0 then
			removeTable(list)
			unitByGUID[guid] = nil

			-- This GUID has no more unit IDs associated with it, so put it
			-- on the MRU list for eventual garbage collection.
			local oldGUID = mruGUIDs:GetOldestGUID()
			if oldGUID and not unitByGUID[oldGUID] then
				-- The oldest GUID has no more unit IDs associated with it,
				-- so remove mappings for it.
				local name = nameByGUID[oldGUID]
				if name then
					UnmapNameToGUID(name, oldGUID)
				end
				ownerGUIDByGUID[oldGUID] = nil
			end
			mruGUIDs:PutNewestGUID(guid)
		end
	end
end

local function UnmapUnit(unit)
	local children = childrenByUnit[unit]
	if children then
		for childUnit in pairs(children) do
			-- Recursively remove mappings for all children.
			UnmapUnit(childUnit)
			RemoveChildUnit(unit, childUnit)
		end
	end
	local guid = guidByUnit[unit]
	local name = nameByUnit[unit]
	if guid or name then
		debug(4, "UnmapUnit", unit)
		if guid then
			UnmapGUIDToUnit(guid, unit)
		end
		if name then
			UnmapNameToUnit(name, unit)
		end
	end
end

local function MapNameToUnit(name, unit)
	nameByUnit[unit] = name
	local list = unitByName[name] or newTable()
	debug(6, "MapNameToUnit", name, unit)
	BinaryInsert(list, unit, true, CompareUnit)
	unitByName[name] = list
end

local function MapNameToGUID(name, guid)
	nameByGUID[guid] = name
	local list = guidByName[name] or newTable()
	debug(6, "MapNameToGUID", name, guid)
	BinaryInsert(list, guid, true)
	guidByName[name] = list
end

local function MapGUIDToUnit(guid, unit)
	guidByUnit[unit] = guid
	local list = unitByGUID[guid] or newTable()
	debug(6, "MapGUIDToUnit", guid, unit)
	BinaryInsert(list, unit, true, CompareUnit)
	unitByGUID[guid] = list
end

------------------------------------------------------------------------

-- GLOBALS: IsInRaid
-- GLOBALS: UnitGUID
-- GLOBALS: UnitName

local function UpdateUnit(unit, guid, changed)
	guid = guid or UnitGUID(unit)
	local name, realm = UnitName(unit)
	local oldGUID = guidByUnit[unit]
	local oldName = nameByUnit[unit]
	if realm == "" then realm = nil end
	if realm then
		name = name .. "-" .. realm
	end

	-- Remove the old GUID and name mappings for this unit if they've changed.
	if not guid or not name then
		-- Unit is gone, so remove unit mappings for this unit ID and all of its children.
		UnmapUnit(unit)
	else
		if oldGUID and guid ~= oldGUID then
			-- Unit is gone, or has a different GUID.
			UnmapGUIDToUnit(oldGUID, unit)
		end
		if oldName and name ~= oldName then
			-- Unit has a different name.
			UnmapNameToUnit(oldName, unit)
		end
		if guid == oldGUID and oldName and name ~= oldName then
			-- Unit has same GUID, but the name changed.
			UnmapNameToGUID(oldName, guid)
		end
	end

	-- Create new mappings from this unit to the current GUID and name.
	local updated
	if guid and guid ~= oldGUID then
		-- Unit has a different GUID.
		MapGUIDToUnit(guid, unit)
		updated = true
	end
	if name and name ~= oldName then
		-- Unit has a different name.
		MapNameToUnit(name, unit)
		updated = true
	end
	if updated then
		MapNameToGUID(name, guid)
		if changed and type(changed) == "table" then
			changed[guid] = unit
		else
			debug(2, "MooUnit_UnitChanged", guid, unit, name)
			callbacks:Fire("MooUnit_UnitChanged", guid, unit, name)
		end
	end
end

local function UpdateUnitWithTarget(unit, guid, changed)
	UpdateUnit(unit, guid, changed)
	local targetUnit = lib:GetTargetUnitByUnit(unit)
	AddChildUnit(unit, targetUnit)
	UpdateUnit(targetUnit, nil, changed)
end

-- Unit IDs for party and raid.
local partyUnits = {}
local raidUnits = {}
do
	tinsert(partyUnits, "player")
	for i = 1, MAX_PARTY_MEMBERS do
		tinsert(partyUnits, "party" .. i)
	end
	for i = 1, MAX_RAID_MEMBERS do
		tinsert(raidUnits, "raid" .. i)
	end
end

local unitJoined = {}
local unitLeft = {}
local unitChanged = {}

local function UpdateRosterUnit(unit)
	local guid = UnitGUID(unit)
	if guid then
		if unitLeft[guid] then
			unitLeft[guid] = nil
		else
			unitJoined[guid] = true
		end
		roster[guid] = unit
	end
	UpdateUnitWithTarget(unit, guid, unitChanged)
end

local function UpdateRoster()
	for guid in pairs(roster) do
		unitLeft[guid] = true
	end
	local units = IsInRaid() and raidUnits or partyUnits
	for _, unit in ipairs(units) do
		UpdateRosterUnit(unit)
		local petUnit = lib:GetPetUnitByUnit(unit)
		if petUnit then
			AddChildUnit(unit, petUnit)
			UpdateRosterUnit(petUnit)
			local petGUID = guidByUnit[petUnit]
			if petGUID then
				ownerGUIDByGUID[petGUID] = guidByUnit[unit]
			end
		end
	end
	local updated
	for guid in pairs(unitLeft) do
		updated = true
		unitLeft[guid] = nil
		roster[guid] = nil
		debug(2, "MooUnit_UnitLeft", guid)
		callbacks:Fire("MooUnit_UnitLeft", guid)
	end
	for guid in pairs(unitJoined) do
		updated = true
		unitJoined[guid] = nil
		local unit = roster[guid]
		debug(2, "MooUnit_UnitJoined", guid, unit)
		callbacks:Fire("MooUnit_UnitJoined", guid, unit)
	end
	for guid, unit in pairs(unitChanged) do
		updated = true
		unitChanged[guid] = nil
		local name = nameByGUID[guid]
		debug(2, "MooUnit_UnitChanged", guid, unit, name)
		callbacks:Fire("MooUnit_UnitChanged", guid, unit, name)
	end
	if updated then
		debug(2, "MooUnit_RosterUpdated")
		callbacks:Fire("MooUnit_RosterUpdated")
	end
end

------------------------------------------------------------------------

-- GLOBALS: UnitIsUnit

function eventFrame:ARENA_OPPONENT_UPDATE(event, unit, eventType)
	if eventType ~= "cleared" or guidByUnit[unit] then
		debug(3, event, unit, eventType)
		UpdateUnitWithTarget(unit)
	end
end

function eventFrame:GROUP_ROSTER_UPDATE(event)
	debug(3, event)
	UpdateRoster()
end

function eventFrame:INSTANCE_ENCOUNTER_ENGAGE_UNIT(event)
	debug(3, event)
	for i = 1, MAX_BOSS_FRAMES do
		UpdateUnitWithTarget("boss" .. i)
	end
end

function eventFrame:NAME_PLATE_UNIT_ADDED(event, unit)
	debug(3, event, unit)
	UpdateUnitWithTarget(unit)
end

function eventFrame:PLAYER_FOCUS_CHANGED(event)
	debug(3, event)
	UpdateUnitWithTarget("focus")
end

function eventFrame:PLAYER_TARGET_CHANGED(event, cause)
	debug(3, event, cause)
	UpdateUnitWithTarget("target")
end

function eventFrame:UNIT_PET(event, unit)
	debug(3, event, unit)
	local petUnit = lib:GetPetUnitByUnit(unit)
	AddChildUnit(unit, petUnit)
	UpdateUnitWithTarget(petUnit)
	local guid = guidByUnit[unit]
	local petGUID = guidByUnit[petUnit]
	if petGUID then
		ownerGUIDByGUID[petGUID] = guid
		debug(2, "MooUnit_PetChanged", guid, unit, petGUID, petUnit)
		callbacks:Fire("MooUnit_PetChanged", guid, unit, petGUID, petUnit)
	end
end

function eventFrame:UNIT_TARGET(event, unit)
	-- Changes to the player's target are tracked with PLAYER_TARGET_CHANGED.
	if unit ~= "player" and not UnitIsUnit("player", unit) then
		debug(3, event, unit)
		local targetUnit = lib:GetTargetUnitByUnit(unit)
		AddChildUnit(unit, targetUnit)
		UpdateUnit(targetUnit)
	end
end

eventFrame.FORBIDDEN_NAME_PLATE_UNIT_ADDED = eventFrame.NAME_PLATE_UNIT_ADDED
eventFrame.FORBIDDEN_NAME_PLATE_UNIT_REMOVED = eventFrame.NAME_PLATE_UNIT_ADDED
eventFrame.NAME_PLATE_UNIT_REMOVED = eventFrame.NAME_PLATE_UNIT_ADDED
eventFrame.PLAYER_ENTERING_WORLD = eventFrame.GROUP_ROSTER_UPDATE
eventFrame.UNIT_NAME_UPDATE = eventFrame.NAME_PLATE_UNIT_ADDED
eventFrame.UNIT_PORTRAIT_UPDATE = eventFrame.NAME_PLATE_UNIT_ADDED