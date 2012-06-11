local T, C, L = unpack(select(2, ...))
if C.unitframe.enable ~= true or C.unitframe.show_arena ~= true or C.unitframe.plugins_diminishing ~= true then return end

----------------------------------------------------------------------------------------
--	Based on Tukui_DrTracker(by Ildyria)
----------------------------------------------------------------------------------------
local frameposition
if C.unitframe.arena_on_right == true then
	frameposition = {"TOPRIGHT", "TOPLEFT", -76, 2, "RIGHT", "LEFT", -3, 0}
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

local function GetSpellDR()
	return {
		-- Disorients
		[49203] = {"disorient"},	-- Hungering Cold
		[6770] = {"disorient"},		-- Sap
		[1776] = {"disorient"},		-- Gouge
		[51514] = {"disorient"},	-- Hex
		[9484] = {"disorient"},		-- Shackle Undead
		[118] = {"disorient"},		-- Polymorph
		[28272] = {"disorient"},	-- Polymorph (Pig)
		[28271] = {"disorient"},	-- Polymorph (Turtle)
		[61305] = {"disorient"},	-- Polymorph (Black cat)
		[61025] = {"disorient"},	-- Polymorph (Serpent)
		[61721] = {"disorient"},	-- Polymorph (Rabbit)
		[61780] = {"disorient"},	-- Polymorph (Turkey)
		[3355] = {"disorient"},		-- Freezing Trap
		[19386] = {"disorient"},	-- Wyvern Sting
		[20066] = {"disorient"},	-- Repentance
		[90337] = {"disorient"},	-- Bad Manner (Monkey)
		[2637] = {"disorient"},		-- Hibernate
		[82676] = {"disorient", "ctrlstun"},	-- Ring of Frost

		-- Silences
		[50479] = {"silence"},		-- Nether Shock (Nether ray)
		[1330] = {"silence"},		-- Garrote
		[25046] = {"silence"},		-- Arcane Torrent (Energy version)
		[28730] = {"silence"},		-- Arcane Torrent (Mana version)
		[50613] = {"silence"},		-- Arcane Torrent (Runic power version)
		[69179] = {"silence"},		-- Arcane Torrent (Rage version)
		[80483] = {"silence"},		-- Arcane Torrent (Focus version)
		[15487] = {"silence"},		-- Silence
		[34490] = {"silence"},		-- Silencing Shot
		[18425] = {"silence"},		-- Improved Kick (Rank 1)
		[86759] = {"silence"},		-- Improved Kick (Rank 2)
		[18469] = {"silence"},		-- Improved Counterspell (Rank 1)
		[55021] = {"silence"},		-- Improved Counterspell (Rank 2)
		[24259] = {"silence"},		-- Spell Lock (Felhunter)
		[47476] = {"silence"},		-- Strangulate
		[18498] = {"silence"},		-- Gag Order (Warrior talent)
		[74347] = {"silence"},		-- Gag Order (Warrior talent)
		[81261] = {"silence"},		-- Solar Beam
		[31935] = {"silence"},		-- Avenger's Shield

		-- Disarms
		[91644] = {"disarm"},		-- Snatch (Bird of Prey)
		[51722] = {"disarm"},		-- Dismantle
		[676] = {"disarm"},			-- Disarm
		[64058] = {"disarm"},		-- Psychic Horror (Disarm effect)
		[50541] = {"disarm"},		-- Clench (Scorpid)

		-- Fears
		[2094] = {"fear"},			-- Blind
		[5782] = {"fear"},			-- Fear (Warlock)
		[6358] = {"fear"},			-- Seduction (Succubus)
		[5484] = {"fear"},			-- Howl of Terror
		[8122] = {"fear"},			-- Psychic Scream
		[65545] = {"fear"},			-- Psychic Horror
		[1513] = {"fear"},			-- Scare Beast
		[10326] = {"fear"},			-- Turn Evil
		[5246] = {"fear"},			-- Intimidating Shout (Main target)
		[20511] = {"fear"},			-- Intimidating Shout (Secondary targets)

		-- Control Stuns
		[89766] = {"ctrlstun"},		-- Axe Toss (Felguard)
		[50519] = {"ctrlstun"},		-- Sonic Blast (Bat)
		[12809] = {"ctrlstun"},		-- Concussion Blow
		[46968] = {"ctrlstun"},		-- Shockwave
		[853] = {"ctrlstun"},		-- Hammer of Justice
		[5211] = {"ctrlstun"},		-- Bash
		[19577] = {"ctrlstun"},		-- Intimidation
		[22570] = {"ctrlstun"},		-- Maim
		[408] = {"ctrlstun"},		-- Kidney Shot
		[20549] = {"ctrlstun"},		-- War Stomp
		[20252] = {"ctrlstun"},		-- Intercept
		[20253] = {"ctrlstun"},		-- Intercept
		[44572] = {"ctrlstun"},		-- Deep Freeze
		[30283] = {"ctrlstun"},		-- Shadowfury
		[2812] = {"ctrlstun"},		-- Holy Wrath
		[22703] = {"ctrlstun"},		-- Inferno Effect
		[54785] = {"ctrlstun"},		-- Demon Leap (Warlock)
		[47481] = {"ctrlstun"},		-- Gnaw (Ghoul)
		[93433] = {"ctrlstun"},		-- Burrow Attack (Worm)
		[56626] = {"ctrlstun"},		-- Sting (Wasp)
		[85388] = {"ctrlstun"},		-- Throwdown
		[1833] = {"ctrlstun"},		-- Cheap Shot
		[9005] = {"ctrlstun"},		-- Pounce
		[88625] = {"ctrlstun"},		-- Holy Word: Chastise
		[7922] = {"ctrlstun"},		-- Charge

		-- Random Stuns
		[64343] = {"rndstun"},		-- Impact
		[39796] = {"rndstun"},		-- Stoneclaw Stun
		[11210] = {"rndstun"},		-- Improved Polymorph (Rank 1)
		[12592] = {"rndstun"},		-- Improved Polymorph (Rank 2)

		-- Cyclone
		[33786] = {"cyclone"},		-- Cyclone

		-- Roots
		[33395] = {"ctrlroot"},		-- Freeze (Water Elemental)
		[50245] = {"ctrlroot"},		-- Pin (Crab)
		[122] = {"ctrlroot"},		-- Frost Nova
		[339] = {"ctrlroot"},		-- Entangling Roots
		[19975] = {"ctrlroot"},		-- Nature's Grasp (Uses different spellIDs than Entangling Roots for the same spell)
		[64695] = {"ctrlroot"},		-- Earthgrab (Storm, Earth and Fire talent)
		[4167] = {"ctrlroot"},		-- Web (Spider)
		[54706] = {"ctrlroot"},		-- Venom Web Spray (Silithid)
		[19306] = {"ctrlroot"},		-- Counterattack
		[90327] = {"ctrlroot"},		-- Lock Jaw (Dog)
		[11190] = {"ctrlroot"},		-- Improved Cone of Cold (Rank 1)
		[12489] = {"ctrlroot", "rndroot"},	-- Improved Cone of Cold (Rank 2)

		-- Random Roots
		[23694] = {"rndroot"},		-- Improved Hamstring
		[44745] = {"rndroot"},		-- Shattered Barrier (Rank 1)
		[54787] = {"rndroot"},		-- Shattered Barrier (Rank 2)

		-- Horror
		[6789] = {"horror"},		-- Death Coil
		[64044] = {"horror"},		-- Psychic Horror
		[87099] = {"horror"},		-- Sin and Punishment (Rank 1)
		[87100] = {"horror"},		-- Sin and Punishment (Rank 2)

		-- Misc
		[19503] = {"scatters"},		-- Scatter Shot
		[31661] = {"dragons"},		-- Dragon's Breath
		[605] = {"mc"},				-- Mind Control
		[710] = {"banish"},			-- Banish
		[19185] = {"entrapment"},	-- Entrapment
	}
