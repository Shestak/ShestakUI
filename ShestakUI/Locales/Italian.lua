﻿local T, C, L = unpack(select(2, ...))
if T.client ~= "itIT" then return end

----------------------------------------------------------------------------------------
--	Localization for itIT client(Thanks to Oz for the translation)
----------------------------------------------------------------------------------------
-- Tooltip
L_TOOLTIP_NO_TALENT = "Nessun talento"
L_TOOLTIP_LOADING = "Caricamento..."
L_TOOLTIP_ACH_STATUS = "Il tuo status è:"
L_TOOLTIP_ACH_COMPLETE = "Il tuo status è: completato "
L_TOOLTIP_ACH_INCOMPLETE = "Il tuo status è: incompleto"
L_TOOLTIP_SPELL_ID = "ID incantesimo/abilità:"
L_TOOLTIP_ITEM_ID = "ID oggetto:"
L_TOOLTIP_WHO_TARGET = "Bersaglio di"
L_TOOLTIP_ITEM_COUNT = "Conteggio oggetti:"

-- Misc
L_MISC_UNDRESS = "Senza vestiti"
L_MISC_DRINKING = " sta bevendo."
L_MISC_BUY_STACK = "Alt + click per comprarne un pacco"
L_MISC_ONECLICK_BUYOUT = "Shift + click per comprare direttamente l'oggetto selezionato senza conferma"
L_MISC_ONECLICK_BID = "Shift + click per fare una puntata sull'oggetto selezionato senza conferma"

-- Raid Utility
L_RAID_UTIL_DISBAND = "Sciogli il gruppo"

-- Zone name
L_ZONE_WINTERGRASP = "Lungoinverno"
L_ZONE_TOLBARAD = "Tol Barad"
L_ZONE_TOLBARADPEN = "Penisola di Tol Barad"
L_ZONE_ARATHIBASIN = "Bacino di Arathi"
L_ZONE_GILNEAS = "La Battaglia per Gilneas"

-- WatchFrame Wowhead link
L_WATCH_WOWHEAD_LINK = "Link a Wowhead"

-- Toggle Menu
L_TOGGLE_ADDON = "AddOn "
L_TOGGLE_ADDONS = " AddOns"
L_TOGGLE_EXPAND = "Espandi"
L_TOGGLE_COLLAPSE = "Rimpicciolisci "
L_TOGGLE_RCLICK = "Clicca col destro per attivare o disattivare "
L_TOGGLE_LCLICK = "Clicca col sinistro per mostrare la finestra "
L_TOGGLE_RELOAD = " (bisogna ricaricare l'interfaccia)"

-- UnitFrame
L_UF_GHOST = "Spirito"
L_UF_DEAD = "Morto"
L_UF_OFFLINE = "Offline"
L_UF_MANA = "Poco mana"
L_UF_TRINKET_READY = "Ninnolo pronto all'uso: "
L_UF_TRINKET_USED = "Ninnolo utilizzato: "
L_UF_WOTF_USED = "Volontà dei Reietti utilizzata: "

-- Map
L_MAP_CURSOR = "Cursore: "
L_MAP_BOUNDS = "Fuori i confini!"

-- Minimap
L_MINIMAP_CALENDAR = "Calendario"

-- Addons list
L_ALOAD_RL = "Ricarica l'interfaccia"
L_ALOAD_DEP = "Dipendenze: "
L_ALOAD_OP_DEP = "Optional Dependencies: " -- Needs review
L_ALOAD_PROFILES = "Profiles" -- Needs review
L_ALOAD_ENABLE_ALL = "Enable All" -- Needs review
L_ALOAD_DISABLE_ALL = "Disable All" -- Needs review
L_ALOAD_PROFILE_NAME = "Profile Name" -- Needs review
L_ALOAD_SET_TO = "Set To.." -- Needs review
L_ALOAD_ADD_TO = "Add To.." -- Needs review
L_ALOAD_REMOVE_FROM = "Remove From.." -- Needs review
L_ALOAD_DELETE_PROFILE = "Delete Profile.." -- Needs review
L_ALOAD_CONFIRM_DELETE = "Are you sure you want to delete this profile? Hold down shift and click again if you are." -- Needs review

