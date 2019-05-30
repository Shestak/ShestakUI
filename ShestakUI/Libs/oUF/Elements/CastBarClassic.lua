if not IsClassicBuild() then return end

local CastScanner = CreateFrame("Frame")

-- Init Tables
CastScanner.db = {}
CastScanner.guid = {}

UnitCastingInfo = _G.UnitCastingInfo or function(unit)
	assert(type(unit) == "string", "Usage: UnitCastingInfo(\"unit\")")

	if not UnitExists(unit) then return end

	if unit == "player" or UnitGUID(unit) == CastScanner.guid.player then
		return CastingInfo()
	else
		local name, text, texture, startTimeMS, endTimeMS, isTradeSkill, castID, notInterruptible, spellID
		local unitGUID = UnitGUID(unit)

		if CastScanner.db[unitGUID] and CastScanner.db[unitGUID].startTimeMS then
			if CastScanner.db[unitGUID].startTimeMS + CastScanner.db[unitGUID].castTime > GetTime() then
				if CastScanner.db.channelStatus then return end
				name					= CastScanner.db[unitGUID].name
				text					= CastScanner.db[unitGUID].text
				texture					= CastScanner.db[unitGUID].texture
				startTimeMS				= CastScanner.db[unitGUID].startTimeMS
				endTimeMS				= CastScanner.db[unitGUID].endTimeMS
				isTradeSkill			= CastScanner.db[unitGUID].isTradeSkill
				castID					= CastScanner.db[unitGUID].castID
				notInterruptible		= CastScanner.db[unitGUID].notInterruptible
				spellID					= CastScanner.db[unitGUID].spellID
			elseif CastScanner.db[unitGUID] then
				wipe(CastScanner.db[unitGUID])
			end
		end

		return name, text, texture, startTimeMS, endTimeMS, isTradeSkill, castID, notInterruptible, spellID
	end
end

UnitChannelInfo = _G.UnitChannelInfo or function(unit)
	assert(type(unit) == "string", "Usage: UnitChannelInfo(\"unit\")")

	if not UnitExists(unit) then return end

	if unit == "player" or UnitGUID(unit) == CastScanner.guid.player then
		return ChannelInfo()
	else
		local name, text, texture, startTimeMS, endTimeMS, isTradeSkill, castID, notInterruptible, spellID
		local unitGUID = UnitGUID(unit)

		if CastScanner.db[unitGUID] and CastScanner.db[unitGUID].startTimeMS then
			if CastScanner.db[unitGUID].startTimeMS + CastScanner.db[unitGUID].castTime > GetTime() then
				if not CastScanner.db[unitGUID].channelStatus then return end
				name					= CastScanner.db[unitGUID].name
				text					= CastScanner.db[unitGUID].text
				texture					= CastScanner.db[unitGUID].texture
				startTimeMS				= CastScanner.db[unitGUID].startTimeMS
				endTimeMS				= CastScanner.db[unitGUID].endTimeMS
				isTradeSkill			= CastScanner.db[unitGUID].isTradeSkill
				castID					= CastScanner.db[unitGUID].castID
				notInterruptible		= CastScanner.db[unitGUID].notInterruptible
				spellID					= CastScanner.db[unitGUID].spellID
			elseif CastScanner.db[unitGUID] then
				wipe(CastScanner.db[unitGUID])
			end
		end
		
		return name, text, texture, startTimeMS, endTimeMS, isTradeSkill, castID, notInterruptible, spellID
	end
end

local interruptibleSpells = {
	-- MC
	[19775] = true,					-- Dark Mending
	-- BWL
	[17290] = true,					-- Fireball
	-- ZG
	[24208] = true,					-- Great Heal
	[23954] = true,					-- Great Heal
	[24300] = true,					-- Drain Life
	[24680] = true,					-- Chain Lightning
	-- AQ20
	-- AQ40
	[25807] = true,					-- Great Heal
	[26192] = true,					-- Arcane Explosion
	-- Naxx
	[28478] = true,					-- Frostbolt
}

function CastScanner:AddCast(unitGUID, castID, spellID, castTime, channelStatus)
	local currentTime = GetTime() * 1e3
	local name, rank, texture = GetSpellInfo(spellID)

	rank = rank or GetSpellRank(spellID)

	local text = (rank and tostring(name.." (r"..rank..")")) or name
	local isTradeSkill = (select(2, GetSpellTradeSkillLink(spellID) and true)) or false
	local notInterruptible = true

	if unitGUID:match("Player") or unitGUID:match("Pet") then
		notInterruptible = false
	else
		if interruptibleSpells[spellID] then
			notInterruptible = false
		end
	end

	self.db[unitGUID] = {
		channelStatus				= channelStatus,
		castTime					= castTime,
		name						= name,
		text						= text,
		texture						= texture,
		startTimeMS					= currentTime,
		endTimeMS					= currentTime + castTime,
		isTradeSkill				= isTradeSkill,
		castID						= castID,
		notInterruptible			= notInterruptible,
		spellID						= spellID,
	}
