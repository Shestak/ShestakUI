local T, C, L = unpack(select(2, ...))
if C.unitframe.enable ~= true or C.raidframe.plugins_aura_watch ~= true then return end

----------------------------------------------------------------------------------------
--	Based on oUF_RaidDebuffs(by Yleaf)
----------------------------------------------------------------------------------------
local _, ns = ...
local oUF = ns.oUF

local bossDebuffPrio = 9999999
local invalidPrio = -1
local auraFilters = {
	["HARMFUL"] = true,
}

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
		["DRUID"] = {
			["Magic"] = false,
			["Curse"] = true,
			["Poison"] = true,
		},
		["MAGE"] = {
			["Curse"] = true,
		},
		["MONK"] = {
			["Magic"] = false,
			["Poison"] = true,
			["Disease"] = true,
		},
		["PALADIN"] = {
			["Magic"] = false,
			["Poison"] = true,
			["Disease"] = true,
		},
		["PRIEST"] = {
			["Magic"] = false,
			["Disease"] = true,
		},
		["SHAMAN"] = {
			["Magic"] = false,
			["Disease"] = false, -- for Classic
			["Curse"] = true,
		},
	}

	DispellFilter = dispellClasses[T.class] or {}
end

local function CheckSpec()
	if not IsClassicBuild() then
		local spec = GetSpecialization()
		if T.class == "DRUID" then
			if spec == 4 then
				DispellFilter.Magic = true
			else
				DispellFilter.Magic = false
			end
		elseif T.class == "MONK" then
			if spec == 2 then
				DispellFilter.Magic = true
			else
				DispellFilter.Magic = false
			end
		elseif T.class == "PALADIN" then
			if spec == 1 then
				DispellFilter.Magic = true
			else
				DispellFilter.Magic = false
			end
		elseif T.class == "PRIEST" then
			if spec == 3 then
				DispellFilter.Magic = false
			else
				DispellFilter.Magic = true
			end
		elseif T.class == "SHAMAN" then
			if spec == 3 then
				DispellFilter.Magic = true
			else
				DispellFilter.Magic = false
			end
		end
	else
		if T.class == "PALADIN" then
			DispellFilter.Magic = true
		elseif T.class == "PRIEST" then
			DispellFilter.Magic = true
		elseif T.class == "SHAMAN" then
			DispellFilter.Disease = true
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
		local timeLeft = self.expirationTime - GetTime()
		if self.reverse then timeLeft = abs((self.expirationTime - GetTime()) - self.duration) end
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

local UpdateDebuffFrame = function(rd, icon, count, debuffType, duration, expirationTime, spellId)
	if rd.index and rd.type and rd.filter then
		if rd.icon then
			rd.icon:SetTexture(icon)
			rd.icon:Show()
		end

		if rd.count then
			if count and (count > 1) then
				rd.count:SetText(count)
				rd.count:Show()
			else
				rd.count:Hide()
			end
		end

		if spellId and T.RaidDebuffsReverse[spellId] then
			rd.reverse = true
		else
			rd.reverse = nil
		end

		if rd.time then
			rd.duration = duration
			if duration and (duration > 0) then
				rd.expirationTime = expirationTime
				rd.nextUpdate = 0
				rd:SetScript("OnUpdate", OnUpdate)
				rd.time:Show()
			else
				rd:SetScript("OnUpdate", nil)
				rd.time:Hide()
			end
		end

		if rd.cd then
			if duration and (duration > 0) then
				rd.cd:SetCooldown(expirationTime - duration, duration)
				rd.cd:Show()
			else
				rd.cd:Hide()
			end
		end

		local c = DispellColor[debuffType] or DispellColor.none
		if C.aura.debuff_color_type == true then
			rd:SetBackdropBorderColor(c[1], c[2], c[3])
		end

		if not rd:IsShown() then
			rd:Show()
		end
	else
		if rd:IsShown() then
			rd:Hide()
		end
	end
end

