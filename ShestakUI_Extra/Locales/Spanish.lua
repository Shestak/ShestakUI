local T, C, L = unpack(ShestakUI)
if T.client ~= "esES" or T.client ~= "esMX" then return end

----------------------------------------------------------------------------------------
--	Localization for esES and esMX client(Thanks to eXecrate for the translation)
----------------------------------------------------------------------------------------
-- Key binding Header Name
L_EXTRA_HEADER_EXTRABAR = "Extra Bar" -- Needs review
L_EXTRA_HEADER_MARK = "Mouseover Raid Icons" -- Needs review

-- Announce fps
L_EXTRA_ANNOUNCE_FPS = "Mis FPS actuales son "

-- Click2Cast
L_EXTRA_BINDER_FRAMES = "Cuadros"
L_EXTRA_BINDER_OPEN = "Abrir encuadernador de hechizos"
L_EXTRA_BINDER_CLOSE = "Cerrar encuadernador de hechizos"

-- BG announce
L_EXTRA_ANNOUNCE_BG_LIGHT = "Ataque ligero llega a "
L_EXTRA_ANNOUNCE_BG_MEDIUM = "Ataque medio llega a "
L_EXTRA_ANNOUNCE_BG_HEAVY = "Ataque duro llega a "
L_EXTRA_ANNOUNCE_BG_CLEAR = "Todo despejado en "
L_EXTRA_ANNOUNCE_BG_FOCUS = "Centrar daño en "
L_EXTRA_ANNOUNCE_BG_STEALTH = "Enemigos en sigilo en las inmediaciones"

-- EnchantScroll
L_EXTRA_SCROLL = "Pergamino"

