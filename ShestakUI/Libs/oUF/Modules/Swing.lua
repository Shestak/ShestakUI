local T, C, L = unpack(select(2, ...))
if C.unitframe.enable ~= true or C.unitframe.plugins_swing ~= true then return end

----------------------------------------------------------------------------------------
--	Based on oUF_Swing(by p3lim and Thalyra)
----------------------------------------------------------------------------------------
local _, ns = ...
local oUF = ns.oUF

local function OnDurationUpdate(self)
	self:SetMinMaxValues(self.min, self.max)

	local swingelapsed = GetTime()
	if swingelapsed > self.max then
		self:Hide()
		self:SetScript("OnUpdate", nil)
	else
		self:SetValue(self.min + (swingelapsed - self.min))

		if self.Text then
			if self.OverrideText then
				self:OverrideText(swingelapsed)
			else
				self.Text:SetFormattedText("%.1f", self.max - swingelapsed)
			end
		end
	end
end

local function Melee(self)
	local _, event, _, GUID, _, _, _, tarGUID, _, _, _, missType = CombatLogGetCurrentEventInfo()
	local bar = self.Swing

	if UnitGUID(self.unit) == tarGUID then
		if string.find(event, "MISSED") then
			if missType == "PARRY" then
				bar.max = bar.min + ((bar.max - bar.min) * 0.6)
				bar:SetMinMaxValues(bar.min, bar.max)
			end
		end
	elseif UnitGUID(self.unit) == GUID then
		if not string.find(event, "SWING") then return end

		bar.min = GetTime()
		bar.max = bar.min + UnitAttackSpeed(self.unit)
		local itemId = GetInventoryItemID("player", 17)

		if itemId ~= nil then
			local _, _, _, _, _, itemType = GetItemInfo(itemId)
			local _, _, _, _, _, weaponType = GetItemInfo(25)
			if itemType ~= weaponType then -- Worn Shortsword, little "hack" for language support
				bar:Show()
				bar:SetMinMaxValues(bar.min, bar.max)
				bar:SetScript("OnUpdate", OnDurationUpdate)
			else
				bar:Hide()
				bar:SetScript("OnUpdate", nil)
			end
		else
			bar:Show()
			bar:SetMinMaxValues(bar.min, bar.max)
			bar:SetScript("OnUpdate", OnDurationUpdate)
		end
	end
end

local function Ranged(self, event, unit, spellName)
	if spellName ~= GetSpellInfo(75) and spellName ~= GetSpellInfo(5019) then return end

	local bar = self.Swing
	bar.min = GetTime()
	bar.max = bar.min + UnitRangedDamage(unit)

	bar:Show()
	bar:SetMinMaxValues(bar.min, bar.max)
	bar:SetScript("OnUpdate", OnDurationUpdate)
end

local function Ooc(self)
	local bar = self.Swing
	bar:Hide()
end

local function Enable(self, unit)
	local bar = self.Swing
	if bar and unit == "player" then

		if not bar.disableRanged then
			self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED", Ranged)
		end

		if not bar.disableMelee then
			self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED", Melee, true)
		end

		if not bar.disableOoc then
			self:RegisterEvent("PLAYER_REGEN_ENABLED", Ooc, true)
		end

		bar:Hide()

		return true
	end
end

local function Disable(self)
	local bar = self.Swing
	if bar then
		if not bar.disableRanged then
			self:UnregisterEvent("UNIT_SPELLCAST_SUCCEEDED", Ranged)
		end

		if not bar.disableMelee then
			self:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED", Melee)
		end

		if not bar.disableOoc then
			self:UnregisterEvent("PLAYER_REGEN_ENABLED", Ooc)
		end
	end
end

oUF:AddElement("Swing", nil, Enable, Disable)