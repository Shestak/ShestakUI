local T, C, L, _ = unpack(select(2, ...))
if C.misc.quest_auto_button ~= true then return end

----------------------------------------------------------------------------------------
--	The best way to add or delete item is to go at www.wowhead.com, search for a item.
--	Example: Seaforium Bombs -> http://www.wowhead.com/item=46847
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
T.ABItems = {
	-- Daily Quests
	52507,	-- Stardust No.2
	69981,	-- Ironforge Rations
	69240,	-- Enchanted Salve
	69235,	-- Fang of the Wolf
	71978,	-- Darkmoon Bandage
	62829,	-- Magnetized Scrap Collector
	79344,	-- Pomharvest Firework
	79885,	-- Barrel of Fireworks
	80599,	-- Goblin Fishing Bomb
	87841,	-- Korven's Experimental Grenades
	82807,	-- Shado-Pan Dragon Gun
	84242,	-- Shado-Pan Bandages
	85261,	-- Shado-Pan Torch
	89123,	-- Wu Kao Explosive
	85950,	-- Mistfall Water Bucket
	86532,	-- Bag of Shado-Pan Gas Bombs
	77475,	-- Stack of Mantras
	80403,	-- Angler's Fishing Spear
	80127,	-- Shadelight Truffle Spores
	87394,	-- Sonic Disruption Fork
	84781,	-- Shado-Pan Torch
	82381,	-- Yak's Milk Flask
	84762,	-- Highly Explosive Yaungol Oil
	32971,	-- Water Bucket
	85581,	-- Shado-Pan Torch
	85884,	-- Sonic Emitter
	82346,	-- Pot of Fire
	78947,	-- Silken Rope
	83134,	-- Bronze Claws
	93180,	-- Re-Configured Remote
	92019,	-- The Bilgewater Molotov
	93751,	-- Blessed Torch
	93668,	-- Saur Fetish
	93806,	-- Resonance Siphon
	93761,	-- Arcane Emancipator
	-- Seaforium
	39213,	-- Massive Seaforium Charge
	46847,	-- Seaforium Bombs
	47030,	-- Huge Seaforium Bombs
	-- Other
	45072,	-- Brightly Colored Egg (Noblegarden)
}

T.ABEquipedItems = {
	49278,	-- Goblin Rocket Pack (ICC)
}