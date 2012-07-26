local T, C, L = unpack(ShestakUI)
if T.client ~= "frFR" then return end

----------------------------------------------------------------------------------------
--	Localization for frFR client(Thanks to Puree for the translation)
----------------------------------------------------------------------------------------
-- Key binding Header Name
L_EXTRA_HEADER_EXTRABAR = "Extra Bar" -- Needs review
L_EXTRA_HEADER_MARK = "Mouseover Raid Icons" -- Needs review

-- Announce fps
L_EXTRA_ANNOUNCE_FPS = "Mon FPS actuel : "

-- Click2Cast
L_EXTRA_BINDER_FRAMES = "Cadres d'unité"
L_EXTRA_BINDER_OPEN = "Ouvrir bind des sorts"
L_EXTRA_BINDER_CLOSE = "Fermer bind des sorts"

-- BG announce
L_EXTRA_ANNOUNCE_BG_LIGHT = "Attaque mineure venant sur "
L_EXTRA_ANNOUNCE_BG_MEDIUM = "Attaque moyenne venant sur "
L_EXTRA_ANNOUNCE_BG_HEAVY = "Attaque massive venant sur "
L_EXTRA_ANNOUNCE_BG_CLEAR = "Tout est Ok à "
L_EXTRA_ANNOUNCE_BG_FOCUS = "Focus dégats sur "
L_EXTRA_ANNOUNCE_BG_STEALTH = "Ennemi furtif proche détecté"

-- EnchantScroll
L_EXTRA_SCROLL = "Parchemin"

-- Announce your Lightwell
L_EXTRA_ANNOUNCE_LA_USE = " a utilisé mon Puits de lumière. "
L_EXTRA_ANNOUNCE_LA_CHARGE = " charge(s))"
L_EXTRA_ANNOUNCE_LA_USELESS = " a utilisé mon Puits de lumière, pour rien. "
L_EXTRA_ANNOUNCE_LA_STOP = "Vous n'aviez pas besoin d'utiliser le Puits de lumière."
L_EXTRA_ANNOUNCE_LA_PLACED = "Puits de lumière placé. "
L_EXTRA_ANNOUNCE_LA_CHARGES = " charges."

