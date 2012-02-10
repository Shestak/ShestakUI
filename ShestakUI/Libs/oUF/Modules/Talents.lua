local T, C, L = unpack(select(2, ...))
if C.unitframe.enable ~= true or C.unitframe.plugins_talents ~= true then return end

----------------------------------------------------------------------------------------
--	Based on oUF_Talents(by Fernir)
----------------------------------------------------------------------------------------
local _, ns = ...
local oUF = ns.oUF

local spells = {
	-- WARRIOR
	[GetSpellInfo(12294)] = L_PLANNER_WARRIOR_1,		-- Mortal Strike
	[GetSpellInfo(23881)] = L_PLANNER_WARRIOR_2,		-- Bloodthirst
	[GetSpellInfo(23922)] = L_PLANNER_WARRIOR_3,		-- Shield Slam
	-- PALADIN
	[GetSpellInfo(20473)] = L_PLANNER_PALADIN_1,		-- Holy Shock
	[GetSpellInfo(31935)] = L_PLANNER_PALADIN_2,		-- Avenger's Shield
	[GetSpellInfo(85256)] = L_PLANNER_PALADIN_3,		-- Templar's Verdict
	-- ROGUE
	[GetSpellInfo(1329)] = L_PLANNER_ROGUE_1,			-- Mutilate
	[GetSpellInfo(84617)] = L_PLANNER_ROGUE_2,			-- Revealing Strike
	[GetSpellInfo(16511)] = L_PLANNER_ROGUE_3,			-- Hemorrhage
	-- PRIEST
	[GetSpellInfo(47540)] = L_PLANNER_PRIEST_1,			-- Penance
	[GetSpellInfo(34861)] = L_PLANNER_PRIEST_2,			-- Circle of Healing
	[GetSpellInfo(88684)] = L_PLANNER_PRIEST_2,		    -- Holy Word: Serenity
	[GetSpellInfo(15407)] = L_PLANNER_PRIEST_3,			-- Mind Flay
	-- DEATHKNIGHT
	[GetSpellInfo(55050)] = L_PLANNER_DEATHKNIGHT_1,	-- Heart Strike
	[GetSpellInfo(49143)] = L_PLANNER_DEATHKNIGHT_2,	-- Frost Strike
	[GetSpellInfo(55090)] = L_PLANNER_DEATHKNIGHT_3,	-- Scourge Strike
	-- MAGE
	[GetSpellInfo(44425)] = L_PLANNER_MAGE_1,			-- Arcane Barrage
	[GetSpellInfo(44457)] = L_PLANNER_MAGE_2,			-- Living Bomb
	[GetSpellInfo(44572)] = L_PLANNER_MAGE_3,			-- Deep Freeze
	-- WARLOCK
	[GetSpellInfo(30108)] = L_PLANNER_WARLOCK_1,		-- Unstable Affliction
	[GetSpellInfo(71521)] = L_PLANNER_WARLOCK_2,		-- Hand of Gul'dan
	[GetSpellInfo(17962)] = L_PLANNER_WARLOCK_3,		-- Conflagrate
	[GetSpellInfo(50796)] = L_PLANNER_WARLOCK_3,		-- Chaos Bolt
	-- SHAMAN
	[GetSpellInfo(51490)] = L_PLANNER_SHAMAN_1,			-- Thunderstorm
	[GetSpellInfo(60103)] = L_PLANNER_SHAMAN_2,			-- Lava Lash
	[GetSpellInfo(61295)] = L_PLANNER_SHAMAN_3,			-- Riptide
	-- HUNTER
	[GetSpellInfo(19577)] = L_PLANNER_HUNTER_1,			-- Intimidation
	[GetSpellInfo(19434)] = L_PLANNER_HUNTER_2,			-- Aimed Shot
	[GetSpellInfo(53301)] = L_PLANNER_HUNTER_3,			-- Explosive Shot
	-- DRUID
	[GetSpellInfo(78674)] = L_PLANNER_DRUID_1,			-- Starsurge
	[GetSpellInfo(33876)] = L_PLANNER_DRUID_2,			-- Mangle (Cat)
	[GetSpellInfo(33878)] = L_PLANNER_DRUID_2,			-- Mangle (Bear)
	[GetSpellInfo(18562)] = L_PLANNER_DRUID_3,			-- Swiftmend
}