end

function CastScanner:DelayCast(unitGUID, castID, spellID, castTime, channelStatus) -- Needs work
	-- todo
end

function CastScanner:RemoveCast(unitGUID)
	if unitGUID and self.db[unitGUID] then
		wipe(self.db[unitGUID])
	end
end

local function SpellName(id)
	local name = GetSpellInfo(id)
	if name then
		return name
	else
		return "Empty"
	end
end

local staticChannelSpells = {
	-- Druid
	[SpellName(16914)] = 10,		-- Hurricane
	[SpellName(740)] = 10,			-- Tranquility
	-- Hunter
	[SpellName(6197)] = 60,			-- Eagle Eye
	[SpellName(1002)] = 60,			-- Eyes of the Beast (someone could talent this for some reason and extend it 30/60sec)
	[SpellName(136)] = 5,			-- Mend Pet
	[SpellName(1510)] = 6,			-- Volley
	-- Mage
	[SpellName(10)] = 8,			-- Blizzard
	[SpellName(12051)] = 8,			-- Evocation
	-- Priest
	[SpellName(605)] = 60,			-- Mind Control
	[SpellName(15407)] = 3,			-- Mind Flay
	[SpellName(2096)] = 60,			-- Mind Vision
	-- Shaman
	[SpellName(6196)] = 60,			-- Far Sight
	-- Warlock
	[SpellName(689)] = 5,			-- Drain Life
	[SpellName(5138)] = 5,			-- Drain Mana
	[SpellName(1120)] = 15,			-- Drain Soul
	[SpellName(126)] = 45,			-- Eye of Kilrogg
	[SpellName(755)] = 10,			-- Health Funnel
	[SpellName(1949)] = 15,			-- Hellfire
	[SpellName(5740)] = 8,			-- Rain of Fire
	[SpellName(18540)] = 60,		-- Ritual of Doom
	[SpellName(23598)] = 600,		-- Ritual of Summoning
	[SpellName(7620)] = 30,			-- Fishing
	[SpellName(13278)] = 4,			-- Gnomish Death Ray
	-- Racial
	[SpellName(10797)] = 6,			-- Starshards
}

local variableChannelSpells = {
	-- Mage
	[5143] = 3,						-- Arcane Missiles (r1)
	[5144] = 4,						-- Arcane Missiles (r2)
	[5145] = 5,						-- Arcane Missiles (r3)
	[8416] = 5,						-- Arcane Missiles (r4)
	[8417] = 5,						-- Arcane Missiles (r5)
	[10211] = 5,					-- Arcane Missiles (r6)
	[10212] = 5,					-- Arcane Missiles (r7)
	[25345] = 5,					-- Arcane Missiles (r8)
	-- Professions
	[746] = 6,						-- First Aid (r1)
	[1159] = 6,						-- First Aid (r2)
	[3267] = 7,						-- First Aid (r3)
	[3268] = 7,						-- First Aid (r4)
	[7926] = 8,						-- First Aid (r5)
	[7927] = 8,						-- First Aid (r6)
	[23569] = 8,					-- First Aid (r6 WSG)
	[24412] = 8,					-- First Aid (r6 AB)
	[10838] = 8,					-- First Aid (r7)
	[10839] = 8,					-- First Aid (r8)
	[23568] = 8,					-- First Aid (r8 WSG)
	[24413] = 8,					-- First Aid (r8 AB)
	[18608] = 8,					-- First Aid (r9)
	[18610] = 8,					-- First Aid (r10)
	[23696] = 8,					-- First Aid (r10 AV)
	[23567] = 8,					-- First Aid (r10 WSG)
	[24414] = 8,					-- First Aid (r10 AB)
}

-- Setup
CastScanner:RegisterEvent("PLAYER_ENTERING_WORLD")

-- Get GUIDs
CastScanner:RegisterEvent("PLAYER_TARGET_CHANGED")
CastScanner:RegisterEvent("UNIT_PET")
-- CastScanner:RegisterEvent("UNIT_HAPPINESS")
CastScanner:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT")
CastScanner:RegisterEvent("UNIT_TARGETABLE_CHANGED")
CastScanner:RegisterEvent("GROUP_ROSTER_UPDATE")
CastScanner:RegisterEvent("NAME_PLATE_UNIT_ADDED")
CastScanner:RegisterEvent("NAME_PLATE_UNIT_REMOVED")

-- CLEU
CastScanner:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

