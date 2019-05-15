local T, C, L, _ = unpack(select(2, ...))
if T.classic then return end

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Misdirection -> http://www.wowhead.com/spell=34477
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
if C.announcements.spells == true then
	T.AnnounceSpells = {
		61999,	-- Raise Ally
		20484,	-- Rebirth
		20707,	-- Soulstone
		31821,	-- Aura Mastery
		633,	-- Lay on Hands
		34477,	-- Misdirection
		57934,	-- Tricks of the Trade
		19801,	-- Tranquilizing Shot
		2908,	-- Soothe
	}
end

if C.announcements.toys == true then
	T.AnnounceToys = {
		[61031] = true,		-- Toy Train Set
		[49844] = true,		-- Direbrew's Remote
	}
end

if C.announcements.feasts == true then
	T.AnnounceBots = {
		[22700] = true,		-- Field Repair Bot 74A
		[44389] = true,		-- Field Repair Bot 110G
		[54711] = true,		-- Scrapbot
		[67826] = true,		-- Jeeves
		[126459] = true,	-- Blingtron 4000
		[161414] = true,	-- Blingtron 5000
		[199109] = true,	-- Auto-Hammer
		[226241] = true,	-- Codex of the Tranquil Mind
	}
end

if C.announcements.portals == true then
	T.AnnouncePortals = {
		-- Alliance
		[10059] = true,		-- Stormwind
		[11416] = true,		-- Ironforge
		[11419] = true,		-- Darnassus
		[32266] = true,		-- Exodar
		[49360] = true,		-- Theramore
		[33691] = true,		-- Shattrath
		[88345] = true,		-- Tol Barad
		[132620] = true,	-- Vale of Eternal Blossoms
		[176246] = true,	-- Stormshield
		[281400] = true,	-- Boralus
		-- Horde
		[11417] = true,		-- Orgrimmar
		[11420] = true,		-- Thunder Bluff
		[11418] = true,		-- Undercity
		[32267] = true,		-- Silvermoon
		[49361] = true,		-- Stonard
		[35717] = true,		-- Shattrath
		[88346] = true,		-- Tol Barad
		[132626] = true,	-- Vale of Eternal Blossoms
		[176244] = true,	-- Warspear
		[281402] = true,	-- Dazar'alor
		-- Alliance/Horde
		[53142] = true,		-- Dalaran
		[120146] = true,	-- Ancient Dalaran
		[224871] = true,	-- Dalaran, Broken Isles
	}
end


if C.announcements.bad_gear == true then
	T.AnnounceBadGear = {
		-- Head
		[1] = {
			88710,	-- Nat's Hat
			33820,	-- Weather-Beaten Fishing Hat
			19972,	-- Lucky Fishing Hat
			46349,	-- Chef's Hat
		},
		-- Neck
		[2] = {
			32757,	-- Blessed Medallion of Karabor
		},
		-- Feet
		[8] = {
			50287,	-- Boots of the Bay
			19969,	-- Nat Pagle's Extreme Anglin' Boots
		},
		-- Back
		[15] = {
			65360,	-- Cloak of Coordination (Alliance)
			65274,	-- Cloak of Coordination (Horde)
		},
		-- Main-Hand
		[16] = {
			44050,	-- Mastercraft Kalu'ak Fishing Pole
			19970,	-- Arcanite Fishing Pole
			84660,	-- Pandaren Fishing Pole
			84661,	-- Dragon Fishing Pole
			45992,	-- Jeweled Fishing Pole
			45991,	-- Bone Fishing Pole
			116826,	-- Draenic Fishing Pole
			116825,	-- Savage Fishing Pole
			86559,	-- Frying Pan
		},
		-- Off-hand
		[17] = {
			86558,	-- Rolling Pin
		},
	}
end