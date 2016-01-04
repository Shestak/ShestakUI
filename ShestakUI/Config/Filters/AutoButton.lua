local T, C, L, _ = unpack(select(2, ...))
if C.misc.quest_auto_button ~= true then return end

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
}

T.ABEquipedItems = {
	49278,	-- Goblin Rocket Pack (ICC)
}