-- Unit Events
--[[
CastScanner:RegisterEvent("UNIT_SPELLCAST_SENT")				-- "unit", "target", "castGUID", spellID
CastScanner:RegisterEvent("UNIT_SPELLCAST_START")				-- "unitTarget", "castGUID", spellID
CastScanner:RegisterEvent("UNIT_SPELLCAST_STOP")				-- "unitTarget", "castGUID", spellID
CastScanner:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")			-- "unitTarget", "castGUID", spellID
CastScanner:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START")		-- "unitTarget", "castGUID", spellID
CastScanner:RegisterEvent("UNIT_SPELLCAST_CHANNEL_STOP")		-- "unitTarget", "castGUID", spellID
-- CastScanner:RegisterEvent("UNIT_SPELLCAST_CHANNEL_UPDATE")		-- "unitTarget", "castGUID", spellID
-- CastScanner:RegisterEvent("UNIT_SPELLCAST_DELAYED")				-- "unitTarget", "castGUID", spellID
CastScanner:RegisterEvent("UNIT_SPELLCAST_FAILED")				-- "unitTarget", "castGUID", spellID
CastScanner:RegisterEvent("UNIT_SPELLCAST_FAILED_QUIET")		-- "unitTarget", "castGUID", spellID
CastScanner:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED")			-- "unitTarget", "castGUID", spellID
-- CastScanner:RegisterEvent("UNIT_SPELLCAST_INTERRUPTIBLE")		-- "unitTarget" (BfA)
-- CastScanner:RegisterEvent("UNIT_SPELLCAST_NOT_INTERRUPTIBLE")	-- "unitTarget" (BfA)
--]]

CastScanner:SetScript("OnEvent", function(self, event, ...)
	if event == "PLAYER_ENTERING_WORLD" then
		wipe(self.db)
		wipe(self.guid)

		self.guid.player = UnitGUID("player")
	elseif event == "PLAYER_TARGET_CHANGED" then
		self.guid.target = UnitGUID("target") or nil
	elseif event == "UNIT_PET" or event == "UNIT_HAPPINESS" then
		self.guid.pet = UnitGUID("pet") or nil
	elseif event == "INSTANCE_ENCOUNTER_ENGAGE_UNIT" or event == "UNIT_TARGETABLE_CHANGED" then
		local unit = IsInRaid() and "boss" or nil

		if not unit then return end

		for i = 1, MAX_BOSS_FRAMES do
			self.guid[unit..i] = UnitGUID(unit..i) or nil
		end
	elseif event == "GROUP_ROSTER_UPDATE" then
		local unit = IsInRaid() and "raid" or "party"

		for i = 1, GetNumGroupMembers(), 1 do
			self.guid[unit..i] = UnitGUID(unit..i) or nil
			self.guid[unit.."pet"..i] = UnitGUID(unit.."pet"..i) or nil
		end

		if unit == "raid" then
			for i = GetNumGroupMembers() + 1, MAX_RAID_MEMBERS or 40, 1 do
				self.guid[unit..i] = nil
				self.guid[unit.."pet"..i] = nil
			end
		else
			for i = GetNumGroupMembers() + 1, MAX_PARTY_MEMBERS or 4, 1 do
				self.guid[unit..i] = nil
				self.guid[unit.."pet"..i] = nil
			end
		end
	elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then
		local _, subEvent, _, sourceGUID, _, _, _, destGUID, _, _, _, spellID, spellName = CombatLogGetCurrentEventInfo()

		if not subEvent == "SPELL_CAST_START" or not subEvent == "SPELL_CAST_SUCCESS" or not subEvent == "SPELL_AURA_REMOVED" or not subEvent == "SPELL_CAST_FAILED" or not "SPELL_INTERRUPT" or not subEvent == "PARTY_KILL" or not subEvent == "UNIT_DIED" then return end

		if subEvent == "SPELL_CAST_START" then
			local castTime = select(4, GetSpellInfo(spellID))
			if not castTime or castTime == 0 then return end

			self:AddCast(sourceGUID, nil, spellID, castTime)
		elseif subEvent == "SPELL_CAST_SUCCESS" then
			local castTime = staticChannelSpells[spellName] or variableChannelSpells[spellID]
			if castTime then
				self:AddCast(sourceGUID, nil, spellID, castTime * 1e3, true)
			else
				self:RemoveCast(sourceGUID)
			end
		elseif subEvent == "SPELL_AURA_REMOVED" then
			if staticChannelSpells[spellName] or variableChannelSpells[spellID] then
				self:RemoveCast(sourceGUID)
			end
		elseif subEvent == "SPELL_CAST_FAILED" or subEvent == "SPELL_INTERRUPT" then
			if sourceGUID == self.guid.player then
				if not UnitCastingInfo("player") then
					self:RemoveCast(sourceGUID)
				end
			else
				self:RemoveCast(sourceGUID)
			end
		elseif subEvent == "PARTY_KILL" or subEvent == "UNIT_DIED" then
			self:RemoveCast(destGUID)
		end
	elseif event == "NAME_PLATE_UNIT_ADDED" or event == "NAME_PLATE_UNIT_REMOVED" then
		local unit = ...

		if unit == "player" then return end

		self.guid[UnitGUID(unit)] = unit or nil
	elseif event == "UNIT_SPELLCAST_SENT" then
		local unitTarget, _, castGUID, spellID = ...
		unitTarget = UnitGUID(unitTarget)

		local castTime = select(4, GetSpellInfo(spellID))
		if not castTime or castTime == 0 then return end

		self:AddCast(unitTarget, castGUID, spellID, castTime)
	elseif event == "UNIT_SPELLCAST_START" then
		local unitTarget, castGUID, spellID = ...
		unitTarget = UnitGUID(unitTarget)

		local castTime = select(4, GetSpellInfo(spellID))
		if not castTime or castTime == 0 then return end

		self:AddCast(unitTarget, castGUID, spellID, castTime)
	elseif event == "UNIT_SPELLCAST_DELAYED" then -- todo
		local unitTarget, castGUID, spellID = ...
		unitTarget = UnitGUID(unitTarget)

		local castTime = select(4, GetSpellInfo(spellID))
		if not castTime or castTime == 0 then return end

		self:DelayCast(unitTarget, castGUID, spellID, castTime)
	elseif event == "UNIT_SPELLCAST_CHANNEL_START" then
		local unitTarget, castGUID, spellID = ...
		unitTarget = UnitGUID(unitTarget)

		local castTime = staticChannelSpells[spellName] or variableChannelSpells[spellID]
		if not castTime or castTime == 0 then return end

		self:AddCast(unitTarget, castGUID, spellID, castTime * 1e3, true)
	elseif event == "UNIT_SPELLCAST_CHANNEL_UPDATE" then -- todo
		local unitTarget, castGUID, spellID = ...
		unitTarget = UnitGUID(unitTarget)

		local castTime = staticChannelSpells[spellName] or variableChannelSpells[spellID]
		if not castTime or castTime == 0 then return end

		self:DelayCast(unitTarget, castGUID, spellID, castTime * 1e3, true)
	elseif event == "UNIT_SPELLCAST_SUCCEEDED" then
		local unitTarget, castGUID, spellID = ...
		unitTarget = UnitGUID(unitTarget)

		local castTime = staticChannelSpells[spellName] or variableChannelSpells[spellID]
		if not castTime or castTime == 0 then
			self:RemoveCast(unitTarget)
		else
			self:AddCast(unitTarget, castGUID, spellID, castTime * 1e3, true)
		end
	elseif event == "UNIT_SPELLCAST_STOP" or event == "UNIT_SPELLCAST_CHANNEL_STOP" then
		local unitTarget = ...
		unitTarget = UnitGUID(unitTarget)

		self:RemoveCast(unitTarget)
	end
end)

