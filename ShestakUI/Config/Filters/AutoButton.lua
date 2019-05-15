local T, C, L, _ = unpack(select(2, ...))
if T.classic or C.misc.quest_auto_button ~= true then return end

----------------------------------------------------------------------------------------
--	The best way to add or delete item is to go at www.wowhead.com, search for a item.
--	Example: Seaforium Bombs -> http://www.wowhead.com/item=46847
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
T.ABItems = {
	-- Daily Quests
	32971,	-- Water Bucket
	38689,	-- Chicken Net
	52507,	-- Stardust No.2
	62829,	-- Magnetized Scrap Collector
	63351,	-- Tahret Dynasty Mallet
	69235,	-- Fang of the Wolf
	69240,	-- Enchanted Salve
	69981,	-- Ironforge Rations
	71978,	-- Darkmoon Bandage
	77475,	-- Stack of Mantras
	78947,	-- Silken Rope
	79885,	-- Barrel of Fireworks
	80127,	-- Shadelight Truffle Spores
	80403,	-- Angler's Fishing Spear
	80599,	-- Goblin Fishing Bomb
	82346,	-- Pot of Fire
	82381,	-- Yak's Milk Flask
	82807,	-- Shado-Pan Dragon Gun
	83134,	-- Bronze Claws
	84762,	-- Highly Explosive Yaungol Oil
	85884,	-- Sonic Emitter
	86532,	-- Bag of Shado-Pan Gas Bombs
	87394,	-- Sonic Disruption Fork
	87841,	-- Korven's Experimental Grenades
	92019,	-- The Bilgewater Molotov
	93180,	-- Re-Configured Remote
	93668,	-- Saur Fetish
	93751,	-- Blessed Torch
	93761,	-- Arcane Emancipator
	93806,	-- Resonance Siphon
	-- Seaforium
	46847,	-- Seaforium Bombs
	47030,	-- Huge Seaforium Bombs
	-- Other
	45072,	-- Brightly Colored Egg (Noblegarden)
	-- Legion
	118330,	-- Pile of Weapons
	122100,	-- Soul Gem
	127030, -- Granny's Flare Grenades
	127295, -- Blazing Torch
	128651, -- Critter Hand Cannon
	128772, -- Branch of the Runewood
	129161, -- Stormforged Horn
	129725, -- Smoldering Torch
	131931, -- Khadgar's Wand
	133756, -- Fresh Mound of Flesh
	133882, -- Trap Rune
	133897, -- Telemancy Beacon
	133925, -- Fel Lash
	133999, -- Inert Crystal
	136605, -- Solendra's Compassion
	137299, -- Nightborne Spellblad
	138146, -- Rediant Ley Crystal
	138965, -- Wand of Siphoning
	140916, -- Satchel of Locklimb Powder
	142509, -- Withered Targeting Orb
	128329, -- Depleted Leyflame Burner
	130260, -- Thaedris' Elixir
	140257, -- Advanced Telemancy Beacon
	142401, -- Telemancy Orbs
}

T.ABEquipedItems = {
	49278,	-- Goblin Rocket Pack (ICC)
}
