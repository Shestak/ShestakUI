local T, C, L, _ = unpack(select(2, ...))
if T.client ~= "esES" and T.client ~= "esMX" then return end

----------------------------------------------------------------------------------------
--	Localization for esES and esMX client
--	Translation: eXecrate, Seal
----------------------------------------------------------------------------------------
-- Announce flasks and food
L_ANNOUNCE_FF_NOFOOD = "No Food: " -- Needs review
L_ANNOUNCE_FF_NOFLASK = "No Flask: " -- Needs review
L_ANNOUNCE_FF_ALLBUFFED = "All Buffed!" -- Needs review
L_ANNOUNCE_FF_CHECK_BUTTON = "Check food and flask" -- Needs review

-- Says thanks for some spells
L_ANNOUNCE_SS_THANKS = "Thanks for " -- Needs review
L_ANNOUNCE_SS_RECEIVED = " received from " -- Needs review

-- Pull countdown announce
L_ANNOUNCE_PC_GO = "GO!" -- Needs review
L_ANNOUNCE_PC_MSG = "Pulling %s in %s.." -- Needs review
L_ANNOUNCE_PC_ABORTED = "Pull ABORTED!" -- Needs review

-- Announce feasts and portals
L_ANNOUNCE_FP_STAT = "%s has prepared a %s - [%s]." -- Needs review
L_ANNOUNCE_FP_PRE = "%s has prepared a %s." -- Needs review
L_ANNOUNCE_FP_PUT = "%s has put down a %s." -- Needs review
L_ANNOUNCE_FP_CAST = "%s is casting %s." -- Needs review
L_ANNOUNCE_FP_CLICK = "%s is casting %s. Click!" -- Needs review
L_ANNOUNCE_FP_USE = "%s used a %s." -- Needs review

-- Announce your interrupts
L_ANNOUNCE_INTERRUPTED = INTERRUPTED

-- Tooltip
L_TOOLTIP_NO_TALENT = "No tienes talentos"
L_TOOLTIP_LOADING = "Cargando..."
L_TOOLTIP_ACH_STATUS = "Estado:"
L_TOOLTIP_ACH_COMPLETE = "Estado: Completado "
L_TOOLTIP_ACH_INCOMPLETE = "Estado: Incompleto"
L_TOOLTIP_SPELL_ID = "ID del hechizo:"
L_TOOLTIP_ITEM_ID = "ID del objeto:"
L_TOOLTIP_WHO_TARGET = "Marcado por"
L_TOOLTIP_ITEM_COUNT = "Contador del objeto:"
L_TOOLTIP_INSPECT_OPEN = "Inspect Frame is open" -- Needs review

-- Misc
L_MISC_UNDRESS = "Desvestir"
L_MISC_DRINKING = " esta bebiendo."
L_MISC_BUY_STACK = "Alt-Click para comprar un lote"
L_MISC_ONECLICK_BUYOUT = "Shift-Right-Click para comprar el objeto seleccionado sin confirmacion" -- Needs review
L_MISC_ONECLICK_BID = "Shift-Right-Click para pujar por el objeto seleccionado sin confirmacion" -- Needs review
L_MISC_ONECLICK_CANCEL = "Shift-Right-Click to cancel on the selected item without confirmation" -- Needs review
L_MISC_UI_OUTDATED = "Tu versión de ShestakUI no está actualizada. Puedes descargar la última versión de www.shestak.org"
L_MISC_HEADER_MARK = "Mouseover Raid Icons" -- Needs review
L_MISC_BINDER_OPEN = "Mouse Bindings" -- Needs review
L_MISC_GROCERY_BUY = "Buy" -- Needs review
L_MISC_GROCERY_DESC = "Automatically buy grocery bags" -- Needs review
L_MISC_SCROLL = "Pergamino"
L_MISC_COLLAPSE = "The Collapse" -- Need review

-- Raid Utility
L_RAID_UTIL_DISBAND = "Disolver grupo"

