local T, C, L, _ = unpack(select(2, ...))
if T.client ~= "deDE" then return end

----------------------------------------------------------------------------------------
--	Localization for deDE client
--	Translation: Alwa, Baine, Chubidu, F5Hellbound, Sinaris, Vienchen
----------------------------------------------------------------------------------------
-- Announce flasks and food
L_ANNOUNCE_FF_NOFOOD = "Kein Essen: "
L_ANNOUNCE_FF_NOFLASK = "Kein Fläschchen: "
L_ANNOUNCE_FF_ALLBUFFED = "Alles drin!"
L_ANNOUNCE_FF_CHECK_BUTTON = "Überprüfe Food und Flask"

-- Says thanks for some spells
L_ANNOUNCE_SS_THANKS = "Danke für "
L_ANNOUNCE_SS_RECEIVED = " erhalten von "

-- Pull countdown announce
L_ANNOUNCE_PC_GO = "GO!"
L_ANNOUNCE_PC_MSG = "Pull %s in %s.."
L_ANNOUNCE_PC_ABORTED = "Pull ABGEBROCHEN!"

-- Announce feasts and portals
L_ANNOUNCE_FP_STAT = "%s bereitet ein %s vor - [%s]."
L_ANNOUNCE_FP_PRE = "%s bereitet ein %s vor."
L_ANNOUNCE_FP_PUT = "%s stellt ein %s auf."
L_ANNOUNCE_FP_CAST = "%s zaubert ein %s."
L_ANNOUNCE_FP_CLICK = "%s zaubert ein %s. Klick!"
L_ANNOUNCE_FP_USE = "%s nahm %s."

-- Announce your interrupts
L_ANNOUNCE_INTERRUPTED = INTERRUPTED

-- Tooltip
L_TOOLTIP_NO_TALENT = "Keine Talente"
L_TOOLTIP_LOADING = "Lade..."
L_TOOLTIP_ACH_STATUS = "Dein Fortschritt:"
L_TOOLTIP_ACH_COMPLETE = "Dein Status: Fertig gestellt am "
L_TOOLTIP_ACH_INCOMPLETE = "Dein Status: Noch nicht Ferig"
L_TOOLTIP_SPELL_ID = "Zauber ID:"
L_TOOLTIP_ITEM_ID = "Gegenstands ID:"
L_TOOLTIP_WHO_TARGET = "Anvisiert von"
L_TOOLTIP_ITEM_COUNT = "Gegenstandsanzahl:" -- Need review
L_TOOLTIP_INSPECT_OPEN = "Betrachtungsfenster offen"

-- Misc
L_MISC_UNDRESS = "Ausziehen"
L_MISC_DRINKING = " trinkt."
L_MISC_BUY_STACK = "Alt-Klick um einen Stapel zu kaufen"
L_MISC_ONECLICK_BUYOUT = "Shift-Right-Click um den ausgewählten Gegenstand ohne Bestätigung zu kaufen"
L_MISC_ONECLICK_BID = "Shift-Right-Click um auf den ausgewählten Gegenstand ohne Bestätigung zu bieten"
L_MISC_ONECLICK_CANCEL = "Shift-Right-Click um den ausgewählten Gegenstand ohne Bestätigung abzubrechen"
L_MISC_UI_OUTDATED = "Deine Version von ShestakUI ist veraltet. Du kannst die aktuelle Version von www.shestak.org laden"
L_MISC_HEADER_MARK = "Mausdrüber Raid Icon"
L_MISC_BINDER_OPEN = "Maus gebunden"
L_MISC_GROCERY_BUY = "Kaufen"
L_MISC_GROCERY_DESC = "Kaufe Lebensmittelaschen automatisch"
L_MISC_SCROLL = "Rolle"
L_MISC_COLLAPSE = "The Collapse" -- Need review

-- Raid Utility
L_RAID_UTIL_DISBAND = "Gruppe auflösen"

-- Zone name
L_ZONE_TOLBARAD = "Tol Barad"
L_ZONE_TOLBARADPEN = "Halbinsel von Tol Barad"
L_ZONE_ARATHIBASIN = "Arathibecken"
L_ZONE_GILNEAS = "Die Schlacht um Gilneas"
L_ZONE_ANCIENTDALARAN = "Dalarankrater"

