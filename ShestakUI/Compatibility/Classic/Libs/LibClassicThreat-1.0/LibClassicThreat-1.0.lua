if not IsClassicBuild() then return end

-- ThreatLib by @Ipse#1953
local major = "ClassicThreat-1.0"
local minor = 1
assert(LibStub, format("%s requires LibStub.", major))
local Lib = LibStub:NewLibrary(major, minor)
if not Lib then return end
if not Lib.updaterFrame then
	Lib.updaterFrame = CreateFrame("Frame")
end
Lib.updaterFrame:UnregisterAllEvents()
Lib.updaterFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

local CallbackHandler = LibStub:GetLibrary("CallbackHandler-1.0")
Lib.callbacks = Lib.callbacks or CallbackHandler:New(Lib)
local threatEvents = Lib.callbacks

if not Lib.talentItemUpdater then
	Lib.talentItemUpdater = CreateFrame("Frame")
end
Lib.talentItemUpdater:UnregisterAllEvents()
Lib.talentItemUpdater:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
Lib.talentItemUpdater:RegisterEvent("CHARACTER_POINTS_CHANGED")
Lib.talentItemUpdater:RegisterEvent("SPELLS_CHANGED")
--Lib.talentItemUpdater:RegisterEvent("PLAYER_ENTERING_WORLD")

if not Lib.auraChecker then
	Lib.auraChecker = CreateFrame("Frame")
end
Lib.auraChecker:UnregisterAllEvents()
Lib.auraChecker:RegisterEvent("UPDATE_SHAPESHIFT_COOLDOWN")
Lib.auraChecker:RegisterEvent("PLAYER_ENTERING_WORLD")
Lib.auraChecker:RegisterEvent("UNIT_AURA")

if not Lib.groupMessageFrame then
	Lib.groupMessageFrame = CreateFrame("Frame")
end
Lib.groupMessageFrame:UnregisterAllEvents()
Lib.groupMessageFrame:RegisterEvent("GROUP_ROSTER_UPDATE")
Lib.groupMessageFrame:RegisterEvent("CHAT_MSG_ADDON")
Lib.groupMessageFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
if not Lib.initialise then 
	Lib.initialise = CreateFrame("Frame")
end
--local ChatAddonMessage = LibStub:GetLibrary("AceComm-3.0");
Lib.initialise:UnregisterAllEvents()
Lib.initialise:RegisterEvent("PLAYER_ENTERING_WORLD")
Lib.groupMemberTable = {[UnitGUID("player")] = true,}
Lib.GUIDThreatTable = {}
Lib.myThreatMulti = {
	["global"] = 1,
	["stance"] = 1,
	["spell"] = 1,
	["aura"] = 1,
	["healing"] = 0.5,
	["melee"] = 1.1,
	["range"] = 1.3,
	["rage"] = 5.0,
	["energy"] = 5.0,
	["mana"] = 0.5,	
	["school"] = {
		[1] = 1, -- physical
		[2] = 1, -- holy
		[4] = 1, -- fire
		[8] = 1, -- nature
		[16] = 1, -- frost
		[32] = 1, -- shadow
		[64] = 1, -- arcane
	},
	["spells"] = {},
	["auraChanges"] = {},
	["stanceChanges"] = {}
}

local tonumber = _G.tonumber

local tauntSpellList = {
	[355] = true, -- Taunt
	[6795] = true, -- Growl (Druid)
	[2649] = true, -- Growl (Pet Rank 1)
	[14916] = true, -- Growl (Pet Rank 2)
	[14917] = true, -- Growl (Pet Rank 3)
	[14918] = true, -- Growl (Pet Rank 4)
	[14919] = true, -- Growl (Pet Rank 5)
	[14920] = true, -- Growl (Pet Rank 6)
	[14921] = true, -- Growl (Pet Rank 7)
}

