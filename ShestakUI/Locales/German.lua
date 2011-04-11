local T, C, L = unpack(select(2, ...))
if T.client ~= "deDE" then return end

----------------------------------------------------------------------------------------
--	Localization for deDE client (Thanks to Baine, chubidu and Vienchen for the translation)
----------------------------------------------------------------------------------------
-- Tooltip
L_TOOLTIP_NO_TALENT = "Keine Talente"
L_TOOLTIP_LOADING = "Lade..."
L_TOOLTIP_ACH_STATUS = "Dein Fortschritt:"
L_TOOLTIP_ACH_COMPLETE = "Dein Status: Fertig gestellt am "
L_TOOLTIP_ACH_INCOMPLETE = "Dein Status: Noch nicht Ferig"
L_TOOLTIP_SPELL_ID = "Zauber ID:"
L_TOOLTIP_ITEM_ID = "Gegenstands ID:"
L_TOOLTIP_WHO_TARGET = "Targeted By" -- Needs review

-- Misc
L_MISC_UNDRESS = "Undress" -- Needs review

-- Raid Utility
L_RAID_UTIL_DISBAND = "Gruppe auflösen"

-- Zone name
L_ZONE_WINTERGRASP = "Tausendwinter"

-- WatchFrame Wowhead link
L_WATCH_WOWHEAD_LINK = "Wowhead link" -- Needs review

-- Toogle Menu
L_TOGGLE_ADDON = "Addon " -- Needs review
L_TOGGLE_ADDONS = " addons" -- Needs review
L_TOGGLE_EXPAND = "Expand " -- Needs review
L_TOGGLE_COLLAPSE = "Collapse " -- Needs review
L_TOGGLE_RCLICK = "Right click to enable or disable " -- Needs review
L_TOGGLE_LCLICK = "Left click to toggle window " -- Needs review
L_TOGGLE_RELOAD = " (needs UI reload)" -- Needs review

-- UnitFrame
L_UF_GHOST = "Geist"
L_UF_DEAD = "Tod"
L_UF_OFFLINE = "Offline"
L_UF_MANA = "Niedriges Mana"
L_UF_TRINKET_READY = "Schmuckstück bereit: "
L_UF_TRINKET_USED = "Schmuckstück benutzt: "
L_UF_WOTF_USED = "WdV benutzt: "

-- Map
L_MAP_CURSOR = "Mauszeiger: "
L_MAP_BOUNDS = "Außerhalb der Begrenzung!"

-- Minimap
L_MINIMAP_CALENDAR = "Kalender"

-- Addons list
L_ALOAD_RL = "Interface Neuladen"
L_ALOAD_TRADE = "Handel"
L_ALOAD_SOLO = "Solo"
L_ALOAD_DEP = "Abhängigkeiten: "

-- Chat
L_CHAT_WHISPER = "Von"
L_CHAT_BN_WHISPER = "Von"
L_CHAT_AFK = "[AFK]"
L_CHAT_DND = "[DND]"
L_CHAT_GM = "[GM]"
L_CHAT_GUILD = "G"
L_CHAT_PARTY = "P"
L_CHAT_PARTY_LEADER = "PL"
L_CHAT_RAID	= "R"
L_CHAT_RAID_LEADER = "RL"
L_CHAT_RAID_WARNING	= "RW"
L_CHAT_BATTLEGROUND	= "BG"
L_CHAT_BATTLEGROUND_LEADER = "BGL"
L_CHAT_OFFICER = "O"
L_CHAT_COME_ONLINE = "ist jetzt online."
L_CHAT_GONE_OFFLINE = "ist jetzt offline."
L_CHAT_COME_ONLINE_COLOR = "ist jetzt |cff298F00online|r !"
L_CHAT_GONE_OFFLINE_COLOR = "ist jetzt |cffff0000offline|r !"

-- Errors frame
L_ERRORFRAME_L = "Klick um Fehler anzuzeigen."