-- WatchFrame Wowhead link
L_WATCH_WOWHEAD_LINK = "Wowhead Link"

-- Toggle Menu
L_TOGGLE_ADDON = "Erweiterung "
L_TOGGLE_ADDONS = " Erweiterungen"
L_TOGGLE_EXPAND = "erweitern "
L_TOGGLE_COLLAPSE = "schließen "
L_TOGGLE_RCLICK = "Rechtsklick zum Aktivieren oder Deaktiveren "
L_TOGGLE_LCLICK = "Links klicken um Fenster aktiv zu halten "
L_TOGGLE_RELOAD = " (benötigt UI neustart)"
L_TOGGLE_NOT_FOUND = " nicht gefunden."

-- UnitFrame
L_UF_GHOST = "Geist"
L_UF_DEAD = "Tod"
L_UF_OFFLINE = "Offline"
L_UF_MANA = "Niedriges Mana"

-- Map
L_MAP_CURSOR = "Mauszeiger: "
L_MAP_BOUNDS = "Außerhalb der Begrenzung!"
L_MAP_FOG = "Nebel des Krieges"

-- Minimap
L_MINIMAP_CALENDAR = "Kalender"
L_MINIMAP_HEAL_LAYOUT = "Links-Klick - Heiler Layout"
L_MINIMAP_DPS_LAYOUT = "Rechts-Klick - DPS Layout"
L_MINIMAP_BLIZZ_LAYOUT = "Mittel-Klick - Blizzard Layout"

-- Chat
L_CHAT_WHISPER = "Von"
L_CHAT_BN_WHISPER = "Von"
L_CHAT_AFK = "[AFK]"
L_CHAT_DND = "[DND]"
L_CHAT_GM = "[GM]"
L_CHAT_GUILD = "G"
L_CHAT_PARTY = "P"
L_CHAT_PARTY_LEADER = "PL"
L_CHAT_RAID = "R"
L_CHAT_RAID_LEADER = "RL"
L_CHAT_RAID_WARNING = "RW"
L_CHAT_INSTANCE_CHAT = "I"
L_CHAT_INSTANCE_CHAT_LEADER = "IL"
L_CHAT_OFFICER = "O"
L_CHAT_PET_BATTLE = "PB"
L_CHAT_COME_ONLINE = "ist jetzt |cff298F00online|r."
L_CHAT_GONE_OFFLINE = "ist jetzt |cffff0000offline|r."

-- Errors frame
L_ERRORFRAME_L = "Klick um Fehler anzuzeigen."

-- Bags
L_BAG_SHOW_BAGS = "Zeige Taschen"
L_BAG_RIGHT_CLICK_SEARCH = "Rechtsklick um zu suchen"
L_BAG_STACK_MENU = "Stapeln"
L_BAG_RIGHT_CLICK_CLOSE = "Rechtsklick öffnet Menü"

-- Grab mail
L_MAIL_STOPPED = "Angehalten, Inventar ist voll."
L_MAIL_UNIQUE = "Angehalten, dieses einzigartiges Item befindet sich bereits in der Tasche oder auf der Bank."
L_MAIL_COMPLETE = "Alles Fertig."
L_MAIL_NEED = "Benötige einen Briefkasten."
L_MAIL_MESSAGES = "nachrichten"

-- Loot
L_LOOT_RANDOM = "Zufälliger Spieler"
L_LOOT_SELF = "Selbst nehmen"
L_LOOT_FISH = "Angeln"
L_LOOT_ANNOUNCE = "Ansagen"
L_LOOT_TO_RAID = "  schlachtzug"
L_LOOT_TO_PARTY = "  gruppe"
L_LOOT_TO_GUILD = "  gilde"
L_LOOT_TO_SAY = "  sagen"

-- LitePanels AFK module
L_PANELS_AFK = "Du bist AFK!"
L_PANELS_AFK_RCLICK = "Rechts-Klick zum Verstecken."
L_PANELS_AFK_LCLICK = "Links-Klick um zurück zu gehen."

-- Cooldowns
L_COOLDOWNS = "Abklingzeit: "
L_COOLDOWNS_COMBATRESS = "BattelRes"
L_COOLDOWNS_COMBATRESS_REMAINDER = "BattelRes übrig: "
L_COOLDOWNS_NEXTTIME = "Nächste möglichkeit: "

