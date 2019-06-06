local T, C, L, _ = unpack(select(2, ...))
if C.unitframe.enable ~= true or C.unitframe.show_arena ~= true or C.unitframe.plugins_diminishing ~= true then return end

----------------------------------------------------------------------------------------
--	Based on Tukui_DrTracker(by Ildyria)
----------------------------------------------------------------------------------------
local frameposition
if C.unitframe.arena_on_right == true then
	frameposition = {"TOPRIGHT", "TOPLEFT", -39, 2, "RIGHT", "LEFT", -3, 0}
else
	frameposition = {"TOPLEFT", "TOPRIGHT", 39, 2, "LEFT", "RIGHT", 3, 0}
end
local framelist = {
	--[FRAME NAME] = {UNITID, SIZE, ANCHOR, ANCHORFRAME, X, Y, "ANCHORNEXT", "ANCHORPREVIOUS", nextx, nexty},
	--["oUF_Player"] = {"player", 31, "TOPRIGHT", "TOPLEFT", -5, 2, "RIGHT", "LEFT", -3, 0},
	["oUF_Arena1"] = {"arena1", 31, unpack(frameposition)},
	["oUF_Arena2"] = {"arena2", 31, unpack(frameposition)},
	["oUF_Arena3"] = {"arena3", 31, unpack(frameposition)},
	["oUF_Arena4"] = {"arena4", 31, unpack(frameposition)},
	["oUF_Arena5"] = {"arena5", 31, unpack(frameposition)},
}

function UpdateDRTracker(self)
	local time = self.start + 18 - GetTime()

	if time < 0 then
		local frame = self:GetParent()
		frame.actives[self.cat] = nil
		self:SetScript("OnUpdate", nil)
		DisplayDrActives(frame)
	end
end

function DisplayDrActives(self, test)
	local _, instanceType = IsInInstance()
	if instanceType ~= "arena" and not test then return end

	if not self.actives then return end
	if not self.auras then self.auras = {} end
	local index
	local previous = nil
	index = 1

	for _, _ in pairs(self.actives) do
		local aura = self.auras[index]
		if not aura then
			aura = CreateFrame("Frame", "DrFrame"..self.target..index, self)
			aura:SetTemplate("Default")
			aura:SetSize(self.size, self.size)
			if index == 1 then
				aura:SetPoint(self.anchor, self:GetParent().Health, self.anchorframe, self.x, self.y)
			else
				aura:SetPoint(self.nextanchor, previous, self.nextanchorframe, self.nextx, self.nexty)
			end

			aura.icon = aura:CreateTexture("$parentIcon", "ARTWORK")
			aura.icon:SetPoint("TOPLEFT", 2, -2)
			aura.icon:SetPoint("BOTTOMRIGHT", -2, 2)
			aura.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

			aura.cooldown = CreateFrame("Cooldown", "$parentCD", aura, "CooldownFrameTemplate")
			aura.cooldown:SetAllPoints(aura.icon)
			aura.cooldown:SetReverse(true)

			aura.count = aura:CreateFontString("$parentCount", "OVERLAY")
			aura.count:SetFont(C.font.unit_frames_font, C.font.unit_frames_font_size * 2, C.font.unit_frames_font_style)
			aura.count:SetPoint("BOTTOMRIGHT", -1, 1)
			aura.count:SetJustifyH("CENTER")
			aura.cat = "cat"
			aura.start = 0

			self.auras[index] = aura
		end

		previous = aura
		index = index + 1
	end

	index = 1
	for cat, value in pairs(self.actives) do
		aura = self.auras[index]
		aura.icon:SetTexture(value.icon)
		aura.count:SetText(value.dr)
		aura.count:Hide()
		if value.dr == 1 then
			aura:SetBackdropBorderColor(0, 1, 0, 1)
		elseif value.dr == 2 then
			aura:SetBackdropBorderColor(1, 0.5, 0, 1)
		else
			aura:SetBackdropBorderColor(1, 0, 0, 1)
		end
		CooldownFrame_Set(aura.cooldown, value.start, 18, 1)
		aura.start = value.start
		aura.cat = cat
		aura:SetScript("OnUpdate", UpdateDRTracker)
		aura.cooldown:Show()

		aura:Show()
		index = index + 1
	end

	for i = index, #self.auras, 1 do
		local aura = self.auras[i]
		aura:SetScript("OnUpdate", nil)
		aura:Hide()
	end
end

local spell = T.DiminishingSpells
local icon = T.DiminishingIcons
local eventRegistered = {
	["SPELL_AURA_APPLIED"] = true,
	["SPELL_AURA_REFRESH"] = true,
	["SPELL_AURA_REMOVED"] = true
}

