local T, C, L = unpack(select(2, ...))
if T.client ~= "esES" or T.client ~= "esMX" then return end

----------------------------------------------------------------------------------------
--	Localization for esES and esMX client(Thanks to Seal and eXecrate for the translation)
----------------------------------------------------------------------------------------
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

-- Misc
L_MISC_UNDRESS = "Desvestir"
L_MISC_DRINKING = " esta bebiendo."
L_MISC_BUY_STACK = "Alt-Click para comprar un lote"
L_MISC_ONECLICK_BUYOUT = "Shift-Click para comprar el objeto seleccionado sin confirmacion"
L_MISC_ONECLICK_BID = "Shift-Click para pujar por el objeto seleccionado sin confirmacion"

-- Raid Utility
L_RAID_UTIL_DISBAND = "Disolver grupo"

-- Zone name
L_ZONE_WINTERGRASP = "Conquista del Invierno"
L_ZONE_TOLBARAD = "Tol Barad"

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

-- UnitFrame
L_UF_GHOST = "Fantasma"
L_UF_DEAD = "Muerto"
L_UF_OFFLINE = "Desconectado"
L_UF_MANA = "Mana bajo"
L_UF_TRINKET_READY = "Abalorio listo: "
L_UF_TRINKET_USED = "Abalorio usado: "
L_UF_WOTF_USED = "WotF usado: "

-- Map
L_MAP_CURSOR = "Cursor: "
L_MAP_BOUNDS = "Fuera de los limites!"

-- Minimap
L_MINIMAP_CALENDAR = "Calendario"

-- Addons list
L_ALOAD_RL = "Recargar UI"
L_ALOAD_TRADE = "Comercio"
L_ALOAD_SOLO = "Solo"
L_ALOAD_DEP = "Dependencias: "

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
L_CHAT_BATTLEGROUND = "CB"
L_CHAT_BATTLEGROUND_LEADER = "LCB"
L_CHAT_OFFICER = "O"
L_CHAT_COME_ONLINE = "se ha conectado."
L_CHAT_GONE_OFFLINE = "se ha desconectado."
L_CHAT_COME_ONLINE_COLOR = "se ha |cff298F00conectado|r !"
L_CHAT_GONE_OFFLINE_COLOR = "se ha |cffff0000desconectado|r !"

-- Errors frame
L_ERRORFRAME_L = "Click para ver errores."

-- Bags
L_BAG_BANK = "Banco"
L_BAG_NO_SLOTS = "¡No puedes comprar más espacios!"
L_BAG_COSTS = "Costo: %.2f oro"
L_BAG_BUY_SLOTS = "Compra un nuevo espacio mediante /bags purchase yes"
L_BAG_OPEN_BANK = "Necesitas abrir primero el banco."
L_BAG_SORT = "Ordena tu bolsa, o tu banco si está abierto."
L_BAG_STACK = "Llena los montones incompletos en tu bolsa, o en tu banco si está abierto."
L_BAG_BUY_BANKS_SLOT = "Compra un espacio en el banco (Necesitas tener el banco abierto)."
L_BAG_SORT_MENU = "Ordenar"
L_BAG_SORT_SPECIAL = "Orden Especial"
L_BAG_STACK_MENU = "Amontonar"
L_BAG_STACK_SPECIAL = "Montón Especial"
L_BAG_SHOW_BAGS = "Mostrar Bolsas"
L_BAG_SORTING_BAGS = "Se ha acabado de ordenar."
L_BAG_NOTHING_SORT = "No hay nada que ordenar."
L_BAG_BAGS_BIDS = "Usando las bolsas: "
L_BAG_STACK_END = "Se ha acabado de amontonar."
L_BAG_RIGHT_CLICK_SEARCH = "Click derecho para buscar"

-- Grab mail
L_MAIL_STOPPED = "Sin espacio, inventario lleno."
L_MAIL_UNIQUE = "Abortado. Se encontró un duplicado del objeto único en las bolsas o en el banco."
L_MAIL_COMPLETE = "Todo enviado."
L_MAIL_NEED = "Necesitas un buzón."
L_MAIL_MESSAGES = "mensajes"

