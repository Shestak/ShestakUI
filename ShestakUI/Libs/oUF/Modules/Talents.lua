local T, C, L = unpack(select(2, ...))
if C.unitframe.enable ~= true or C.unitframe.plugins_talents ~= true then return end

----------------------------------------------------------------------------------------
--	Based on oUF_Talents(by Fernir)
----------------------------------------------------------------------------------------
local _, ns = ...
local oUF = ns.oUF

local spells = {
	-- DEATHKNIGHT
	[GetSpellInfo(55050)] = L_PLANNER_DEATHKNIGHT_1,	-- Heart Strike
	[GetSpellInfo(49143)] = L_PLANNER_DEATHKNIGHT_2,	-- Frost Strike
	[GetSpellInfo(55090)] = L_PLANNER_DEATHKNIGHT_3,	-- Scourge Strike
	-- DRUID
	[GetSpellInfo(78674)] = L_PLANNER_DRUID_1,			-- Starsurge
	[GetSpellInfo(5221)] = L_PLANNER_DRUID_2,			-- Shred
	[GetSpellInfo(8936)] = L_PLANNER_DRUID_4,			-- Regrowth
	-- HUNTER
	[GetSpellInfo(34026)] = L_PLANNER_HUNTER_1,			-- Kill Command
	[GetSpellInfo(19434)] = L_PLANNER_HUNTER_2,			-- Aimed Shot
	[GetSpellInfo(53209)] = L_PLANNER_HUNTER_2,			-- Chimera Shot
	[GetSpellInfo(53301)] = L_PLANNER_HUNTER_3,			-- Explosive Shot
	-- MAGE
	[GetSpellInfo(30451)] = L_PLANNER_MAGE_1,			-- Arcane Blast
	[GetSpellInfo(133)] = L_PLANNER_MAGE_2,				-- Fireball
	[GetSpellInfo(116)] = L_PLANNER_MAGE_3,				-- Frostbolt
	-- MONK
	[GetSpellInfo(121253)] = L_PLANNER_MONK_1,			-- Keg Smash
	[GetSpellInfo(115181)] = L_PLANNER_MONK_1,			-- Breath of Fire
	[GetSpellInfo(115175)] = L_PLANNER_MONK_2,			-- Soothing Mist
	[GetSpellInfo(107428)] = L_PLANNER_MONK_3,			-- Rising Sun Kick
	-- PALADIN
	[GetSpellInfo(20473)] = L_PLANNER_PALADIN_1,		-- Holy Shock
	[GetSpellInfo(31935)] = L_PLANNER_PALADIN_2,		-- Avenger's Shield
	[GetSpellInfo(879)] = L_PLANNER_PALADIN_3,			-- Exorcism
	[GetSpellInfo(85256)] = L_PLANNER_PALADIN_3,		-- Templar's Verdict
	-- PRIEST
	[GetSpellInfo(47540)] = L_PLANNER_PRIEST_1,			-- Penance
	[GetSpellInfo(34861)] = L_PLANNER_PRIEST_2,			-- Circle of Healing
	[GetSpellInfo(15407)] = L_PLANNER_PRIEST_3,			-- Mind Flay
	-- ROGUE
	[GetSpellInfo(1329)] = L_PLANNER_ROGUE_1,			-- Mutilate
	[GetSpellInfo(84617)] = L_PLANNER_ROGUE_2,			-- Revealing Strike
	[GetSpellInfo(16511)] = L_PLANNER_ROGUE_3,			-- Hemorrhage
	-- SHAMAN
	[GetSpellInfo(51490)] = L_PLANNER_SHAMAN_1,			-- Thunderstorm
	[GetSpellInfo(60103)] = L_PLANNER_SHAMAN_2,			-- Lava Lash
	[GetSpellInfo(61295)] = L_PLANNER_SHAMAN_3,			-- Riptide
	-- WARLOCK
	[GetSpellInfo(30108)] = L_PLANNER_WARLOCK_1,		-- Unstable Affliction
	[GetSpellInfo(86040)] = L_PLANNER_WARLOCK_2,		-- Hand of Gul'dan
	[GetSpellInfo(348)] = L_PLANNER_WARLOCK_3,			-- Immolate
	[GetSpellInfo(29722)] = L_PLANNER_WARLOCK_3,		-- Incinerate
	-- WARRIOR
	[GetSpellInfo(12294)] = L_PLANNER_WARRIOR_1,		-- Mortal Strike
	[GetSpellInfo(23881)] = L_PLANNER_WARRIOR_2,		-- Bloodthirst
	[GetSpellInfo(23922)] = L_PLANNER_WARRIOR_3,		-- Shield Slam
}