-- Announce flasks and food
L_EXTRA_ANNOUNCE_FF_NOFOOD = "No Food: " -- Needs review
L_EXTRA_ANNOUNCE_FF_NOFLASK = "No Flask: " -- Needs review
L_EXTRA_ANNOUNCE_FF_ALLBUFFED = "All Buffed!" -- Needs review
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
	["Royaumes de l'Est"]				= {X =   42, A =    0, H =    0},
	["Kalimdor"]						= {X =   43, A =    0, H =    0},
	["Outreterre"]						= {X =   44, A =    0, H =    0},
	["Norfendre"]						= {X =   45, A =    0, H =    0},
	["Carte du monde"]					= {X =  nil, A =    0, H =    0},
	-- Eastern Kingdoms
	["Hautes-terres Arathies"]			= {X =  761, A = 4896, H = 4896},
	["Terres Ingrates"]					= {X =  765, A = 4900, H = 4900},
	["Terres Foudroyées"]				= {X =  766, A = 4909, H = 4909},
	["Steppes Ardentes"]				= {X =  775, A = 4901, H = 4901},
	["Défilé de Deuillevent"]			= {X =  777, A =    0, H =    0},
	["Dun Morogh"]						= {X =  627, A =    0, H =    0},
	["Bois de la Pénombre"]				= {X =  778, A = 4907, H =    0},
	["Maleterres de l'Est"]				= {X =  771, A = 4892, H = 4892},
	["Forêt d'Elwynn"]					= {X =  776, A =    0, H =    0},
	["Bois des Chants éternels"]		= {X =  859, A =    0, H =    0},
	["Les terres Fantômes"]				= {X =  858, A =    0, H = 4908},
	["Contreforts de Hautebrande"]		= {X =  772, A =    0, H = 4895},
	["Loch Modan"]						= {X =  779, A = 4899, H =    0},
	["Strangleronce septentrionale"]	= {X =  781, A = 4906, H = 4906},
	["Les Carmines"]					= {X =  780, A = 4902, H =    0},
	["Gorge des Vents brûlants"]		= {X =  774, A = 4910, H = 4910},
	["Forêt des Pins Argentés"]			= {X =  769, A =    0, H = 4894},
	["Marais des Chagrins"]				= {X =  782, A = 4904, H = 4904},
	["Cap Strangleronce"]				= {X = 4995, A = 4905, H = 4905},
	["Les Hinterlands"]					= {X =  773, A = 4897, H = 4897},
	["Clairières de Tirisfal"]			= {X =  768, A =    0, H =    0},
	["Maleterres de l'Ouest"]			= {X =  770, A = 4893, H = 4893},
	["Marche de l'Ouest"]				= {X =  802, A = 4903, H =    0},
	["Les Paluns"]						= {X =  841, A = 4898, H =    0},
	-- Kalimdor
	["Orneval"]							= {X =  845, A = 4925, H = 4976},
	["Azshara"]							= {X =  852, A =    0, H = 4927},
	["Île de Brume-Azur"]				= {X =  860, A =    0, H =    0},
	["Île de Brume-Sang"]				= {X =  861, A = 4926, H = 4926},
	["Sombrivage"]						= {X =  844, A = 4928, H = 4928},
	["Désolace"]						= {X =  848, A = 4930, H = 4930},
	["Durotar"]							= {X =  728, A =    0, H =    0},
	["Marécage d'Âprefange"]			= {X =  850, A = 4929, H = 4978},
	["Gangrebois"]						= {X =  853, A = 4931, H = 4931},
	["Féralas"]							= {X =  849, A = 4932, H = 4979},
	["Reflet-de-Lune"]					= {X =  855, A =    0, H =    0},
	["Mulgore"]							= {X =  736, A =    0, H =    0},
	["Tarides du Nord"]					= {X =  750, A =    0, H = 4933},
	["Silithus"]						= {X =  856, A = 4934, H = 4934},
	["Tarides du Sud"]					= {X = 4996, A = 4937, H = 4981},
	["Les Serres-Rocheuses"]			= {X =  847, A = 4936, H = 4980},
	["Tanaris"]							= {X =  851, A = 4935, H = 4935},
	["Teldrassil"]						= {X =  842, A =    0, H =    0},
	["Mille pointes"]					= {X =  846, A = 4938, H = 4938},
	["Cratère d'Un'Goro"]				= {X =  854, A = 4939, H = 4939},
	["Berceau-de-l'Hiver"]				= {X =  857, A = 4940, H = 4940},
	-- Outland
	["Les Tranchantes"]					= {X =  865, A = 1193, H = 1193},
	["Péninsule des Flammes infernales"]= {X =  862, A = 1189, H = 1271},
	["Nagrand"]							= {X =  866, A = 1192, H = 1273},
	["Raz-de-Néant"]					= {X =  843, A = 1194, H = 1194},
	["Vallée d'Ombrelune"]				= {X =  864, A = 1195, H = 1195},
	["Forêt de Terokkar"]				= {X =  867, A = 1191, H = 1272},
	["Marécage de Zangar"]				= {X =  863, A = 1190, H = 1190},
	-- Northrend
	["Toundra Boréenne"]				= {X = 1264, A =   33, H = 1358},
	["Forêt du Chant de cristal"]		= {X = 1457, A =    0, H =    0},
	["Désolation des dragons"]			= {X = 1265, A =   35, H = 1356},
	["Les Grisonnes"]					= {X = 1266, A =   37, H = 1357},
	["Fjord Hurlant"]					= {X = 1263, A =   34, H = 1356},
	["La Couronne de glace"]			= {X = 1270, A =   40, H =   40},
	["Bassin de Sholazar"]				= {X = 1268, A =   39, H =   39},
	["Les pics Foudroyés"]				= {X = 1269, A =   38, H =   38},
	["Zul'Drak"]						= {X = 1267, A =   36, H =   36},
	-- Cataclysm
	["Le Tréfonds"]						= {X = 4864, A = 4871, H = 4871},
	["Mont Hyjal"]						= {X = 4863, A = 4870, H = 4870},
	["Hautes-terres du Crépuscule"]		= {X = 4866, A = 4873, H = 5501},
	["Uldum"]							= {X = 4865, A = 4872, H = 4872},
	["Vashj'ir"]						= {X = 4825, A = 4869, H = 4982},
	["Tol Barad"]						= {X =    0, A = 4874, H = 4874},
	["Péninsule de Tol Barad"]			= {X =    0, A = 4874, H = 4874},
	-- Boolean Explores
	["Île de Quel'Danas"]				= {X =  868, A =    0, H =    0},
	["Ahn'Qiraj : le royaume Déchu"]	= {X =    0, A =    0, H =    0},
	["Joug-d'hiver"]					= {X =    0, A =    0, H =    0},
}