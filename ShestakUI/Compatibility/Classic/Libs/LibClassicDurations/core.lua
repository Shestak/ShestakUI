if not IsClassicBuild() then return end

--[================[
LibClassicDurations
Author: d87
Description: tracking expiration times
--]================]


local MAJOR, MINOR = "LibClassicDurations", 1.0
local lib = LibStub:NewLibrary(MAJOR, MINOR)
if not lib then return end

-- lib.callbacks = lib.callbacks or LibStub("CallbackHandler-1.0"):New(lib)

lib.frame = lib.frame or CreateFrame("Frame")

local weakKeysMeta = { __mode == "k" }
lib.guids = lib.guids or setmetatable({}, weakKeysMeta)
lib.spells = lib.spells or {

}

local f = lib.frame
local callbacks = lib.callbacks
local guids = lib.guids
local spells = lib.spells

local CombatLogGetCurrentEventInfo = CombatLogGetCurrentEventInfo
local UnitGUID = UnitGUID
local UnitAura = UnitAura
local GetTime = GetTime

f:SetScript("OnEvent", function(self, event, ...)
    return self[event](self, event, ...)
end)


lib.AddAura = lib.AddAura or function(id, opts)
    if not opts then return end

    if type(id) == "table" then
        for _, spellID in ipairs(id) do
            spells[spellID] = opts
        end
    else
        spells[id] = opts
    end
end

lib.Talent = lib.Talent or function (...)
    for i=1, 5 do
        local spellID = select(i, ...)
        if not spellID then break end
        if IsPlayerSpell(spellID) then return i end
    end
    return 0
end


--------------------------
-- DIMINISHING RETURNS
--------------------------
local bit_band = bit.band
local DRResetTime = 18.4

local DRInfo = setmetatable({}, weakKeysMeta)
local COMBATLOG_OBJECT_TYPE_PLAYER = COMBATLOG_OBJECT_TYPE_PLAYER
local COMBATLOG_OBJECT_REACTION_FRIENDLY = COMBATLOG_OBJECT_REACTION_FRIENDLY

local DRMultipliers = { 0.5, 0.25, 0}
local function addDRLevel(dstGUID, category)
    local guitTable = DRInfo[dstGUID]
    if not guidTable then
        DRInfo[dstGUID] = {}
        guidTable = DRInfo[dstGUID]
    end

    local catTable = guidTable[category]
    if not catTable then
        guidTable[category] = {}
        catTable = guidTable[category]
    end

    local now = GetTime()
    local isExpired = (catTable.expires or 0) <= now
    if isExpired then
        catTable.level = 1
        catTable.expires = now + DRResetTime
    else
        catTable.level = catTable.level + 1
    end
end
local function clearDRs(dstGUID)
    DRInfo[dstGUID] = nil
end
local function getDRMul(dstGUID, spellID)
    local category = lib.DR_CategoryBySpellID[spellID]
    if not category then return 1 end

    local guitTable = DRInfo[dstGUID]
    if guidTable then
        local catTable = guidTable[category]
        if catTable then
            local now = GetTime()
            local isExpired = (catTable.expires or 0) <= now
            if isExpired then
                return 1
            else
                local mul = DRMultipliers[catTable.level]
                return mul or 1
            end
        end
    end
    return 1
end

local function CountDiminishingReturns(eventType, srcGUID, srcFlags, dstGUID, dstFlags, spellID, auraType)
    if auraType == "DEBUFF" then
        if eventType == "SPELL_AURA_REMOVED" or eventType == "SPELL_AURA_REFRESH" then
            local category = lib.DR_CategoryBySpellID[spellID]
            if not category then return end

            local isDstPlayer = bit_band(dstFlags, COMBATLOG_OBJECT_TYPE_PLAYER) > 0
            -- local isFriendly = bit_band(dstFlags, COMBATLOG_OBJECT_REACTION_FRIENDLY) > 0

            if not isDstPlayer then
                if not lib.DR_TypesPVE[category] then return end
            end

            addDRLevel(dstGUID, category)
        end
        if eventType == "UNIT_DIED" then
            clearDRs(dstGUID)
        end
    end
end

--------------------------------------------

local function cleanDuration(duration, spellID, srcGUID)
    if type(duration) == "function" then
        local isSrcPlayer = srcGUID == UnitGUID("player")
        return duration(spellID, isSrcPlayer)
    end
    return duration
end