-- Bags
L_BAG_BANK = "Bank"
L_BAG_NO_SLOTS = "Kann keine weiteren Taschenplätze kaufen!"
L_BAG_COSTS = "Kosten: %.2f Gold"
L_BAG_BUY_SLOTS = "Kaufe neuen Platz mit /bags purchase yes"
L_BAG_OPEN_BANK = "Du musst erst das Bankfach öffnen."
L_BAG_SORT = "Sortiert deine Taschen oder die Bank, falls geöffnet."
L_BAG_STACK = "Stapelt Items neu in deinen Taschen und der Bank, falls geöffnet."
L_BAG_BUY_BANKS_SLOT = "Kaufe Bankplatz (Bank muss geöffnet sein)."
L_BAG_SORT_MENU = "Sortieren"
L_BAG_SORT_SPECIAL = "Sortieren Spezialtasche"
L_BAG_STACK_MENU = "Stapeln"
L_BAG_STACK_SPECIAL = "Stapeln Spezialtasche"
L_BAG_SHOW_BAGS = "Zeige Taschen"
L_BAG_SORTING_BAGS = "Sortieren abgeschlossen."
L_BAG_NOTHING_SORT = "Nichts zu sortieren."
L_BAG_BAGS_BIDS = "Benutze Taschen: "
L_BAG_STACK_END = "Neu stapeln abgeschlossen."
L_BAG_RIGHT_CLICK_SEARCH = "Rechtsklick um zu suchen"

-- Grab mail
L_MAIL_STOPPED = "Angehalten, Inventar ist voll."
L_MAIL_COMPLETE = "Alles Fertig."
L_MAIL_NEED = "Benötige einen Briefkasten."
L_MAIL_MESSAGES =  "nachrichten"

-- Loot
L_LOOT_RANDOM = "Zufälliger Spieler"
L_LOOT_SELF = "Selbst nehmen"
L_LOOT_UNKNOWN = "Unbekannt"
L_LOOT_FISH = "Angeln"
L_LOOT_MONSTER = ">> Beute von "
L_LOOT_CHEST = ">> Beute aus Kiste"
L_LOOT_ANNOUNCE = "Ansagen"
L_LOOT_TO_RAID = "  schlachtzug"
L_LOOT_TO_PARTY = "  gruppe"
L_LOOT_TO_GUILD = "  gilde"
L_LOOT_TO_SAY = "  sagen"
L_LOOT_CANNOT = "Kann nicht würfeln"

-- LitePanels AFK module
L_PANELS_AFK = "Du bist AFK!"
L_PANELS_AFK_RCLICK = "Rechts-Klick zum Verstecken."
L_PANELS_AFK_LCLICK = "Links-Klick um zurück zu gehen."

-- Cooldowns
L_COOLDOWNS = "Abklingzeit: "

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

-- Talent spec
L_PLANNER_DEATHKNIGHT_1 = "Blut"
L_PLANNER_DEATHKNIGHT_2 = "Frost"
L_PLANNER_DEATHKNIGHT_3 = "Unheilig"
L_PLANNER_WARRIOR_1 = "Waffen"
L_PLANNER_WARRIOR_2 = "Furor"
L_PLANNER_WARRIOR_3 = "Schutz"
L_PLANNER_ROGUE_1 = "Meucheln"
L_PLANNER_ROGUE_2 = "Kampf"
L_PLANNER_ROGUE_3 = "Täuschung"
L_PLANNER_MAGE_1 = "Arkan"
L_PLANNER_MAGE_2 = "Feuer"
L_PLANNER_MAGE_3 = "Frost"
L_PLANNER_PRIEST_1 = "Disziplin"
L_PLANNER_PRIEST_2 = "Heilig"
L_PLANNER_PRIEST_3 = "Schatten"
L_PLANNER_WARLOCK_1 = "Gebrechen"
L_PLANNER_WARLOCK_2 = "Dämonologie"
L_PLANNER_WARLOCK_3 = "Zerstörung"
L_PLANNER_HUNTER_1 = "Tierherrschaft"
L_PLANNER_HUNTER_2 = "Treffsicherheit"
L_PLANNER_HUNTER_3 = "Überleben"
L_PLANNER_DRUID_1 = "Gleichgewicht"
L_PLANNER_DRUID_2 = "Wilder Kampf"
L_PLANNER_DRUID_3 = "Wiederherstellung"
L_PLANNER_SHAMAN_1 = "Elementar"
L_PLANNER_SHAMAN_2 = "Verstärkung"
L_PLANNER_SHAMAN_3 = "Wiederherstellung"
L_PLANNER_PALADIN_1 = "Heilig"
L_PLANNER_PALADIN_2 = "Schutz"
L_PLANNER_PALADIN_3 = "Vergeltung"

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
L_DATATEXT_CONTROL = " unter Kontrolle:"