-- Chat
L_CHAT_WHISPER = "Da"
L_CHAT_BN_WHISPER = "DA"
L_CHAT_AFK = "[Assente]"
L_CHAT_DND = "[Occupato]"
L_CHAT_GM = "[CG]"
L_CHAT_GUILD = "G"
L_CHAT_PARTY = "GR"
L_CHAT_PARTY_LEADER = "CGR"
L_CHAT_RAID = "IN"
L_CHAT_RAID_LEADER = "CIN"
L_CHAT_RAID_WARNING = "AIN"
L_CHAT_BATTLEGROUND = "CB"
L_CHAT_BATTLEGROUND_LEADER = "CCB"
L_CHAT_OFFICER = "UF"
L_CHAT_PET_BATTLE = "PB" -- Needs review
L_CHAT_COME_ONLINE = "è adesso online."
L_CHAT_GONE_OFFLINE = "è andato offline."
L_CHAT_COME_ONLINE_COLOR = "è adesso |cff298F00online|r !"
L_CHAT_GONE_OFFLINE_COLOR = "è adesso |cffff0000offline|r !"

-- Errors frame
L_ERRORFRAME_L = "Clicca per vedere gli errori."

-- Bags
L_BAG_BANK = "Banca"
L_BAG_NO_SLOTS = "Non puoi comprare altri spazi!"
L_BAG_COSTS = "Costo: %.2f ori"
L_BAG_BUY_SLOTS = "Compra nuovi spazi con /bags purchase yes"
L_BAG_OPEN_BANK = "Devi prima aprire la tua banca."
L_BAG_SORT = "Riordina le tue sacche o la tua banca, se aperta."
L_BAG_STACK = "Completa le pile parziali di oggetti identici nelle tue sacche o nella tua banca, se è aperta."
L_BAG_BUY_BANKS_SLOT = "Compra uno spazio in banca (devi avere la tua banca aperta)."
L_BAG_SORT_MENU = "Riordina"
L_BAG_SORT_SPECIAL = "Riordino speciale"
L_BAG_STACK_MENU = "Impila oggetti identici"
L_BAG_STACK_SPECIAL = "Impilamento speciale oggetti identici"
L_BAG_SHOW_BAGS = "Mostra le sacche"
L_BAG_SORTING_BAGS = "Riordino terminato."
L_BAG_NOTHING_SORT = "Niente da riordinare."
L_BAG_BAGS_BIDS = "Sacche utilizzate: "
L_BAG_STACK_END = "Impilamento terminato."
L_BAG_RIGHT_CLICK_SEARCH = "Clicca col destro per cercare"

-- Grab mail
L_MAIL_STOPPED = "Interrotto, l'inventario è pieno."
L_MAIL_UNIQUE = "Interrotto. È stato rinvenuto il duplicato di un oggetto unico in una sacca o in banca."
L_MAIL_COMPLETE = "Completato."
L_MAIL_NEED = "Hai bisogno della buca per le lettere."
L_MAIL_MESSAGES = "messaggi"

-- Loot
L_LOOT_RANDOM = "Giocatore casuale"
L_LOOT_SELF = "Bottino personale"
L_LOOT_UNKNOWN = "Sconosciuto"
L_LOOT_FISH = "Bottino pescato"
L_LOOT_MONSTER = ">> Bottino da"
L_LOOT_CHEST = ">> Bottino della cassa"
L_LOOT_ANNOUNCE = "Annuncia a"
L_LOOT_TO_RAID = "  incursione"
L_LOOT_TO_PARTY = "  gruppo"
L_LOOT_TO_GUILD = "  gilda"
L_LOOT_TO_SAY = "  dice"
L_LOOT_CANNOT = "Non puoi partecipare al tiro per il bottino"

-- LitePanels AFK module
L_PANELS_AFK = "Sei assente!"
L_PANELS_AFK_RCLICK = "Clicca col destro per nascondere il pannello."
L_PANELS_AFK_LCLICK = "Clicca col sinistro per non essere più impostato come assente."