-- Loot
L_LOOT_RANDOM = "Jugador aleatorio"
L_LOOT_SELF = "Despojar automáticamente"
L_LOOT_UNKNOWN = "Desconocido"
L_LOOT_FISH = "Despojar pescado"
L_LOOT_MONSTER = ">> Botín de "
L_LOOT_CHEST = ">> Botín del cofre"
L_LOOT_ANNOUNCE = "Anunciar a"
L_LOOT_TO_RAID = "  banda"
L_LOOT_TO_PARTY = "  grupo"
L_LOOT_TO_GUILD = "  hermandad"
L_LOOT_TO_SAY = "  decir"
L_LOOT_CANNOT = "No puedes tirar dados"

-- LitePanels AFK module
L_PANELS_AFK = "Estas ausente!"
L_PANELS_AFK_RCLICK = "Botón derecho para ocultar."
L_PANELS_AFK_LCLICK = "Botón izquierdo para retroceder."

-- Cooldowns
L_COOLDOWNS = "TR: "

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

-- Talent spec
L_PLANNER_DEATHKNIGHT_1 = "Sangre"
L_PLANNER_DEATHKNIGHT_2 = "Escarcha"
L_PLANNER_DEATHKNIGHT_3 = "Profana"
L_PLANNER_WARRIOR_1 = "Armas"
L_PLANNER_WARRIOR_2 = "Furia"
L_PLANNER_WARRIOR_3 = "Protección"
L_PLANNER_ROGUE_1 = "Asesinato"
L_PLANNER_ROGUE_2 = "Combate"
L_PLANNER_ROGUE_3 = "Sutileza"
L_PLANNER_MAGE_1 = "Arcano"
L_PLANNER_MAGE_2 = "Fuego"
L_PLANNER_MAGE_3 = "Escarcha"
L_PLANNER_PRIEST_1 = "Disciplina"
L_PLANNER_PRIEST_2 = "Sagrado"
L_PLANNER_PRIEST_3 = "Sombras"
L_PLANNER_WARLOCK_1 = "Aflicción"
L_PLANNER_WARLOCK_2 = "Demonología"
L_PLANNER_WARLOCK_3 = "Destrucción"
L_PLANNER_HUNTER_1 = "Dominio de bestias"
L_PLANNER_HUNTER_2 = "Puntería"
L_PLANNER_HUNTER_3 = "Supervivencia"
L_PLANNER_DRUID_1 = "Equilibrio"
L_PLANNER_DRUID_2 = "Combate feral"
L_PLANNER_DRUID_3 = "Restauración"
L_PLANNER_SHAMAN_1 = "Elemental"
L_PLANNER_SHAMAN_2 = "Mejora"
L_PLANNER_SHAMAN_3 = "Restauración"
L_PLANNER_PALADIN_1 = "Sagrado"
L_PLANNER_PALADIN_2 = "Protección"
L_PLANNER_PALADIN_3 = "Reprensión"

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
L_DATATEXT_CONTROL = " bajo control:"

-- Info text
L_INFO_ERRORS = "Ningún error aun."
L_INFO_INVITE = "Invitación aceptada de: "
L_INFO_DUEL = "Duelo rechazado de: "
L_INFO_DISBAND = "Deshaciendo banda..."
L_INFO_ADDON_SETS1 = "Escribe /addons <solo/party/raid/pvp/trade/quest>, para cargar las modificaciones preinstaladas."
L_INFO_ADDON_SETS2 = "Puedes añadir, borrar o cambiar la lista de las modificaciones, modificando wtf.lua en la carpeta `scripts`."
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
L_POPUP_SWITCH_RAID = "Hay activos 2 estilos para banda, por favor selecciona uno."
L_POPUP_DISBAND_RAID = "¿Estás seguro de que quieres disolver el grupo?"
L_POPUP_DISABLEUI = "ShestakUI no funciona con esta resolución, ¿Quieres desactivar ShestakUI? (Pulsa cancelar si quieres probar otra resolución)"
L_POPUP_SETTINGS_ALL = "¿Aplicar modificaciones para todos los addons? (DBM/DXE, Skada o MSBT)"
L_POPUP_SETTINGS_DBM = "Necesito cambiar la posición de los elementos del DBM."
L_POPUP_SETTINGS_DXE = "Necesito cambiar la posición de los elementos del DXE."
L_POPUP_SETTINGS_BW = "Necesito cambiar la posición de los elementos del BigWigs."

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
L_COMBATTEXT_POPUP = "Para guardar la posición de la ventana de texto de combate necesitas recargar tu UI."
L_COMBATTEXT_UNSAVED = "La posición de la ventana de texto de combate no está guardada, no olvides recargar la UI."
L_COMBATTEXT_UNLOCKED = "Texto de combate desbloqueado."