local function CombatLogCheck(self)
	local _, instanceType = IsInInstance()
	if instanceType ~= "arena" then return end
	local _, eventType, _, _, _, _, _, destGUID, _, _, _, spellID, _, _, auraType = CombatLogGetCurrentEventInfo()
	if not eventRegistered[eventType] then return end
	if destGUID ~= UnitGUID(self.target) then return end

	local needupdate = false
	if eventType == "SPELL_AURA_APPLIED" then
		if auraType == "DEBUFF" and spell[spellID] then
			if not self.actives then self.actives = {} end
			for _, cat in pairs(spell[spellID]) do
				if self.actives[cat] then
					if self.actives[cat].start + 18 < GetTime() then
						self.actives[cat].start = GetTime()
						self.actives[cat].dr = 1
						self.actives[cat].icon = icon[cat]
					else
						self.actives[cat].start = GetTime()
						self.actives[cat].dr = 2 * self.actives[cat].dr
						self.actives[cat].icon = icon[cat]
					end
				else
					self.actives[cat] = {}
					self.actives[cat].start = GetTime()
					self.actives[cat].dr = 1
					self.actives[cat].icon = icon[cat]
				end
			end
			needupdate = true
		end
	elseif eventType == "SPELL_AURA_REFRESH" then
		if auraType == "DEBUFF" and spell[spellID] then
			if not self.actives then self.actives = {} end
			for _, cat in pairs(spell[spellID]) do
				if not self.actives[cat] then
					self.actives[cat] = {}
					self.actives[cat].dr = 1
				end
				self.actives[cat].start = GetTime()
				self.actives[cat].dr = 2 * self.actives[cat].dr
				self.actives[cat].icon = icon[cat]
			end
			needupdate = true
		end
	elseif eventType == "SPELL_AURA_REMOVED" then
		if auraType == "DEBUFF" and spell[spellID] then
			if not self.actives then self.actives = {} end
			for _, cat in pairs(spell[spellID]) do
				if self.actives[cat] then
					if self.actives[cat].start + 18 < GetTime() then
						self.actives[cat].start = GetTime()
						self.actives[cat].dr = 1
						self.actives[cat].icon = icon[cat]
					else
						self.actives[cat].start = GetTime()
						self.actives[cat].dr = self.actives[cat].dr
						self.actives[cat].icon = icon[cat]
					end
				else
					self.actives[cat] = {}
					self.actives[cat].start = GetTime()
					self.actives[cat].dr = 1
					self.actives[cat].icon = icon[cat]
				end
			end
			needupdate = true
		end
	end

	if needupdate then DisplayDrActives(self) end
end

for frame, target in pairs(framelist) do
	self = _G[frame]
	local DrTracker = CreateFrame("Frame", nil, self)
	DrTracker:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	DrTracker:SetScript("OnEvent", CombatLogCheck)
	DrTracker.target = target[1]
	DrTracker.size = target[2]
	DrTracker.anchor = target[3]
	DrTracker.anchorframe = target[4]
	DrTracker.x = target[5]
	DrTracker.y = target[6]
	DrTracker.nextanchor = target[7]
	DrTracker.nextanchorframe = target[8]
	DrTracker.nextx = target[9]
	DrTracker.nexty = target[10]
	self.DrTracker = DrTracker
end

for spell in pairs(T.DiminishingSpells) do
	local name = GetSpellInfo(spell)
	if not name then
		if not T.classic then
			print("|cffff0000WARNING: spell ID ["..tostring(spell).."] no longer exists! Report this to Shestak.|r")
		else
			print("|cffff0000WARNING: spell ID ["..tostring(spell).."] no longer exists! Report this to EsreverWoW.|r")
		end
	end
end

local function tdr()
	if InCombatLockdown() then print("|cffffff00"..ERR_NOT_IN_COMBAT.."|r") return end

	local testlist = {"stun", "root", "silence"}

	for frame in pairs(framelist) do
		self = _G[frame].DrTracker
		if not self.actives then self.actives = {} end
		local dr = 1
		for _, cat in pairs(testlist) do
			if not self.actives[cat] then self.actives[cat] = {} end
			self.actives[cat].dr = dr
			self.actives[cat].start = GetTime()
			self.actives[cat].icon = icon[cat]
			dr = dr * 2
		end
		DisplayDrActives(self, true)
	end
end

SlashCmdList.DIMINISHINGCD = tdr
SLASH_DIMINISHINGCD1 = "/tdr"
SLASH_DIMINISHINGCD2 = "/евк"