-- Zone name
L_ZONE_TOLBARAD = "Tol Barad"
L_ZONE_TOLBARADPEN = "Península de Tol Barad"
L_ZONE_ARATHIBASIN = "Cuenca de Arathi"
L_ZONE_GILNEAS = "La Batalla por Gilneas"
L_ZONE_ANCIENTDALARAN = "Cráter de Dalaran"

-- WatchFrame Wowhead link
L_WATCH_WOWHEAD_LINK = "Link de WoWhead"

-- Toggle Menu
L_TOGGLE_ADDON = "Complemento "
L_TOGGLE_ADDONS = " complementos"
L_TOGGLE_EXPAND = "Expandir "
L_TOGGLE_COLLAPSE = "Colapsar "
L_TOGGLE_RCLICK = "Click derecho para activar o desactivar "
L_TOGGLE_LCLICK = "Click izquierdo para cambiar de ventana "
L_TOGGLE_RELOAD = " (necesita reiniciar la UI)"
L_TOGGLE_NOT_FOUND = " not found." -- Needs review

-- UnitFrame
L_UF_GHOST = "Fantasma"
L_UF_DEAD = "Muerto"
L_UF_OFFLINE = "Desconectado"
L_UF_MANA = "Mana bajo"

-- Map
L_MAP_CURSOR = "Cursor: "
L_MAP_BOUNDS = "Fuera de los limites!"
L_MAP_FOG = "Fog of War" -- Needs review

-- Minimap
L_MINIMAP_CALENDAR = "Calendario"
L_MINIMAP_HEAL_LAYOUT = "Left-Click - Heal Layout" -- Needs review
L_MINIMAP_DPS_LAYOUT = "Right-Click - DPS Layout" -- Needs review
L_MINIMAP_BLIZZ_LAYOUT = "Middle-Click - Blizzard Layout" -- Needs review

-- Chat
L_CHAT_WHISPER = "De"
L_CHAT_BN_WHISPER = "De"
L_CHAT_AFK = "[AFK]"
L_CHAT_DND = "[NM]"
L_CHAT_GM = "[GM]"
L_CHAT_GUILD = "H"
L_CHAT_PARTY = "G"
L_CHAT_PARTY_LEADER = "LG"
L_CHAT_RAID = "B"
L_CHAT_RAID_LEADER = "LB"
L_CHAT_RAID_WARNING = "AB"
L_CHAT_INSTANCE_CHAT = "I" -- Needs review
L_CHAT_INSTANCE_CHAT_LEADER = "IL" -- Needs review
L_CHAT_OFFICER = "O"
L_CHAT_PET_BATTLE = "PB" -- Needs review
L_CHAT_COME_ONLINE = "se ha |cff298F00conectado|r."
L_CHAT_GONE_OFFLINE = "se ha |cffff0000desconectado|r."

-- Errors frame
L_ERRORFRAME_L = "Click para ver errores."

-- Bags
L_BAG_SHOW_BAGS = "Mostrar Bolsas"
L_BAG_RIGHT_CLICK_SEARCH = "Click derecho para buscar"
L_BAG_STACK_MENU = "Amontonar"
L_BAG_RIGHT_CLICK_CLOSE = "Right-click to open menu" -- Need review

-- Grab mail
L_MAIL_STOPPED = "Sin espacio, inventario lleno."
L_MAIL_UNIQUE = "Abortado. Se encontró un duplicado del objeto único en las bolsas o en el banco."
L_MAIL_COMPLETE = "Todo enviado."
L_MAIL_NEED = "Necesitas un buzón."
L_MAIL_MESSAGES = "mensajes"

-- Loot
L_LOOT_RANDOM = "Jugador aleatorio"
L_LOOT_SELF = "Despojar automáticamente"
L_LOOT_FISH = "Despojar pescado"
L_LOOT_ANNOUNCE = "Anunciar a"
L_LOOT_TO_RAID = "  banda"
L_LOOT_TO_PARTY = "  grupo"
L_LOOT_TO_GUILD = "  hermandad"
L_LOOT_TO_SAY = "  decir"