local buffs = { -- Credits: Proditor, Rinu
	-- DEATHKNIGHT
	[GetSpellInfo(50421)] = L_PLANNER_DEATHKNIGHT_1,	-- Scent of Blood
	[GetSpellInfo(55610)] = L_PLANNER_DEATHKNIGHT_2,	-- Improved Icy Talons
	[GetSpellInfo(81340)] = L_PLANNER_DEATHKNIGHT_3,	-- Sudden Doom
	-- DRUID
	[GetSpellInfo(24858)] = L_PLANNER_DRUID_1,			-- Moonkin Form
	[GetSpellInfo(52610)] = L_PLANNER_DRUID_2,			-- Savage Roar
	[GetSpellInfo(5229)] = L_PLANNER_DRUID_3,			-- Enrage
	[GetSpellInfo(135286)] = L_PLANNER_DRUID_3,			-- Tooth and Claw
	[GetSpellInfo(33763)] = L_PLANNER_DRUID_4,			-- Lifebloom
	[GetSpellInfo(48438)] = L_PLANNER_DRUID_4,			-- Wild Growth
	-- HUNTER
	[GetSpellInfo(82692)] = L_PLANNER_HUNTER_1,			-- Focus Fire
	[GetSpellInfo(53220)] = L_PLANNER_HUNTER_2,			-- Steady Focus
	[GetSpellInfo(56453)] = L_PLANNER_HUNTER_3,			-- Lock and Load
	-- MAGE
	[GetSpellInfo(79683)] = L_PLANNER_MAGE_1,			-- Arcane Missiles!
	[GetSpellInfo(48107)] = L_PLANNER_MAGE_2,			-- Heating Up
	[GetSpellInfo(44544)] = L_PLANNER_MAGE_3,			-- Fingers of Frost
	-- MONK
	[GetSpellInfo(115295)] = L_PLANNER_MONK_1,			-- Guard
	[GetSpellInfo(115867)] = L_PLANNER_MONK_2,			-- Mana Tea
	[GetSpellInfo(119611)] = L_PLANNER_MONK_2,			-- Renewing Mist
	[GetSpellInfo(125359)] = L_PLANNER_MONK_3,			-- Tiger Power
	-- PALADIN
	[GetSpellInfo(53563)] = L_PLANNER_PALADIN_1,		-- Beacon of Light
	[GetSpellInfo(114637)] = L_PLANNER_PALADIN_2,		-- Bastion of Glory
	[GetSpellInfo(84963)] = L_PLANNER_PALADIN_3,		-- Inquisition
	-- PRIEST
	[GetSpellInfo(77613)] = L_PLANNER_PRIEST_1,			-- Grace
	[GetSpellInfo(59889)] = L_PLANNER_PRIEST_1,			-- Borrowed Time
	[GetSpellInfo(63735)] = L_PLANNER_PRIEST_2,			-- Serendipity
	[GetSpellInfo(15473)] = L_PLANNER_PRIEST_3,			-- Shadowform
	-- ROGUE
	[GetSpellInfo(121153)] = L_PLANNER_ROGUE_1,			-- Blindside
	[GetSpellInfo(13877)] = L_PLANNER_ROGUE_2,			-- Blade Flurry
	[GetSpellInfo(31665)] = L_PLANNER_ROGUE_3,			-- Master of Subtlety
	-- SHAMAN
	[GetSpellInfo(51470)] = L_PLANNER_SHAMAN_1,			-- Elemental Oath
	[GetSpellInfo(30809)] = L_PLANNER_SHAMAN_2,			-- Unleashed Rage
	[GetSpellInfo(974)] = L_PLANNER_SHAMAN_3,			-- Earth Shield
	-- WARLOCK
	[GetSpellInfo(122355)] = L_PLANNER_WARLOCK_2,		-- Molten Core
	[GetSpellInfo(117828)] = L_PLANNER_WARLOCK_3,		-- Backdraft
	-- WARRIOR
	[GetSpellInfo(60503)] = L_PLANNER_WARRIOR_1,		-- Taste for Blood
	[GetSpellInfo(46916)] = L_PLANNER_WARRIOR_2,		-- Bloodsurge
	[GetSpellInfo(50227)] = L_PLANNER_WARRIOR_3,		-- Sword and Board
}

local function Update(object, event, unit)
	if object.unit ~= unit or unit == "player" or unit:find("pet") then return end
	object.Talents:SetText("")
	if UnitIsFriend("player", unit) or not UnitIsPlayer(unit) then return end
	for index = 1, 40 do
		local name, _, _, _, _, _, _, unitCaster = UnitAura(unit, index, "HELPFUL")
		if name ~= nil and unitCaster == unit then
			if buffs[name] then
				object.Talents:SetText(buffs[name])
				return
			end
		end
	end
	local spell = UnitCastingInfo(unit)
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