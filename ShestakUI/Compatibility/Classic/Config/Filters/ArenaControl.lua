local T, C, L, _ = unpack(select(2, ...))
if not C.unitframe.enable ~= true or C.unitframe.show_arena ~= true then return end

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Cyclone -> http://www.wowhead.com/spell=33786
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
local function SpellName(id)
	local name = GetSpellInfo(id)
	if name then
		return name
	else
		print("|cffff0000WARNING: spell ID ["..tostring(id).."] no longer exists! Report this to EsreverWoW.|r")
		return "Empty"
	end
end

T.ArenaControl = {
	-- Crowd Controls
	-- Druid
	[SpellName(5211)] = 5,		-- Bash
	[SpellName(16922)] = 5,		-- Celestial Focus
	[SpellName(2637)] = 5,		-- Hibernate
	[SpellName(22570)] = 5,		-- Mangle
	[SpellName(9005)] = 5,		-- Pounce
	-- Hunter
	[SpellName(3355)] = 5,		-- Freezing Trap
	[SpellName(24394)] = 5,		-- Intimidation
	[SpellName(1513)] = 5,		-- Scare Beast
	[SpellName(19503)] = 5,		-- Scatter Shot
	[SpellName(19386)] = 5,		-- Wyvern Sting
	-- Mage
	[SpellName(12355)] = 5,		-- Impact
	[SpellName(118)] = 5,		-- Polymorph
	-- [SpellName(28272)] = 5,		-- Polymorph (Pig)
	-- [SpellName(28271)] = 5,		-- Polymorph (Turtle)
	-- Paladin
	[SpellName(853)] = 5,		-- Hammer of Justice
	[SpellName(20066)] = 5,		-- Repentance
	[SpellName(20170)] = 5,		-- Stun (Seal of Justice Proc)
	[SpellName(2878)] = 5,		-- Turn Undead
	-- Priest
	[SpellName(15269)] = 5,		-- Blackout
	[SpellName(605)] = 5,		-- Mind Control
	[SpellName(8122)] = 5,		-- Psychic Scream
	[SpellName(9484)] = 5,		-- Shackle Undead
	-- Rogue
	[SpellName(2094)] = 5,		-- Blind
	[SpellName(1833)] = 5,		-- Cheap Shot
	[SpellName(1776)] = 5,		-- Gouge
	[SpellName(408)] = 5,		-- Kidney Shot
	[SpellName(6770)] = 5,		-- Sap
	-- Shaman
	-- Warlock
	[SpellName(6789)] = 5,		-- Death Coil
	[SpellName(5782)] = 5,		-- Fear
	[SpellName(5484)] = 5,		-- Howl of Terror
	[SpellName(6358)] = 5,		-- Seduction (Succubus)
	-- Warrior
	[SpellName(7922)] = 5,		-- Charge Stun
	[SpellName(12809)] = 5,		-- Concussion Blow
	[SpellName(20253)] = 5,		-- Intercept Stun
	[SpellName(5246)] = 5,		-- Intimidating Shout
	-- Mace Specialization
	[SpellName(5530)] = 5,		-- Mace Specialization (Rogue / Warrior)
	-- Racial
	[SpellName(20549)] = 5,		-- War Stomp

	-- Silences
	[SpellName(18469)] = 4,		-- Counterspell - Silenced
	[SpellName(15487)] = 4,		-- Silence
	[SpellName(18425)] = 4,		-- Kick - Silenced
	[SpellName(24259)] = 4,		-- Spell Lock (Felhunter)
	[SpellName(18498)] = 4,		-- Shield Bash - Silenced

	-- Roots
	[SpellName(19675)] = 3,		-- Feral Charge Effect
	[SpellName(25999)] = 3,		-- Charge (Boar)
	[SpellName(339)] = 3,		-- Entangling Roots
	[SpellName(19975)] = 3,		-- Entangling Roots (Nature's Grasp)
	[SpellName(19185)] = 3,		-- Entrapment
	[SpellName(122)] = 3,		-- Frost Nova
	[SpellName(12494)] = 3,		-- Frostbite
	[SpellName(23694)] = 3,		-- Improved Hamstring
	
	-- Disarms
	-- [SpellName(14251)] = 1,		-- Riposte
	[SpellName(676)] = 1,		-- Disarm

	-- Immunities
	[SpellName(11958)] = 2,		-- Ice Block
	[SpellName(642)] = 2,		-- Divine Shield

	-- Buffs
	-- Druid
	[SpellName(29166)] = 1,		-- Innervate
	[SpellName(17116)] = 1,		-- Nature's Swiftness
	-- Hunter
	[SpellName(19574)] = 1,		-- Bestial Wrath
	[SpellName(3045)] = 1,		-- Rapid Fire
	--Mage
	[SpellName(12042)] = 1,		-- Arcane Power
	[SpellName(28682)] = 1,		-- Combustion
	[SpellName(12472)] = 1,		-- Icy Veins
	[SpellName(12043)] = 1,		-- Presence of Mind
	-- Paladin
	[SpellName(1044)] = 1,		-- Blessing of Freedom
	[SpellName(1022)] = 1,		-- Blessing of Protection
	[SpellName(6940)] = 1,		-- Blessing of Sacrifice
	[SpellName(20216)] = 1,		-- Divine Favor
	-- Priest
	[SpellName(6346)] = 1,		-- Fear Ward
	[SpellName(10060)] = 1,		-- Power Infusion
	-- Rogue
	[SpellName(13877)] = 1,		-- Blade Flurry
	-- Shaman
	[SpellName(8178)] = 1,		-- Grounding Totem
	[SpellName(16190)] = 1,		-- Mana Tide Totem
	-- Warlock
	[SpellName(18708)] = 1,		-- Fel Domination
	-- Warrior
	[SpellName(18499)] = 1,		-- Berserker Rage
	[SpellName(12292)] = 1,		-- Death Wish
	[SpellName(12976)] = 1,		-- Last Stand
	-- Racial
	[SpellName(20554)] = 1,		-- Berserking (Mana)
	-- [SpellName(26296)] = 1,		-- Berserking (Rage)
	-- [SpellName(26297)] = 1,		-- Berserking (Energy)
	[SpellName(20572)] = 1,		-- Blood Fury
	[SpellName(20600)] = 1,		-- Perception
	[SpellName(20594)] = 1,		-- Stoneform
	[SpellName(7744)] = 1,		-- Will of the Forsaken

	-- Defense abilities
	[SpellName(22812)] = 1,		-- Barkskin
	[SpellName(19263)] = 1,		-- Deterrence
	[SpellName(5277)] = 1,		-- Evasion
	[SpellName(1856)] = 1,		-- Vanish
	[SpellName(23920)] = 1,		-- Spell Reflection
}