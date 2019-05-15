local T, C, L, _ = unpack(select(2, ...))
if T.classic or C.unitframe.enable ~= true or C.unitframe.castbar_ticks ~= true then return end

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
	[SpellName(205021)] = 5,	-- Ray of Frost
	-- Monk
	[SpellName(113656)] = 4,	-- Fists of Fury
	[SpellName(115175)] = 8,	-- Soothing Mist
	[SpellName(117952)] = 4,	-- Crackling Jade Lightning
	-- Priest
	[SpellName(15407)] = 4,		-- Mind Flay
	[SpellName(48045)] = 4,		-- Mind Sear
	[SpellName(47540)] = 3,		-- Penance
	[SpellName(64843)] = 4,		-- Divine Hymn
	-- Warlock
	[SpellName(755)] = 5,		-- Health Funnel
	[SpellName(198590)] = 5,	-- Drain Soul
	[SpellName(234153)] = 5,	-- Drain Life
}

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:RegisterEvent("PLAYER_TALENT_UPDATE")
f:SetScript("OnEvent", function()
	if T.class ~= "PRIEST" then return end

	-- Penance
	local penanceTicks = IsPlayerSpell(193134) and 4 or 3
	T.CastBarTicks[SpellName(47540)] = penanceTicks
end)