-- Autoinvite
L_INVITE_ENABLE = "Autoinvite AN: "
L_INVITE_DISABLE = "Autoinvite AUS"

-- Bind key
L_BIND_SAVED = "Alle Tastenbelegungen wurden gespeichert."
L_BIND_DISCARD = "Alle grade neu belegten Tastenbelegungen wurden verworfen."
L_BIND_INSTRUCT = "Bewege deine Maus über einen Aktionsbutton um ihn mit einem Hotkey zu belegen. Drücke Escape oder Rechte Maustaste um die aktuelle Tastenbelegeung des Buttons zu löschen."
L_BIND_CLEARED = "Alle Tastaturbelegungen gelöscht für"
L_BIND_BINDING = "Belegung"
L_BIND_KEY = "Taste"
L_BIND_NO_SET = "Keine Tastaturbelegung festgelegt"

-- BG stats
L_DATATEXT_BASESASSAULTED = "Basen angegriffen:"
L_DATATEXT_BASESDEFENDED = "Basen verteidigt:"
L_DATATEXT_TOWERSASSAULTED = "Türme angegriffen:"
L_DATATEXT_TOWERSDEFENDED = "Türme verteidigt:"
L_DATATEXT_FLAGSCAPTURED = "Flaggen eingenommen:"
L_DATATEXT_FLAGSRETURNED = "Flaggen zurückgebracht:"
L_DATATEXT_GRAVEYARDSASSAULTED = "Friedhöfe angegriffen:"
L_DATATEXT_GRAVEYARDSDEFENDED = "Friedhöfe verteidigt:"
L_DATATEXT_DEMOLISHERSDESTROYED = "Verwüster zerstört:"
L_DATATEXT_GATESDESTROYED = "Tore zerstört:"
L_DATATEXT_ORB_POSSESSIONS = "Gehaltene Kugeln:"
L_DATATEXT_VICTORY_POINTS = "Siegespunkte:"
L_DATATEXT_CARTS_CONTROLLED = "Kontrollierte Loren:"

-- Info text
L_INFO_ERRORS = "Noch keine Fehler."
L_INFO_INVITE = "Gruppeneinladung akzeptiert von "
L_INFO_DUEL = "Duellanfrage Ignoriert von "
L_INFO_PET_DUEL = "Haustier Duellanfrage Ignoriert von "
L_INFO_DISBAND = "Löse Gruppe auf..."
L_INFO_SETTINGS_DBM = "Gebe /settings dbm ein, um DBM Einstellungen zu laden."
L_INFO_SETTINGS_DXE = "Gebe /settings dxe ein, um DXE Einstellungen zu laden."
L_INFO_SETTINGS_MSBT = "Gebe /settings msbt ein, um die MSBT Einstellungen zu laden."
L_INFO_SETTINGS_SKADA = "Gebe /settings skada ein, um die Skada Einstellungen zu laden."
L_INFO_SETTINGS_ALL = "Gebe /settings all ein, um die Einstellungen für alle unterstützten AddOns zu laden."
L_INFO_NOT_INSTALLED = " ist nicht installiert."
L_INFO_SKIN_DISABLED1 = "Stilisierung für "
L_INFO_SKIN_DISABLED2 = " ist ausgeschaltet."

-- Popups
L_POPUP_INSTALLUI = "Dies ist Ihre erste Benutzung von ShestakUI mit diesem Charakter. Um das Interface zu konfigurieren, wird das UI nun neugeladen."
L_POPUP_RESETUI = "Sind Sie sich sicher, dass Sie die Einstellungen von ShestakUI zurückgesetzen wollen?"
L_POPUP_RESETSTATS = "Bist du sicher das du die Gold und verbrachte Zeit Statistik zurücksetzen möchtest?"
L_POPUP_SWITCH_RAID = "Wähle Raid Layout."
L_POPUP_DISBAND_RAID = "Bist du dir sicher, dass du die Gruppe auflösen möchtest?"
L_POPUP_DISABLEUI = "ShestakUI funktioniert nicht mit deiner Auflösung, möchtest du ShestakUI ausschalten? (Drücke Abbrechen, falls du eine andere Auflösung testen willst)"
L_POPUP_SETTINGS_ALL = "Einstellungen für alle AddOns übernehmen? (DBM/DXE, Skada und MSBT)"
L_POPUP_SETTINGS_DBM = "Die Position der DBM Elemente muss verändert werden."
L_POPUP_SETTINGS_DXE = "Die Position der DXE Elemente muss verändert werden."
L_POPUP_SETTINGS_BW = "Die Position der BigWigs Elemente muss verändert werden."
L_POPUP_ARMORY = "Waffenkammer"
L_POPUP_CURRENCY_CAP = "Maximalwert erreicht"

