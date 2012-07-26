local T, C, L = unpack(ShestakUI)
if T.client ~= "itIT" then return end

----------------------------------------------------------------------------------------
--	Localization for itIT client(Thanks to Oz for the translation)
----------------------------------------------------------------------------------------
-- Key binding Header Name
L_EXTRA_HEADER_EXTRABAR = "Barra extra"
L_EXTRA_HEADER_MARK = "Icone dell'incursione in mouseover"

-- Announce fps
L_EXTRA_ANNOUNCE_FPS = "I miei attuali FPS sono "

-- Click2Cast
L_EXTRA_BINDER_FRAMES = "Riquadri"
L_EXTRA_BINDER_OPEN = "Apri l'assegnazione incantesimi/abilità"
L_EXTRA_BINDER_CLOSE = "Chiudi l'assegnazione incantesimi/abilità"

-- BG announce
L_EXTRA_ANNOUNCE_BG_LIGHT = "Piccolo attacco in arrivo: "
L_EXTRA_ANNOUNCE_BG_MEDIUM = "Attacco in arrivo: "
L_EXTRA_ANNOUNCE_BG_HEAVY = "Pesante attacco in arrivo: "
L_EXTRA_ANNOUNCE_BG_CLEAR = "Tutto calmo: "
L_EXTRA_ANNOUNCE_BG_FOCUS = "Concentrate il danno su "
L_EXTRA_ANNOUNCE_BG_STEALTH = "Nemici furtivi nei paraggi"

-- EnchantScroll
L_EXTRA_SCROLL = "Pergamena"

-- Announce your Lightwell
L_EXTRA_ANNOUNCE_LA_USE = " ha usato il mio Pozzo di Luce. "
L_EXTRA_ANNOUNCE_LA_CHARGE = " carica (cariche)."
L_EXTRA_ANNOUNCE_LA_USELESS = " ha usato il mio Pozzo di Luce inutilmente."
L_EXTRA_ANNOUNCE_LA_STOP = "Non avresti dovuto utilizzare il Pozzo di Luce."
L_EXTRA_ANNOUNCE_LA_PLACED = "Pozzo di Luce posizionato."
L_EXTRA_ANNOUNCE_LA_CHARGES = " cariche."

-- Announce flasks and food
L_EXTRA_ANNOUNCE_FF_NOFOOD = "Senza beneficio da cibo: "
L_EXTRA_ANNOUNCE_FF_NOFLASK = "Senza beneficio da tonico: "
L_EXTRA_ANNOUNCE_FF_ALLBUFFED = "Tutti i benefici sono attivi!"
L_EXTRA_ANNOUNCE_FF_CHECK_BUTTON = "Controllo uso cibi e tonici"

-- Says thanks for some spells
L_EXTRA_ANNOUNCE_SS_THANKS = "Grazie per "
L_EXTRA_ANNOUNCE_SS_RECEIVED = " ricevuto/a da "

-- Taunt announce
L_EXTRA_TAUNT_UNKNOWN = "Comando sconociuto:"
L_EXTRA_TAUNT_ADD = "Aggiungi difensore"
L_EXTRA_TAUNT_DEL = "Cancella difensore"
L_EXTRA_TAUNT_DEL_ALL = "Cancella tutti i difensori"
L_EXTRA_TAUNT_TANK_LIST = "Lista dei difensori"
L_EXTRA_TAUNT_AURA = "Controllo delle auree"
L_EXTRA_TAUNT_AURA_CHECK = "Cotrollo delle auree completato."
L_EXTRA_TAUNT_ALREADY_LIST = " è già nella lista."
L_EXTRA_TAUNT_ADDED_TANK = "Difensore aggiunto "
L_EXTRA_TAUNT_REMOVED_TANK = "Difensore rimosso "
L_EXTRA_TAUNT_TARGET_FIRST = "Devi avere prima in bersaglio un membro del gruppo."
L_EXTRA_TAUNT_ALL_REMOVED = "Tutti i difensori 'personali' rimossi."