-- Cooldowns
L_COOLDOWNS = "RC: "

-- Autoinvite
L_INVITE_ENABLE = "Invito automatico attivato: "
L_INVITE_DISABLE = "Invito automatico disattivato"

-- Bind key
L_BIND_SAVED = "Tutte le assegnazioni tasti sono state salvate."
L_BIND_DISCARD = "Tutte le nuove assegnazioni tasti non sono state salvate."
L_BIND_INSTRUCT = "Passa il tuo mouse sul bottone della barra delle azioni a cui vuoi assegnare un tasto. Premi il pulsante ESC o il tasto destro per cancellare l'attuale assegnazione tasti di quel bottone"
L_BIND_CLEARED = "Tutte le assegnazioni tasti sono state cancellate per"
L_BIND_BINDING = "Assegnazione"
L_BIND_KEY = "Tasto"
L_BIND_NO_SET = "Nessuna assegnazione impostata"

-- Talent spec
L_PLANNER_DEATHKNIGHT_1 = "Sangue"
L_PLANNER_DEATHKNIGHT_2 = "Gelo"
L_PLANNER_DEATHKNIGHT_3 = "Empietà"
L_PLANNER_WARRIOR_1 = "Armi"
L_PLANNER_WARRIOR_2 = "Furia"
L_PLANNER_WARRIOR_3 = "Protezione"
L_PLANNER_ROGUE_1 = "Assassinio"
L_PLANNER_ROGUE_2 = "Combattimento"
L_PLANNER_ROGUE_3 = "Scaltrezza"
L_PLANNER_MAGE_1 = "Arcano"
L_PLANNER_MAGE_2 = "Fuoco"
L_PLANNER_MAGE_3 = "Gelo"
L_PLANNER_MONK_1 = "Brewmaster"	--need review
L_PLANNER_MONK_2 = "Mistweaver"	--need review
L_PLANNER_MONK_3 = "Windwalker"	--need review
L_PLANNER_PRIEST_1 = "Disciplina"
L_PLANNER_PRIEST_2 = "Sacro"
L_PLANNER_PRIEST_3 = "Ombra"
L_PLANNER_WARLOCK_1 = "Afflizione"
L_PLANNER_WARLOCK_2 = "Demonologia"
L_PLANNER_WARLOCK_3 = "Distruzione"
L_PLANNER_HUNTER_1 = "Affinità animale"
L_PLANNER_HUNTER_2 = "Precisione di tiro"
L_PLANNER_HUNTER_3 = "Sopravvivenza"
L_PLANNER_DRUID_1 = "Equilibrio"
L_PLANNER_DRUID_2 = "Combattimento ferino"
L_PLANNER_DRUID_3 = "Guardian"	--need review
L_PLANNER_DRUID_4 = "Rigenerazione"
L_PLANNER_SHAMAN_1 = "Elementale"
L_PLANNER_SHAMAN_2 = "Potenziamento"
L_PLANNER_SHAMAN_3 = "Rigenerazione"
L_PLANNER_PALADIN_1 = "Sacro"
L_PLANNER_PALADIN_2 = "Protezione"
L_PLANNER_PALADIN_3 = "Castigo"

-- BG stats
L_DATATEXT_BASESASSAULTED = "Basi assaltate:"
L_DATATEXT_BASESDEFENDED = "Basi difese:"
L_DATATEXT_TOWERSASSAULTED = "Torri assaltate:"
L_DATATEXT_TOWERSDEFENDED = "Torri difese:"
L_DATATEXT_FLAGSCAPTURED = "Bandiere catturate:"
L_DATATEXT_FLAGSRETURNED = "Bandiere recuperate:"
L_DATATEXT_GRAVEYARDSASSAULTED = "Cimiteri assaltati:"
L_DATATEXT_GRAVEYARDSDEFENDED = "Cimiteri difesi"
L_DATATEXT_DEMOLISHERSDESTROYED = "Demolitori distrutti:"
L_DATATEXT_GATESDESTROYED = "Cancelli distrutti:"
L_DATATEXT_CONTROL = " sotto controllo:"

