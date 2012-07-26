local T, C, L = unpack(ShestakUI)
if T.client ~= "deDE" then return end

----------------------------------------------------------------------------------------
--	Localization for deDE client(Thanks to Vienchen for the translation)
----------------------------------------------------------------------------------------
-- Key binding Header Name
L_EXTRA_HEADER_EXTRABAR = "Extra Bar" -- Needs review
L_EXTRA_HEADER_MARK = "Mouseover Raid Icons" -- Needs review

-- Announce fps
L_EXTRA_ANNOUNCE_FPS = "Meine FPS sind "

-- Click2Cast
L_EXTRA_BINDER_FRAMES = "Frames"
L_EXTRA_BINDER_OPEN = "Öffne spell binder"
L_EXTRA_BINDER_CLOSE = "Schließe spell binder"

-- BG announce
L_EXTRA_ANNOUNCE_BG_LIGHT = "wenig Schaden auf "
L_EXTRA_ANNOUNCE_BG_MEDIUM = "mittlerer Schaden auf "
L_EXTRA_ANNOUNCE_BG_HEAVY = "viel Schaden auf "
L_EXTRA_ANNOUNCE_BG_CLEAR = "alles klar auf "
L_EXTRA_ANNOUNCE_BG_FOCUS = "Fokusschaden auf "
L_EXTRA_ANNOUNCE_BG_STEALTH = "Unsichtbarer Gegner in der Nähe"

-- EnchantScroll
L_EXTRA_SCROLL = "Rolle"

-- Announce your Lightwell
L_EXTRA_ANNOUNCE_LA_USE = " used my lightwell. " -- Needs review
L_EXTRA_ANNOUNCE_LA_CHARGE = " charge(s))" -- Needs review
L_EXTRA_ANNOUNCE_LA_USELESS = " used my lightwell, uselessly. " -- Needs review
L_EXTRA_ANNOUNCE_LA_STOP = "You shouldn't have used the lightwell." -- Needs review
L_EXTRA_ANNOUNCE_LA_PLACED = "Lightwell placed. " -- Needs review
L_EXTRA_ANNOUNCE_LA_CHARGES = " charges." -- Needs review

-- Announce flasks and food
L_EXTRA_ANNOUNCE_FF_NOFOOD = "Kein Essen: "
L_EXTRA_ANNOUNCE_FF_NOFLASK = "Kein Fläschchen: "
L_EXTRA_ANNOUNCE_FF_ALLBUFFED = "Alles drin!"
L_EXTRA_ANNOUNCE_FF_CHECK_BUTTON = "Check food and flask" -- Needs review

-- Says thanks for some spells
L_EXTRA_ANNOUNCE_SS_THANKS = "Thanks for " -- Needs review
L_EXTRA_ANNOUNCE_SS_RECEIVED = " received from " -- Needs review

-- Taunt announce
L_EXTRA_TAUNT_UNKNOWN = "Unknown command:" -- Needs review
L_EXTRA_TAUNT_ADD = "Add tank" -- Needs review
L_EXTRA_TAUNT_DEL = "Delete tank" -- Needs review
L_EXTRA_TAUNT_DEL_ALL = "Delete all tanks" -- Needs review
L_EXTRA_TAUNT_TANK_LIST = "List of tanks" -- Needs review
L_EXTRA_TAUNT_AURA = "Auras check" -- Needs review
L_EXTRA_TAUNT_AURA_CHECK = "Auras check done." -- Needs review
L_EXTRA_TAUNT_ALREADY_LIST = " is already in the list." -- Needs review
L_EXTRA_TAUNT_ADDED_TANK = "Added tank " -- Needs review
L_EXTRA_TAUNT_REMOVED_TANK = "Removed tank " -- Needs review
L_EXTRA_TAUNT_TARGET_FIRST = "You have to target a group member first." -- Needs review
L_EXTRA_TAUNT_ALL_REMOVED = "All custom tanks removed." -- Needs review