---------------------------------------------------------------------------------------------------------
-- end of CastScanner
---------------------------------------------------------------------------------------------------------
local _, ns = ...
local oUF = ns.oUF

local GetNetStats = GetNetStats
local GetTime = GetTime
local UnitCastingInfo = UnitCastingInfo
local UnitChannelInfo = UnitChannelInfo

local function updateSafeZone(self)
	local safeZone = self.SafeZone
	local width = self:GetWidth()
	local _, _, _, ms = GetNetStats()

	local safeZoneRatio = (ms / 1e3) / self.max
	if(safeZoneRatio > 1) then
		safeZoneRatio = 1
	end

	safeZone:SetWidth(width * safeZoneRatio)
end

local function UNIT_SPELLCAST_START(self, event, unit)
	if(self.unit ~= unit and self.realUnit ~= unit) then return end

	local element = self.Castbar
	local name, text, texture, startTime, endTime, _, castID, notInterruptible, spellID = UnitCastingInfo(unit)
	if(not name) then
		return element:Hide()
	end

	endTime = endTime / 1e3
	startTime = startTime / 1e3
	local max = endTime - startTime

	element.castID = castID
	element.duration = GetTime() - startTime
	element.max = max
	element.delay = 0
	element.casting = true
	element.notInterruptible = notInterruptible
	element.holdTime = 0
	element.spellID = spellID

	element:SetMinMaxValues(0, max)
	element:SetValue(0)

	if(element.Text) then element.Text:SetText(text) end
	if(element.Icon) then element.Icon:SetTexture(texture) end
	if(element.Time) then element.Time:SetText() end

	local shield = element.Shield
	if(shield and notInterruptible) then
		shield:Show()
	elseif(shield) then
		shield:Hide()
	end

	local sf = element.SafeZone
	if(sf) then
		sf:ClearAllPoints()
		sf:SetPoint(element:GetReverseFill() and 'LEFT' or 'RIGHT')
		sf:SetPoint('TOP')
		sf:SetPoint('BOTTOM')
		updateSafeZone(element)
	end

	--[[ Callback: Castbar:PostCastStart(unit, name)
	Called after the element has been updated upon a spell cast start.

	* self - the Castbar widget
	* unit - unit for which the update has been triggered (string)
	* name - name of the spell being cast (string)
	--]]
	if(element.PostCastStart) then
		element:PostCastStart(unit, name)
	end
	element:Show()