end

local function GetDrIcons()
	return {
		["banish"] = select(3, GetSpellInfo(710)),
		["ctrlstun"] = select(3, GetSpellInfo(44572)),
		["cyclone"] = select(3, GetSpellInfo(33786)),
		["disarm"] = select(3, GetSpellInfo(676)),
		["disorient"] = select(3, GetSpellInfo(118)),
		["entrapment"] = select(3, GetSpellInfo(19185)),
		["fear"] = select(3, GetSpellInfo(8122)),
		["horror"] = select(3, GetSpellInfo(64044)),
		["mc"] = select(3, GetSpellInfo(605)),
		["rndroot"] = select(3, GetSpellInfo(12489)),
		["rndstun"] = select(3, GetSpellInfo(64343)),
		["ctrlroot"] = select(3, GetSpellInfo(122)),
		["scatters"] = select(3, GetSpellInfo(19503)),
		["dragons"] = select(3, GetSpellInfo(31661)),
		["silence"] = select(3, GetSpellInfo(55021)),
		["taunt"] = select(3, GetSpellInfo(355)),
	}
end

function UpdateDRTracker(self)
	local time = self.start + 18 - GetTime()

	if time < 0 then
		local frame = self:GetParent()
		frame.actives[self.cat] = nil
		self:SetScript("OnUpdate", nil)
		DisplayDrActives(frame)
	end
