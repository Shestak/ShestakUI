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
		2908,	-- Soothe
		120668,	-- Stormlash Totem
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

	--T.AnnounceCauldrons = {

	--}

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
		-- Portals
		[10059] = true,		-- Stormwind (Alliance)
		[11416] = true,		-- Ironforge (Alliance)
		[11419] = true,		-- Darnassus (Alliance)
		[32266] = true,		-- Exodar (Alliance)
		[49360] = true,		-- Theramore (Alliance)
		[33691] = true,		-- Shattrath (Alliance)
		[88345] = true,		-- Tol Barad (Alliance)
		[132620] = true,	-- Vale of Eternal Blossoms (Alliance)
		[11417] = true,		-- Orgrimmar (Horde)
		[11420] = true,		-- Thunder Bluff (Horde)
		[11418] = true,		-- Undercity (Horde)
		[32267] = true,		-- Silvermoon (Horde)
		[49361] = true,		-- Stonard (Horde)
		[35717] = true,		-- Shattrath (Horde)
		[88346] = true,		-- Tol Barad (Horde)
		[132626] = true,	-- Vale of Eternal Blossoms (Horde)
		[53142] = true,		-- Dalaran (Alliance/Horde)
	}
end