end

local function UNIT_SPELLCAST_FAILED(self, event, unit, castID)
	if(self.unit ~= unit and self.realUnit ~= unit) then return end

	local element = self.Castbar
	--[[
	if(element.castID ~= castID) then
		return
	end
	--]]

	local text = element.Text
	if(text) then
		text:SetText(FAILED)
	end

	element.casting = nil
	element.notInterruptible = nil
	element.holdTime = element.timeToHold or 0

	--[[ Callback: Castbar:PostCastFailed(unit)
	Called after the element has been updated upon a failed spell cast.

	* self - the Castbar widget
	* unit - unit for which the update has been triggered (string)
	--]]
	if(element.PostCastFailed) then
		return element:PostCastFailed(unit)
	end
end

local function UNIT_SPELLCAST_INTERRUPTED(self, event, unit, castID)
	if(self.unit ~= unit and self.realUnit ~= unit) then return end

	local element = self.Castbar
	--[[
	if(element.castID ~= castID) then
		return
	end
	--]]

	local text = element.Text
	if(text) then
		text:SetText(INTERRUPTED)
	end

	element.casting = nil
	element.channeling = nil
	element.holdTime = element.timeToHold or 0

	--[[ Callback: Castbar:PostCastInterrupted(unit)
	Called after the element has been updated upon an interrupted spell cast.

	* self - the Castbar widget
	* unit - unit for which the update has been triggered (string)
	--]]
	if(element.PostCastInterrupted) then
		return element:PostCastInterrupted(unit)
	end
end

local function UNIT_SPELLCAST_INTERRUPTIBLE(self, event, unit)
	if(self.unit ~= unit and self.realUnit ~= unit) then return end

	local element = self.Castbar
	local shield = element.Shield
	if(shield) then
		shield:Hide()
	end

	element.notInterruptible = nil

	--[[ Callback: Castbar:PostCastInterruptible(unit)
	Called after the element has been updated when a spell cast has become interruptible.

	* self - the Castbar widget
	* unit - unit for which the update has been triggered (string)
	--]]
	if(element.PostCastInterruptible) then
		return element:PostCastInterruptible(unit)
	end
end

local function UNIT_SPELLCAST_NOT_INTERRUPTIBLE(self, event, unit)
	if(self.unit ~= unit and self.realUnit ~= unit) then return end

	local element = self.Castbar
	local shield = element.Shield
	if(shield) then
		shield:Show()
	end

	element.notInterruptible = true

	--[[ Callback: Castbar:PostCastNotInterruptible(unit)
	Called after the element has been updated when a spell cast has become non-interruptible.

	* self - the Castbar widget
	* unit - unit for which the update has been triggered (string)
	--]]
	if(element.PostCastNotInterruptible) then
		return element:PostCastNotInterruptible(unit)
	end
end

local function UNIT_SPELLCAST_DELAYED(self, event, unit)
	if(self.unit ~= unit and self.realUnit ~= unit) then return end

	local element = self.Castbar
	local name, _, _, startTime = UnitCastingInfo(unit)
	if(not startTime or not element:IsShown()) then return end

	local duration = GetTime() - (startTime / 1000)
	if(duration < 0) then duration = 0 end

	element.delay = element.delay + element.duration - duration
	element.duration = duration

	element:SetValue(duration)

	--[[ Callback: Castbar:PostCastDelayed(unit, name)
	Called after the element has been updated when a spell cast has been delayed.

	* self - the Castbar widget
	* unit - unit that the update has been triggered (string)
	* name - name of the delayed spell (string)
	--]]
	if(element.PostCastDelayed) then
		return element:PostCastDelayed(unit, name)
	end
end

local function UNIT_SPELLCAST_STOP(self, event, unit, castID)
	if(self.unit ~= unit and self.realUnit ~= unit) then return end

	local element = self.Castbar
	--[[
	if(element.castID ~= castID) then
		return
	end
	--]]

	element.casting = nil
	element.notInterruptible = nil

	--[[ Callback: Castbar:PostCastStop(unit)
	Called after the element has been updated when a spell cast has finished.

	* self - the Castbar widget
	* unit - unit for which the update has been triggered (string)
	--]]
	if(element.PostCastStop) then
		return element:PostCastStop(unit)
	end
end

