local T, C, L = unpack(select(2, ...))
if C.unitframe.enable ~= true or C.unitframe.show_arena ~= true then return end

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example : Incinerate Flesh from Lord Jaraxxus -> http://www.wowhead.com/?spell=67049
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
T.ArenaControl = function()
	return {
		-- Crowd Control
		[GetSpellInfo(33786)] = 3,	-- Cyclone
		[GetSpellInfo(2637)] = 3,	-- Hibernate
		[GetSpellInfo(55041)] = 3,	-- Freezing Trap Effect
		[GetSpellInfo(6770)] = 3,	-- Sap
		[GetSpellInfo(2094)] = 3,	-- Blind
		[GetSpellInfo(5782)] = 3,	-- Fear
		[GetSpellInfo(6789)] = 3,	-- Death Coil Warlock
		[GetSpellInfo(6358)] = 3,	-- Seduction
		[GetSpellInfo(5484)] = 3,	-- Howl of Terror
		[GetSpellInfo(5246)] = 3,	-- Intimidating Shout
		[GetSpellInfo(8122)] = 3,	-- Psychic Scream
		[GetSpellInfo(118)] = 3,	-- Polymorph
		[GetSpellInfo(28272)] = 3,	-- Polymorph pig
		[GetSpellInfo(28271)] = 3,	-- Polymorph turtle
		[GetSpellInfo(61305)] = 3,	-- Polymorph black cat
		[GetSpellInfo(61025)] = 3,	-- Polymorph serpent
		[GetSpellInfo(51514)] = 3,	-- Hex
		[GetSpellInfo(710)] = 3,	-- Banish

		-- Roots
		[GetSpellInfo(339)] = 3,	-- Entangling Roots
		[GetSpellInfo(122)] = 3,	-- Frost Nova
		[GetSpellInfo(87194)] = 3,	-- Paralysis (SP)
		[GetSpellInfo(33395)] = 3,	-- Freeze
		[GetSpellInfo(16979)] = 3,	-- Feral Charge
		[GetSpellInfo(13810)] = 1,	-- Frost Trap
		[GetSpellInfo(61394)] = 1,	-- Frost Trap Glyph

		-- Stuns and Incapacitates
		[GetSpellInfo(5211)] = 3,	-- Bash
		[GetSpellInfo(1833)] = 3,	-- Cheap Shot
		[GetSpellInfo(408)] = 3,	-- Kidney Shot
		[GetSpellInfo(1776)] = 3,	-- Gouge
		[GetSpellInfo(44572)] = 3,	-- Deep Freeze
		[GetSpellInfo(19386)] = 3,	-- Wyvern Sting
		[GetSpellInfo(19503)] = 3,	-- Scatter Shot
		[GetSpellInfo(9005)] = 3,	-- Pounce
		[GetSpellInfo(22570)] = 3,	-- Maim
		[GetSpellInfo(853)] = 3,	-- Hammer of Justice
		[GetSpellInfo(20066)] = 3,	-- Repentance
		[GetSpellInfo(46968)] = 3,	-- Shockwave
		[GetSpellInfo(49203)] = 3,	-- Hungering Cold
		[GetSpellInfo(47481)] = 3,	-- Gnaw (dk pet stun)
		[GetSpellInfo(91797)] = 3,	-- Gnaw (dk pet stun mutant)
		[GetSpellInfo(24394)] = 3,	-- Intimidation

		-- Silences
		[GetSpellInfo(18469)] = 1,	-- Improved Counterspell
		[GetSpellInfo(15487)] = 1,	-- Silence
		[GetSpellInfo(34490)] = 1,	-- Silencing Shot
		[GetSpellInfo(18425)] = 1,	-- Improved Kick
		[GetSpellInfo(47476)] = 1,	-- Strangulate

		-- Disarms
		[GetSpellInfo(676)] = 1,	-- Disarm
		[GetSpellInfo(51722)] = 1,	-- Dismantle
		[GetSpellInfo(50541)] = 1,	-- Clench - Scorpid

		-- Buffs
		[GetSpellInfo(33206)] = 1,	-- Pain Suppression
		[GetSpellInfo(1022)] = 1,	-- Hand of Protection
		[GetSpellInfo(1044)] = 1,	-- Hand of Freedom
		[GetSpellInfo(2825)] = 1,	-- Bloodlust
		[GetSpellInfo(32182)] = 1,	-- Heroism
		[GetSpellInfo(29166)] = 1,	-- Innervate
		[GetSpellInfo(18708)] = 1,	-- Fel Domination
		[GetSpellInfo(54428)] = 1,	-- Divine Plea
		[GetSpellInfo(31821)] = 1,	-- Aura mastery

		-- Turtling abilities
		[GetSpellInfo(871)] = 1,	-- Shield Wall
		[GetSpellInfo(48707)] = 1,	-- Anti-Magic Shell
		[GetSpellInfo(31224)] = 1,	-- Cloak of Shadows
		[GetSpellInfo(19263)] = 1,	-- Deterrence

		-- Immunities
		[GetSpellInfo(45438)] = 2,	-- Ice Block
		[GetSpellInfo(642)] = 2,	-- Divine Shield
	}
end