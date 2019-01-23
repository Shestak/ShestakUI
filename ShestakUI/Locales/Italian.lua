local T, C, L, _ = unpack(select(2, ...))
if T.client ~= "itIT" then return end

----------------------------------------------------------------------------------------
--	Localization for itIT client
--	Translation: Oz
----------------------------------------------------------------------------------------
-- Announce flasks and food
L_ANNOUNCE_FF_NOFOOD = "Senza beneficio da cibo: "
L_ANNOUNCE_FF_NOFLASK = "Senza beneficio da tonico: "
L_ANNOUNCE_FF_ALLBUFFED = "Tutti i benefici sono attivi!"
L_ANNOUNCE_FF_CHECK_BUTTON = "Controllo cibi e tonici"

-- Says thanks for some spells
L_ANNOUNCE_SS_THANKS = "Grazie per "
L_ANNOUNCE_SS_RECEIVED = " ricevuto/a da "

-- Pull countdown announce
L_ANNOUNCE_PC_GO = "VIA!"
L_ANNOUNCE_PC_MSG = "Avvio incontro %s in %s.."
L_ANNOUNCE_PC_ABORTED = "Avvio incontro ANNULLATO!"

-- Announce feasts and portals
L_ANNOUNCE_FP_STAT = "%s ha preparato un/una %s - [%s]."
L_ANNOUNCE_FP_PRE = "%s ha preparato un/una %s."
L_ANNOUNCE_FP_PUT = "%s ha messo già un/una %s."
L_ANNOUNCE_FP_CAST = "%s sta lanciando %s."
L_ANNOUNCE_FP_CLICK = "%s sta lanciando %s. Cliccate!"
L_ANNOUNCE_FP_USE = "%s ha utilizzato un/una %s."

-- Announce your interrupts
L_ANNOUNCE_INTERRUPTED = INTERRUPTED

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
L_TOOLTIP_INSPECT_OPEN = "Il riquadro 'Ispeziona' è aperto"

-- Misc
L_MISC_UNDRESS = "Senza vestiti"
L_MISC_DRINKING = " sta bevendo."
L_MISC_BUY_STACK = "Alt + click per comprarne una pila"
L_MISC_ONECLICK_BUYOUT = "Shift + click sul destro per comprare direttamente l'oggetto selezionato senza conferma"
L_MISC_ONECLICK_BID = "Shift + click sul destro per fare una puntata sull'oggetto selezionato senza conferma"
L_MISC_ONECLICK_CANCEL = "Shift + click sul destro per cancellare l'oggetto selezionato senza conferma"
L_MISC_UI_OUTDATED = "La tua versione della ShestakUI non è aggiornata: puoi scaricare la nuova versione da www.shestak.org."
L_MISC_HEADER_MARK = "Marchi d'incursione al passaggio del mouse"
L_MISC_BINDER_OPEN = "Assegnazione pulsanti mouse"
L_MISC_GROCERY_BUY = "Compra"
L_MISC_GROCERY_DESC = "Compra automaticamente i sacchetti di alimenti"
L_MISC_SCROLL = "Pergamena"
L_MISC_COLLAPSE = "Il Crollo"

-- Raid Utility
L_RAID_UTIL_DISBAND = "Sciogli il gruppo"

-- Zone name
L_ZONE_TOLBARAD = "Tol Barad"
L_ZONE_TOLBARADPEN = "Penisola di Tol Barad"
L_ZONE_ARATHIBASIN = "Bacino d'Arathi"
L_ZONE_GILNEAS = "Battaglia per Gilneas"
L_ZONE_ANCIENTDALARAN = "Cratere di Dalaran"

-- WatchFrame Wowhead link
L_WATCH_WOWHEAD_LINK = "Collegamento a Wowhead"

-- Toggle Menu
L_TOGGLE_ADDON = "AddOn "
L_TOGGLE_ADDONS = " AddOns"
L_TOGGLE_EXPAND = "Espandi"
L_TOGGLE_COLLAPSE = "Rimpicciolisci "
L_TOGGLE_RCLICK = "Clicca col destro per attivare o disattivare "
L_TOGGLE_LCLICK = "Clicca col sinistro per mostrare la finestra "
L_TOGGLE_RELOAD = " (bisogna ricaricare l'interfaccia)"
L_TOGGLE_NOT_FOUND = " non trovata."

-- UnitFrame
L_UF_GHOST = "Spirito"
L_UF_DEAD = "Morto"
L_UF_OFFLINE = "Disconnesso"
L_UF_MANA = "Poco mana"

-- Map
L_MAP_CURSOR = "Cursore: "
L_MAP_BOUNDS = "Fuori i confini!"
L_MAP_FOG = "Nebbia della guerra"
L_MAP_COORDS = "Coordinate"