-- ExploreMap
L_EXTRA_EXPLORED = "Esplorato/a: "
L_EXTRA_ZONEACHID = { -- Needs review
	-- http://www.wowhead.com/achievement=*
	-- e(X)plore achievement id, (Q)uest achievement id
	["Regni Orientali"]					= {X =   42, A =    0, H =    0},
	["Kalimdor"]						= {X =   43, A =    0, H =    0},
	["Terre Esterne"]					= {X =   44, A =    0, H =    0},
	["Nordania"]						= {X =   45, A =    0, H =    0},
	["Mappa del mondo"]					= {X =  nil, A =    0, H =    0},
	-- Eastern Kingdoms
	["Altipiani d'Arathi"]				= {X =  761, A = 4896, H = 4896},
	["Maleterre"]						= {X =  765, A = 4900, H = 4900},
	["Terre Devastate"]					= {X =  766, A = 4909, H = 4909},
	["Steppe Ardenti"]					= {X =  775, A = 4901, H = 4901},
	["Valico Ventomorto"]				= {X =  777, A =    0, H =    0},
	["Dun Morogh"]						= {X =  627, A =    0, H =    0},
	["Boscovespro"]						= {X =  778, A = 4907, H =    0},
	["Terre Infette Orientali"]			= {X =  771, A = 4892, H = 4892},
	["Foresta di Elwynn"]				= {X =  776, A =    0, H =    0},
	["Boschi di Cantoeterno"]			= {X =  859, A =    0, H =    0},
	["Terre Spettrali"]					= {X =  858, A =    0, H = 4908},
	["Alture di Colletorto"]			= {X =  772, A =    0, H = 4895},
	["Loch Modan"]						= {X =  779, A = 4899, H =    0},
	["Rovotorto Settentrionale"]		= {X =  781, A = 4906, H = 4906},
	["Montagne Crestarossa"]			= {X =  780, A = 4902, H =    0},
	["Gorgia Rovente"]					= {X =  774, A = 4910, H = 4910},
	["Selva Pinargento"]				= {X =  769, A =    0, H = 4894},
	["Palude del Dolore"]				= {X =  782, A = 4904, H = 4904},
	["Capo di Rovotorto"]				= {X = 4995, A = 4905, H = 4905},
	["Entroterre"]						= {X =  773, A = 4897, H = 4897},
	["Radure di Tirisfal"]				= {X =  768, A =    0, H =    0},
	["Terre Infette Occidentali"]		= {X =  770, A = 4893, H = 4893},
	["Marche Occidentali"]				= {X =  802, A = 4903, H =    0},
	["Paludi Grigie"]					= {X =  841, A = 4898, H =    0},
	-- Kalimdor
	["Valtetra"]						= {X =  845, A = 4925, H = 4976},
	["Azshara"]							= {X =  852, A =    0, H = 4927},
	["Isola Brumazzurra"]				= {X =  860, A =    0, H =    0},
	["Isola Brumacremisi"]				= {X =  861, A = 4926, H = 4926},
	["Rivafosca"]						= {X =  844, A = 4928, H = 4928},
	["Desolanda"]						= {X =  848, A = 4930, H = 4930},
	["Durotar"]							= {X =  728, A =    0, H =    0},
	["Acquemorte"]						= {X =  850, A = 4929, H = 4978},
	["Vilbosco"]						= {X =  853, A = 4931, H = 4931},
	["Feralas"]							= {X =  849, A = 4932, H = 4979},
	["Radaluna"]						= {X =  855, A =    0, H =    0},
	["Mulgore"]							= {X =  736, A =    0, H =    0},
	["Savane Settentrionali"]			= {X =  750, A =    0, H = 4933},
	["Silitus"]							= {X =  856, A = 4934, H = 4934},
	["Savane Meridionali"]				= {X = 4996, A = 4937, H = 4981},
	["Valle di Petrartiglio"]			= {X =  847, A = 4936, H = 4980},
	["Tanaris"]							= {X =  851, A = 4935, H = 4935},
	["Teldrassil"]						= {X =  842, A =    0, H =    0},
	["Millepicchi"]						= {X =  846, A = 4938, H = 4938},
	["Cratere di Un'Goro"]				= {X =  854, A = 4939, H = 4939},
	["Fontefredda"]						= {X =  857, A = 4940, H = 4940},
	-- Outland
	["Montagne Spinaguzza"]				= {X =  865, A = 1193, H = 1193},
	["Penisola del Fuoco Infernale"]	= {X =  862, A = 1189, H = 1271},
	["Nagrand"]							= {X =  866, A = 1192, H = 1273},
	["Landa Fatua"]						= {X =  843, A = 1194, H = 1194},
	["Valle di Torvaluna"]				= {X =  864, A = 1195, H = 1195},
	["Foresta di Terokk"]				= {X =  867, A = 1191, H = 1272},
	["Paludi di Zangar"]				= {X =  863, A = 1190, H = 1190},
	-- Northrend
	["Tundra Boreale"]					= {X = 1264, A =   33, H = 1358},
	["Foresta di Cristallo"]			= {X = 1457, A =    0, H =    0},
	["Dracombra"]						= {X = 1265, A =   35, H = 1356},
	["Colli Bradi"]						= {X = 1266, A =   37, H = 1357},
	["Fiordo Echeggiante"]				= {X = 1263, A =   34, H = 1356},
	["Corona di Ghiaccio"]				= {X = 1270, A =   40, H =   40},
	["Bacino di Sholazar"]				= {X = 1268, A =   39, H =   39},
	["Cime Tempestose"]					= {X = 1269, A =   38, H =   38},
	["Zul'Drak"]						= {X = 1267, A =   36, H =   36},
	-- Cataclysm
	["Rocciafonda"]						= {X = 4864, A = 4871, H = 4871},
	["Monte Hyjal"]						= {X = 4863, A = 4870, H = 4870},
	["Alture del Crepuscolo"]			= {X = 4866, A = 4873, H = 5501},
	["Uldum"]							= {X = 4865, A = 4872, H = 4872},
	["Vashj'ir"]						= {X = 4825, A = 4869, H = 4982},
	["Tol Barad"]						= {X =    0, A = 4874, H = 4874},
	["Penisola di Tol Barad"]			= {X =    0, A = 4874, H = 4874},
	-- Boolean Explores
	["Isola di Quel'Danas"]				= {X =  868, A =    0, H =    0},
	["Ahn'Qiraj: il Regno Perduto"]		= {X =    0, A =    0, H =    0},
	["Lungoinverno"]					= {X =    0, A =    0, H =    0},
}