-- Class script
L_CLASS_HUNTER_UNHAPPY = "Dein Begleiter ist unzufrieden!"
L_CLASS_HUNTER_CONTENT = "Dein Begleiter ist zufrieden!"
L_CLASS_HUNTER_HAPPY = "Dein Begleiter ist glücklich!"

-- Info text
L_INFO_ERRORS = "Noch keine Fehler."
L_INFO_INVITE = "Gruppeneinladung akzeptiert von: "
L_INFO_DUEL = "Duellanfrage Ignoriert von: "
L_INFO_DISBAND = "Löse Gruppe auf..."
L_INFO_ADDON_SETS1 = "Gebe /addons <solo/party/raid/pvp/trade/quest> ein, um ein vorgegebenes Set an Addons zu laden."
L_INFO_ADDON_SETS2 = "Du kannst Sets hinzufügen, löschen oder verändern, indem du die wtf.lua im `scripts` Ordner bearbeitest."
L_INFO_SETTINGS_DBM = "Gebe /settings dbm ein, um DBM Einstellungen zu laden."
L_INFO_SETTINGS_MSBT = "Gebe /settings msbt ein, um die MSBT Einstellungen zu laden."
L_INFO_SETTINGS_SKADA = "Gebe /settings skada ein, um die Skada Einstellungen zu laden."
L_INFO_SETTINGS_RECOUNT = "Gebe /settings recount ein, um die Recount Einstellungen zu laden. Danach in den Recountoptionen das *Default* Profil auswählen."
L_INFO_SETTINGS_DXE = "Gebe /settings dxe ein, um die DXE Einstellungen zu laden. Wähle danach das Profil *Default* in den DXE Optionen."
L_INFO_SETTINGS_ALL = "Gebe /settings all ein, um die Einstellungen für alle unterstützten AddOns zu laden."

-- Popups
L_POPUP_INSTALLUI = "Dies ist Ihre erste Benutzung von ShestakUI mit diesem Charakter. Um das Interface zu konfigurieren, wird das UI nun neugeladen."
L_POPUP_RESETUI = "Sind Sie sich sicher, dass Sie die Einstellungen von ShestakUI zurückgesetzen wollen?"
L_POPUP_RESETSTATS = "Are you sure you want to reset statistics for time spent in game and gold."  -- Needs review
L_POPUP_SWITCH_RAID = "Es sind 2 Raidlayouts aktiviert, bitte wählen Sie eines davon aus."
L_POPUP_DISBAND_RAID = "Bist du dir sicher, dass du die Gruppe auflösen möchtest?"
L_POPUP_DISABLEUI = "ShestakUI funktioniert nicht mit deiner Auflösung, möchtest du ShestakUI ausschalten? (Drücke Abbrechen, falls du eine andere Auflösung testen willst)"
L_POPUP_SETTINGS_ALL = "Einstellungen für alle AddOns übernehmen? (DBM/DXE, Skada/Rexount und MSBT)"
L_POPUP_SETTINGS_DBM = "Die Position der DBM Elemente muss verändert werden."
L_POPUP_SETTINGS_BW = "Die Position der BigWigs Elemente muss verändert werden."
L_POPUP_SETTINGS_CLIQUE = "Deine Clique Einstellungen sind nicht mit ShestakUI kompatibel. Willst du sie neu einstellen?"

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
L_COMBATTEXT_POPUP = "Um die Kampftext Fensterpositionen zu sichern muss das Interface neu geladen werden."
L_COMBATTEXT_UNSAVED = "Kampftext Fensterpositionen nicht gespeichert, vergiss nicht das Interface neu zu laden."
L_COMBATTEXT_UNLOCKED = "Kmpftext freigegeben."