-- Minimap
L_MINIMAP_CALENDAR = "Calendario"
L_MINIMAP_HEAL_LAYOUT = "Click-Sinistro - Disposizione da Guaritore"
L_MINIMAP_DPS_LAYOUT = "Click-Destro - Disposizione d'Assaltatore"
L_MINIMAP_BLIZZ_LAYOUT = "Click-Centrale - Disposizione Blizzard"

-- Chat
L_CHAT_WHISPER = "Da"
L_CHAT_BN_WHISPER = "DA"
L_CHAT_AFK = "[Assente]"
L_CHAT_DND = "[Occupato]"
L_CHAT_GM = "[RG]"
L_CHAT_GUILD = "G"
L_CHAT_PARTY = "GR"
L_CHAT_PARTY_LEADER = "CGR"
L_CHAT_RAID = "IN"
L_CHAT_RAID_LEADER = "CIN"
L_CHAT_RAID_WARNING = "AIN"
L_CHAT_INSTANCE_CHAT = "IS"
L_CHAT_INSTANCE_CHAT_LEADER = "CIS"
L_CHAT_OFFICER = "UF"
L_CHAT_PET_BATTLE = "STM"
L_CHAT_COME_ONLINE = "si è |cff298F00connesso/a|r."
L_CHAT_GONE_OFFLINE = "si è |cffff0000disconnesso/a|r."

-- Errors frame
L_ERRORFRAME_L = "Clicca per vedere gli errori."

-- Bags
L_BAG_SHOW_BAGS = "Mostra le sacche"
L_BAG_RIGHT_CLICK_SEARCH = "Clicca col destro per cercare"
L_BAG_STACK_MENU = "Impila oggetti identici"
L_BAG_RIGHT_CLICK_CLOSE = "Clicca col destro per aprire il menu"

-- Grab mail
L_MAIL_STOPPED = "Interrotto, l'inventario è pieno."
L_MAIL_UNIQUE = "Interrotto. È stato rinvenuto il duplicato di un oggetto unico in una sacca o in banca."
L_MAIL_COMPLETE = "Completato."
L_MAIL_NEED = "Hai bisogno della cassetta delle lettere."
L_MAIL_MESSAGES = "messaggi"

-- Loot
L_LOOT_RANDOM = "Giocatore casuale"
L_LOOT_SELF = "Bottino personale"
L_LOOT_FISH = "Bottino pescato"
L_LOOT_ANNOUNCE = "Annuncia a"
L_LOOT_TO_RAID = "  incursione"
L_LOOT_TO_PARTY = "  gruppo"
L_LOOT_TO_GUILD = "  gilda"
L_LOOT_TO_SAY = "  dice"

-- LitePanels AFK module
L_PANELS_AFK = "Sei assente!"
L_PANELS_AFK_RCLICK = "Click destro = nascondi pannello."
L_PANELS_AFK_LCLICK = "Click sinistro = non più assente."

-- Cooldowns
L_COOLDOWNS = "RC: "
L_COOLDOWNS_COMBATRESS = "Resurrezione in Combattimento"
L_COOLDOWNS_COMBATRESS_REMAINDER = "Resurrezione in combattimento: "
L_COOLDOWNS_NEXTTIME = "Tempi di ricarica: "

-- Autoinvite
L_INVITE_ENABLE = "Invito automatico attivato: "
L_INVITE_DISABLE = "Invito automatico disattivato"

-- Bind key
L_BIND_SAVED = "Tutte le assegnazioni tasti sono state salvate."
L_BIND_DISCARD = "Tutte le nuove assegnazioni tasti non sono state salvate."
L_BIND_INSTRUCT = "Passa il tuo mouse sullo scomparto della barra delle azioni a cui vuoi assegnare un tasto. Premi il pulsante ESC o il tasto destro per cancellare l'attuale assegnazione tasti di quello scomparto."
L_BIND_CLEARED = "Tutte le assegnazioni tasti sono state cancellate per"
L_BIND_BINDING = "Assegnazione"
L_BIND_KEY = "Tasto"
L_BIND_NO_SET = "Nessuna assegnazione impostata"