local threatSpellMods = {	
	-- Heroic Strike
	[78] = { -- rank 1
		["threat"] = 20,
	},
	[284] = { -- rank 2
		["threat"] = 39,
	},
	[285] = { -- rank 3
		["threat"] = 59,
	},
	[1608] = { -- rank 4
		["threat"] = 78,
	},
	[11564] = { -- rank 5
		["threat"] = 98,
	},
	[11565] = { -- rank 6
		["threat"] = 118,
	},
	[11566] = { -- rank 7
		["threat"] = 137,
	},
	[11567] = { -- rank 8
		["threat"] = 145,
	},
	[25286] = { -- rank 9
		["threat"] = 175, -- 173?
	},
	-- Revenge 
	[6572] = { -- rank 1
		["threat"] = 155,
	},
	[6574] = { -- rank 2
		["threat"] = 195,
	},
	[7379] = { -- rank 3
		["threat"] = 235,
	},
	[11600] = { -- rank 4
		["threat"] = 275,
	},
	[11601] = { -- rank 5
		["threat"] = 315,
	},
	[25288] = {-- rank 6
		["threat"] = 335,
	},
	-- Sunder Armor
	[7386] = { -- rank 1
		["threat"] = 100,
	},
	[7405] = { -- rank 2
		["threat"] = 140,
	},
	[8380] = { -- rank 3
		["threat"] = 180,
	},
	[11596] = { -- rank 4
		["threat"] = 220,
	},
	[11597] = { -- rank 5
		["threat"] = 260,
	},
	-- Shield Slam
	[23922] = { -- rank 1
		["threat"] = 160,
	},
	[23923] = { -- rank 2
		["threat"] = 190,
	},
	[23924] = { -- rank 3
		["threat"] = 220,
	},
	[23925] = { -- rank 4
		["threat"] = 250,
	},
	-- Shield Bash
	[72] = { -- rank 1
		["threat"] = 180,
	},
	[1671] = { -- rank 2
		["threat"] = 180,
	},
	[1672] = { -- rank 3
		["threat"] = 180,
	},
	-- Thunder Clap
	[6343] = { -- rank 1
		["threat"] = 17,
	},
	[8198] = { -- rank 2
		["threat"] = 40,
	},
	[8204] = { -- rank 3
		["threat"] = 64,
	},
	[8205] = { -- rank 4
		["threat"] = 96,
	},
	[11580] = { -- rank 5
		["threat"] = 143,
	},
	[11581] = { -- rank 6
		["threat"] = 180,
	},
	-- Hamstring
	[1715] = { -- rank 1
		["threat"] = 61,
	},
	[7372] = { -- rank 2
		["threat"] = 101,
	},
	[7373] = { -- rank 3
		["threat"] = 141,
	},
	-- Cleave
	[845] = { -- rank 1
		["threat"] = 10,
	},
	[7369] = { -- rank 2
		["threat"] = 40,
	},
	[11608] = { -- rank 3
		["threat"] = 60,
	},
	[11609] = { -- rank 4
		["threat"] = 70,
	},
	[20569] = { -- rank 5
		["threat"] = 100,
	},
	-- Battle Shout
	[6673] = { -- rank 1
		["threat"] = 5,
	},
	[5242] = { -- rank 2
		["threat"] = 11,
	},
	[6192] = { -- rank 3
		["threat"] = 17,
	},
	[11549] = { -- rank 4
		["threat"] = 26,
	},
	[11550] = { -- rank 5
		["threat"] = 39,
	},
	[11551] = { -- rank 6
		["threat"] = 55,
	},
	[25289] = { -- rank 7
		["threat"] = 70,
	},
	-- Arcane Intellect (These numbers are taken from battle shout because idk what they actually are)
	[1459] = { -- rank 1
		["threat"] = 5,
	},
	[1460] = { -- rank 2
		["threat"] = 11,
	},
	[1461] = { -- rank 3
		["threat"] = 17,
	},
	[10156] = { -- rank 4
		["threat"] = 26,
	},
	[10157] = { -- rank 5
		["threat"] = 39,
	},
	-- Demoralizing Shout
	[1160] = { -- rank 1
		["threat"] = 11,
	},
	[6190] = { -- rank 2
		["threat"] = 17,
	},
	[11554] = { -- rank 3
		["threat"] = 21,
	},
	[11555] = { -- rank 4
		["threat"] = 32,
	},
	[11556] = { -- rank 5
		["threat"] = 43,
	},
	-- Counterspell
	[2139] = {
		["threat"] = 300,
	},
	-- Remove Lesser Curse
	[475] = {
		["threat"] = 14,
	},
	-- Cleanse
	[4987] = {
		["threat"] = 40,
	},
	-- Holy Shield
	[20925] = { -- rank 1
		["threat"] = 20,
		--["multi"] = 1.2,
	},
	[20927] = { -- rank 2
		["threat"] = 30,
		--["multi"] = 1.2,
	},
	[20928] = { -- rank 3
		["threat"] = 40,
		--["multi"] = 1.2,
	},
	-- Fade
	[586] = { -- rank 1
		["threat"] = -55,
	},
	[9578] = { -- rank 2
		["threat"] = -155,
	},
	[9579] = { -- rank 3
		["threat"] = -285,
	},
	[9592] = { -- rank 4
		["threat"] = -440,
	},
	[10941] = { -- rank 5
		["threat"] = -620,
	},
	[10942] = { -- rank 6
		["threat"] = -820,
	},
	-- Mind Blast 
	[8092] = { -- rank 1
		["multi"] = 2,
	},
	[8102] = { -- rank 2
		["multi"] = 2,
	},
	[8103] = { -- rank 3
		["multi"] = 2,
	},
	[8104] = { -- rank 4
		["multi"] = 2,
	},
	[8105] = { -- rank 5
		["multi"] = 2,
	},
	[8106] = { -- rank 6
		["multi"] = 2,
	},
	[10945] = { -- rank 7
		["multi"] = 2,
	},
	[10946] = { -- rank 8
		["multi"] = 2,
	},
	[10947] = { -- rank 9
		["multi"] = 2,
	},
	-- Vanish
	[1856] = { -- rank 2
		["multi"] = 0,
	},
	[1857] = { -- rank 2
		["multi"] = 0,
	},
	-- Feint
	[1966] = { -- rank 1
		["threat"] = -150,
	},
	[6768] = { -- rank 2
		["threat"] = -240,
	},
	[8637] = { -- rank 3
		["threat"] = -390,
	},
	[11303] = { -- rank 4
		["threat"] = -600,
	},
	[25302] = { -- rank 5
		["threat"] = -800,
	},
	-- Earth Shock
	[8042] = { -- rank 1
		["multi"] = 2,
	},
	[8044] = { -- rank 2
		["multi"] = 2,
	},
	[8045] = { -- rank 3
		["multi"] = 2,
	},
	[8046] = { -- rank 4
		["multi"] = 2,
	},
	[10412] = { -- rank 5
		["multi"] = 2,
	},
	[10413] = { -- rank 6
		["multi"] = 2,
	},
	[10414] = { -- rank 7
		["multi"] = 2,
	},
	-- Rockbiter Weapon
	[8017] = { -- rank 1
		["threat"] = 6,
	},
	[8018] = { -- rank 2
		["threat"] = 10,
	},
	[8019] = { -- rank 3
		["threat"] = 16,
	},
	[10399] = { -- rank 4
		["threat"] = 27,
	},
	[16314] = { -- rank 5
		["threat"] = 41,
	},
	[16315] = { -- rank 6
		["threat"] = 55,
	},
	[16316] = { -- rank 7
		["threat"] = 72,
	},
	-- Suffering
	[17735] = { -- rank 1
		["threat"] = 200,
	},
	[17750] = { -- rank 2
		["threat"] = 300,
	},
	[17751] = { -- rank 3
		["threat"] = 450,
	},
	[17752] = { -- rank 4
		["threat"] = 600,
	},
	-- Searing Pain
	[5676] = { -- rank 1
		["multi"] = 2,
	},
	[17919] = { -- rank 2
		["multi"] = 2,
	},
	[17920] = { -- rank 3
		["multi"] = 2,
	},
	[17921] = { -- rank 4
		["multi"] = 2,
	},
	[17922] = { -- rank 5
		["multi"] = 2,
	},
	[17923] = { -- rank 6
		["multi"] = 2,
	},
	-- Swipe
	[779] = { -- rank 1
		["multi"] = 1.75,
	},
	[780] = { -- rank 2
		["multi"] = 1.75,
	},
	[769] = { -- rank 3
		["multi"] = 1.75,
	},
	[9754] = { -- rank 4
		["multi"] = 1.75,
	},
	[9908] = { -- rank 5
		["multi"] = 1.75,
	},
	-- Maul
	[6807] = { -- rank 1
		["multi"] = 1.75,
	},
	[6808] = { -- rank 2
		["multi"] = 1.75,
	},
	[6809] = { -- rank 3
		["multi"] = 1.75,
	},
	[8972] = { -- rank 4
		["multi"] = 1.75,
	},
	[9745] = { -- rank 5
		["multi"] = 1.75,
	},
	[9880] = { -- rank 6
		["multi"] = 1.75,
	},
	[9881] = { -- rank 7
		["multi"] = 1.75,
	},
	-- Faerie Fire
	[770] = { -- rank 1
		["threat"] = 108,
	},
	[778] = { -- rank 2
		["threat"] = 108,
	},
	[9749] = { -- rank 3
		["threat"] = 108,
	},
	[9907] = { -- rank 4
		["threat"] = 108,
	},
	-- Cower (Cat)
	[8998] = { -- rank 1
		["threat"] = -240,
	},
	[9000] = { -- rank 2
		["threat"] = -390,
	},
	[9892] = { -- rank 3
		["threat"] = -600,
	},
	-- Feign Death
	[5384] = {
		["multi"] = 0,
	},
	-- Distracting Shot
	[20736] = { -- rank 1
		["threat"] = 100,
	},
	[14274] = { -- rank 2
		["threat"] = 200,
	},
	[15629] = { -- rank 3
		["threat"] = 300,
	},
	[15630] = { -- rank 4
		["threat"] = 400,
	},
	[15631] = { -- rank 5
		["threat"] = 500,
	},
	[15632] = { -- rank 6
		["threat"] = 600,
	},
	-- Cower (Hunter Pet)
	[1742] = { -- rank 1
		["threat"] = -30,
	},
	[1753] = { -- rank 2
		["threat"] = -55,
	},
	[1754] = { -- rank 3
		["threat"] = -85,
	},
	[1755] = { -- rank 4
		["threat"] = -125,
	},
	[1756] = { -- rank 5
		["threat"] = -175,
	},
	[16697] = { -- rank 6
		["threat"] = -225,
	},
	-- Scorpid Poison (Hunter Pet)
	[24587] = { -- rank 1
		["threat"] = 5,
	},
	[24586] = { -- rank 2
		["threat"] = 5,
	},
	[24583] = { -- rank 3
		["threat"] = 5,
	},
	[24640] = { -- rank 4
		["threat"] = 5,
	},
	-- Holy Nova
	[15237] = { -- rank 1
		["multi"] = 0,
	},
	[15430] = { -- rank 2
		["multi"] = 0,
	},
	[15431] = { -- rank 3
		["multi"] = 0,
	},
	[27799] = { -- rank 4
		["multi"] = 0,
	},
	[27800] = { -- rank 5
		["multi"] = 0,
	},
	[27801] = { -- rank 6
		["multi"] = 0,
	},
}
local auraThreatSpells = {
	[6673] = true, [5242] = true, [6192] = true, [11549] = true, [11550] = true, [11551] = true, [25289] = true,  -- bs
	[1459] = true, [1460] = true, [1461] = true, [10156] = true, [10157] = true,  -- AI
	[1160] = true, [6190] = true, [11554] = true, [11555] = true, [11556] = true, [11556] = true,  -- DS
}
local spellsAppliedList = {
	[1160] = true, [6190] = true, [11554] = true, [11555] = true, [11556] = true, -- demo shout
}
local tierItemChanges = {
	[12] = {
		[2] = function()
			if not Lib.myThreatMulti["spells"][75] then
				Lib.myThreatMulti["spells"][75] = {
					["threat"] = 0,
					["multi"] = 1
				}
			end
			Lib.myThreatMulti["spells"][75]["multi"] = Lib.myThreatMulti["spells"][75]["multi"] * 0.75 or 0.75
			Lib.myThreatMulti["school"][1] = Lib.myThreatMulti["school"][1] * 2
		end
	},
	-- might
	[209] = {
		[8] = function()
			-- +15% sunder armor threat (https://classic.wowhead.com/spell=23561/enhanced-sunder-armor)
			if not Lib.myThreatMulti["spellChanges"][7386] then
				Lib.myThreatMulti["spellChanges"][7386] = {}
			end
			Lib.myThreatMulti["spellChanges"][7386]["multi"] = Lib.myThreatMulti["spellChanges"][7386] * 1.15 or 1.15

			if not Lib.myThreatMulti["spellChanges"][7405] then
				Lib.myThreatMulti["spellChanges"][7405] = {}
			end
			Lib.myThreatMulti["spellChanges"][7405]["multi"] = Lib.myThreatMulti["spellChanges"][7405] * 1.15 or 1.15

			if not Lib.myThreatMulti["spellChanges"][8380] then
				Lib.myThreatMulti["spellChanges"][8380] = {}
			end
			Lib.myThreatMulti["spellChanges"][8380]["multi"] = Lib.myThreatMulti["spellChanges"][8380] * 1.15 or 1.15

			if not Lib.myThreatMulti["spellChanges"][11596] then
				Lib.myThreatMulti["spellChanges"][11596] = {}
			end
			Lib.myThreatMulti["spellChanges"][11596]["multi"] = Lib.myThreatMulti["spellChanges"][11596] * 1.15 or 1.15

			if not Lib.myThreatMulti["spellChanges"][11597] then
				Lib.myThreatMulti["spellChanges"][11597] = {}
			end
			Lib.myThreatMulti["spellChanges"][11597]["multi"] = Lib.myThreatMulti["spellChanges"][11597]["multi"] * 1.15 or 1.15
		end
	},
	-- bloodfang
	[213] = {
		[5] = function()
		--"+25% threat mod feint (https://classic.wowhead.com/spell=23558/improved-feint 1966 6768 8637 11303 25302 1.25"
		if not Lib.myThreatMulti["spellChanges"][1966] then
			Lib.myThreatMulti["spellChanges"][1966] = {}
		end
		Lib.myThreatMulti["spellChanges"][1966]["multi"] = Lib.myThreatMulti["spellChanges"][1966] * 1.25 or 1.25

		if not Lib.myThreatMulti["spellChanges"][6768] then
			Lib.myThreatMulti["spellChanges"][6768] = {}
		end
		Lib.myThreatMulti["spellChanges"][6768]["multi"] = Lib.myThreatMulti["spellChanges"][6768] * 1.25 or 1.25

		if not Lib.myThreatMulti["spellChanges"][8637] then
			Lib.myThreatMulti["spellChanges"][8637] = {}
		end
		Lib.myThreatMulti["spellChanges"][8637]["multi"] = Lib.myThreatMulti["spellChanges"][8637] * 1.25 or 1.25

		if not Lib.myThreatMulti["spellChanges"][11303] then
			Lib.myThreatMulti["spellChanges"][11303] = {}
		end
		Lib.myThreatMulti["spellChanges"][11303]["multi"] = Lib.myThreatMulti["spellChanges"][11303] * 1.25 or 1.25

		if not Lib.myThreatMulti["spellChanges"][25302] then
			Lib.myThreatMulti["spellChanges"][25302] = {}
		end
		Lib.myThreatMulti["spellChanges"][25302]["multi"] = Lib.myThreatMulti["spellChanges"][25302]["multi"] * 1.25 or 1.25
		end
	},
	--arcanist
	[201] = {
		[8] = "Spell Threat -15%"
	},
	-- neaterwind
	[210] = {
		[3] = "Scorch-10001, Arcane Missiles-2001, Fireball-2001, frostbolt-10001 (https://www.wowhead.com/spell=21879/friendly-nukes"
	},
	--nemisis
	[212] = {
		[8] = "https://classic.wowhead.com/spell=23555/decreased-destruction-threat"
	},
	[525] = {
		[6] = "-10% healing"
	},
	--bonescythe
	[524] = {
		[6] = "backstab, sinister strike, hemorrhage, eviscerate -8% threat"
	},
	--plaguehaert
	[529] = {
		[6] = "crits -25% threat. Corruption, immolate, curse of agony, siphon life -25% threat."
	},
}

local CLEUEventTable = {
	["SPELL_DAMAGE"] = true,
	["SPELL_MISSEDS"] = true,
	["SPELL_HEAL"] = true,
	["SPELL_DRAIN"] = true,
	["SPELL_LEECH"] = true,
	["SPELL_INTERRUPT"] = true,
	["SPELL_DISPEL"] = true,
	["SPELL_DISPEL_FAILED"] = true,
	["SPELL_PERIODIC_DAMAGE"] = true,
	["SPELL_PERIODIC_MISSEDS"] = true,
	["SPELL_PERIODIC_HEAL"] = true,
	["SPELL_PERIODIC_DRAIN"] = true,
	["SPELL_PERIODIC_LEECH"] = true,
	["SPELL_PERIODIC_INTERRUPT"] = true,
	["SPELL_PERIODIC_DISPEL"] = true,
		["SPELL_PERIODIC_DISPEL_FAILED"] = true,
		["SPELL_CAST_SUCCESS"] = true,
		["SPELL_ENERGIZE"] = true,
		["SWING_DAMAGE"] = true,
		["RANGE_DAMAGE"] = true,
}

local stanceList = {
	["WARRIOR"] = {
		[1] = 0.8,
		[2] = 1.3,
		[3] = 0.8,
	},
	["DRUID"] = {
		[1] = 1.3,
		[3] = 0.8,
	}
}

local classTalentList = {
	sunder = {3, 10, "WARRIOR"},
	heroicstrike = {1, 1, "WARRIOR"},
	defiance = {3, 9, "WARRIOR"}, -- +3% defensive stance
	impale = {1, 11, "WARRIOR"},
	silentresolve = {1, 3, "PRIEST"}, -- -4% spell threat
	shadowaffinity = {3, 3, "PRIEST"}, -- - 8% shadow spells
	druidsubtlety = {3, 8, "DRUID"}, -- healing -4%
	feralinstinct = {2, 3, "DRUID"}, -- +3% bear form
	ferocity = {2, 1, "DRUID"},
	tranquility = {3, 13, "DRUID"}, -- -50% tranquility threat
	savagefury = {2, 13,"DRUID"},
	masterdemonologist = {2, 15, "WARLOCK"}, -- -4% imp threat
	arcanesubtlety = {1, 1, "MAGE"}, -- -20% arcane spells
	frostchanneling = {3, 12, "MAGE"}, -- -10% frost spells
	burningsoul = {2, 9, "MAGE"}, -- - 15% fire spells
	righteousfury = {2, 7, "PALADIN"}, -- +16% righteous fury
	healinggrace = {3, 9, "SHAMAN"}, -- -5% healing
	sleightofhand = {3, 3, "ROGUE"}, -- -10% feint
}

-- 71 defensive stance 130% threat mod
-- 768 cat form 80% threat mod
-- 5487 bear form 130% threat mod
-- 475 remove curse +14 threat
-- 2139 counterspell +300 threat
-- 4987 cleanse +40 threat
-- 20928 holy shield, +40, +30, +20 + 120% threat mod
-- 10942 fade, -55, -155, -285, -440, -620, -820, temporary?
-- 1966 feint, -150, -240, -390, -600, -800
-- 16316 rockbiter +72, +55, +41, +27, +16, +10, +6
-- 17752 suffering +600, +450, +300, +200
-- 20662 Execute 125% threat mod
-- 2457 battlestance/2458 berserker stance 80% threat mod
-- 25072 enchant gloves - threat +2% threat mod
-- 25084 enchant cloak - subtlety -2% threat mod
-- 12685 stealthblade (fade) -55 threat
-- 28862 eye of diminution -35% threat
-- 26400 fetish of the sand reaver -70% threat
local slotsToNotWatch = {
	[16] = true,
	[17] = true,
	[18] = true,
	[0] = true,
}
Lib.itemUpdateInfo = function(self, event, ...)
	local localClass, class = UnitClass("player")
	if event == "PLAYER_EQUIPMENT_CHANGED" then
		-- Don't need to check PLAYER_ENTERING_WORLD because
		-- we run this function again on talent check which fires on login
		local equipmentSlot, hasCurrent = ...
		if not UnitAffectingCombat("player") then
		-- fall through the player is out of combat
		-- need a better way to do this
		local tier = {}
			for i = 1,15 do -- we don't have to worry about weapons because they don't have any threat mods
				local item = GetInventoryItemID("player", i)
				if item then
					local setId = tierItemChanges[select(16, GetItemInfo(item))]
					if tierItemChanges[setId] then
						if tier[setId] then
							tier[setId] = tier[setId] + 1
						else
							tier[setId] = 1
						end
						if tierItemChanges[setId][tier[setId]] then
							tierItemChanges[setId][tier[setId]]()
						end
					end
				end
			end
		--[[ idk why but like there are no threat mod items, just procs so this part is just useless kms
		elseif equipmentSlot then
			if itemSlotList[equipmentSlot] then
				if itemList[GetInventoryItemID("player", equipmentSlot)] then

				end
			end
		else
			for i = 1, 18 do
				local item = GetInventoryItemID("player", i)
				if itemSlotList[item] then
					for k,v in pairs(itemSlotList[item]) do
						if Lib.myThreatMulti[k] then
							Lib.myThreatMulti[k] = v
						end
					end
				end
			end]]
		end
	end
	if event == "CHARACTER_POINTS_CHANGED" or event == "SPELLS_CHANGED" then
		-- recheck talents
		Lib.myThreatMulti = {
			["global"] = 1,
			["stance"] = 1,
			["spell"] = 1,
			["aura"] = 1,
			["healing"] = 0.5,
			["melee"] = 1.1,
			["range"] = 1.3,
			["rage"] = 5.0,
			["energy"] = 5.0,
			["mana"] = 0.5,
			["school"] = {
				[1] = 1, -- physical
				[2] = 1, -- holy
				[4] = 1, -- fire
				[8] = 1, -- nature
				[16] = 1, -- frost
				[32] = 1, -- shadow
				[64] = 1, -- arcane
			},
			["spells"] = {},
			["auraChanges"] = {},
			["stanceChanges"] = {}
		}
		local threatMulti = Lib.myThreatMulti
		if class == "DRUID" then
			local subtlety = select(5, GetTalentInfo(3, 8))
			local feralInstinct = select(5, GetTalentInfo(2, 3))
			local tranquility = select(5, GetTalentInfo(3, 13))
			if subtlety > 0 then
				threatMulti["healing"] = threatMulti["healing"] * (1 - subtlety * 0.04)
			end
			if feralInstinct > 0 then
				threatMulti["stanceChanges"][1] = feralInstinct * 0.3
			end
			if tranquility > 0 then
				threatMulti["spells"][9862] = (1 - tranquility * 0.5)
			end
		elseif class == "MAGE" then
			local arcaneSubtlety = select(5, GetTalentInfo(1,1))
			local burningSoul = select(5, GetTalentInfo(2, 9))
			local frostChanneling = select(5, GetTalentInfo(3, 12))
			if arcaneSubtlety > 0 then
				threatMulti["school"][64] = threatMulti["school"][64] * (1 - arcaneSubtlety * 0.2 )
			end
			if burningSoul > 0 then
				threatMulti["school"][4] = threatMulti["school"][4] * (1 - burningSoul * 0.15 )
			end
			if frostChanneling > 0 then
				threatMulti["school"][16] = threatMulti["school"][16] * (1 - burningSoul * 0.1 )
			end
		elseif class == "PALADIN" then
			local righteousFury = select(5, GetTalentInfo(2, 7))
			if righteousFury > 0 then
				threatMulti["auraChanges"][25780] = righteousFury * 0.16
			end
		elseif class == "PRIEST" then
			local shadowAffinity = select(5, GetTalentInfo(3, 3))
			local silentResolve = select(5, GetTalentInfo(1, 3))
			if shadowAffinity > 0 then
				threatMulti["school"][32] = threatMulti["school"][32] * (1 - shadowAffinity * 0.8 )
			end
			if silentResolve > 0 then
				threatMulti["spell"] = threatMulti["spell"] * (1 - silentResolve * 0.04 )
			end
		elseif class == "ROGUE" then
			threatMulti["melee"] = 0.8 -- rogue's have an 80% threat mod
			local sleightOfHand = select(5, GetTalentInfo(3, 3))
			if sleightOfHand > 0 then
				threatMulti["auras"][11303] = (1 - sleightOfHand * 0.1)
			end
		elseif class == "SHAMAN" then
			local healingGrace = select(5, GetTalentInfo(3, 9))
			if healingGrace > 0 then
				threatMulti["healing"] = threatMulti["healing"] * (1 - subtlety * 0.05)
			end
		elseif class == "WARLOCK" then
			local masterDemonologist = select(5, GetTalentInfo(2, 15))
			if masterDemonologist > 0 then
				threatMulti["spells"][20313] = (1 - masterDemonologist*0.04)
			end
		elseif class == "WARRIOR" then
			local defiance = select(5, GetTalentInfo(3, 9))
			if defiance > 0 then
				threatMulti["stanceChanges"][1] = defiance * 0.03
			end
		end
		Lib.itemUpdateInfo(self, "PLAYER_EQUIPMENT_CHANGED")
	end
end

local auraThreatList = {
	[25780] = { -- https://classic.wowhead.com/spell=25780/righteous-fury Righteous Fury
		["multi"] = 1.6,
	},
	[12685] = { -- https://classic.wowhead.com/spell=12685/fade Fade Stealthblade
		["threat"] = -55,
	},
	[23604] = { -- https://classic.wowhead.com/spell=23604/reduce-threat Reduce Threat Black Amnesty
		["threat"] = -540,
	},
	[28862] = { -- https://classic.wowhead.com/spell=28862/the-eye-of-diminution Eye of Diminution Eye of Diminution
		["multi"] = 0.65,
	},
	[26400] = { -- https://classic.wowhead.com/spell=26400/arcane-shroud Arcane Shroud Fetish of the Sand Reaver
		["multi"] = 0.3,
	},
	[25908] = { -- https://classic.wowhead.com/spell=25908/tranquil-air-totem Tranquil Air Totem
		["multi"] = 0.8,
	},
	[25892] = { -- https://classic.wowhead.com/spell=25892/grace-of-earth Grace of Earth
		["threat"] = -650,
	},
	[21992] = { -- https://classic.wowhead.com/spell=21992/thunderfury#used-by-item Thunderfury Nature Resist Proc
		["threat"] = 149,
	},
	[1038] = { -- https://classic.wowhead.com/spell=1038/blessing-of-salvation#comments Blessing of Salvation
		["multi"] = 0.7,
	},
	[25895] = { -- https://classic.wowhead.com/spell=25895/greater-blessing-of-salvation Greater Blessing of Salvation
		["multi"] = 0.7,
	},
}

local checkPlayerBuffs = function(self, event, ...)
	if event == "UPDATE_SHAPESHIFT_COOLDOWN" or event == "PLAYER_ENTERING_WORLD" then
		local localClass, class = UnitClass("player")
		for i=1, NUM_STANCE_SLOTS do
			local icon, name, active, spellId = GetShapeshiftFormInfo(i)
			if active then
				Lib.myThreatMulti["stance"] = stanceList[class][i] or 1
				if Lib.myThreatMulti["stanceChanges"][i] then
					Lib.myThreatMulti["stance"] = Lib.myThreatMulti["stance"] + Lib.myThreatMulti["stanceChanges"][i]
					return
				end
			end
		end
	elseif event == "UNIT_AURA" then
		Lib.myThreatMulti["aura"] = 1
		for i = 1,16 do
			local spellId = select(10, UnitBuff("player", i))
			if not spellId then return end
			if auraThreatList[spellId] then
				if Lib.myThreatMulti["auraChanges"][spellId] then
					Lib.myThreatMulti["aura"] = Lib.myThreatMulti["aura"] * (auraThreatList[spellId] + Lib.myThreatMulti["auraChanges"][spellId])
				else
					Lib.myThreatMulti["aura"] = Lib.myThreatMulti["aura"] * auraThreatList[spellId]
				end
			end
		end
	end			
end

local iterateGroupMembers = function()
	local unit = IsInRaid() and "raid" or "party"
	local numGroupMembers = unit == "party" and GetNumSubgroupMembers() or GetNumGroupMembers()
	local i = unit == "party" and 0 or 1
	return
	function()
	local ret
		if i == 0 and unit == "party" then
			ret = "player"
		elseif i <= numGroupMembers and i > 0 then
			ret = unit .. i
		end
		i = i + 1
		return ret
	end
end

local groupMessageFunction = function(self, event, ...)
	-- local channel = IsInRaid() and "RAID" or "PARTY"
	if event == "GROUP_ROSTER_UPDATE" or event == "PLAYER_ENTERING_WORLD" then
		for unit in iterateGroupMembers() do 
			Lib.groupMemberTable[UnitGUID(unit)] = true
		end
		--[[
		local message = string.format(
			"%s:%s:%d",
			guid,
			"HANDSHAKE",
			threat
		)
		C_ChatInfo.SendAddonMessage("THREATLIB", message, channel)]]
		
	elseif event == "CHAT_MSG_ADDON" then
		local prefix, message = ...
		if prefix == "THREATLIB" then
			local sourceGUID, threatEvent, threat, destGUID = strsplit(":", message)
			threat = tonumber(threat)
			if threatEvent == "THREAT_RECALC" and sourceGUID ~= UnitGUID("player") then
				if Lib.groupMemberTable[sourceGUID] then
					if not Lib.GUIDThreatTable[destGUID] then
						Lib.GUIDThreatTable[destGUID] = {}
					end
					if not Lib.GUIDThreatTable[destGUID][sourceGUID] then
						Lib.GUIDThreatTable[destGUID][sourceGUID] = 0
					end
					Lib.GUIDThreatTable[destGUID][sourceGUID] = Lib.GUIDThreatTable[destGUID][sourceGUID] + threat
					--MyLib.callbacks:Fire("THREATLIBUPDATE", sourceGUID, destGUID)
				end
			end
		end
	end
end

local threatCalcFunction = function(event, destGUID, sourceGUID, sourceName, spellId, spellSchool, amount, amount2, amount3, isHeal, powerType)
	if not amount then return end
	local channel = IsInRaid() and "RAID" or "PARTY"
	local name, rank, icon, castTime, minRange, maxRange = GetSpellInfo(spellId)
	local threatMulti = Lib.myThreatMulti
	local globaMod = threatMulti["global"]
	local attackMod = 1
	local spellMod = 1
	local spellAdd = 0
	local spellChangesAdd = 0
	local spellChangesMulti = 1
	local schoolMod = threatMulti["school"][spellSchool] or 1
	local stanceMod = threatMulti["stance"]
	local auraMod = threatMulti["aura"]
	local powerThreatMod = 1
	if powerType then
		if powerType == 0 then
			powerThreatMod = threatMulti["mana"]
		elseif powerType == 1 then
			powerThreatMod = threatMulti["rage"]
		elseif powerType == 3 then
			powerThreatMod = threatMulti["energy"]
		end
	end
	if threatMulti["spells"][spellId] then
		if threatMulti["spells"][spellId]["threat"] then
			spellChangesAdd = threatMulti["spells"][spellId]["threat"]
		end
		if threatMulti["spells"][spellId]["multi"] then
			spellChangesMulti = threatMulti["spells"][spellId]["multi"]
		end
	end
	if threatSpellMods[spellId] then
		if threatSpellMods[spellId]["threat"] then
			spellAdd = threatSpellMods[spellId]["threat"]
		end
		if threatSpellMods[spellId]["multi"] then
			spellMod = threatSpellMods[spellId]["multi"]
		end
	end
	if maxRange == 0 then
		attackMod = threatMulti["melee"]
	else
		attackMod = threatMulti["range"]
	end
	local threat = (amount+spellAdd+spellChangesAdd)*globaMod*attackMod*spellMod*spellChangesMulti*schoolMod
	if isHeal == true then
		attackMod = threatMulti["healing"]
		local threat = (amount-amount2+spellAdd+spellChangesAdd)*globaMod*attackMod*spellMod*spellChangesMulti*schoolMod
	end
	local message = string.format(
			"%s:%s:%s:%s",
			sourceGUID,
			"THREAT_RECALC",
			threat,
			destGUID
		)
		ChatThrottleLib:SendAddonMessage("NORMAL", "THREATLIB", message, channel)
		--MyLib.callbacks:Fire("THREATLIBUPDATE", sourceGUID, destGUID)
		--C_ChatInfo.SendAddonMessage("NORMAL", "THREATLIB", message, channel)
	return threat
end


local threatUpdateList = function(...)
	local time, event, _, sourceGUID, sourceName, _, _, destGUID, destName, _, _, spellId, spellName, spellSchool, amount, amount2, amount3 = CombatLogGetCurrentEventInfo()
	if (sourceGUID == UnitGUID("player") or sourceGUID == UnitGUID("pet")) and (amount or spellId) then
		local isHeal = false
		if event == "SPELL_AURA_REFRESH" or event == "SPELL_AURA_APPLIED" then
			if auraThreatSpells[spellId] then -- this spell was a buff
				for npc,threatList in pairs(Lib.GUIDThreatTable) do
					for playerGUID, threatvalue in pairs(threatList) do
						if playerGUID == sourceGUID then
							Lib.GUIDThreatTable[npc][sourceGUID] = Lib.GUIDThreatTable[npc][sourceGUID] + threatCalcFunction(event, npc, sourceGUID, sourceName, spellId, spellSchool, 0, 0, 0, isHeal)
							threatEvents:Fire("UNIT_THREAT_LIST_UPDATE")
							threatEvents:Fire("UNIT_THREAT_SITUATION_UPDATE")
							return
						end
					end
				end
			end
		elseif event == "SPELL_CAST_SUCCESS" then
			if tauntSpellList[spellId] then -- This is a taunt spell
				local maxThreat = 0
				if Lib.GUIDThreatTable[destGUID] then
					for playerGUID,threatValue in pairs(Lib.GUIDThreatTable[destGUID]) do
						if threatValue >= maxThreat then
							maxThreat = threatValue
						end
					end
					if not Lib.GUIDThreatTable[destGUID][sourceGUID] then
						Lib.GUIDThreatTable[destGUID][sourceGUID] = 0
					end
					Lib.GUIDThreatTable[destGUID][sourceGUID] = maxThreat
				else
					Lib.GUIDThreatTable[destGUID] = {}
					Lib.GUIDThreatTable[destGUID][sourceGUID] = 0
				end
				threatEvents:Fire("UNIT_THREAT_LIST_UPDATE")
				threatEvents:Fire("UNIT_THREAT_SITUATION_UPDATE")
			end
			return 
		elseif event == "SPELL_AURA_APPLIED" then
			if spellsAppliedList[spellId] then
				if not Lib.GUIDThreatTable[destGUID] then
					Lib.GUIDThreatTable[destGUID] = {}
				end
				local threatList = Lib.GUIDThreatTable[destGUID]
				if not threatList[sourceGUID] then
					threatList[sourceGUID] = 0
				end
				threatList[sourceGUID] = threatList[sourceGUID] + threatCalcFunction(event, destGUID, sourceGUID, sourceName, spellId, spellSchool, 0, 0, 0, isHeal)
				threatEvents:Fire("UNIT_THREAT_LIST_UPDATE")
				threatEvents:Fire("UNIT_THREAT_SITUATION_UPDATE")
			end
		elseif event == "SPELL_ENERGIZE" then
			for npc, threatList in pairs(Lib.GUIDThreatTable) do
				for playerGUID, threatvalue in pairs(threatList) do
					if playerGUID == sourceGUID then
						Lib.GUIDThreatTable[npc][sourceGUID] = Lib.GUIDThreatTable[npc][sourceGUID] + threatCalcFunction(event, npc, sourceGUID, sourceName, spellId, spellSchool, amount, 0, 0, isHeal, powerType)
						threatEvents:Fire("UNIT_THREAT_LIST_UPDATE")
						threatEvents:Fire("UNIT_THREAT_SITUATION_UPDATE")
					end
				end
			end
		elseif event == "SPELL_HEAL" then
			isHeal = true
			local mobList = {}
			for npcGUID, threatTable in pairs(Lib.GUIDThreatTable) do
				if Lib.GUIDThreatTable[npcGUID] then
					for playerGUID, info in pairs(threatTable) do
						if playerGUID == destGUID then
							mobList[1] = npcGUID
						end
					end
				end
			end
			local splitValue = #mobList
			for k,npc in pairs(mobList) do
				if not Lib.GUIDThreatTable[npc][sourceGUID] then
					Lib.GUIDThreatTable[npc][sourceGUID] = 0
				end
				Lib.GUIDThreatTable[npc][sourceGUID] = Lib.GUIDThreatTable[npc][sourceGUID] + threatCalcFunction(event, npc, sourceGUID, sourceName, spellId, spellSchool, amount, amount2, amount3, isHeal)/splitValue
			end
			threatEvents:Fire("UNIT_THREAT_LIST_UPDATE")
			threatEvents:Fire("UNIT_THREAT_SITUATION_UPDATE")
			return
		elseif event == "SWING_DAMAGE" then
			amount = spellId
			spellSchool = 1
		end
		if not Lib.GUIDThreatTable[destGUID] then
			Lib.GUIDThreatTable[destGUID] = {}
		end
		if CLEUEventTable[event] and Lib.GUIDThreatTable[destGUID] then
			local threatList = Lib.GUIDThreatTable[destGUID]
			if not threatList[sourceGUID] then
				threatList[sourceGUID] = 0
			end
			threatList[sourceGUID] = threatList[sourceGUID] + threatCalcFunction(event, destGUID, sourceGUID, sourceName, spellId, spellSchool, amount, amount2, amount3, isHeal) 
			threatEvents:Fire("UNIT_THREAT_LIST_UPDATE")
			threatEvents:Fire("UNIT_THREAT_SITUATION_UPDATE")
		end
	elseif event == "UNIT_DIED" then
		local unitType = strsplit("-", destGUID)
		if unitType == "player" or unitType == "pet" then 
			for npc,threatList in pairs(Lib.GUIDThreatTable) do
				for playerGUID, threatvalue in pairs(threatList) do 
					if playerGUID == destGUID then 
						threatList[npc][destGUID] = nil
						threatEvents:Fire("UNIT_THREAT_LIST_UPDATE")
						threatEvents:Fire("UNIT_THREAT_SITUATION_UPDATE")
					end
				end
			end
		elseif Lib.GUIDThreatTable[destGUID] then
			Lib.GUIDThreatTable[destGUID] = nil
			threatEvents:Fire("UNIT_THREAT_LIST_UPDATE")
			threatEvents:Fire("UNIT_THREAT_SITUATION_UPDATE")
		end
	end
end

Lib.DetailedThreatSituation = function(player, mob)
	local playerGUID = UnitGUID(player)
	local mobGUID = UnitGUID(mob)
	local highestThreatGUID = UnitGUID(player)
	local secondThreatGUID = UnitGUID(player)
	local threatPct = 100
	local maxThreat = 0
	local maxthreat2 = 0 
	local threatValue = 0
	local isTanking = 0
	local isMelee = IsItemInRange(8149, mob) 
	local unitType = strsplit("-", playerGUID)
	if UnitIsUnit(player, mob.."target") then
		isTanking = 1
	end
	local status = 3
	if Lib.GUIDThreatTable[mobGUID] then
		for unit,threat in pairs(Lib.GUIDThreatTable[mobGUID]) do
			if threat > maxThreat then
				maxThreat2 = maxThreat
				maxThreat = threat
				secondThreatGUID = highestThreatGUID
				highestThreatGUID = unit
			end
			if unit == playerGUID then
				threatValue = threat
			end
		end
	else
		return
	end
	if maxThreat > 0 then
		local rawThreatPct = threatValue/maxThreat
	end
	if unitType == "Pet" then 
		isMelee = true 
	end
	if maxThreat ~= threatValue and threatValue > 0 then
		if isMelee then
			threatPct = threatValue/(maxThreat*1.1)*100
		else
			threatPct = threatValue/(maxThreat*1.3)*100
		end
	elseif threatValue <= 0 then
		threatPct = 0
	end
	return isTanking, status, threatPct, rawThreatPct, threatValue
end

Lib.groupMessageFrame:SetScript("OnEvent", groupMessageFunction)
Lib.updaterFrame:SetScript("OnEvent", threatUpdateList)
Lib.talentItemUpdater:SetScript("OnEvent", Lib.itemUpdateInfo)
Lib.auraChecker:SetScript("OnEvent", checkPlayerBuffs)
Lib.initialise:SetScript("OnEvent", loadThreat)
C_ChatInfo.RegisterAddonMessagePrefix("THREATLIB")