-- LiteStats
L_STATS_ACC_PLAYED = "Jugado"
L_STATS_ADDED_JUNK = "Anadida excepcion de basura"
L_STATS_REMOVE_EXCEPTION = "Añadir/borrar excepción"
L_STATS_ALT = "ALT"
L_STATS_AUTO_REPAIR = "Reparación auto."
L_STATS_GUILD_REPAIR = "Reparar con dinero de la hermandad"
L_STATS_AUTO_SELL = "Auto-vender basura"
L_STATS_BANDWIDTH = "Ancho de banda:"
L_STATS_DOWNLOAD = "Descarga:"
L_STATS_CLEARED_JUNK = "Limpiada la lista de excepciones de basura."
L_STATS_CLEAR_EXCEPTIONS = "Limpiada la lista de excepciones."
L_STATS_WORLD_MAP = "Clickeando abres el Mapa del Mundo."
L_STATS_CURRENT_XP = "Actual/Max EXP"
L_STATS_MEMORY_USAGE = "Uso de memoria de la UI por defecto:"
L_STATS_GARBAGE_COLLECTED = "Basura recogida"
L_STATS_CHANGE_SORTING = "(Hermandad) Click-Derecho para cambiar la clasificacion, shift-click-derecho para invertir el orden."
L_STATS_HIDDEN = "Oculto"
L_STATS_VIEW_NOTES = "Manten pulsada la tecla Alt para ver rangos, notas y notas de oficiales."
L_STATS_HR = "hr"
L_STATS_INF = "inf"
L_STATS_ALREADY_EXCEPTIONS = "ya esta en la lista de excepciones."
L_STATS_NOT_JUNK = "no es basura."
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
L_STATS_TOTAL = "Total"
L_STATS_TOTAL_MEMORY_USAGE = "Uso total de la memoria:"
L_STATS_NOT_TO_SELL = "Usa /junk para configurar que objetos no se venderan."
L_STATS_WATCH_CURRENCY = "Elementos vistos en la pestana de dinero se reflejaran en la descripcion."
L_STATS_WATCH_FACTIONS = "Mirar facciones desde la herramienta de facciones."
L_STATS_TOOLTIP_TIME_PLAYED = "Cuando estes a nivel max, la descripcion mostrara detalles del tiempo jugado de la cuenta."
L_STATS_TOOLTIP_EXPERIENCE = "Cuando no estes a nivel max, la descripcion mostrara detalles de la experiencia."

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
	"/luaerror ON|OFF - Activa la visión de errores lua.",
	"/spec, /ss - Cambia entre especializaciones de talentos.",
	"/clfix - Arregla el registro de combate.",
	"/heal - Cambia a la apariencia de 'Curación'.",
	"/dps - Cambia a la apariencia de 'Daño'.",
	"/frame - La descripción aun no está lista.",
	"/addons solo|party|raid|pvp|trade - Puedes cambiar la lista de addons al final del archivo ShestakUI\Config\Settings.lua, en el bloque - 'Addons group'.",
	"/farmmode - Incrementa el tamaño del minimapa.",
	"/moveui - Permite mover los elementos de la interfaz.",
	"/resetui - Reinicia la configuración general a la por defecto.",
	"/resetuf - Reinicia los marcos de unidades a su posición por defecto.",
	"/resetconfig - Reinicia la configuración de ShestakUI_Config.",
	"/resetstats - Reinicia las estadísticas de oro y tiempo empleado.",
	"/settings ADDON_NAME - Aplica la configuración a msbt, dbm, skada, o a todos los addons (con 'all').",
	"/ls, /litestats - Ayuda para LiteStats.",
	"/bags - Gestiona las bolsas.",
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