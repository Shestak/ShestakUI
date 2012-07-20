local T, C, L = unpack(select(2, ...))
if C.unitframe.enable ~= true or C.raidframe.plugins_aura_watch ~= true then return end

----------------------------------------------------------------------------------------
--	Based on oUF_RaidDebuffs(by Yleaf)
----------------------------------------------------------------------------------------
local _, ns = ...
local oUF = ns.oUF

local addon = {}
ns.oUF_RaidDebuffs = addon
if not _G.oUF_RaidDebuffs then
	_G.oUF_RaidDebuffs = addon
end

local debuff_data = {}
addon.DebuffData = debuff_data

addon.ShowDispelableDebuff = C.raidframe.plugins_debuffhighlight_icon
addon.FilterDispellableDebuff = true
addon.MatchBySpellName = true
addon.priority = 10

local function add(spell)
	if addon.MatchBySpellName and type(spell) == "number" then
		spell = GetSpellInfo(spell)
	end
	debuff_data[spell] = addon.priority
	addon.priority = addon.priority + 1
end

function addon:RegisterDebuffs(t)
	for _, v in next, t do
		add(v)
	end
end

function addon:ResetDebuffData()
	wipe(debuff_data)
	addon.priority = 10
end

local DispellColor = {
	["Magic"]	= {0.2, 0.6, 1},
	["Curse"]	= {0.6, 0, 1},
	["Disease"]	= {0.6, 0.4, 0},
	["Poison"]	= {0, 0.6, 0},
	["none"]	= {unpack(C.media.border_color)},
}

if C.aura.debuff_color_type == true then
	DispellColor.none = {1, 0, 0}
end

local DispellPriority = {
	["Magic"]	= 4,
	["Curse"]	= 3,
	["Disease"]	= 2,
	["Poison"]	= 1,
}

local DispellFilter
do
	local dispellClasses = {
		["PRIEST"] = {
			["Magic"] = true,
			["Disease"] = true,
		},
		["SHAMAN"] = {
			["Magic"] = false,
			["Curse"] = true,
		},
		["PALADIN"] = {
			["Magic"] = false,
			["Poison"] = true,
			["Disease"] = true,
		},
		["MAGE"] = {
			["Curse"] = true,
		},
		["DRUID"] = {
			["Magic"] = false,
			["Curse"] = true,
			["Poison"] = true,
		},
		["MONK"] = {
			["Magic"] = false,
			["Poison"] = true,
			["Disease"] = true,
		},
	}

	DispellFilter = dispellClasses[select(2, UnitClass("player"))] or {}
end

local function CheckSpec(self, event, levels)
	-- Not interested in gained points from leveling
	if event == "CHARACTER_POINTS_CHANGED" and levels > 0 then return end

	-- Check for certain talents to see if we can dispel magic or not
	if select(2, UnitClass("player")) == "PALADIN" then
		-- Check to see if we have the 'Sacred Cleansing' talent
		if T.CheckForKnownTalent(53551) then
			DispellFilter.Magic = true
		else
			DispellFilter.Magic = false
		end
	elseif select(2, UnitClass("player")) == "SHAMAN" then
		-- Check to see if we have the 'Improved Cleanse Spirit' talent
		if T.CheckForKnownTalent(77130) then
			DispellFilter.Magic = true
		else
			DispellFilter.Magic = false
		end
	elseif select(2, UnitClass("player")) == "DRUID" then
		-- Check to see if we have the 'Nature's Cure' talent
		if T.CheckForKnownTalent(88423) then
			DispellFilter.Magic = true
		else
			DispellFilter.Magic = false
		end
	elseif select(2, UnitClass("player")) == "MONK" then
		-- Check to see if we have the 'Internal Medicine' talent
		if T.CheckForKnownTalent(115451) then
			DispellFilter.Magic = true
		else
			DispellFilter.Magic = false
		end
	end
end

local function formatTime(s)
	if s > 60 then
		return format("%dm", s / 60), s % 60
	else
		return format("%d", s), s - floor(s)
	end
end