end

function DisplayDrActives(self)
	if not self.actives then return end
	if not self.auras then self.auras = {} end
	local index
	local previous = nil
	index = 1

	for _, _ in pairs(self.actives) do
		local aura = self.auras[index]
		if not aura then
			aura = CreateFrame("Frame", "DrFrame"..self.target..index, self)
			aura:Width(self.size)
			aura:Height(self.size)
			aura:SetScale(1)
			aura:SetTemplate("Default")
			if index == 1 then
				aura:Point(self.anchor, self:GetParent().Health, self.anchorframe, self.x, self.y)
			else
				aura:Point(self.nextanchor, previous, self.nextanchorframe, self.nextx, self.nexty)
			end

			aura.icon = aura:CreateTexture("$parenticon", "ARTWORK")
			aura.icon:Point("TOPLEFT", 2, -2)
			aura.icon:Point("BOTTOMRIGHT", -2, 2)
			aura.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

			aura.cooldown = CreateFrame("Cooldown", "$parentCD", aura, "CooldownFrameTemplate")
			aura.cooldown:SetAllPoints(aura.icon)
			aura.cooldown:SetReverse()

			aura.count = aura:CreateFontString("$parentCount", "OVERLAY")
			aura.count:SetFont(C.font.unit_frames_font, C.font.unit_frames_font_size * 2, C.font.unit_frames_font_style)
			aura.count:Point("BOTTOMRIGHT", -1, 1)
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
		CooldownFrame_SetTimer(aura.cooldown, value.start, 18, 1)
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

local spell = GetSpellDR()
local icon = GetDrIcons()
local eventRegistered = {
	["SPELL_AURA_APPLIED"] = true,
	["SPELL_AURA_REFRESH"] = true,
	["SPELL_AURA_REMOVED"] = true
}

local function CombatLogCheck(self, ...)
	local _, _, eventType, _, _, _, _, _, destGUID, _, _, _, spellID, _, _, auraType, _ = ...
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

local function tdr()
	if InCombatLockdown() then print(ERR_NOT_IN_COMBAT) return end

	local testlist = {"fear", "disorient", "ctrlroot"}

	for frame, target in pairs(framelist) do
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
		DisplayDrActives(self)
	end
end

SLASH_MOVINGDRTRACKER1 = "/tdr"
SlashCmdList.MOVINGDRTRACKER = tdr