-- Info text
L_INFO_ERRORS = "Nessun errore ancora."
L_INFO_INVITE = "Accettato l'invito di: "
L_INFO_DUEL = "Declinata la richiesta di duello di: "
L_INFO_DISBAND = "Scioglimento gruppo..."
L_INFO_SETTINGS_DBM = "Digita /settings dbm per applicare le impostazioni predefinite per DBM."
L_INFO_SETTINGS_DXE = "Digita /settings dxe per applicare le impostazioni predefinite per DXE."
L_INFO_SETTINGS_MSBT = "Digita /settings msbt per applicare le impostazioni predefinite per MSBT."
L_INFO_SETTINGS_SKADA = "Digita /settings skada per applicare le impostazioni predefinite per Skada."
L_INFO_SETTINGS_ALL = "Digita /settings all, per applicare le impostazioni predefinite per tutte le AddOns."
L_INFO_NOT_INSTALLED = " non è installato."
L_INFO_SKIN_DISABLED1 = "Restyling per "
L_INFO_SKIN_DISABLED2 = " è disabilitato."

-- Popups
L_POPUP_INSTALLUI = "È la prima volta che utilizzi la ShestakUI con questo personaggio. Devi riavviare l'interfaccia utente per configurarla."
L_POPUP_RESETUI = "Vuoi davvero ripristinare tutte le impostazioni iniziali della ShestakUI?"
L_POPUP_RESETSTATS = "Vuoi davvero riazzerare tutte le statistiche relative a tempo trascorso in gioco e oro?"
L_POPUP_SWITCH_RAID = "Sono attive entrambe le configurazioni per le incursioni, scegline una, per favore."
L_POPUP_DISBAND_RAID = "Vuoi davvero sciogliere il gruppo??"
L_POPUP_DISABLEUI = "A questa risoluzione la ShestakUI non funziona correttamente, vuoi disabilitare l'AddOn? (clicca 'Cancella' se vuoi provare con un'altra risoluzione)"
L_POPUP_SETTINGS_ALL = "Applica le impostazioni per tutte le AddOns? (DBM/DXE, Skada e MSBT)"
L_POPUP_SETTINGS_DBM = "È necessario cambiare la posizione degli elementi di DBM."
L_POPUP_SETTINGS_DXE = "È necessario cambiare la posizione degli elementi di DXE."
L_POPUP_SETTINGS_BW = "È necessario cambiare la posizione degli elementi di BigWigs."
L_POPUP_ARMORY = "Armory" -- Needs review

-- Welcome message
L_WELCOME_LINE_1 = "Benvenuto/a in ShestakUI "
L_WELCOME_LINE_2_1 = "Digita /cfg per configurare l'interfaccia oppure visita http://shestak.org"
L_WELCOME_LINE_2_2 = "per maggiori informazioni."

-- Combat text
L_COMBATTEXT_KILLING_BLOW = "Colpo mortale"
L_COMBATTEXT_ALREADY_UNLOCKED = "Testo di combattimento già sbloccato."
L_COMBATTEXT_ALREADY_LOCKED = "Testo di combattimento già bloccato."
L_COMBATTEXT_TEST_DISABLED = "Modalità 'prova' del testo di combattimento disabilitata."
L_COMBATTEXT_TEST_ENABLED = "Modalità 'prova' del testo di combattimento abilitata."
L_COMBATTEXT_TEST_USE_UNLOCK = "Digita /xct per sbloccare e quindi poter muovere e ridimensionare i riquadri del testo di combattimento."
L_COMBATTEXT_TEST_USE_LOCK = "Digita /xct per bloccare i riquadri del testo di combattimento."
L_COMBATTEXT_TEST_USE_TEST = "Digita /xct test per attivare la modalità 'prova' per il testo di combattimento."
L_COMBATTEXT_POPUP = "Per poter salvare la posizione delle finestre del testo di combattimento è necessario riavviare la tua interfaccia utente."
L_COMBATTEXT_UNSAVED = "La posizione delle finestre del testo di combattimento non è ancora stata salvata: non dimenticare di riavviare l'interfaccia utente."
L_COMBATTEXT_UNLOCKED = "Testo di combattimento sbloccato."