-- LitePanels AFK module
L_PANELS_AFK = "Estas ausente!"
L_PANELS_AFK_RCLICK = "Botón derecho para ocultar."
L_PANELS_AFK_LCLICK = "Botón izquierdo para retroceder."

-- Cooldowns
L_COOLDOWNS = "TR: "
L_COOLDOWNS_COMBATRESS = "CombatRess" -- Needs review
L_COOLDOWNS_COMBATRESS_REMAINDER = "Combat resurrect: " -- Needs review
L_COOLDOWNS_NEXTTIME = "Next time: " -- Needs review

-- Autoinvite
L_INVITE_ENABLE = "Auto Invitar ON: "
L_INVITE_DISABLE = "Auto Invitar OFF"

-- Bind key
L_BIND_SAVED = "La configuración de las teclas ha sido guardada."
L_BIND_DISCARD = "Se han descartado los cambios en la configuración de las teclas."
L_BIND_INSTRUCT = "Coloca el cursor encima de cualquier botón para asignar una tecla. Presiona la tecla ESC o el botón derecho del ratón para quitar la asignación actual."
L_BIND_CLEARED = "Todas las asignaciones de teclas se han limpiado para"
L_BIND_BINDING = "Asignación"
L_BIND_KEY = "Tecla"
L_BIND_NO_SET = "No tiene asignación"

-- BG stats
L_DATATEXT_BASESASSAULTED = "Bases Asaltadas:"
L_DATATEXT_BASESDEFENDED = "Bases Defendidas:"
L_DATATEXT_TOWERSASSAULTED = "Torres Asaltadas:"
L_DATATEXT_TOWERSDEFENDED = "Torres Defendidas:"
L_DATATEXT_FLAGSCAPTURED = "Banderas Capturadas:"
L_DATATEXT_FLAGSRETURNED = "Banderas Devueltas:"
L_DATATEXT_GRAVEYARDSASSAULTED = "Cementerios Asaltados:"
L_DATATEXT_GRAVEYARDSDEFENDED = "Cementerios Defendidos:"
L_DATATEXT_DEMOLISHERSDESTROYED = "Catapultas Destruidas:"
L_DATATEXT_GATESDESTROYED = "Puertas Destruidas:"
L_DATATEXT_ORB_POSSESSIONS = "Orbes en Posesión:"
L_DATATEXT_VICTORY_POINTS = "Puntos de Victoria:"
L_DATATEXT_CARTS_CONTROLLED = "Vagonetas Controladas:"

-- Info text
L_INFO_ERRORS = "Ningún error aun."
L_INFO_INVITE = "Invitación aceptada de "
L_INFO_DUEL = "Duelo rechazado de "
L_INFO_PET_DUEL = "Declined pet duel request from " -- Needs review
L_INFO_DISBAND = "Deshaciendo banda..."
L_INFO_SETTINGS_DBM = "Escribe /settings dbm, para aplicar las preferencias del DBM."
L_INFO_SETTINGS_DXE = "Escribe /settings dxe, para aplicar las preferencias del DXE."
L_INFO_SETTINGS_MSBT = "Escribe /settings msbt, para aplicar las preferencias del MSBT."
L_INFO_SETTINGS_SKADA = "Escribe /settings skada, para aplicar las preferencias del Skada."
L_INFO_SETTINGS_ALL = "Escribe /settings all, para aplicar todas las modificaciones."
L_INFO_NOT_INSTALLED = " no esta instalado."
L_INFO_SKIN_DISABLED1 = "Estilizacion para "
L_INFO_SKIN_DISABLED2 = " esta desactivado."

