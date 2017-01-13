local T, C, L, _ = unpack(select(2, ...))
if C.unitframe.enable ~= true or C.unitframe.castbar_ticks ~= true then return end

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Tranquility -> http://www.wowhead.com/spell=740
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
local function SpellName(id)
	local name = GetSpellInfo(id)
	if name then
		return name
	else
		print("|cffff0000WARNING: spell ID ["..tostring(id).."] no longer exists! Report this to Shestak.|r")
		return "Empty"
	end
end

T.CastBarTicks = {
	-- Druid
	[SpellName(740)] = 4,		-- Tranquility
	-- Mage
	[SpellName(5143)] = 5,		-- Arcane Missiles
	[SpellName(12051)] = 4,		-- Evocation
	-- Monk
	[SpellName(115175)] = 9,	-- Soothing Mist
	[SpellName(117952)] = 6,	-- Crackling Jade Lightning
	[SpellName(113656)] = 4,	-- Fists of Fury
	-- Priest
	[SpellName(15407)] = 4,		-- Mind Flay
	[SpellName(47540)] = 3,		-- Penance
	[SpellName(64843)] = 4,		-- Divine Hymn
	-- Warlock
	[SpellName(198590)] = 6,	-- Drain Soul
	[SpellName(755)] = 6,		-- Health Funnel
}