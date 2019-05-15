local T, C, L, _ = unpack(select(2, ...))
if not T.classic or C.loot.auto_greed ~= true then return end

----------------------------------------------------------------------------------------
--	The best way to add or delete item is to go at www.wowhead.com, search for a item.
--	Example: Amani Hex Stick -> http://www.wowhead.com/item=33865
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
T.NeedLoot = {
	-- Custom
	--[[
	5760,	-- Eternium Lockbox
	7909,	-- Aquamarine
	7910,	-- Star Ruby
	--]]

	-- Tier 1 BoE
	--[[
	16799,	-- Arcanist Bindings
	16802,	-- Arcanist Belt
	16804,	-- Felheart Bracers
	16806,	-- Felheart Belt
	16817,	-- Girdle of Prophecy
	16819,	-- Vambraces of Prophecy
	16825,	-- Nightslayer Bracelets
	16827,	-- Nightslayer Belt
	16828,	-- Cenarion Belt
	16830,	-- Cenarion Bracers
	16838,	-- Earthfury Belt
	16840,	-- Earthfury Bracers
	16850,	-- Giantstalker's Bracers
	16851,	-- Giantstalker's Belt
	16857,	-- Lawbringer Bracers
	16858,	-- Lawbringer Belt
	16861,	-- Bracers of Might
	16864,	-- Belt of Might
	--]]

	-- MC
	--[[
	7076,	-- Essence of Earth
	7078,	-- Essence of Fire
	11382,	-- Blood of the Mountain
	17010,	-- Fiery Core
	17011,	-- Lava Core
	--]]

	-- ZG
	--[[
	19698,	-- Zulian Coin
	19699,	-- Razzashi Coin
	19700,	-- Hakkari Coin
	19701,	-- Gurubashi Coin
	19702,	-- Vilebranch Coin
	19703,	-- Witherbark Coin
	19704,	-- Sandfury Coin
	19705,	-- Skullsplitter Coin
	19706,	-- Bloodscalp Coin
	19707,	-- Red Hakkari Bijou
	19708,	-- Blue Hakkari Bijou
	19709,	-- Yellow Hakkari Bijou
	19710,	-- Orange Hakkari Bijou
	19711,	-- Green Hakkari Bijou
	19712,	-- Purple Hakkari Bijou
	19713,	-- Bronze Hakkari Bijou
	19714,	-- Silver Hakkari Bijou
	19715,	-- Gold Hakkari Bijou
	--]]

	-- AQ
	--[[
	20858,	-- Stone Scarab
	20859,	-- Gold Scarab
	20860,	-- Silver Scarab
	20861,	-- Bronze Scarab
	20862,	-- Crystal Scarab
	20863,	-- Clay Scarab
	20864,	-- Bone Scarab
	20865,	-- Ivory Scarab
	20866,	-- Azure Idol
	20867,	-- Onyx Idol
	20868,	-- Lambent Idol
	20869,	-- Amber Idol
	20870,	-- Jasper Idol
	20871,	-- Obsidian Idol
	20872,	-- Vermillion Idol
	20873,	-- Alabaster Idol
	20874,	-- Idol of the Sun
	20875,	-- Idol of Night
	20876,	-- Idol of Death
	20877,	-- Idol of the Sage
	20878,	-- Idol of Rebirth
	20879,	-- Idol of Life
	20881,	-- Idol of Strife
	20882,	-- Idol of War
	--]]
	
	-- Naxx
	--[[
	22373,	-- Wartorn Leather Scrap
	22374,	-- Wartorn Chain Scrap
	22375,	-- Wartorn Plate Scrap
	22376,	-- Wartorn Cloth Scrap
	--]]
}