-- LiteStats
L_STATS_ACC_PLAYED = "Gesamtspielzeit"
L_STATS_ADDED_JUNK = "Junk-Ausnahme hinzugefügt"
L_STATS_REMOVE_EXCEPTION = "Ausnahme hinzufügen/entfernen."
L_STATS_ALT = "ALT"
L_STATS_AUTO_REPAIR = "Automatisch reparieren"
L_STATS_AUTO_SELL = "Junk automatisch verkaufen"
L_STATS_BANDWIDTH = "Bandbreite:"
L_STATS_DOWNLOAD = "Download:" -- Needs review
L_STATS_CLEARED_JUNK = "Junk-Ausnahmeliste gelöscht."
L_STATS_CLEAR_EXCEPTIONS = "Ausnahmenliste löschen."
L_STATS_WORLD_MAP = "Klicken, zum Öffnen der World-Map."
L_STATS_CURRENT_XP = "Aktuell/Max XP"
L_STATS_MEMORY_USAGE = "Standard UI Speicherausnutzung:"
L_STATS_GARBAGE_COLLECTED = "Abfall zusammengefasst"
L_STATS_CHANGE_SORTING = "(Gilde) Rechts-Klick, zum Ändern der Sortierung und Umschalt-Rechts-Klick zum Umkehren der Reihenfolge."
L_STATS_HIDDEN = "Versteckt"
L_STATS_VIEW_NOTES = "Halte die ALT-Taste gedrückt, zum Anzeigen der Ränge, Notizen und Offizier Notizen."
L_STATS_HR = "std"
L_STATS_INF = "unend"
L_STATS_ALREADY_EXCEPTIONS = "ist bereits in der Ausnahmeliste."
L_STATS_NOT_JUNK = "ist kein Junk."
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
L_STATS_QUEST = "Q" -- Needs review
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
L_STATS_TOTAL = "Gesamt"
L_STATS_TOTAL_MEMORY_USAGE = "Gesamte Speicherausnutzung:"
L_STATS_NOT_TO_SELL = "Verwende /junk zum Konfigurieren der Gegenstände, die nicht verkauft werden sollen."
L_STATS_WATCH_CURRENCY = "Bereits gesehene Gegenstände aus dem Abzeichen-Fenster werden im Tooltip angezeigt."
L_STATS_WATCH_FACTIONS = "Überwache Fraktionen aus dem Ruffenster."
L_STATS_TOOLTIP_TIME_PLAYED = "Wenn das max. Level erreicht ist, wird das Tooltip die gespielte Zeit für den Account anzeigen."
L_STATS_TOOLTIP_EXPERIENCE = "Wenn unter dem max. Level, wird ein Tooltip mit weiteren Details angezeigt."

-- Slash commands
L_SLASHCMD_HELP = {
	"Available slash commands:",
	"/rl - Description is not ready.",
	"/rc - Description is not ready.",
	"/gm - Description is not ready.",
	"/dis ADDON_NAME - Description is not ready.",
	"/en ADDON_NAME - Description is not ready.",
	"/rd - Description is not ready.",
	"/toraid - Description is not ready.",
	"/luaerror - Description is not ready.",
	"/spec - Description is not ready.",
	"/clfix - Description is not ready.",
	"/heal - Description is not ready.",
	"/dps - Description is not ready.",
	"/frame - Description is not ready.",
	"/addons solo|party|raid|pvp|trade - Description is not ready.",
	"/farmmode - Description is not ready.",
	"/moveui - Description is not ready.",
	"/resetui - Description is not ready.",
	"/resetuf - Description is not ready.",
	"/resetconfig - Description is not ready.",
	"/resetstats - Description is not ready.",
	"/settings ADDON_NAME - Description is not ready.",
	"/ls - Description is not ready.",
	"/bags - Description is not ready.",
	"/xct - Description is not ready.",
	"/raidcd - Description is not ready.",
	"/enemycd - Description is not ready.",
	"/pulsecd - Description is not ready.",
	"/threat - Description is not ready.",
	"/tt - Description is not ready.",
	"/invite - Description is not ready.",
	"/testuf - Description is not ready.",
	"/cfg - Description is not ready.",
}