-- LiteStats
L_STATS_ACC_PLAYED = "Account in uso"
L_STATS_ADDED_JUNK = "Eccezione aggiunta all'elenco cianfrusaglie"
L_STATS_REMOVE_EXCEPTION = "Aggiungi/rimuovi un'eccezione."
L_STATS_ALT = "ALT."
L_STATS_AUTO_REPAIR = "Riparazione automatica"
L_STATS_GUILD_REPAIR = "Riparazione con i fondi di gilda"
L_STATS_AUTO_SELL = "Vendita automatica delle cianfrusaglie"
L_STATS_BANDWIDTH = "Larghezza banda:"
L_STATS_DOWNLOAD = "Download:"
L_STATS_CLEARED_JUNK = "Lista eccezioni dell'elenco cianfrusaglie cancellata."
L_STATS_CLEAR_EXCEPTIONS = "Cancella la lista eccezioni."
L_STATS_WORLD_MAP = "Clicca per aprire la mappa del mondo."
L_STATS_CURRENT_XP = "PE attuali/massimi"
L_STATS_MEMORY_USAGE = "Utilizzo memoria interfaccia:"
L_STATS_GARBAGE_COLLECTED = "Spazzatura raccolta"
L_STATS_CHANGE_SORTING = "(Gilda) Clicca col destro per cambiare l'ordine, clicca shift+tasto destro per invertirlo."
L_STATS_HIDDEN = "Nascosto/a"
L_STATS_VIEW_NOTES = "Tieni premuto il tasto Alt per visualizzare gradi, note e note degli ufficiali."
L_STATS_HR = "o"
L_STATS_INF = "inf"
L_STATS_ALREADY_EXCEPTIONS = "è già nell'elenco delle eccezioni."
L_STATS_NOT_JUNK = "non è una cianfrusaglia."
L_STATS_ITEMLINK = "Link all'oggetto"
L_STATS_JUNK_EXCEPTIONS = "Eccezioni elenco cianfrusaglie"
L_STATS_JUNK_LIST = "Elenco cianfrusaglie"
L_STATS_JUNK_PROFIT = "Profitto vendita cianfrusaglie"
L_STATS_KILLS = "U"
L_STATS_OPEN_CALENDAR = "Clicca col sinistro per aprire il calendario (/cal)."
L_STATS_OPEN_CHARACTER = "Clicca col sinistro per aprire il pannello personaggio."
L_STATS_OPEN_CURRENCY = "Clicca col sinistro per aprire il pannello Valuta."
L_STATS_OPEN_TALENT = "Clicca col sinistro per aprire il pannello dei talenti."
L_STATS_XP_RATE = "Andamento PE per il livello"
L_STATS_IGNORED_ITEMS = "Lista degli oggetti attualmente ignorati."
L_STATS_TOGGLE_TIME = "L'orario 'locale/reame' e quello '24 ore' possono essere attivati con le impostazioni orologio."
L_STATS_LOCATION = "Località/Coordinate"
L_STATS_MEMORY = "Memoria"
L_STATS_ON = "Attivo"
L_STATS_OTHER_OPTIONS = "Altre opzioni potranno essere configurate tra %s"
L_STATS_PLAYED_LEVEL = "Tempo giocato a questo livello"
L_STATS_PLAYED_SESSION = "Tempo giocato in questa sessione"
L_STATS_PLAYED_TOTAL = "Tempo giocato totale"
L_STATS_QUEST = "M"
L_STATS_QUESTS_TO = "Missioni/uccisioni per %s"
L_STATS_REMAINING_XP = "PE rimanenti"
L_STATS_REMOVED_JUNK = "Eccezione cianfrusaglie rimossa."
L_STATS_RESTED_XP = "PE da 'riposato'"
L_STATS_RC_COLLECTS_GARBAGE = "Clicca col destro per raccogliere la 'spazzatura LUA'."
L_STATS_RC_TIME_MANAGER = "Clicca col destro per aprire le impostazionni orologio."
L_STATS_RC_EXPERIENCE = "Clicca col destro per navigare tra esperienza, tempo giocato e il visualizzatore fazione sotto osservazione."
L_STATS_RC_AUTO_REPAIRING = "Clicca col destro per attivare/disattivare la riparazione automatica."
L_STATS_RC_AUTO_SELLING = "Clicca col destro per attivare/disattivare la vendita automatica delle cianfrusaglie"
L_STATS_RC_TALENT = "Clicca col destro per cambiare l'albero talenti attivo."
L_STATS_SERVER_GOLD = "Oro totale su questo reame"
L_STATS_SESSION_GAIN = "Guadagno/perdita della sessione"
L_STATS_SESSION_XP = "Andamento PE della sessione"
L_STATS_INSERTS_COORDS = "Tieni premuto Shift e clicca sul nome della località o sulle coordinate per inserirli automaticamente in chat."
L_STATS_EQUIPMENT_CHANGER = "Tieni premuto Shift e clicca (o utilizza il tasto centrale del mouse, se lo hai) per cambiare il set d'equipaggiamento."
L_STATS_SORTING_BY = "Suddivisi per"
L_STATS_TIPS = "suggerimenti:"
L_STATS_TOTAL = "Totale"
L_STATS_TOTAL_MEMORY_USAGE = "Utilizzo totale memoria:"
L_STATS_NOT_TO_SELL = "Utilizza /junk per configurare quali oggetti non vendere."
L_STATS_WATCH_CURRENCY = "Gli oggetti attualmente osservati nel pannello Valuta non inseriti nei suggerimenti."
L_STATS_WATCH_FACTIONS = "Fazioni sotto osservazione dal pannello delle fazioni del personaggio."
L_STATS_TOOLTIP_TIME_PLAYED = "A livello massimo, un suggerimento mostrerà i dettagli su quanto tempo hai giocato con questo account."
L_STATS_TOOLTIP_EXPERIENCE = "A livelli inferiori a quello massimo, un suggerimento mostrerà dettagli sull'esperienza."

