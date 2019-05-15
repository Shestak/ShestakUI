local T, C, L, _ = unpack(select(2, ...))
if T.classic or C.automation.cancel_bad_buffs ~= true then return end

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
		print("|cffff0000WARNING: spell ID ["..tostring(id).."] no longer exists! Report this to Shestak.|r")
		return "Empty"
	end
end

T.BadBuffs = {
	[SpellName(58493)] = true,	-- Mohawked!
	[SpellName(44212)] = true,	-- Jack-o'-Lanterned!
	[SpellName(61716)] = true,	-- Rabbit Costume
	[SpellName(172010)] = true,	-- Abomination Costume
	[SpellName(24732)] = true,	-- Bat Costume
	[SpellName(172015)] = true,	-- Geist Costume
	[SpellName(24735)] = true,	-- Ghost Costume
	[SpellName(172008)] = true,	-- Ghoul Costume
	[SpellName(24712)] = true,	-- Leper Gnome Costume
	[SpellName(24710)] = true,	-- Ninja Costume
	[SpellName(24709)] = true,	-- Pirate Costume
	[SpellName(24723)] = true,	-- Skeleton Costume
	[SpellName(172003)] = true,	-- Slime Costume
	[SpellName(172020)] = true,	-- Spider Costume
	[SpellName(24740)] = true,	-- Wisp Costume
	[SpellName(61781)] = true,	-- Turkey Feathers
	[SpellName(61734)] = true,	-- Noblegarden Bunny
}