-- Welcome message
L_WELCOME_LINE_1 = "Willkommen bei ShestakUI "
L_WELCOME_LINE_2_1 = "Gebe /cfg ein um das Interface zu konfigurieren, oder besuche http://shestak.org"
L_WELCOME_LINE_2_2 = "für weitere Informationen."

-- Combat text
L_COMBATTEXT_KILLING_BLOW = "Todesstoß"
L_COMBATTEXT_ALREADY_UNLOCKED = "Kampftext bereits freigegeben."
L_COMBATTEXT_ALREADY_LOCKED = "Kampftext bereits gespert."
L_COMBATTEXT_TEST_DISABLED = "Kampftext Testmodus deaktiviert."
L_COMBATTEXT_TEST_ENABLED = "Kampftext Testmodus aktiviert."
L_COMBATTEXT_TEST_USE_UNLOCK = "Gib '/xct' ein um die Kampftext Fenster freizugeben um sie verschieben und verändern zu können."
L_COMBATTEXT_TEST_USE_LOCK = "Gib '/xct' ein um den Kampftext Testmodus zu sperren."
L_COMBATTEXT_TEST_USE_TEST = "Gib '/xct' ein um den Kampftext Testmodus zu aktivieren."
L_COMBATTEXT_TEST_USE_RESET = "Type /xct reset to restore default positions." -- Need review
L_COMBATTEXT_POPUP = "Um die Kampftext Fensterpositionen zu sichern muss das Interface neu geladen werden."
L_COMBATTEXT_UNSAVED = "Kampftext Fensterpositionen nicht gespeichert, vergiss nicht das Interface neu zu laden."
L_COMBATTEXT_UNLOCKED = "Kampftext freigegeben."