-- Popups
L_POPUP_INSTALLUI = "Es la primera vez que usas ShestakUI con este personaje. Usted debe volver a cargar la interfaz de usuario para configurarlo."
L_POPUP_RESETUI = "¿Estás seguro de que desea restablecer ShestakUI?"
L_POPUP_RESETSTATS = "¿Estás seguro de que quieres reiniciar las estadísticas de tiempo empleado en el juego y oro adquirido?"
L_POPUP_SWITCH_RAID = "Select Raid layout." -- Needs review
L_POPUP_DISBAND_RAID = "¿Estás seguro de que quieres disolver el grupo?"
L_POPUP_DISABLEUI = "ShestakUI no funciona con esta resolución, ¿Quieres desactivar ShestakUI? (Pulsa cancelar si quieres probar otra resolución)"
L_POPUP_SETTINGS_ALL = "¿Aplicar modificaciones para todos los addons? (DBM/DXE, Skada o MSBT)"
L_POPUP_SETTINGS_DBM = "Necesito cambiar la posición de los elementos del DBM."
L_POPUP_SETTINGS_DXE = "Necesito cambiar la posición de los elementos del DXE."
L_POPUP_SETTINGS_BW = "Necesito cambiar la posición de los elementos del BigWigs."
L_POPUP_ARMORY = "Arsenal"
L_POPUP_CURRENCY_CAP = "You get maximum value of" -- Needs review

-- Welcome message
L_WELCOME_LINE_1 = "Bienvenido a ShestakUI "
L_WELCOME_LINE_2_1 = "Escribe /cfg para configurar la interfaz, o visita http://shestak.org"
L_WELCOME_LINE_2_2 = "para más información."

-- Combat text
L_COMBATTEXT_KILLING_BLOW = "Golpe de gracia"
L_COMBATTEXT_ALREADY_UNLOCKED = "Texto de combate desbloqueado."
L_COMBATTEXT_ALREADY_LOCKED = "Texto de combate bloqueado."
L_COMBATTEXT_TEST_DISABLED = "Modo Texto de combate deshabilitado."
L_COMBATTEXT_TEST_ENABLED = "Modo Texto de combate habilitado."
L_COMBATTEXT_TEST_USE_UNLOCK = "Escribe /xct unlock para mover y cambiar el tamaño del marco de texto de combate."
L_COMBATTEXT_TEST_USE_LOCK = "Escribe /xct lock para bloquear el marco de texto de combate."
L_COMBATTEXT_TEST_USE_TEST = "Escribe /xct test para probar el modo Texto de combate."
L_COMBATTEXT_TEST_USE_RESET = "Type /xct reset to restore default positions." -- Need review
L_COMBATTEXT_POPUP = "Para guardar la posición de la ventana de texto de combate necesitas recargar tu UI."
L_COMBATTEXT_UNSAVED = "La posición de la ventana de texto de combate no está guardada, no olvides recargar la UI."
L_COMBATTEXT_UNLOCKED = "Texto de combate desbloqueado."

