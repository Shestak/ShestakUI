local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Misdirection -> http://www.wowhead.com/spell=34477
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
if C.announcements.spells == true then
	T.AnnounceSpells = {
		34477,	-- Misdirection
		19801,	-- Tranquilizing Shot
		57934,	-- Tricks of the Trade
		633,	-- Lay on Hands
		20484,	-- Rebirth
		6199,	-- Raise Ally
		20707,	-- Soulstone
		110309,	-- Symbiosis
	}
end

if C.announcements.toy_train == true then
	T.AnnounceToys = {
		[61031] = true,		-- Toy Train Set
		[49844] = true,		-- Direbrew's Remote
	}
end

if C.announcements.feasts == true then
	T.AnnounceFeasts = {
		-- WotLK
		[66476] = true,		-- Bountiful Feast
		[57426] = true,		-- Fish Feast
		[57301] = true,		-- Great Feast
		[58474] = true,		-- Small Feast
		[58465] = true,		-- Gigantic Feast
		-- Cataclysm
		[87643] = true,		-- Broiled Dragon Feast
		[87915] = true,		-- Goblin Barbecue Feast
		[87644] = true,		-- Seafood Magnifique Feast
		-- Pandaria
		[104958] = true,	-- Pandaren Banquet
		[105193] = true,	-- Great Pandaren Banquet
		[126492] = true,	-- Banquet of the Grill
		[126494] = true,	-- Great Banquet of the Grill
		[126495] = true,	-- Banquet of the Wok
		[126496] = true,	-- Great Banquet of the Wok
		[126497] = true,	-- Banquet of the Pot
		[126498] = true,	-- Great Banquet of the Pot
		[126499] = true,	-- Banquet of the Steamer
		[126500] = true,	-- Great Banquet of the Steamer
		[126501] = true,	-- Banquet of the Oven
		[126502] = true,	-- Great Banquet of the Oven
		[126503] = true,	-- Banquet of the Brew
		[126504] = true,	-- Great Banquet of the Brew
	}

	T.AnnounceCauldrons = {
		-- Cataclysm
		[92712] = true,		-- Big Cauldron of Battle
		[92649] = true,		-- Cauldron of Battle
	}

	T.AnnounceBots = {
		[22700] = true,		-- Field Repair Bot 74A
		[44389] = true,		-- Field Repair Bot 110G
		[67826] = true,		-- Jeeves
		[54711] = true,		-- Scrapbot
		[54710] = true,		-- MOLL-E
	}
end

if C.announcements.portals == true then
	T.AnnouncePortals = {
		[11419] = true,		-- Portal: Darnassus (Alliance)
		[32266] = true,		-- Portal: Exodar (Alliance)
		[11416] = true,		-- Portal: Ironforge (Alliance)
		[33691] = true,		-- Portal: Shattrath (Alliance)
		[10059] = true,		-- Portal: Stormwind (Alliance)
		[49360] = true,		-- Portal: Theramore (Alliance)
		[88345] = true,		-- Portal: Tol Barad (Alliance)
		[53142] = true,		-- Portal: Dalaran (Alliance/Horde)
		[11417] = true,		-- Portal: Orgrimmar (Horde)
		[35717] = true,		-- Portal: Shattrath (Horde)
		[32267] = true,		-- Portal: Silvermoon (Horde)
		[49361] = true,		-- Portal: Stonard (Horde)
		[11420] = true,		-- Portal: Thunder Bluff (Horde)
		[88346] = true,		-- Portal: Tol Barad (Horde)
		[11418] = true,		-- Portal: Undercity (Horde)
	}
end