-- LiteStats
L_STATS_ACC_PLAYED = "Gesamtspielzeit"
L_STATS_ADDED_JUNK = "Junk-Ausnahme hinzugefügt"
L_STATS_REMOVE_EXCEPTION = "Ausnahme hinzufügen/entfernen."
L_STATS_AUTO_REPAIR = "Automatisch reparieren"
L_STATS_GUILD_REPAIR = "Reparieren mithilfe der Gildenbank"
L_STATS_AUTO_SELL = "Junk automatisch verkaufen"
L_STATS_BANDWIDTH = "Bandbreite:"
L_STATS_DOWNLOAD = "Download:"
L_STATS_CLEARED_JUNK = "Junk-Ausnahmeliste gelöscht."
L_STATS_CLEAR_EXCEPTIONS = "Ausnahmenliste löschen."
L_STATS_CURRENCY_RAID = "Schlachtzugs Siegel"
L_STATS_WORLD_MAP = "Klicken, zum Öffnen der World-Map."
L_STATS_CURRENT_XP = "Aktuell/Max XP"
L_STATS_MEMORY_USAGE = "Blizzard UI Speicher Auslastung:"
L_STATS_GARBAGE_COLLECTED = "Abfall zusammengefasst"
L_STATS_CHANGE_SORTING = "[Gilde] Rechts-Klick, zum Ändern der Sortierung und Umschalt-Rechts-Klick zum Umkehren der Reihenfolge."
L_STATS_HIDDEN = "Versteckt"
L_STATS_VIEW_NOTES = "Halte die Alt-Taste gedrückt, zum Anzeigen der Ränge, Notizen und Offizier Notizen."
L_STATS_HR = "std"
L_STATS_INF = "unend"
L_STATS_ALREADY_EXCEPTIONS = "ist bereits in der Ausnahmeliste."
L_STATS_ITEMLINK = "itemlink"
L_STATS_JUNK_EXCEPTIONS = "Junk-Ausnahmen"
L_STATS_JUNK_LIST = "Junk-Liste"
L_STATS_JUNK_PROFIT = "Junk-Gewinn"
L_STATS_KILLS = "G"
L_STATS_OPEN_CALENDAR = "Links-Klick, zum Öffnen des Kalenders (/cal)."
L_STATS_OPEN_CHARACTER = "Links-Klick, zum Öffnen des Charakterfensters."
L_STATS_OPEN_CURRENCY = "Links-Klick, zum Öffnen des Abzeichen-Fensters."
L_STATS_OPEN_TALENT = "Links-Klick, zum Öffnen des Talentfensters."
L_STATS_XP_RATE = "Level XP-Rate"
L_STATS_IGNORED_ITEMS = "Zeige die aktuell ignorierten Gegenstände."
L_STATS_TOGGLE_TIME = "Lokal/Realm & 24-Stunden-Modus können in den Einstellungen der Uhr gewechselt werden."
L_STATS_LOCATION = "Standort/Koordinaten"
L_STATS_MEMORY = "Speicher"
L_STATS_ON = "AN"
L_STATS_OTHER_OPTIONS = "Weitere Einstellungen können in %s konfiguriert werden"
L_STATS_PLAYED_LEVEL = "Auf diesem Level gespielt"
L_STATS_PLAYED_SESSION = "Diese Sitzung gespielt"
L_STATS_PLAYED_TOTAL = "Gesamt gespielt"
L_STATS_QUEST = "Q"
L_STATS_QUESTS_TO = "Quests/Getötet bis %s"
L_STATS_REMAINING_XP = "Verbleibende XP"
L_STATS_REMOVED_JUNK = "Junk-Ausnahme entfernt"
L_STATS_RESTED_XP = "Erholte XP"
L_STATS_RC_COLLECTS_GARBAGE = "Rechts-Klick sammelt Lua-Abfall."
L_STATS_RC_TIME_MANAGER = "Rechts-Klick, um die Einstellungen der Uhr anzuzeigen."
L_STATS_RC_EXPERIENCE = "Rechts-Klick, zum Wechseln zwischen Erfahrung, gespielte Zeit und Fraktionsüberwachung."
L_STATS_RC_AUTO_REPAIRING = "Rechts-Klick, zum Ein- oder Ausschalten des automatischen Reparieren."
L_STATS_RC_AUTO_SELLING = "Rechts-Klick, zum Ein- oder Ausschalten des automatischen Verkaufen."
L_STATS_RC_TALENT = "Rechts-Klick, zum Wechseln Deiner Talentspezialisierung."
L_STATS_SERVER_GOLD = "Server Gold"
L_STATS_SESSION_GAIN = "Sitzung - Gewinn/Verlust"
L_STATS_SESSION_XP = "Sitzung - XP Rate"
L_STATS_INSERTS_COORDS = "Umschalt-Klick auf das Standort/Koordination Modul, zum Einfügen Deiner aktuellen Koordinaten in den Chat."
L_STATS_EQUIPMENT_CHANGER = "Umschalt-Klick oder Mittel-Klick für den Ausrüstungsmanager."
L_STATS_SORTING_BY = "Sortieren nach"
L_STATS_TIPS = "Tipps:"
L_STATS_TOTAL_MEMORY_USAGE = "Gesamte Speicherausnutzung:"
L_STATS_NOT_TO_SELL = "Verwende /junk zum Konfigurieren der Gegenstände, die nicht verkauft werden sollen."
L_STATS_WATCH_CURRENCY = "Bereits gesehene Gegenstände aus dem Abzeichen-Fenster werden im Tooltip angezeigt."
L_STATS_WATCH_FACTIONS = "Überwache Fraktionen aus dem Ruffenster."
L_STATS_TOOLTIP_TIME_PLAYED = "Wenn das max. Level erreicht ist, wird das Tooltip die gespielte Zeit für den Account anzeigen."
L_STATS_TOOLTIP_EXPERIENCE = "Wenn unter dem max. Level, wird ein Tooltip mit weiteren Details angezeigt."
L_STATS_SEALS = "Angebot der Woche"