-- LiteStats
L_STATS_ACC_PLAYED = "Jugado"
L_STATS_ADDED_JUNK = "Anadida excepcion de basura"
L_STATS_REMOVE_EXCEPTION = "Añadir/borrar excepción"
L_STATS_AUTO_REPAIR = "Reparación auto."
L_STATS_GUILD_REPAIR = "Reparar con dinero de la hermandad"
L_STATS_AUTO_SELL = "Auto-vender basura"
L_STATS_BANDWIDTH = "Ancho de banda:"
L_STATS_DOWNLOAD = "Descarga:"
L_STATS_CLEARED_JUNK = "Limpiada la lista de excepciones de basura."
L_STATS_CLEAR_EXCEPTIONS = "Limpiada la lista de excepciones."
L_STATS_CURRENCY_RAID = "Raid Seals" -- Need review
L_STATS_WORLD_MAP = "Clickeando abres el Mapa del Mundo."
L_STATS_CURRENT_XP = "Actual/Max EXP"
L_STATS_MEMORY_USAGE = "Blizzard UI Memory Usage:" -- Needs review
L_STATS_GARBAGE_COLLECTED = "Basura recogida"
L_STATS_CHANGE_SORTING = "[Hermandad] Click-Derecho para cambiar la clasificacion, Shift-Click-Derecho para invertir el orden."
L_STATS_HIDDEN = "Oculto"
L_STATS_VIEW_NOTES = "Manten pulsada la tecla Alt para ver rangos, notas y notas de oficiales."
L_STATS_HR = "hr"
L_STATS_INF = "inf"
L_STATS_ALREADY_EXCEPTIONS = "ya esta en la lista de excepciones."
L_STATS_ITEMLINK = "enlace del objeto"
L_STATS_JUNK_EXCEPTIONS = "Excepciones de basura"
L_STATS_JUNK_LIST = "Lista de basura"
L_STATS_JUNK_PROFIT = "Ganancia con la basura"
L_STATS_KILLS = "A"
L_STATS_OPEN_CALENDAR = "Click-Izquierdo abre el calendario (/cal)."
L_STATS_OPEN_CHARACTER = "Click-Izquierdo abre la pestana de personaje."
L_STATS_OPEN_CURRENCY = "Click-Izquierdo abre la pestana de dinero."
L_STATS_OPEN_TALENT = "Click-Izquierdo abre el cuadro de la UI de talentos."
L_STATS_XP_RATE = "EXP en este nivel"
L_STATS_IGNORED_ITEMS = "Enumerar los objetos ignorados actualmente."
L_STATS_TOGGLE_TIME = "Hora Local/Reino y el reloj de 24hr se pueden activar desde el administrador de tiempo."
L_STATS_LOCATION = "Situación/Coordenadas"
L_STATS_MEMORY = "Memoria"
L_STATS_ON = "ON"
L_STATS_OTHER_OPTIONS = "Otras opciones se pueden configurar en %s"
L_STATS_PLAYED_LEVEL = "Jugado este nivel"
L_STATS_PLAYED_SESSION = "Jugado esta sesión"
L_STATS_PLAYED_TOTAL = "Total jugado"
L_STATS_QUEST = "M"
L_STATS_QUESTS_TO = "Misiones/Muertes para %s"
L_STATS_REMAINING_XP = "EXP Restante"
L_STATS_REMOVED_JUNK = "Removida excepcion de basura"
L_STATS_RESTED_XP = "EXP de descanso"
L_STATS_RC_COLLECTS_GARBAGE = "Click-Derecho recolecta basura de Lua."
L_STATS_RC_TIME_MANAGER = "Click-Derecho abre el administrador de tiempo."
L_STATS_RC_EXPERIENCE = "Clic derecho para alternar experiencia, tiempo jugado y facciones."
L_STATS_RC_AUTO_REPAIRING = "Click-Derecho activa el Auto-Reparar."
L_STATS_RC_AUTO_SELLING = "Click-Derecho activa el Auto-Vender."
L_STATS_RC_TALENT = "Click-Derecho activa tu especializacion de talentos."
L_STATS_SERVER_GOLD = "Oro del servidor"
L_STATS_SESSION_GAIN = "Sesion ganado/perdido"
L_STATS_SESSION_XP = "EXP en esta sesion"
L_STATS_INSERTS_COORDS = "Shift-Click en los modulos de localizacion o coordenadas inserta las coords en el chat."
L_STATS_EQUIPMENT_CHANGER = "Shift-Click o Click-Central para el cambiador de equipamiento."
L_STATS_SORTING_BY = "Ordenado por"
L_STATS_TIPS = "consejos:"
L_STATS_TOTAL_MEMORY_USAGE = "Uso total de la memoria:"
L_STATS_NOT_TO_SELL = "Usa /junk para configurar que objetos no se venderan."
L_STATS_WATCH_CURRENCY = "Elementos vistos en la pestana de dinero se reflejaran en la descripcion."
L_STATS_WATCH_FACTIONS = "Mirar facciones desde la herramienta de facciones."
L_STATS_TOOLTIP_TIME_PLAYED = "Cuando estes a nivel max, la descripcion mostrara detalles del tiempo jugado de la cuenta."
L_STATS_TOOLTIP_EXPERIENCE = "Cuando no estes a nivel max, la descripcion mostrara detalles de la experiencia."
L_STATS_SEALS = "Seals this week" -- Needs review