local function UNIT_SPELLCAST_CHANNEL_START(self, event, unit, _, spellID)
	if(self.unit ~= unit and self.realUnit ~= unit) then return end

	local element = self.Castbar
	local name, _, texture, startTime, endTime, _, notInterruptible = UnitChannelInfo(unit)
	if(not name) then
		return
	end

	endTime = endTime / 1e3
	startTime = startTime / 1e3
	local max = (endTime - startTime)
	local duration = endTime - GetTime()

	element.duration = duration
	element.max = max
	element.delay = 0
	element.channeling = true
	element.notInterruptible = notInterruptible
	element.holdTime = 0
	element.spellID = spellID

	-- We have to do this, as it's possible for spell casts to never have _STOP
	-- executed or be fully completed by the OnUpdate handler before CHANNEL_START
	-- is called.
	element.casting = nil
	element.castID = nil

	element:SetMinMaxValues(0, max)
	element:SetValue(duration)

	if(element.Text) then element.Text:SetText(name) end
	if(element.Icon) then element.Icon:SetTexture(texture) end
	if(element.Time) then element.Time:SetText() end

	local shield = element.Shield
	if(shield and notInterruptible) then
		shield:Show()
	elseif(shield) then
		shield:Hide()
	end

	local sf = element.SafeZone
	if(sf) then
		sf:ClearAllPoints()
		sf:SetPoint(element:GetReverseFill() and 'RIGHT' or 'LEFT')
		sf:SetPoint('TOP')
		sf:SetPoint('BOTTOM')
		updateSafeZone(element)
	end

	--[[ Callback: Castbar:PostChannelStart(unit, name)
	Called after the element has been updated upon a spell channel start.

	* self - the Castbar widget
	* unit - unit for which the update has been triggered (string)
	* name - name of the channeled spell (string)
	--]]
	if(element.PostChannelStart) then
		element:PostChannelStart(unit, name)
	end
	element:Show()
end

local function UNIT_SPELLCAST_CHANNEL_UPDATE(self, event, unit)
	if(self.unit ~= unit and self.realUnit ~= unit) then return end

	local element = self.Castbar
	local name, _, _, startTime, endTime = UnitChannelInfo(unit)
	if(not name or not element:IsShown()) then
		return
	end

	local duration = (endTime / 1000) - GetTime()

	element.delay = element.delay + element.duration - duration
	element.duration = duration
	element.max = (endTime - startTime) / 1000

	element:SetMinMaxValues(0, element.max)
	element:SetValue(duration)

	--[[ Callback: Castbar:PostChannelUpdate(unit, name)
	Called after the element has been updated after a channeled spell has been delayed or interrupted.

	* self - the Castbar widget
	* unit - unit for which the update has been triggered (string)
	* name - name of the channeled spell (string)
	--]]
	if(element.PostChannelUpdate) then
		return element:PostChannelUpdate(unit, name)
	end
end

local function UNIT_SPELLCAST_CHANNEL_STOP(self, event, unit)
	if(self.unit ~= unit and self.realUnit ~= unit) then return end

	local element = self.Castbar
	if(element:IsShown()) then
		element.channeling = nil
		element.notInterruptible = nil

		--[[ Callback: Castbar:PostChannelStop(unit)
		Called after the element has been updated after a channeled spell has been completed.

		* self - the Castbar widget
		* unit - unit for which the update has been triggered (string)
		--]]
		if(element.PostChannelStop) then
			return element:PostChannelStop(unit)
		end
	end
end