-- Slash commands
L_SLASHCMD_HELP = {
	"Available slash commands:",
	"/rl - Interface neu laden.",
	"/rc - Starte Bereitschaftscheck.",
	"/gm - Öffne das Game Master Fenster.",
	"/dis ADDON_NAME - Deaktiviere Addon.",
	"/en ADDON_NAME - Aktiviere Addon.",
	"/rd - Gruppe oder Schlachtzug auflösen.",
	"/toraid - In Gruppe oder Schlachtzug umwandeln.",
	"/teleport - Teleport vom beliebigen Dungeon.",
	"/spec, /ss - Zwischen den Talenten wechseln.",
	"/heal - Zum Heiler Layout wechseln.",
	"/dps - Zum DPS Layout wechseln.",
	"/frame - Beschreibung nicht verfügbar.",
	"/farmmode - Erhöht die Größe der Minimap.",
	"/moveui - Ermöglicht das Bewegen der Interface Elemente.",
	"/resetui - Zurücksetzen der allgemeinen Einstellungen auf die Standardwerte.",
	"/resetuf - Zurücksetzen der Einheitenfenster auf die Standardposition.",
	"/resetconfig - Zurücksetzen der ShestakUI_Config Einstellungen.",
	"/resetstats - Gold Statistik und gespielte Zeit zurücksetzen.",
	"/settings ADDON_NAME - Einstellungen für msbt, dbm, skada, oder alle Addons anwenden.",
	"/ls, /litestats - Hilfe für LiteStats.",
	"/xct - Kampflogtext verwalten.",
	"/raidcd - Abklingzeiten für Schlachtzüge testen.",
	"/enemycd - Gegnerische Abklingzeiten testen.",
	"/pulsecd - Pulsierende Abklingzeiten testen.",
	"/threat - Bedrohungsmeter testen.",
	"/tt - Ziehl anflüstern.",
	"/ainv - Automatisches Einladen aktivieren.",
	"/testuf - Einheitenfenster testen.",
	"/cfg - Interface Einstellungen öffnen.",
}

-- ExploreMap
L_EXTRA_EXPLORED = "Erforscht: "
L_EXTRA_ZONEACHID = {
	-- http://www.wowhead.com/achievement=*
	-- e(X)plore achievement id, (Q)uest achievement id
	["Östliche Königreiche"]			= {X =   42, A =    0, H =    0},
	["Kalimdor"]						= {X =   43, A =    0, H =    0},
	["Scherbenwelt"]					= {X =   44, A =    0, H =    0},
	["Nordend"]							= {X =   45, A =    0, H =    0},
	["Pandaria"]						= {X = 6974, A =    0, H =    0},
	["Weltkarte"]						= {X =  nil, A =    0, H =    0},
	-- Eastern Kingdoms
	["Arathihochland"]					= {X =  761, A = 4896, H = 4896},
	["Ödland"]							= {X =  765, A = 4900, H = 4900},
	["Verwüstete Lande"]				= {X =  766, A = 4909, H = 4909},
	["Brennende Steppe"]				= {X =  775, A = 4901, H = 4901},
	["Gebirgspass der Totenwinde"]		= {X =  777, A =    0, H =    0},
	["Dun Morogh"]						= {X =  627, A =    0, H =    0},
	["Dämmerwald"]						= {X =  778, A = 4903, H =    0},
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
	["Sumpfland"]						= {X =  841, A = 4899, H =    0},
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
	-- Pandaria
	["Der Jadewald"]					= {X = 6351, A = 6300, H = 6534},
	["Tal der Vier Winde"]				= {X = 6969, A = 6301, H = 6301},
	["Kun-Lai-Gipfel"]					= {X = 6976, A = 6537, H = 6538},
	["Tonlongsteppe"]					= {X = 6977, A = 6539, H = 6539},
	["Schreckensöde"]					= {X = 6978, A = 6540, H = 6540},
	["Tal der Ewigen Blüten"]			= {X = 6979, A =    0, H =    0},
	-- Boolean Explores
	["Insel von Quel'Danas"]			= {X =  868, A =    0, H =    0},
	["Ahn'Qiraj: Das Gefallene Königreich"] = {X = 0, A =    0, H =    0},
	["Tausendwintersee"]				= {X =    0, A =    0, H =    0},
}