-- Announce your Lightwell
L_EXTRA_ANNOUNCE_LA_USE = " usó mi Pozo de Luz. "
L_EXTRA_ANNOUNCE_LA_CHARGE = " carga(s))"
L_EXTRA_ANNOUNCE_LA_USELESS = " usó mi Pozo de Luz inútilmente. "
L_EXTRA_ANNOUNCE_LA_STOP = "No deberías haber usado el Pozo de Luz."
L_EXTRA_ANNOUNCE_LA_PLACED = "Pozo de Luz colocado. "
L_EXTRA_ANNOUNCE_LA_CHARGES = " cargas."

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
if T.client == "esES" then
L_EXTRA_ZONEACHID = {
	-- http://www.wowhead.com/achievement=*
	-- e(X)plore achievement id, (Q)uest achievement id
	["Reinos del Este"]					= {X =   42, A =    0, H =    0},
	["Kalimdor"]						= {X =   43, A =    0, H =    0},
	["Terrallende"]						= {X =   44, A =    0, H =    0},
	["Rasganorte"]						= {X =   45, A =    0, H =    0},
	["Mapa del mundo"]					= {X =  nil, A =    0, H =    0},
	-- Eastern Kingdoms
	["Tierras Altas de Arathi"]			= {X =  761, A = 4896, H = 4896},
	["Tierras Inhóspitas"]				= {X =  765, A = 4900, H = 4900},
	["Las Tierras Devastadas"]			= {X =  766, A = 4909, H = 4909},
	["Las Estepas Ardientes"]			= {X =  775, A = 4901, H = 4901},
	["Paso de la Muerte"]				= {X =  777, A =    0, H =    0},
	["Dun Morogh"]						= {X =  627, A =    0, H =    0},
	["Bosque del Ocaso"]				= {X =  778, A = 4907, H =    0},
	["Tierras de la Peste del Este"]	= {X =  771, A = 4892, H = 4892},
	["Bosque de Elwynn"]				= {X =  776, A =    0, H =    0},
	["Bosque Canción Eterna"]			= {X =  859, A =    0, H =    0},
	["Tierras Fantasma"]				= {X =  858, A =    0, H = 4908},
	["Laderas de Trabalomas"]			= {X =  772, A =    0, H = 4895},
	["Loch Modan"]						= {X =  779, A = 4899, H =    0},
	["Norte de la Vega de Tuercespina"]	= {X =  781, A = 4906, H = 4906},
	["Montañas Crestagrana"]			= {X =  780, A = 4902, H =    0},
	["La Garganta de Fuego"]			= {X =  774, A = 4910, H = 4910},
	["Bosque de Argénteos"]				= {X =  769, A =    0, H = 4894},
	["Pantano de las Penas"]			= {X =  782, A = 4904, H = 4904},
	["El Cabo de Tuercespina"]			= {X = 4995, A = 4905, H = 4905},
	["Tierras del Interior"]			= {X =  773, A = 4897, H = 4897},
	["Claros de Tirisfal"]				= {X =  768, A =    0, H =    0},
	["Tierras de la Peste del Oeste"]	= {X =  770, A = 4893, H = 4893},
	["Páramos de Poniente"]				= {X =  802, A = 4903, H =    0},
	["Los Humedales"]					= {X =  841, A = 4898, H =    0},
	-- Kalimdor
	["Vallefresno"]						= {X =  845, A = 4925, H = 4976},
	["Azshara"]							= {X =  852, A =    0, H = 4927},
	["Isla Bruma Azur"]					= {X =  860, A =    0, H =    0},
	["Isla Bruma de Sangre"]			= {X =  861, A = 4926, H = 4926},
	["Costa Oscura"]					= {X =  844, A = 4928, H = 4928},
	["Desolace"]						= {X =  848, A = 4930, H = 4930},
	["Durotar"]							= {X =  728, A =    0, H =    0},
	["Marjal Revolcafango"]				= {X =  850, A = 4929, H = 4978},
	["Frondavil"]						= {X =  853, A = 4931, H = 4931},
	["Feralas"]							= {X =  849, A = 4932, H = 4979},
	["Claro de la Luna"]				= {X =  855, A =    0, H =    0},
	["Mulgore"]							= {X =  736, A =    0, H =    0},
	["Los Baldíos del Norte"]			= {X =  750, A =    0, H = 4933},
	["Silithus"]						= {X =  856, A = 4934, H = 4934},
	["Los Baldíos del Sur"]				= {X = 4996, A = 4937, H = 4981},
	["Sierra Espolón"]					= {X =  847, A = 4936, H = 4980},
	["Tanaris"]							= {X =  851, A = 4935, H = 4935},
	["Teldrassil"]						= {X =  842, A =    0, H =    0},
	["Las Mil Agujas"]					= {X =  846, A = 4938, H = 4938},
	["Cráter de Un'Goro"]				= {X =  854, A = 4939, H = 4939},
	["Cuna del Invierno"]				= {X =  857, A = 4940, H = 4940},
	-- Outland
	["Montañas Filospada"]				= {X =  865, A = 1193, H = 1193},
	["Península del Fuego Infernal"]	= {X =  862, A = 1189, H = 1271},
	["Nagrand"]							= {X =  866, A = 1192, H = 1273},
	["Tormenta Abisal"]					= {X =  843, A = 1194, H = 1194},
	["Valle Sombraluna"]				= {X =  864, A = 1195, H = 1195},
	["Bosque de Terokkar"]				= {X =  867, A = 1191, H = 1272},
	["Marisma de Zangar"]				= {X =  863, A = 1190, H = 1190},
	-- Northrend
	["Tundra Boreal"]					= {X = 1264, A =   33, H = 1358},
	["Bosque Canto de Cristal"]			= {X = 1457, A =    0, H =    0},
	["Cementerio de Dragones"]			= {X = 1265, A =   35, H = 1356},
	["Colinas Pardas"]					= {X = 1266, A =   37, H = 1357},
	["Fiordo Aquilonal"]				= {X = 1263, A =   34, H = 1356},
	["Corona de Hielo"]					= {X = 1270, A =   40, H =   40},
	["Cuenca de Sholazar"]				= {X = 1268, A =   39, H =   39},
	["Las Cumbres Tormentosas"]			= {X = 1269, A =   38, H =   38},
	["Zul'Drak"]						= {X = 1267, A =   36, H =   36},
	-- Cataclysm
	["Infralar"]						= {X = 4864, A = 4871, H = 4871},
	["Monte Hyjal"]						= {X = 4863, A = 4870, H = 4870},
	["Tierras Altas Crepusculares"]		= {X = 4866, A = 4873, H = 5501},
	["Uldum"]							= {X = 4865, A = 4872, H = 4872},
	["Vashj'ir"]						= {X = 4825, A = 4869, H = 4982},
	["Tol Barad"]						= {X =    0, A = 4874, H = 4874},
	["Península de Tol Barad"]			= {X =    0, A = 4874, H = 4874},
	-- Boolean Explores
	["Isla de Quel'Danas"]				= {X =  868, A =    0, H =    0},
	["Ahn'Qiraj: El Reino Caído"]		= {X =    0, A =    0, H =    0},
	["Conquista del Invierno"]			= {X =    0, A =    0, H =    0},
}
elseif T.client == "esMX" then
L_EXTRA_ZONEACHID = {
	-- http://www.wowhead.com/achievement=*
	-- e(X)plore achievement id, (Q)uest achievement id
	["Reinos del Este"]					= {X =   42, A =    0, H =    0},
	["Kalimdor"]						= {X =   43, A =    0, H =    0},
	["Terrallende"]						= {X =   44, A =    0, H =    0},
	["Rasganorte"]						= {X =   45, A =    0, H =    0},
	["Mapa del mundo"]					= {X =  nil, A =    0, H =    0},
	-- Eastern Kingdoms
	["Tierras Altas de Arathi"]			= {X =  761, A = 4896, H = 4896},
	["Tierras Inhóspitas"]				= {X =  765, A = 4900, H = 4900},
	["Las Tierras Devastadas"]			= {X =  766, A = 4909, H = 4909},
	["Las Estepas Ardientes"]			= {X =  775, A = 4901, H = 4901},
	["Paso de la Muerte"]				= {X =  777, A =    0, H =    0},
	["Dun Morogh"]						= {X =  627, A =    0, H =    0},
	["Bosque del Ocaso"]				= {X =  778, A = 4907, H =    0},
	["Tierras de la Peste del Este"]	= {X =  771, A = 4892, H = 4892},
	["Bosque de Elwynn"]				= {X =  776, A =    0, H =    0},
	["Bosque Canción Eterna"]			= {X =  859, A =    0, H =    0},
	["Tierras Fantasma"]				= {X =  858, A =    0, H = 4908},
	["Laderas de Trabalomas"]			= {X =  772, A =    0, H = 4895},
	["Loch Modan"]						= {X =  779, A = 4899, H =    0},
	["Norte de la Vega de Tuercespina"]	= {X =  781, A = 4906, H = 4906},
	["Montañas Crestagrana"]			= {X =  780, A = 4902, H =    0},
	["La Garganta de Fuego"]			= {X =  774, A = 4910, H = 4910},
	["Bosque de Argénteos"]				= {X =  769, A =    0, H = 4894},
	["Pantano de las Penas"]			= {X =  782, A = 4904, H = 4904},
	["El Cabo de Tuercespina"]			= {X = 4995, A = 4905, H = 4905},
	["Tierras del Interior"]			= {X =  773, A = 4897, H = 4897},
	["Claros de Tirisfal"]				= {X =  768, A =    0, H =    0},
	["Tierras de la Peste del Oeste"]	= {X =  770, A = 4893, H = 4893},
	["Páramos de Poniente"]				= {X =  802, A = 4903, H =    0},
	["Los Humedales"]					= {X =  841, A = 4898, H =    0},
	-- Kalimdor
	["Vallefresno"]						= {X =  845, A = 4925, H = 4976},
	["Azshara"]							= {X =  852, A =    0, H = 4927},
	["Isla Bruma Azur"]					= {X =  860, A =    0, H =    0},
	["Isla Bruma de Sangre"]			= {X =  861, A = 4926, H = 4926},
	["Costa Oscura"]					= {X =  844, A = 4928, H = 4928},
	["Desolace"]						= {X =  848, A = 4930, H = 4930},
	["Durotar"]							= {X =  728, A =    0, H =    0},
	["Marjal Revolcafango"]				= {X =  850, A = 4929, H = 4978},
	["Frondavil"]						= {X =  853, A = 4931, H = 4931},
	["Feralas"]							= {X =  849, A = 4932, H = 4979},
	["Claro de la Luna"]				= {X =  855, A =    0, H =    0},
	["Mulgore"]							= {X =  736, A =    0, H =    0},
	["Los Baldíos del Norte"]			= {X =  750, A =    0, H = 4933},
	["Silithus"]						= {X =  856, A = 4934, H = 4934},
	["Los Baldíos del Sur"]				= {X = 4996, A = 4937, H = 4981},
	["Sierra Espolón"]					= {X =  847, A = 4936, H = 4980},
	["Tanaris"]							= {X =  851, A = 4935, H = 4935},
	["Teldrassil"]						= {X =  842, A =    0, H =    0},
	["Las Mil Agujas"]					= {X =  846, A = 4938, H = 4938},
	["Cráter de Un'Goro"]				= {X =  854, A = 4939, H = 4939},
	["Cuna del Invierno"]				= {X =  857, A = 4940, H = 4940},
	-- Outland
	["Montañas Filospada"]				= {X =  865, A = 1193, H = 1193},
	["Península del Fuego Infernal"]	= {X =  862, A = 1189, H = 1271},
	["Nagrand"]							= {X =  866, A = 1192, H = 1273},
	["Tormenta Abisal"]					= {X =  843, A = 1194, H = 1194},
	["Valle Sombraluna"]				= {X =  864, A = 1195, H = 1195},
	["Bosque de Terokkar"]				= {X =  867, A = 1191, H = 1272},
	["Marisma de Zangar"]				= {X =  863, A = 1190, H = 1190},
	-- Northrend
	["Tundra Boreal"]					= {X = 1264, A =   33, H = 1358},
	["Bosque Canto de Cristal"]			= {X = 1457, A =    0, H =    0},
	["Cementerio de Dragones"]			= {X = 1265, A =   35, H = 1356},
	["Colinas Pardas"]					= {X = 1266, A =   37, H = 1357},
	["Fiordo Aquilonal"]				= {X = 1263, A =   34, H = 1356},
	["Corona de Hielo"]					= {X = 1270, A =   40, H =   40},
	["Cuenca de Sholazar"]				= {X = 1268, A =   39, H =   39},
	["Las Cumbres Tormentosas"]			= {X = 1269, A =   38, H =   38},
	["Zul'Drak"]						= {X = 1267, A =   36, H =   36},
	-- Cataclysm
	["Infralar"]						= {X = 4864, A = 4871, H = 4871},
	["Monte Hyjal"]						= {X = 4863, A = 4870, H = 4870},
	["Tierras Altas Crepusculares"]		= {X = 4866, A = 4873, H = 5501},
	["Uldum"]							= {X = 4865, A = 4872, H = 4872},
	["Vashj'ir"]						= {X = 4825, A = 4869, H = 4982},
	["Tol Barad"]						= {X =    0, A = 4874, H = 4874},
	["Península de Tol Barad"]			= {X =    0, A = 4874, H = 4874},
	-- Boolean Explores
	["Isla de Quel'Danas"]				= {X =  868, A =    0, H =    0},
	["Ahn'Qiraj: El Reino Caído"]		= {X =    0, A =    0, H =    0},
	["Conquista del Invierno"]			= {X =    0, A =    0, H =    0},
}
end