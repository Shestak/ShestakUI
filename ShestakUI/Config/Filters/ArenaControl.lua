local T, C, L = unpack(select(2, ...))
if C.unitframe.enable ~= true or C.unitframe.show_arena ~= true then return end

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Cyclone -> http://www.wowhead.com/spell=33786
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
T.ArenaControl = function()
	return {
		-- Crowd Controls
		[GetSpellInfo(33786)] = 3,	-- Cyclone
		[GetSpellInfo(2637)] = 3,	-- Hibernate
		[GetSpellInfo(3355)] = 3,	-- Freezing Trap
		[GetSpellInfo(6770)] = 3,	-- Sap
		[GetSpellInfo(2094)] = 3,	-- Blind
		[GetSpellInfo(5782)] = 3,	-- Fear
		[GetSpellInfo(6789)] = 3,	-- Mortal Coil
		[GetSpellInfo(6358)] = 3,	-- Seduction
		[GetSpellInfo(5484)] = 3,	-- Howl of Terror
		[GetSpellInfo(5246)] = 3,	-- Intimidating Shout
		[GetSpellInfo(8122)] = 3,	-- Psychic Scream
		[GetSpellInfo(118)] = 3,	-- Polymorph
		[GetSpellInfo(28272)] = 3,	-- Polymorph Pig
		[GetSpellInfo(28271)] = 3,	-- Polymorph Turtle
		[GetSpellInfo(61305)] = 3,	-- Polymorph Black Cat
		[GetSpellInfo(61721)] = 3,	-- Polymorph Rabbit
		[GetSpellInfo(61025)] = 3,	-- Polymorph Serpent
		[GetSpellInfo(61780)] = 3,	-- Polymorph Turkey
		[GetSpellInfo(51514)] = 3,	-- Hex
		[GetSpellInfo(50519)] = 3,	-- Sonic Blast (Bat)
		[GetSpellInfo(90337)] = 3,	-- Bad Manner (Monkey)
		[GetSpellInfo(605)] = 3,	-- Mind Control
		[GetSpellInfo(64044)] = 3,	-- Psychic Horror

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
		[GetSpellInfo(105593)] = 3,	-- Fist of Justice
		[GetSpellInfo(20066)] = 3,	-- Repentance
		[GetSpellInfo(46968)] = 3,	-- Shockwave
		[GetSpellInfo(115001)] = 3,	-- Remorseless Winter
		[GetSpellInfo(47481)] = 3,	-- Gnaw (dk pet stun)
		[GetSpellInfo(91797)] = 3,	-- Gnaw (dk pet stun mutant)
		[GetSpellInfo(24394)] = 3,	-- Intimidation
		[GetSpellInfo(82691)] = 3,	-- Ring of Frost
		[GetSpellInfo(31661)] = 3,	-- Dragon's Breath
		--MOP[GetSpellInfo(12355)] = 3,	-- Impact
		--MOP[GetSpellInfo(83047)] = 3,	-- Improved Polymorph
		--MOP[GetSpellInfo(93986)] = 3,	-- Aura of Foreboding
		[GetSpellInfo(30283)] = 3,	-- Shadowfury
		[GetSpellInfo(6544)] = 3,	-- Heroic Leap
		--MOP[GetSpellInfo(85388)] = 3,	-- Throwdown
		[GetSpellInfo(108194)] = 3,	-- Asphyxiate
		[GetSpellInfo(118905)] = 3,	-- Static Charge

		-- Roots
		[GetSpellInfo(339)] = 3,	-- Entangling Roots
		[GetSpellInfo(122)] = 3,	-- Frost Nova
		[GetSpellInfo(87194)] = 3,	-- Paralysis (SP)
		[GetSpellInfo(33395)] = 3,	-- Freeze
		--MOP[GetSpellInfo(83302)] = 3,	-- Improved Cone of Cold
		--MOP[GetSpellInfo(55080)] = 3,	-- Shattered Barrier
		[GetSpellInfo(16979)] = 3,	-- Feral Charge
		[GetSpellInfo(19185)] = 3,	-- Entrapment
		[GetSpellInfo(50245)] = 3,	-- Pin (Crab)
		[GetSpellInfo(54706)] = 3,	-- Venom Web Spray (Silithid)
		[GetSpellInfo(4167)] = 3,	-- Web (Spider)
		[GetSpellInfo(63685)] = 3,	-- Freeze (Frozen Power)
		[GetSpellInfo(7922)] = 3,	-- Charge Stun

		-- Immunities
		[GetSpellInfo(45438)] = 2,	-- Ice Block
		[GetSpellInfo(642)] = 2,	-- Divine Shield
		[GetSpellInfo(46924)] = 2,	-- Bladestorm
		[GetSpellInfo(19263)] = 2,	-- Deterrence

		-- Silences
		[GetSpellInfo(55021)] = 1,	-- Improved Counterspell
		[GetSpellInfo(15487)] = 1,	-- Silence
		[GetSpellInfo(34490)] = 1,	-- Silencing Shot
		[GetSpellInfo(47476)] = 1,	-- Strangulate
		[GetSpellInfo(81261)] = 1,	-- Solar Beam
		[GetSpellInfo(1330)] = 1,	-- Garrote - Silence
		[GetSpellInfo(24259)] = 1,	-- Spell Lock (Felhunter)

		-- Disarms
		[GetSpellInfo(676)] = 1,	-- Disarm
		[GetSpellInfo(51722)] = 1,	-- Dismantle
		[GetSpellInfo(50541)] = 1,	-- Clench - Scorpid

		-- Buffs
		[GetSpellInfo(33206)] = 1,	-- Pain Suppression
		[GetSpellInfo(1022)] = 1,	-- Hand of Protection
		[GetSpellInfo(6940)] = 1,	-- Hand of Sacrifice
		[GetSpellInfo(1044)] = 1,	-- Hand of Freedom
		[GetSpellInfo(29166)] = 1,	-- Innervate
		--MOP[GetSpellInfo(18708)] = 1,	-- Fel Domination
		[GetSpellInfo(54428)] = 1,	-- Divine Plea
		[GetSpellInfo(31821)] = 1,	-- Aura mastery
		[GetSpellInfo(96267)] = 1,	-- Strength of Soul
		[GetSpellInfo(8178)] = 1,	-- Grounding Totem
		[GetSpellInfo(49016)] = 1,	-- Unholy Frenzy

		-- Defense abilities
		[GetSpellInfo(871)] = 1,	-- Shield Wall
		[GetSpellInfo(48707)] = 1,	-- Anti-Magic Shell
		[GetSpellInfo(31224)] = 1,	-- Cloak of Shadows
		[GetSpellInfo(48792)] = 1,	-- Icebound Fortitude
	}
end