local function COMBAT_LOG_EVENT_UNFILTERED(self, event)
	local _, subEvent, _, sourceGUID, _, _, _, destGUID, _, _, _, spellID, spellName = CombatLogGetCurrentEventInfo()

	if(subEvent == 'SPELL_CAST_START') then
		local unit = CastScanner.guid[sourceGUID]
			
		if(unit) then
			UNIT_SPELLCAST_START(self, event, unit)
		end

		for unit, guid in pairs(CastScanner.guid) do
			if(guid == sourceGUID) then
				UNIT_SPELLCAST_START(self, event, unit)
			end
		end
	elseif(subEvent == 'SPELL_CAST_SUCCESS') then
		local unit = CastScanner.guid[sourceGUID]
		
		if(unit) then
			local castTime = staticChannelSpells[spellName] or variableChannelSpells[spellID]
			if(castTime) then
				UNIT_SPELLCAST_CHANNEL_START(self, event, unit)
			else
				UNIT_SPELLCAST_STOP(self, event, unit)
			end
		end

		for unit, guid in pairs(CastScanner.guid) do
			if(guid == sourceGUID) then
				local castTime = staticChannelSpells[spellName] or variableChannelSpells[spellID]
				if(castTime) then
					UNIT_SPELLCAST_CHANNEL_START(self, event, unit)
				else
					UNIT_SPELLCAST_STOP(self, event, unit)
				end
			end
		end
	elseif(subEvent == 'SPELL_AURA_REMOVED') then
		local unit = CastScanner.guid[sourceGUID]

		if(unit) then
			if(staticChannelSpells[spellName] or variableChannelSpells[spellID]) then
				UNIT_SPELLCAST_STOP(self, event, unit)
			end
		end

		for unit, guid in pairs(CastScanner.guid) do
			if(guid == sourceGUID) then
				if(staticChannelSpells[spellName] or variableChannelSpells[spellID]) then
					UNIT_SPELLCAST_STOP(self, event, unit)
				end
			end
		end
	elseif(subEvent == 'SPELL_CAST_FAILED') then
		local unit = CastScanner.guid[sourceGUID]

		if(unit and ((sourceGUID == CastScanner.guid.player and not UnitCastingInfo('player')) or sourceGUID ~= CastScanner.guid.player)) then
			UNIT_SPELLCAST_FAILED(self, event, unit)
		end

		for unit, guid in pairs(CastScanner.guid) do
			if(guid == sourceGUID and ((sourceGUID == CastScanner.guid.player and not UnitCastingInfo('player')) or sourceGUID ~= CastScanner.guid.player)) then
				UNIT_SPELLCAST_FAILED(self, event, unit)
			end
		end
	elseif(subEvent == 'SPELL_INTERRUPT') then
		local unit = CastScanner.guid[destGUID]

		if(unit) then
			UNIT_SPELLCAST_INTERRUPTED(self, event, unit)
		end

		for unit, guid in pairs(CastScanner.guid) do
			if(guid == sourceGUID) then
				UNIT_SPELLCAST_INTERRUPTED(self, event, unit)
			end
		end
	elseif(subEvent == 'PARTY_KILL' or subEvent == 'UNIT_DIED') then
		local unit = CastScanner.guid[sourceGUID]

		if(unit) then
			UNIT_SPELLCAST_STOP(self, event, unit)
			UNIT_SPELLCAST_CHANNEL_STOP(self, event, unit)
		end

		for unit, guid in pairs(CastScanner.guid) do
			if(guid == sourceGUID) then
				UNIT_SPELLCAST_STOP(self, event, unit)
				UNIT_SPELLCAST_CHANNEL_STOP(self, event, unit)
			end
		end
	end
end

local function onUpdate(self, elapsed)
	if(self.casting) then
		local duration = self.duration + elapsed
		if(duration >= self.max) then
			self.casting = nil
			self:Hide()

			if(self.PostCastStop) then self:PostCastStop(self.__owner.unit) end
			return
		end

		if(self.Time) then
			if(self.delay ~= 0) then
				if(self.CustomDelayText) then
					self:CustomDelayText(duration)
				else
					self.Time:SetFormattedText('%.1f|cffff0000-%.1f|r', duration, self.delay)
				end
			else
				if(self.CustomTimeText) then
					self:CustomTimeText(duration)
				else
					self.Time:SetFormattedText('%.1f', duration)
				end
			end
		end

		self.duration = duration
		self:SetValue(duration)

		if(self.Spark) then
			local horiz = self.horizontal
			local size = self[horiz and 'GetWidth' or 'GetHeight'](self)

			local offset = (duration / self.max) * size
			if(self:GetReverseFill()) then
				offset = size - offset
			end

			self.Spark:SetPoint('CENTER', self, horiz and 'LEFT' or 'BOTTOM', horiz and offset or 0, horiz and 0 or offset)
		end
	elseif(self.channeling) then
		local duration = self.duration - elapsed

		if(duration <= 0) then
			self.channeling = nil
			self:Hide()

			if(self.PostChannelStop) then self:PostChannelStop(self.__owner.unit) end
			return
		end

		if(self.Time) then
			if(self.delay ~= 0) then
				if(self.CustomDelayText) then
					self:CustomDelayText(duration)
				else
					self.Time:SetFormattedText('%.1f|cffff0000-%.1f|r', duration, self.delay)
				end
			else
				if(self.CustomTimeText) then
					self:CustomTimeText(duration)
				else
					self.Time:SetFormattedText('%.1f', duration)
				end
			end
		end

		self.duration = duration
		self:SetValue(duration)
		if(self.Spark) then
			local horiz = self.horizontal
			local size = self[horiz and 'GetWidth' or 'GetHeight'](self)

			local offset = (duration / self.max) * size
			if(self:GetReverseFill()) then
				offset = size - offset
			end

			self.Spark:SetPoint('CENTER', self, horiz and 'LEFT' or 'BOTTOM', horiz and offset or 0, horiz and 0 or offset)
		end
	elseif(self.holdTime > 0) then
		self.holdTime = self.holdTime - elapsed
	else
		self.casting = nil
		self.castID = nil
		self.channeling = nil

		self:Hide()
	end
end

