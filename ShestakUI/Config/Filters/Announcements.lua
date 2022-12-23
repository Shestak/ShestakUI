local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Misdirection -> http://www.wowhead.com/spell=34477
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
if C.announcements.spells == true then
	T.announce_spells = {
		61999,	-- Raise Ally
		20484,	-- Rebirth
		391054,	-- Intercession
		20707,	-- Soulstone
		345130,	-- Disposable Spectrophasic Reanimator
		31821,	-- Aura Mastery
		633,	-- Lay on Hands
		34477,	-- Misdirection
		57934,	-- Tricks of the Trade
		19801,	-- Tranquilizing Shot
		2908,	-- Soothe
	}

	if #C.announcements.spells_list > 0 then
		T.announce_spells = C.announcements.spells_list
	else
		if C.options.announcements and C.options.announcements.spells_list then
			C.options.announcements.spells_list = nil
		end
	end
	T.AnnounceSpells = {}
	for _, spell in pairs(T.announce_spells) do
		T.AnnounceSpells[spell] = true
	end
end

if C.announcements.toys == true then
	T.AnnounceToys = {
		[61031] = true,		-- Toy Train Set
		[49844] = true,		-- Direbrew's Remote
	}
end

if C.announcements.feasts == true then
	T.AnnounceFeast = {
		[382427] = true,	-- Grand Banquet of the Kalu'a
		[371521] = true,	-- Potion Cauldron of Power
		[371611] = true,	-- Prepare Potion Cauldron of Ultimate Power
	}
	T.AnnounceBots = {
		[22700] = true,		-- Field Repair Bot 74A
		[44389] = true,		-- Field Repair Bot 110G
		[54711] = true,		-- Scrapbot
		[67826] = true,		-- Jeeves
		[126459] = true,	-- Blingtron 4000
		[161414] = true,	-- Blingtron 5000
		[298926] = true,	-- Blingtron 7000
		[199109] = true,	-- Auto-Hammer
		[324029] = true,	-- Codex of the Still Mind
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
		[344597] = true,	-- Oribos
		[395289] = true,	-- Valdrakken
	}
end


if C.announcements.bad_gear == true then
	local badRings = {
		[40585] = true,		-- Signet of the Kirin Tor
		[40586] = true,		-- Band of the Kirin Tor
		[44934] = true,		-- Loop of the Kirin Tor
		[44935] = true,		-- Ring of the Kirin Tor
		[45688] = true,		-- Inscribed Band of the Kirin Tor
		[45689] = true,		-- Inscribed Loop of the Kirin Tor
		[45690] = true,		-- Inscribed Ring of the Kirin Tor
		[45691] = true,		-- Inscribed Signet of the Kirin Tor
		[48954] = true,		-- Etched Band of the Kirin Tor
		[48955] = true,		-- Etched Loop of the Kirin Tor
		[48956] = true,		-- Etched Ring of the Kirin Tor
		[48957] = true,		-- Etched Signet of the Kirin Tor
		[51557] = true,		-- Runed Signet of the Kirin Tor
		[51558] = true,		-- Runed Loop of the Kirin Tor
		[51559] = true,		-- Runed Ring of the Kirin Tor
		[51560] = true,		-- Runed Band of the Kirin Tor
		[95050] = true,		-- Brassiest Knuckle (Horde)
		[95051] = true,		-- Brassiest Knuckle (Alliance)
		[118907] = true,	-- Pit Fighter's Punching Ring (Alliance)
		[118908] = true,	-- Pit Fighter's Punching Ring (Horde)
		[139599] = true,	-- Empowered Ring of the Kirin Tor (new Dalaran)
		[142469] = true,	-- Violet Seal of the Grand Magus
		[144391] = true,	-- Pugilist's Powerful Punching Ring (Alliance)
		[144392] = true,	-- Pugilist's Powerful Punching Ring (Horde)
		[166559] = true,	-- Commander's Signet of Battle
		[166560] = true,	-- Captain's Signet of Command
	}

	T.AnnounceBadGear = {
		-- Head
		[1] = {
			[88710] = true,		-- Nat's Hat
			[33820] = true,		-- Weather-Beaten Fishing Hat
			[19972] = true,		-- Lucky Fishing Hat
		},
		-- Neck
		[2] = {
			[32757] = true,		-- Blessed Medallion of Karabor
		},
		-- Feet
		[8] = {
			[50287] = true,		-- Boots of the Bay
			[19969] = true,		-- Nat Pagle's Extreme Anglin' Boots
		},
		-- Rings
		[11] = badRings,
		[12] = badRings,
		-- Back
		[15] = {
			[65360] = true,		-- Cloak of Coordination (Alliance)
			[65274] = true,		-- Cloak of Coordination (Horde)
		},
		-- Main-Hand
		[16] = {
			[180136] = true,	-- The Brokers Angle'r
			[133755] = true,	-- Underlight Angler
			[44050] = true,		-- Mastercraft Kalu'ak Fishing Pole
			[19970] = true,		-- Arcanite Fishing Pole
			[84660] = true,		-- Pandaren Fishing Pole
			[84661] = true,		-- Dragon Fishing Pole
			[45992] = true,		-- Jeweled Fishing Pole
			[45991] = true,		-- Bone Fishing Pole
			[116826] = true,	-- Draenic Fishing Pole
			[116825] = true,	-- Savage Fishing Pole
			[86559] = true,		-- Frying Pan
		},
		-- Off-hand
		[17] = {
			[86558] = true,		-- Rolling Pin
		},
	}
end