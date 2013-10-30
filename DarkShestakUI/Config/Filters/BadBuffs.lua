local T, C, L, _ = unpack(select(2, ...))
if C.automation.cancel_bad_buffs ~= true then return end

----------------------------------------------------------------------------------------
--	The best way to add or delete item is to go at www.wowhead.com, search for a item.
--	Example: Mohawked! -> http://www.wowhead.com/item=58493
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
T.BadBuffs = {
	[GetSpellInfo(58493)] = true,	-- Mohawked!
	[GetSpellInfo(44212)] = true,	-- Jack-o'-Lanterned!
	[GetSpellInfo(61716)] = true,	-- Rabbit Costume
	[GetSpellInfo(24724)] = true,	-- Skeleton Costume
	[GetSpellInfo(24732)] = true,	-- Bat Costume
	[GetSpellInfo(24741)] = true,	-- Wisp Costume
	[GetSpellInfo(24737)] = true,	-- Ghost Costume
	[GetSpellInfo(24711)] = true,	-- Pirate Costume
	[GetSpellInfo(24712)] = true,	-- Leper Gnome Costume
	[GetSpellInfo(24710)] = true,	-- Ninja Costume
	[GetSpellInfo(61781)] = true,	-- Turkey Feathers
	[GetSpellInfo(61734)] = true,	-- Noblegarden Bunny
}