local function Update(self, ...)
	UNIT_SPELLCAST_START(self, ...)
	return UNIT_SPELLCAST_CHANNEL_START(self, ...)
end

local function ForceUpdate(element)
	return Update(element.__owner, 'ForceUpdate', element.__owner.unit)
end

local function Enable(self, unit)
	local element = self.Castbar
	if(element) then
		element.__owner = self
		element.ForceUpdate = ForceUpdate

		if(not (unit and unit:match'%wtarget$')) then
			self:RegisterEvent('COMBAT_LOG_EVENT_UNFILTERED', COMBAT_LOG_EVENT_UNFILTERED)
		end

		element.horizontal = element:GetOrientation() == 'HORIZONTAL'
		element.holdTime = 0
		element:SetScript('OnUpdate', element.OnUpdate or onUpdate)

		if(self.unit == 'player') then
			self:RegisterEvent('UNIT_SPELLCAST_START', UNIT_SPELLCAST_START)
			self:RegisterEvent('UNIT_SPELLCAST_FAILED', UNIT_SPELLCAST_FAILED)
			self:RegisterEvent('UNIT_SPELLCAST_STOP', UNIT_SPELLCAST_STOP)
			self:RegisterEvent('UNIT_SPELLCAST_INTERRUPTED', UNIT_SPELLCAST_INTERRUPTED)
			self:RegisterEvent('UNIT_SPELLCAST_DELAYED', UNIT_SPELLCAST_DELAYED)
			self:RegisterEvent('UNIT_SPELLCAST_CHANNEL_START', UNIT_SPELLCAST_CHANNEL_START)
			self:RegisterEvent('UNIT_SPELLCAST_CHANNEL_UPDATE', UNIT_SPELLCAST_CHANNEL_UPDATE)
			self:RegisterEvent('UNIT_SPELLCAST_CHANNEL_STOP', UNIT_SPELLCAST_CHANNEL_STOP)
			CastingBarFrame:UnregisterAllEvents()
			CastingBarFrame.Show = CastingBarFrame.Hide
			CastingBarFrame:Hide()

			PetCastingBarFrame:UnregisterAllEvents()
			PetCastingBarFrame.Show = PetCastingBarFrame.Hide
			PetCastingBarFrame:Hide()
		end

		if(element:IsObjectType('StatusBar') and not element:GetStatusBarTexture()) then
			element:SetStatusBarTexture([[Interface\TargetingFrame\UI-StatusBar]])
		end

		local spark = element.Spark
		if(spark and spark:IsObjectType('Texture') and not spark:GetTexture()) then
			spark:SetTexture([[Interface\CastingBar\UI-CastingBar-Spark]])
		end

		local shield = element.Shield
		if(shield and shield:IsObjectType('Texture') and not shield:GetTexture()) then
			shield:SetTexture([[Interface\CastingBar\UI-CastingBar-Small-Shield]])
		end

		local safeZone = element.SafeZone
		if(safeZone and safeZone:IsObjectType('Texture') and not safeZone:GetTexture()) then
			safeZone:SetColorTexture(1, 0, 0)
		end

		return true
	end
end

local function Disable(self)
	local element = self.Castbar
	if(element) then
		element:Hide()

		self:UnregisterEvent('COMBAT_LOG_EVENT_UNFILTERED', COMBAT_LOG_EVENT_UNFILTERED)
		self:UnregisterEvent('UNIT_SPELLCAST_START', UNIT_SPELLCAST_START)
		self:UnregisterEvent('UNIT_SPELLCAST_FAILED', UNIT_SPELLCAST_FAILED)
		self:UnregisterEvent('UNIT_SPELLCAST_STOP', UNIT_SPELLCAST_STOP)
		self:UnregisterEvent('UNIT_SPELLCAST_INTERRUPTED', UNIT_SPELLCAST_INTERRUPTED)
		self:UnregisterEvent('UNIT_SPELLCAST_INTERRUPTIBLE', UNIT_SPELLCAST_INTERRUPTIBLE)
		self:UnregisterEvent('UNIT_SPELLCAST_NOT_INTERRUPTIBLE', UNIT_SPELLCAST_NOT_INTERRUPTIBLE)
		self:UnregisterEvent('UNIT_SPELLCAST_DELAYED', UNIT_SPELLCAST_DELAYED)
		self:UnregisterEvent('UNIT_SPELLCAST_CHANNEL_START', UNIT_SPELLCAST_CHANNEL_START)
		self:UnregisterEvent('UNIT_SPELLCAST_CHANNEL_UPDATE', UNIT_SPELLCAST_CHANNEL_UPDATE)
		self:UnregisterEvent('UNIT_SPELLCAST_CHANNEL_STOP', UNIT_SPELLCAST_CHANNEL_STOP)

		element:SetScript('OnUpdate', nil)
	end
end

oUF:AddElement('Castbar', Update, Enable, Disable)