-- ExploreMap
L_EXTRA_EXPLORED = "Explored: " -- Needs review
L_EXTRA_ZONEACHID = {
	-- http://www.wowhead.com/achievement=*
	-- e(X)plore achievement id, (Q)uest achievement id
	["Östliche Königreiche"]			= {X =   42, A =    0, H =    0},
	["Kalimdor"]						= {X =   43, A =    0, H =    0},
	["Scherbenwelt"]					= {X =   44, A =    0, H =    0},
	["Nordend"]							= {X =   45, A =    0, H =    0},
	["Weltkarte"]						= {X =  nil, A =    0, H =    0},
	-- Eastern Kingdoms
	["Arathihochland"]					= {X =  761, A = 4896, H = 4896},
	["Ödland"]							= {X =  765, A = 4900, H = 4900},
	["Verwüstete Lande"]				= {X =  766, A = 4909, H = 4909},
	["Brennende Steppe"]				= {X =  775, A = 4901, H = 4901},
	["Gebirgspass der Totenwinde"]		= {X =  777, A =    0, H =    0},
	["Dun Morogh"]						= {X =  627, A =    0, H =    0},
	["Dämmerwald"]						= {X =  778, A = 4907, H =    0},
	["Östliche Pestländer"]				= {X =  771, A = 4892, H = 4892},
	["Wald von Elwynn"]					= {X =  776, A =    0, H =    0},
	["Immersangwald"]					= {X =  859, A =    0, H =    0},
	["Geisterlande"]					= {X =  858, A =    0, H = 4908},
	["Vorgebirge des Hügellands"]		= {X =  772, A =    0, H = 4895},
	["Loch Modan"]						= {X =  779, A = 4899, H =    0},
	["Nördliches Schlingendorntal"]		= {X =  781, A = 4906, H = 4906},
	["Rotkammgebirge"]					= {X =  780, A = 4902, H =    0},
	["Sengende Schlucht"]				= {X =  774, A = 4910, H = 4910},
	["Silberwald"]						= {X =  769, A =    0, H = 4894},
	["Sümpfe des Elends"]				= {X =  782, A = 4904, H = 4904},
	["Das Schlingendornkap"]			= {X = 4995, A = 4905, H = 4905},
	["Hinterland"]						= {X =  773, A = 4897, H = 4897},
	["Tirisfal"]						= {X =  768, A =    0, H =    0},
	["Westliche Pestländer"]			= {X =  770, A = 4893, H = 4893},
	["Westfall"]						= {X =  802, A = 4903, H =    0},
	["Sumpfland"]						= {X =  841, A = 4898, H =    0},
	-- Kalimdor
	["Eschental"]						= {X =  845, A = 4925, H = 4976},
	["Azshara"]							= {X =  852, A =    0, H = 4927},
	["Azurmythosinsel"]					= {X =  860, A =    0, H =    0},
	["Blutmythosinsel"]					= {X =  861, A = 4926, H = 4926},
	["Dunkelküste"]						= {X =  844, A = 4928, H = 4928},
	["Desolace"]						= {X =  848, A = 4930, H = 4930},
	["Durotar"]							= {X =  728, A =    0, H =    0},
	["Düstermarschen"]					= {X =  850, A = 4929, H = 4978},
	["Teufelswald"]						= {X =  853, A = 4931, H = 4931},
	["Feralas"]							= {X =  849, A = 4932, H = 4979},
	["Mondlichtung"]					= {X =  855, A =    0, H =    0},
	["Mulgore"]							= {X =  736, A =    0, H =    0},
	["Nördliches Brachland"]			= {X =  750, A =    0, H = 4933},
	["Silithus"]						= {X =  856, A = 4934, H = 4934},
	["Südliches Brachland"]				= {X = 4996, A = 4937, H = 4981},
	["Steinkrallengebirge"]				= {X =  847, A = 4936, H = 4980},
	["Tanaris"]							= {X =  851, A = 4935, H = 4935},
	["Teldrassil"]						= {X =  842, A =    0, H =    0},
	["Tausend Nadeln"]					= {X =  846, A = 4938, H = 4938},
	["Krater von Un'Goro"]				= {X =  854, A = 4939, H = 4939},
	["Winterquell"]						= {X =  857, A = 4940, H = 4940},
	-- Outland
	["Schergrat"]						= {X =  865, A = 1193, H = 1193},
	["Höllenfeuerhalbinsel"]			= {X =  862, A = 1189, H = 1271},
	["Nagrand"]							= {X =  866, A = 1192, H = 1273},
	["Nethersturm"]						= {X =  843, A = 1194, H = 1194},
	["Schattenmondtal"]					= {X =  864, A = 1195, H = 1195},
	["Wälder von Terokkar"]				= {X =  867, A = 1191, H = 1272},
	["Zangarmarschen"]					= {X =  863, A = 1190, H = 1190},
	-- Northrend
	["Boreanische Tundra"]				= {X = 1264, A =   33, H = 1358},
	["Kristallsangwald"]				= {X = 1457, A =    0, H =    0},
	["Drachenöde"]						= {X = 1265, A =   35, H = 1356},
	["Grizzlyhügel"]					= {X = 1266, A =   37, H = 1357},
	["Der Heulende Fjord"]				= {X = 1263, A =   34, H = 1356},
	["Eiskrone"]						= {X = 1270, A =   40, H =   40},
	["Sholazarbecken"]					= {X = 1268, A =   39, H =   39},
	["Die Sturmgipfel"]					= {X = 1269, A =   38, H =   38},
	["Zul'Drak"]						= {X = 1267, A =   36, H =   36},
	-- Cataclysm
	["Tiefenheim"]						= {X = 4864, A = 4871, H = 4871},
	["Hyjal"]							= {X = 4863, A = 4870, H = 4870},
	["Schattenhochland"]				= {X = 4866, A = 4873, H = 5501},
	["Uldum"]							= {X = 4865, A = 4872, H = 4872},
	["Vashj'ir"]						= {X = 4825, A = 4869, H = 4982},
	["Tol Barad"]						= {X =    0, A = 4874, H = 4874},
	["Halbinsel von Tol Barad"]			= {X =    0, A = 4874, H = 4874},
	-- Boolean Explores
	["Insel von Quel'Danas"]			= {X =  868, A =    0, H =    0},
	["Ahn'Qiray: Das Gefallene Königreich"] = {X =    0, A =    0, H =    0},
	["Tausendwintersee"]				= {X =    0, A =    0, H =    0},
}