-- Info text
L_INFO_ERRORS = "Nessun errore ancora."
L_INFO_INVITE = "Accettato l'invito di "
L_INFO_DUEL = "Declinata la richiesta di duello di "
L_INFO_PET_DUEL = "Declinata la richiesta di duello tra mascottes di "
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
L_POPUP_SWITCH_RAID = "Scegli la disposizione per le incursioni."
L_POPUP_DISBAND_RAID = "Vuoi davvero sciogliere il gruppo?"
L_POPUP_DISABLEUI = "A questa risoluzione la ShestakUI non funziona correttamente, vuoi disabilitare l'AddOn (clicca 'Cancella' se vuoi provare con un'altra risoluzione)?"
L_POPUP_SETTINGS_ALL = "Applica le impostazioni per tutte le AddOns (DBM/DXE, Skada e MSBT)?"
L_POPUP_SETTINGS_DBM = "È necessario cambiare la posizione degli elementi di DBM."
L_POPUP_SETTINGS_DXE = "È necessario cambiare la posizione degli elementi di DXE."
L_POPUP_SETTINGS_BW = "È necessario cambiare la posizione degli elementi di BigWigs."
L_POPUP_ARMORY = "Armeria"
L_POPUP_CURRENCY_CAP = "Hai raggiunto il valore massimo di"

-- Welcome message
L_WELCOME_LINE_1 = "Benvenuto/a in ShestakUI "
L_WELCOME_LINE_2_1 = "Digita /cfg per configurare l'interfaccia oppure visita http://shestak.org"
L_WELCOME_LINE_2_2 = "per maggiori informazioni."

-- Combat text
L_COMBATTEXT_KILLING_BLOW = "Colpo di grazia"
L_COMBATTEXT_ALREADY_UNLOCKED = "Testo di combattimento già sbloccato."
L_COMBATTEXT_ALREADY_LOCKED = "Testo di combattimento già bloccato."
L_COMBATTEXT_TEST_DISABLED = "Modalità 'prova' del testo di combattimento disabilitata."
L_COMBATTEXT_TEST_ENABLED = "Modalità 'prova' del testo di combattimento abilitata."
L_COMBATTEXT_TEST_USE_UNLOCK = "Digita /xct per sbloccare e quindi poter muovere e ridimensionare i riquadri del testo di combattimento."
L_COMBATTEXT_TEST_USE_LOCK = "Digita /xct per bloccare i riquadri del testo di combattimento."
L_COMBATTEXT_TEST_USE_TEST = "Digita /xct test per attivare la modalità 'prova' per il testo di combattimento."
L_COMBATTEXT_TEST_USE_RESET = "Digita /xct reset to ripristinare le posizioni predefinite."
L_COMBATTEXT_POPUP = "Per poter salvare la posizione delle finestre del testo di combattimento è necessario riavviare la tua interfaccia utente."
L_COMBATTEXT_UNSAVED = "La posizione delle finestre del testo di combattimento non è ancora stata salvata: non dimenticare di riavviare l'interfaccia utente."
L_COMBATTEXT_UNLOCKED = "Testo di combattimento sbloccato."