local Update = function(self, event, unit)
	if unit ~= self.unit then return end
	local rd = self.RaidDebuffs
	rd.priority = invalidPrio
	local _icon, _count, _debuffType, _duration, _expirationTime, _spellId

	for filter in next, (rd.Filters or auraFilters) do
		local i = 0
		while(true) do
			i = i + 1
			local name, icon, count, debuffType, duration, expirationTime, _, _, _, spellId, _, isBossDebuff = UnitAura(unit, i, filter)
			if not name then break end

			if rd.ShowBossDebuff and isBossDebuff then
				local prio = rd.BossDebuffPriority or bossDebuffPrio
				if prio and prio > rd.priority then
					rd.priority = prio
					rd.index = i
					rd.type = "Boss"
					rd.filter = filter
					_icon, _count, _debuffType, _duration, _expirationTime, _spellId = icon, count, debuffType, duration, expirationTime, spellId
				end
			end

			if rd.ShowDispellableDebuff and debuffType then
				local disPrio = rd.DispellPriority or DispellPriority
				local disFilter = rd.DispellFilter or DispellFilter
				local prio

				if rd.FilterDispellableDebuff and disFilter then
					prio = disFilter[debuffType] and disPrio[debuffType]
				else
					prio = disPrio[debuffType]
				end

				if prio and prio > rd.priority then
					rd.priority = prio
					rd.index = i
					rd.type = "Dispel"
					rd.filter = filter
					_icon, _count, _debuffType, _duration, _expirationTime, _spellId = icon, count, debuffType, duration, expirationTime, spellId
				end
			end

			local prio = rd.Debuffs and rd.Debuffs[rd.MatchBySpellName and name or spellId]
			local prioPvP
			if C.raidframe.plugins_pvp_debuffs == true then
				prioPvP = rd.Debuffs and T.PvPDebuffs[rd.MatchBySpellName and name or spellId]
			end
			if not T.RaidDebuffsIgnore[spellId] and (prio and (prio > rd.priority) or prioPvP and (prioPvP > rd.priority)) then
				if (prio and not prioPvP) or ((prio and prioPvP) and prio > prioPvP) then
					rd.priority = prio
				else
					rd.priority = prioPvP
				end
				rd.index = i
				rd.type = "Custom"
				rd.filter = filter
				_icon, _count, _debuffType, _duration, _expirationTime, _spellId = icon, count, debuffType, duration, expirationTime, spellId
			end
		end
	end

	if rd.priority == invalidPrio then
		rd.index = nil
		rd.filter = nil
		rd.type = nil
	end

	return UpdateDebuffFrame(rd, _icon, _count, _debuffType, _duration, _expirationTime, _spellId)
end

local Path = function(self, ...)
	return (self.RaidDebuffs.Override or Update) (self, ...)
end

local ForceUpdate = function(element)
	return Path(element.__owner, "ForceUpdate", element.__owner.unit)
end

local Enable = function(self)
	local rd = self.RaidDebuffs
	if rd then
		self:RegisterEvent("UNIT_AURA", Path)
		rd.ForceUpdate = ForceUpdate
		rd.__owner = self
		return true
	end
	if not IsClassicBuild() then
		self:RegisterEvent("PLAYER_TALENT_UPDATE", CheckSpec, true)
	else
		self:RegisterEvent("CHARACTER_POINTS_CHANGED", CheckSpec, true)
	end
	CheckSpec()
end

local Disable = function(self)
	if self.RaidDebuffs then
		self:UnregisterEvent("UNIT_AURA", Path)
		self.RaidDebuffs:Hide()
		self.RaidDebuffs.__owner = nil
	end
	if not IsClassicBuild() then
		self:UnregisterEvent("PLAYER_TALENT_UPDATE", CheckSpec)
	else
		self:UnregisterEvent("CHARACTER_POINTS_CHANGED", CheckSpec)
	end
end

oUF:AddElement("RaidDebuffs", Update, Enable, Disable)