local abs = math.abs
local function OnUpdate(self, elapsed)
	self.elapsed = (self.elapsed or 0) + elapsed
	if self.elapsed >= 0.1 then
		local timeLeft = self.endTime - GetTime()
		if self.reverse then timeLeft = abs((self.endTime - GetTime()) - self.duration) end
		if timeLeft > 0 then
			local text = formatTime(timeLeft)
			self.time:SetText(text)
		else
			self:SetScript("OnUpdate", nil)
			self.time:Hide()
		end
		self.elapsed = 0
	end
end

local function UpdateDebuff(self, name, icon, count, debuffType, duration, endTime, spellId)
	local f = self.RaidDebuffs
	if name then
		f.icon:SetTexture(icon)
		f.icon:Show()
		f.duration = duration

		if f.count then
			if count and (count > 1) then
				f.count:SetText(count)
				f.count:Show()
			else
				f.count:Hide()
			end
		end

		if spellId and T.ReverseTimer[spellId] then
			f.reverse = true
		else
			f.reverse = nil
		end

		if f.time then
			if duration and (duration > 0) then
				f.endTime = endTime
				f.nextUpdate = 0
				f:SetScript("OnUpdate", OnUpdate)
				f.time:Show()
			else
				f:SetScript("OnUpdate", nil)
				f.time:Hide()
			end
		end

		if f.cd then
			if duration and (duration > 0) then
				f.cd:SetCooldown(endTime - duration, duration)
				f.cd:Show()
			else
				f.cd:Hide()
			end
		end

		local c = DispellColor[debuffType] or DispellColor.none
		f:SetBackdropColor(unpack(C.media.backdrop_color))
		if C.aura.debuff_color_type == true then
			f:SetBackdropBorderColor(c[1], c[2], c[3])
		end

		f:Show()
	else
		f:Hide()
	end
end

local blackList = {
	[105171] = true,	-- Deep Corruption
	[108220] = true,	-- Deep Corruption (trash)
	[106368] = true,	-- Twilight Shift
	[33878] = true,		-- Mangle (Bear)
	[33876] = true,		-- Mangle (Cat)
	[94009] = true,		-- Rend
	[58567] = true,		-- Sunder Armor
	[77661] = true,		-- Searing Flames
	[9007] = true,		-- Pounce Bleed
}

local function Update(self, event, unit)
	if unit ~= self.unit then return end
	local _name, _icon, _count, _dtype, _duration, _endTime, _spellId
	local _priority, priority = 0
	for i = 1, 40 do
		local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId = UnitAura(unit, i, "HARMFUL")
		if not name then break end

		if addon.ShowDispelableDebuff and debuffType then
			if addon.FilterDispellableDebuff then
				DispellPriority[debuffType] = DispellPriority[debuffType] + addon.priority --Make Dispell buffs on top of Boss Debuffs
				priority = DispellFilter[debuffType] and DispellPriority[debuffType]
			else
				priority = DispellPriority[debuffType]
			end

			if priority and (priority > _priority) then
				_priority, _name, _icon, _count, _dtype, _duration, _endTime, _spellId = priority, name, icon, count, debuffType, duration, expirationTime, spellId
			end
		end

		priority = debuff_data[addon.MatchBySpellName and name or spellId]
		if priority and not blackList[spellId] and (priority > _priority) then
			_priority, _name, _icon, _count, _dtype, _duration, _endTime, _spellId = priority, name, icon, count, debuffType, duration, expirationTime, spellId
		end
	end

	UpdateDebuff(self, _name, _icon, _count, _dtype, _duration, _endTime, _spellId)

	DispellPriority = {
		["Magic"]	= 4,
		["Curse"]	= 3,
		["Disease"]	= 2,
		["Poison"]	= 1,
	}
end

local function Enable(self)
	if self.RaidDebuffs then
		self:RegisterEvent("UNIT_AURA", Update)
		return true
	end
	self:RegisterEvent("PLAYER_TALENT_UPDATE", CheckSpec)
	self:RegisterEvent("CHARACTER_POINTS_CHANGED", CheckSpec)
end

local function Disable(self)
	if self.RaidDebuffs then
		self:UnregisterEvent("UNIT_AURA", Update)
		self.RaidDebuffs:Hide()
	end
	self:UnregisterEvent("PLAYER_TALENT_UPDATE", CheckSpec)
	self:UnregisterEvent("CHARACTER_POINTS_CHANGED", CheckSpec)
end

oUF:AddElement("RaidDebuffs", Update, Enable, Disable)