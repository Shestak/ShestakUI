local T, C, L, _ = unpack(select(2, ...))
if C.misc.quest_auto_button ~= true then return end

----------------------------------------------------------------------------------------
--	The best way to add or delete item is to go at www.wowhead.com, search for a item.
--	Example: Seaforium Bombs -> http://www.wowhead.com/item=46847
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
T.ABItems = {
	-- Daily Quests
	[32971] = true,		-- Water Bucket
	[38689] = true,		-- Chicken Net
	[52507] = true,		-- Stardust No.2
	[62829] = true,		-- Magnetized Scrap Collector
	[63351] = true,		-- Tahret Dynasty Mallet
	[69235] = true,		-- Fang of the Wolf
	[69240] = true,		-- Enchanted Salve
	[69981] = true,		-- Ironforge Rations
	[71978] = true,		-- Darkmoon Bandage
	[77475] = true,		-- Stack of Mantras
	[78947] = true,		-- Silken Rope
	[79885] = true,		-- Barrel of Fireworks
	[80127] = true,		-- Shadelight Truffle Spores
	[80403] = true,		-- Angler's Fishing Spear
	[80599] = true,		-- Goblin Fishing Bomb
	[82346] = true,		-- Pot of Fire
	[82381] = true,		-- Yak's Milk Flask
	[82807] = true,		-- Shado-Pan Dragon Gun
	[83134] = true,		-- Bronze Claws
	[84762] = true,		-- Highly Explosive Yaungol Oil
	[85884] = true,		-- Sonic Emitter
	[86532] = true,		-- Bag of Shado-Pan Gas Bombs
	[87394] = true,		-- Sonic Disruption Fork
	[87841] = true,		-- Korven's Experimental Grenades
	[92019] = true,		-- The Bilgewater Molotov
	[93180] = true,		-- Re-Configured Remote
	[93668] = true,		-- Saur Fetish
	[93751] = true,		-- Blessed Torch
	[93761] = true,		-- Arcane Emancipator
	[93806] = true,		-- Resonance Siphon
	-- Seaforium
	[46847] = true,		-- Seaforium Bombs
	[47030] = true,		-- Huge Seaforium Bombs
	-- Other
	[45072] = true,		-- Brightly Colored Egg (Noblegarden)
	-- Legion
	[118330] = true,	-- Pile of Weapons
	[122100] = true,	-- Soul Gem
	[127030] = true,	-- Granny's Flare Grenades
	[127295] = true,	-- Blazing Torch
	[128651] = true,	-- Critter Hand Cannon
	[128772] = true,	-- Branch of the Runewood
	[129161] = true,	-- Stormforged Horn
	[129725] = true,	-- Smoldering Torch
	[131931] = true,	-- Khadgar's Wand
	[133756] = true,	-- Fresh Mound of Flesh
	[133882] = true,	-- Trap Rune
	[133897] = true,	-- Telemancy Beacon
	[133925] = true,	-- Fel Lash
	[133999] = true,	-- Inert Crystal
	[136605] = true,	-- Solendra's Compassion
	[137299] = true,	-- Nightborne Spellblad
	[138146] = true,	-- Rediant Ley Crystal
	[138965] = true,	-- Wand of Siphoning
	[140916] = true,	-- Satchel of Locklimb Powder
	[142509] = true,	-- Withered Targeting Orb
	[128329] = true,	-- Depleted Leyflame Burner
	[130260] = true,	-- Thaedris' Elixir
	[140257] = true,	-- Advanced Telemancy Beacon
	[142401] = true,	-- Telemancy Orbs
	-- BfA
	[166905] = true,	-- Hunting Knife
	[168183] = true,	-- Rare Metal Collector
	[168253] = true,	-- Fathom Hook
	[168482] = true,	-- Plug the Geysers
}
