local T, C, L = unpack(select(2, ...))
if C.unitframe.enable ~= true or C.unitframe.castbar_ticks ~= true then return end

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Drain Life -> http://www.wowhead.com/spell=689
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
T.CastBarTicks = {
	-- Druid
	[GetSpellInfo(44203)] = 4,	-- Tranquility
	[GetSpellInfo(16914)] = 10,	-- Hurricane
	-- Mage
	[GetSpellInfo(5143)] = 5,	-- Arcane Missiles
	[GetSpellInfo(10)] = 8,		-- Blizzard
	[GetSpellInfo(12051)] = 4,	-- Evocation
	-- Monk
	[GetSpellInfo(115175)] = 9,	-- Soothing Mist
	-- Priest
	[GetSpellInfo(15407)] = 3,	-- Mind Flay
	[GetSpellInfo(48045)] = 5,	-- Mind Sear
	[GetSpellInfo(47540)] = 2,	-- Penance
	[GetSpellInfo(64901)] = 4,	-- Hymn of Hope
	[GetSpellInfo(64843)] = 4,	-- Divine Hymn
	-- Warlock
	[GetSpellInfo(689)] = 6,	-- Drain Life
	[GetSpellInfo(1120)] = 6,	-- Drain Soul
	[GetSpellInfo(755)] = 3,	-- Health Funnel
	[GetSpellInfo(1949)] = 15,	-- Hellfire
}