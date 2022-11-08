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
	[SpellName(12051)] = 6,		-- Evocation
	[SpellName(205021)] = 5,	-- Ray of Frost
	-- Monk
	[SpellName(115175)] = 8,	-- Soothing Mist
	[SpellName(117952)] = 4,	-- Crackling Jade Lightning
	-- Priest
	[SpellName(15407)] = 6,		-- Mind Flay
	[SpellName(48045)] = 6,		-- Mind Sear
	[SpellName(47540)] = 3,		-- Penance
	[SpellName(64843)] = 4,		-- Divine Hymn
	[SpellName(64902)] = 5,		-- Symbol of Hope (Mana Hymn)
	-- Warlock
	[SpellName(755)] = 5,		-- Health Funnel
	[SpellName(198590)] = 5,	-- Drain Soul
	[SpellName(234153)] = 5,	-- Drain Life
	-- Evoker
	[SpellName(356995)] = 3,	-- Disintegrate
	-- Racials
	[SpellName(291944)] = 6,	-- Regeneratin (Zandalari)
}

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:RegisterEvent("PLAYER_TALENT_UPDATE")
f:SetScript("OnEvent", function()
	if T.class ~= "PRIEST" then
		f:UnregisterAllEvents()
		return
	end

	-- Penance
	local penanceTicks = IsPlayerSpell(193134) and 4 or 3
	T.CastBarTicks[SpellName(47540)] = penanceTicks
end)
