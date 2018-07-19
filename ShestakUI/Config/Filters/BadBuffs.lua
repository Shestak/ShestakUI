local T, C, L, _ = unpack(select(2, ...))
if C.automation.cancel_bad_buffs ~= true then return end

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Mohawked! -> http://www.wowhead.com/spell=58493
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
T.BadBuffs = {
	[58493] = true,		-- Mohawked!
	[44212] = true,		-- Jack-o'-Lanterned!
	[61716] = true,		-- Rabbit Costume
	[172010] = true,	-- Abomination Costume
	[24732] = true,		-- Bat Costume
	[172015] = true,	-- Geist Costume
	[24735] = true,		-- Ghost Costume
	[172008] = true,	-- Ghoul Costume
	[24712] = true,		-- Leper Gnome Costume
	[24710] = true,		-- Ninja Costume
	[24709] = true,		-- Pirate Costume
	[24723] = true,		-- Skeleton Costume
	[172003] = true,	-- Slime Costume
	[172020] = true,	-- Spider Costume
	[24740] = true,		-- Wisp Costume
	[61781] = true,		-- Turkey Feathers
	[61734] = true,		-- Noblegarden Bunny
}