local function SetTimer(srcGUID, dstGUID, dstName, dstFlags, spellID, spellName, opts, auraType, doRemove)
    if not opts then return end

    local guidTable = guids[dstGUID]
    if not guidTable then
        guids[dstGUID] = setmetatable({}, weakKeysMeta)
        guidTable = guids[dstGUID]
    end

    local isStacking = opts.stacking
    -- local auraUID = MakeAuraUID(spellID, isStacking and srcGUID)

    if doRemove then
        if guidTable[spellID] then
            if isStacking then
                if guidTable[spellID].applications then
                    guidTable[spellID].applications[srcGUID] = nil
                end
            else
                guidTable[spellID] = nil
            end
        end
        return
    end

    local spellTable = guidTable[spellID]
    if not spellTable then
        guidTable[spellID] = {}
        spellTable = guidTable[spellID]
        if isStacking then
            spellTable.applications = {}
        end
    end

    local applicationTable
    if isStacking then
        applicationTable = spellTable.applications[srcGUID]
        if not applicationTable then
            spellTable.applications[srcGUID] = {}
            applicationTable = spellTable.applications[srcGUID]
        end
    else
        applicationTable = spellTable
    end

    local duration = cleanDuration(opts.duration, spellID, srcGUID)
    local mul = getDRMul(dstGUID, spellID)
    duration = duration * mul
    local now = GetTime()
    local expirationTime = now + duration
    applicationTable[1] = duration
    applicationTable[2] = expirationTime
end



---------------------------
-- COMBAT LOG HANDLER
---------------------------
function f:COMBAT_LOG_EVENT_UNFILTERED(event)

    local timestamp, eventType, hideCaster,
    srcGUID, srcName, srcFlags, srcFlags2,
    dstGUID, dstName, dstFlags, dstFlags2,
    spellID, spellName, spellSchool, auraType, amount = CombatLogGetCurrentEventInfo()

    CountDiminishingReturns(eventType, srcGUID, srcFlags, dstGUID, dstFlags, spellID, auraType)
    
    if auraType == "BUFF" or auraType == "DEBUFF" then
        local opts = spells[spellID]
        if  eventType == "SPELL_AURA_REFRESH" or
            eventType == "SPELL_AURA_APPLIED" or
            eventType == "SPELL_AURA_APPLIED_DOSE" then
            SetTimer(srcGUID, dstGUID, dstName, dstFlags, spellID, spellName, opts, auraType)
        elseif eventType == "SPELL_AURA_REMOVED" then
            SetTimer(srcGUID, dstGUID, dstName, dstFlags, spellID, spellName, opts, auraType, true)
        -- elseif eventType == "SPELL_AURA_REMOVED_DOSE" then
            -- self:RemoveDose(srcGUID, dstGUID, spellID, spellName, auraType, amount)
        end
    end
end

function lib:GetGUIDAuraTime(dstGUID, spellID)
    -- local guid = UnitGUID(unit)
    -- if activeSpellLocks[guid] then
    --     local spellID, duration, expirationTime = unpack(activeSpellLocks[guid])
    --     if GetTime() > expirationTime then return nil end
    --     local name, _, icon = GetSpellInfo(spellID)
    --     return spellID, name, icon, duration, expirationTime
    -- end
end

local function GetGUIDAuraTime(dstGUID, spellID, srcGUID, isStacking)
    local guidTable = guids[dstGUID]
    if guidTable then        
        -- local isStacking = opts.stacking
        local spellTable = guidTable[spellID]
        if spellTable then
            local applicationTable
            if isStacking then
                if srcGUID then
                    applicationTable = spellTable.applications[srcGUID]
                else -- return some duration
                    applicationTable = select(2,next(spellTable.applications))
                end
            else
                applicationTable = spellTable
            end
            if not applicationTable then return end
            local duration, expirationTime = unpack(applicationTable)
            if GetTime() <= expirationTime then
                return duration, expirationTime
            end
        end
    end
end

function lib:GetAuraDurationByUnit(unit, spellID, casterUnit)
    local opts = spells[spellID]
    if not opts then return end
    local dstGUID = UnitGUID(unit)
    local srcGUID = casterUnit and UnitGUID(casterUnit)
    return GetGUIDAuraTime(dstGUID, spellID, srcGUID, opts.stacking)
end
function lib:GetAuraDurationByGUID(dstGUID, spellID, srcGUID)
    local opts = spells[spellID]
    if not opts then return end
    return GetGUIDAuraTime(dstGUID, spellID, srcGUID, opts.stacking)
end

local activeFrames = {}
function lib:RegisterFrame(frame)
    activeFrames[frame] = true
    if next(activeFrames) then
        f:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    end
end

function lib:UnregisterFrame(frame)
    activeFrames[frame] = nil
    if not next(activeFrames) then
        f:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    end
end