-- Slash commands
L_SLASHCMD_HELP = {
	"Comandi slash disponibili:",
	"/rl - Ricarica l'interfaccia.",
	"/rc - Avvia un appello.",
	"/gm - Apre il pannello per interagire con i GM.",
	"/dis ADDON_NAME - Disabilita AddOn.",
	"/en ADDON_NAME - Attiva AddOn.",
	"/rd - Sciogli gruppo o incursione.",
	"/toraid - Trasforma il gruppo in incursione.",
	"/teleport - Teletrasporto dalle spedizioni casuali.",
	"/luaerror ON|OFF - Attiva/disattiva la visualizzazione degli errori LUA.",
	"/spec, /ss - Passa da un albero talenti all'altro",
	"/clfix - Correggi il Registro di combattimento.",
	"/heal - Passa alla configurazione 'guaritori'.",
	"/dps - Passa alla configurazione 'assaltatori'",
	"/frame - La descrizione non è pronta.",
	"/farmmode - Incrementa le dimensioni della minimappa.",
	"/moveui - Consenti lo spostamento degli elementi dell'interfaccia.",
	"/resetui - Ripristina le impostazioni generali iniziali.",
	"/resetuf - Riporta i riquadri delle unità alla loro posizione originaria.",
	"/resetconfig - Riporta le impostazioni della ShestakUI_Config a quelle iniziali.",
	"/resetstats - Riazzera le statistiche su oro e tempo di gioco.",
	"/settings ADDON_NAME - Applica le impostazioni a MSBT, DBM, Skada o a tutte le AddOns.",
	"/ls, /litestats - Comandi d'aiuto per LiteStats.",
	"/bags - Gestione sacche.",
	"/xct - Gestione testo di combattimento.",
	"/raidcd - Prova dei recuperi dell'incursione.",
	"/enemycd - Prova dei recuperi del nemico.",
	"/pulsecd - Prova dei tuoi recuperi con effetto 'pulse'.",
	"/threat - Prova del Contatore Minaccia.",
	"/tt - Sussurra al bersaglio.",
	"/ainv - Attiva gli inviti automatici.",
	"/testuf - Prova dei riquadri delle unità.",
	"/cfg - Apri il pannello impostazioni interfaccia.",
}