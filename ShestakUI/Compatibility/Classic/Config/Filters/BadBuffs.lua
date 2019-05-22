local T, C, L, _ = unpack(select(2, ...))
if not T.classic or C.automation.cancel_bad_buffs ~= true then return end

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Mohawked! -> http://www.wowhead.com/spell=58493
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

T.BadBuffs = {
	[SpellName(24732)] = true,	-- Bat Costume
	[SpellName(24735)] = true,	-- Ghost Costume
	[SpellName(24712)] = true,	-- Leper Gnome Costume
	[SpellName(24710)] = true,	-- Ninja Costume
	[SpellName(24709)] = true,	-- Pirate Costume
	[SpellName(24723)] = true,	-- Skeleton Costume
	[SpellName(24740)] = true,	-- Wisp Costume
}