local buffs = { -- Credits: Proditor, Rinu
	-- WARRIOR
	[GetSpellInfo(60503)] = L_PLANNER_WARRIOR_1,		-- Taste for Blood
	[GetSpellInfo(29801)] = L_PLANNER_WARRIOR_2,		-- Rampage
	[GetSpellInfo(50227)] = L_PLANNER_WARRIOR_3,		-- Sword and Board
	-- PALADIN
	[GetSpellInfo(20053)] = L_PLANNER_PALADIN_1,		-- Conviction
	[GetSpellInfo(20178)] = L_PLANNER_PALADIN_2,		-- Reckoning
	[GetSpellInfo(89906)] = L_PLANNER_PALADIN_3,		-- Judgements of the Bold
	-- ROGUE
	[GetSpellInfo(58426)] = L_PLANNER_ROGUE_1,			-- Overkill
	[GetSpellInfo(13877)] = L_PLANNER_ROGUE_2,			-- Blade Flurry
	[GetSpellInfo(51698)] = L_PLANNER_ROGUE_3,			-- Honor Among Thieves
	-- PRIEST
	[GetSpellInfo(47930)] = L_PLANNER_PRIEST_1,			-- Grace
	[GetSpellInfo(59889)] = L_PLANNER_PRIEST_1,			-- Borrowed Time
	[GetSpellInfo(63735)] = L_PLANNER_PRIEST_2,			-- Serendipity
	[GetSpellInfo(15473)] = L_PLANNER_PRIEST_3,			-- Shadowform
	-- DEATHKNIGHT
	[GetSpellInfo(49222)] = L_PLANNER_DEATHKNIGHT_1,	-- Bone Shield
	[GetSpellInfo(53138)] = L_PLANNER_DEATHKNIGHT_1,	-- Abomination's Might
	[GetSpellInfo(55610)] = L_PLANNER_DEATHKNIGHT_2,	-- Improved Icy Talons
	[GetSpellInfo(81340)] = L_PLANNER_DEATHKNIGHT_3,	-- Sudden Doom
	-- MAGE
	[GetSpellInfo(82930)] = L_PLANNER_MAGE_1,			-- Arcane Tactics
	[GetSpellInfo(48108)] = L_PLANNER_MAGE_2,			-- Hot Streak
	[GetSpellInfo(11426)] = L_PLANNER_MAGE_3,			-- Ice Barrier
	[GetSpellInfo(44544)] = L_PLANNER_MAGE_3,			-- Fingers of Frost
	-- WARLOCK
	[GetSpellInfo(53646)] = L_PLANNER_WARLOCK_2,		-- Demonic Pact
	[GetSpellInfo(30301)] = L_PLANNER_WARLOCK_3,		-- Nether Protection
	-- SHAMAN
	[GetSpellInfo(51466)] = L_PLANNER_SHAMAN_1,			-- Elemental Oath
	[GetSpellInfo(30808)] = L_PLANNER_SHAMAN_2,			-- Unleashed Rage
	[GetSpellInfo(974)] = L_PLANNER_SHAMAN_3,			-- Earth Shield
	-- HUNTER
	[GetSpellInfo(75447)] = L_PLANNER_HUNTER_1,			-- Ferocious Inspiration
	[GetSpellInfo(19506)] = L_PLANNER_HUNTER_2,			-- Trueshot Aura
	[GetSpellInfo(53290)] = L_PLANNER_HUNTER_3,			-- Hunting Party
	-- DRUID
	[GetSpellInfo(24858)] = L_PLANNER_DRUID_1,			-- Moonkin Form
	[GetSpellInfo(17007)] = L_PLANNER_DRUID_2,			-- Leader of the Pack
	[GetSpellInfo(48438)] = L_PLANNER_DRUID_3,			-- Wild Growth
}

local function Update(object, event, unit)
	if object.unit ~= unit or unit == "player" or unit:find("pet") then return end
	object.Talents:SetText("")
	for index = 1, 40 do
		local name, _, _, _, _, _, _, unitCaster = UnitAura(unit, index, "HELPFUL")
		if UnitIsFriend("player", unit) then return end
		if name ~= nil and unitCaster == unit then
			if buffs[name] then
				object.Talents:SetText(buffs[name])
				return
			end
		end
	end
	local spell = select(1, UnitCastingInfo(unit))
	if UnitIsFriend("player", unit) then return end
	if spell then
		if spells[spell] then
			object.Talents:SetText(spells[spell])
			return
		end
	end
end

local function Enable(object)
	if not object.Talents then return end
	object:RegisterEvent("UNIT_AURA", Update)
	object:RegisterEvent("UNIT_SPELLCAST_START", Update)
	return true
end

local function Disable(object)
	if object.Talents then
		object:UnregisterEvent("UNIT_AURA", Update)
		object:UnregisterEvent("UNIT_SPELLCAST_START", Update)
	end
end

oUF:AddElement("Talents", Update, Enable, Disable)
for i, frame in ipairs(oUF.objects) do Enable(frame) end