-- Slash commands
L_SLASHCMD_HELP = {
	"Lista de comandos disponibles:",
	"/rl - Recargar interfaz.",
	"/rc - Realizar una comprobación.",
	"/gm - Abrir marco del MH.",
	"/dis ADDON_NAME - Desactiva el addon.",
	"/en ADDON_NAME - Activa el addon.",
	"/rd - Rompe el grupo o la banda.",
	"/toraid - Convierte el grupo a bandaConvert to party or raid.",
	"/teleport - Teleportarse desde una mazmorra aleatoria.",
	"/spec, /ss - Cambia entre especializaciones de talentos.",
	"/heal - Cambia a la apariencia de 'Curación'.",
	"/dps - Cambia a la apariencia de 'Daño'.",
	"/frame - La descripción aun no está lista.",
	"/farmmode - Incrementa el tamaño del minimapa.",
	"/moveui - Permite mover los elementos de la interfaz.",
	"/resetui - Reinicia la configuración general a la por defecto.",
	"/resetuf - Reinicia los marcos de unidades a su posición por defecto.",
	"/resetconfig - Reinicia la configuración de ShestakUI_Config.",
	"/resetstats - Reinicia las estadísticas de oro y tiempo empleado.",
	"/settings ADDON_NAME - Aplica la configuración a msbt, dbm, skada, o a todos los addons (con 'all').",
	"/ls, /litestats - Ayuda para LiteStats.",
	"/xct - Gestiona el texto de combate.",
	"/raidcd - Prueba de los enfriamientos de la banda.",
	"/enemycd - Prueba de los enfriamientos del enemigo.",
	"/pulsecd - Prueba de tus propios enfriamientos.",
	"/threat - Prueba del medidor de amenaza.",
	"/tt - Susurrar objetivo.",
	"/ainv - Activa la invitación automática.",
	"/testuf - Prueba de los marcos de unidades.",
	"/cfg - Abre la configuración de la interfaz.",
}

-- ExploreMap
L_EXTRA_EXPLORED = "Explored: " -- Needs review
L_EXTRA_ZONEACHID = {
	-- http://www.wowhead.com/achievement=*
	-- e(X)plore achievement id, (Q)uest achievement id
	["Reinos del Este"]					= {X =   42, A =    0, H =    0},
	["Kalimdor"]						= {X =   43, A =    0, H =    0},
	["Terrallende"]						= {X =   44, A =    0, H =    0},
	["Rasganorte"]						= {X =   45, A =    0, H =    0},
	["Pandaria"]						= {X = 6974, A =    0, H =    0},
	["Mapa del mundo"]					= {X =  nil, A =    0, H =    0},
	-- Eastern Kingdoms
	["Tierras Altas de Arathi"]			= {X =  761, A = 4896, H = 4896},
	["Tierras Inhóspitas"]				= {X =  765, A = 4900, H = 4900},
	["Las Tierras Devastadas"]			= {X =  766, A = 4909, H = 4909},
	["Las Estepas Ardientes"]			= {X =  775, A = 4901, H = 4901},
	["Paso de la Muerte"]				= {X =  777, A =    0, H =    0},
	["Dun Morogh"]						= {X =  627, A =    0, H =    0},
	["Bosque del Ocaso"]				= {X =  778, A = 4903, H =    0},
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
	["Los Humedales"]					= {X =  841, A = 4899, H =    0},
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
	-- Pandaria
	["El Bosque de Jade"]				= {X = 6351, A = 6300, H = 6534},
	["Valle de los Cuatro Vientos"]		= {X = 6969, A = 6301, H = 6301},
	["Cima Kun-Lai"]					= {X = 6976, A = 6537, H = 6538},
	["Estepas de Tong Long"]			= {X = 6977, A = 6539, H = 6539},
	["Desierto del Pavor"]				= {X = 6978, A = 6540, H = 6540},
	["Valle de la Flor Eterna"]			= {X = 6979, A =    0, H =    0},
	-- Boolean Explores
	["Isla de Quel'Danas"]				= {X =  868, A =    0, H =    0},
	["Ahn'Qiraj: El Reino Caído"]		= {X =    0, A =    0, H =    0},
	["Conquista del Invierno"]			= {X =    0, A =    0, H =    0},
}