-- LiteStats
L_STATS_ACC_PLAYED = "Account in uso"
L_STATS_ADDED_JUNK = "Eccezione aggiunta all'elenco cianfrusaglie"
L_STATS_REMOVE_EXCEPTION = "Aggiungi/rimuovi un'eccezione."
L_STATS_AUTO_REPAIR = "Riparazione automatica"
L_STATS_GUILD_REPAIR = "Riparazione con i fondi di gilda"
L_STATS_AUTO_SELL = "Vendita automatica delle cianfrusaglie"
L_STATS_BANDWIDTH = "Larghezza banda:"
L_STATS_DOWNLOAD = "Download:"
L_STATS_CLEARED_JUNK = "Lista eccezioni dell'elenco cianfrusaglie cancellata."
L_STATS_CLEAR_EXCEPTIONS = "Cancella la lista eccezioni."
L_STATS_CURRENCY_RAID = "Sigilli d’incursione"
L_STATS_WORLD_MAP = "Clicca per aprire la mappa del mondo."
L_STATS_CURRENT_XP = "PE attuali/massimi"
L_STATS_MEMORY_USAGE = "Utilizzo memoria interfaccia Blizzard:"
L_STATS_GARBAGE_COLLECTED = "Spazzatura raccolta"
L_STATS_CHANGE_SORTING = "[Gilda] Clicca col destro per invitare e sussurrare, clicca col tasto centrale per cambiare l'ordine, clicca Shift + tasto centrale per invertirlo."
L_STATS_HIDDEN = "Nascosto/a"
L_STATS_VIEW_NOTES = "Tieni premuto il tasto Alt per visualizzare ranghi, note e note degli ufficiali."
L_STATS_HR = "o"
L_STATS_INF = "inf"
L_STATS_ALREADY_EXCEPTIONS = "è già nell'elenco delle eccezioni."
L_STATS_ITEMLINK = "Collegamento all'oggetto"
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
L_STATS_ON = "Acceso"
L_STATS_OTHER_OPTIONS = "Altre opzioni potranno essere configurate tra %s"
L_STATS_PLAYED_LEVEL = "Tempo giocato a questo livello"
L_STATS_PLAYED_SESSION = "Tempo giocato in questa sessione"
L_STATS_PLAYED_TOTAL = "Tempo giocato totale"
L_STATS_QUEST = "M"
L_STATS_QUESTS_TO = "Missioni/uccisioni per %s"
L_STATS_REMAINING_XP = "PE rimanenti"
L_STATS_REMOVED_JUNK = "Eccezione cianfrusaglie rimossa."
L_STATS_RESTED_XP = "PE da 'riposato'"
L_STATS_RC_COLLECTS_GARBAGE = "Clicca col destro per raccogliere la 'spazzatura Lua'."
L_STATS_RC_TIME_MANAGER = "Clicca col destro per aprire le impostazionni orologio."
L_STATS_RC_EXPERIENCE = "Clicca col destro per navigare tra esperienza, tempo giocato e il visualizzatore fazione sotto osservazione."
L_STATS_RC_AUTO_REPAIRING = "Clicca col destro per attivare/disattivare la riparazione automatica."
L_STATS_RC_AUTO_SELLING = "Clicca col destro per attivare/disattivare la vendita automatica delle cianfrusaglie"
L_STATS_RC_TALENT = "Clicca col destro per cambiare la spec. talenti attiva."
L_STATS_SERVER_GOLD = "Oro totale su questo reame"
L_STATS_SESSION_GAIN = "Guadagno/perdita della sessione"
L_STATS_SESSION_XP = "Andamento PE della sessione"
L_STATS_INSERTS_COORDS = "Tieni premuto Shift e clicca sul nome della località o sulle coordinate per inserirli automaticamente in chat."
L_STATS_EQUIPMENT_CHANGER = "Tieni premuto Shift e clicca (o utilizza il tasto centrale del mouse, se lo hai) per cambiare il set d'equipaggiamento."
L_STATS_SORTING_BY = "Suddivisi per"
L_STATS_TIPS = "suggerimenti:"
L_STATS_TOTAL_MEMORY_USAGE = "Utilizzo totale memoria:"
L_STATS_NOT_TO_SELL = "Utilizza /junk per configurare quali oggetti non vendere."
L_STATS_WATCH_CURRENCY = "Gli oggetti attualmente osservati nel pannello Valuta saranno inseriti nei suggerimenti."
L_STATS_WATCH_FACTIONS = "Fazioni sotto osservazione dal pannello delle fazioni del personaggio."
L_STATS_TOOLTIP_TIME_PLAYED = "A livello massimo, un suggerimento mostrerà i dettagli su quanto tempo hai giocato con questo account."
L_STATS_TOOLTIP_EXPERIENCE = "A livelli inferiori a quello massimo, un suggerimento mostrerà dettagli sull'esperienza."
L_STATS_SEALS = "Sigilli in questa settimana"

-- Slash commands
L_SLASHCMD_HELP = {
	"Comandi slash disponibili:",
	"/rl - Ricarica l'interfaccia.",
	"/rc - Avvia un appello.",
	"/gm - Apri il pannello per interagire con i RG.",
	"/dis ADDON_NAME - Disabilita AddOn.",
	"/en ADDON_NAME - Attiva AddOn.",
	"/rd - Sciogli gruppo o incursione.",
	"/toraid - Trasforma il gruppo in incursione.",
	"/teleport - Teletrasporto dalle spedizioni casuali.",
	"/spec, /ss - Passa da una specializzazione dei talenti all'altra",
	"/heal - Passa alla configurazione 'guaritori'.",
	"/dps - Passa alla configurazione 'assaltatori'.",
	"/frame - La descrizione non è pronta.",
	"/farmmode - Incrementa le dimensioni della minimappa.",
	"/moveui - Consenti lo spostamento degli elementi dell'interfaccia.",
	"/resetui - Ripristina le impostazioni generali iniziali.",
	"/resetuf - Riporta i riquadri delle unità alla loro posizione originaria.",
	"/resetconfig - Riporta le impostazioni della ShestakUI_Config a quelle iniziali.",
	"/resetstats - Riazzera le statistiche su oro e tempo di gioco.",
	"/settings ADDON_NAME - Applica le impostazioni a MSBT, DBM, Skada o a tutte le AddOns.",
	"/ls, /litestats - Comandi d'aiuto per LiteStats.",
	"/xct - Gestione testo di combattimento.",
	"/raidcd - Prova i recuperi d'incursione.",
	"/enemycd - Prova i recuperi del nemico.",
	"/pulsecd - Prova i tuoi recuperi con effetto 'pulse'.",
	"/threat - Prova il Contatore Minaccia.",
	"/tt - Sussurra al bersaglio.",
	"/ainv - Attiva gli inviti automatici.",
	"/testuf - Prova i riquadri delle unità.",
	"/cfg - Apri il pannello impostazioni interfaccia.",
}