local _, L = ...
if GetLocale() ~= "itIT" then return end

----------------------------------------------------------------------------------------
--	Localization for itIT client
--	Translation: Oz
----------------------------------------------------------------------------------------
L_GUI_SET_SAVED_SETTTINGS = "Imposta le impostazioni 'Per-Personaggio'"
L_GUI_SET_SAVED_SETTTINGS_DESC = "Switch between a profile that applies to all characters and one that is unique to this character." -- Need review
L_GUI_RESET_CHAR = "Vuoi davvero ripristinare le impostazioni iniziali della ShestakUI per questo personaggio?"
L_GUI_RESET_ALL = "Vuoi davvero ripristinate tutte le impostazioni iniziali della ShestakUI?"
L_GUI_PER_CHAR = "Vuoi davvero modificare questa impostazione (attivazione/disattivazione salvataggio impostazioni 'Per-Personaggio')?"
L_GUI_RESET_CAT = "Are you sure you want to reset category's settings?" -- Need review
L_GUI_RESET_CAT_DESC = "Reset category's settings. \nCTRL-click to reset all" -- Need review
L_GUI_NEED_RELOAD = "You need to reload the UI to apply your changes." -- Need review
L_GUI_LAYOUT = "Change layout" -- Need review
L_GUI_SPELL_LIST = "List of spells" -- Need review
L_GUI_SPELL_INPUT = "Spell ID" -- Need review
L_GUI_TIME_INPUT = "Time" -- Need review
L_GUI_EXPERT_MODE = "Expert mode" -- Need review
L_GUI_EXPERT_MODE_DESC = "Custom editing of Lua profile" -- Need review

-- General options
L_GUI_GENERAL_SUBTEXT = "These settings control the general user interface settings. Type in chat '/uihelp' for help." -- Need review
L_GUI_GENERAL_WELCOME_MESSAGE = "Messaggio di benvenuto in chat"
L_GUI_GENERAL_AUTOSCALE = "Ridimensionamento automatico dell'interfaccia"
L_GUI_GENERAL_UISCALE = "Scala dell'interfaccia (se il ridimensionamento automatico è disabilitato)"
L.general_subheader_blizzard = "Blizzard UI elements" -- Need review
L.general_error_filter = "Error filtering" -- Need review
L.general_error_blacklist = "Blacklist" -- Need review
L.general_error_whitelist = "Whitelist" -- Need review
L.general_error_combat = "In combat" -- Need review
L.general_error_none = "None" -- Need review
L.general_vehicle_mouseover = "Riquadro veicolo al passaggio del mouse"
L.general_move_blizzard = "Consenti di muovere alcuni riquadri dell'interfaccia Blizzard"
L.general_color_picker = "Selezionatore colore migliorato"
L.general_color_picker_desc = "Add copy/paste buttons and digit text entry for Blizzard color picker frame" -- Need review
L.general_minimize_mouseover = "Pulsante per minimizzare le missioni al passaggio del mouse"
L.general_hide_banner = "Nascondi il Boss Banner Loot Frame"
L.general_hide_talking_head = "Nascondi il Talking Head Frame"

-- Media options
L.media_border_color = "Color for borders" -- Need review
L.media_classborder_color = "Color for class borders" -- Need review
L.media_backdrop_color = "Color for borders backdrop" -- Need review
L.media_backdrop_alpha = "Alpha for transparent backdrop" -- Need review
L.media_texture = "Main texture" -- Need review
L.media_subheader_normal = "Change general font" -- Need review
L.media_subheader_pixel = "Change secondary font" -- Need review

-- Font options
L.font = "Fonts" -- Need review
L.font_subtext = "Customize individual fonts for elements." -- Need review
L.font_stats_font = "Select font" -- Need review
L.font_stats_font_style = "Font flag" -- Need review
L.font_stats_font_shadow = "Font shadow" -- Need review
L.font_subheader_stats = "Stats font" -- Need review
L.font_subheader_combat = "Combat text font" -- Need review
L.font_subheader_chat = "Chat font" -- Need review
L.font_subheader_chat_tabs = "Chat tabs font" -- Need review
L.font_subheader_action = "Action bars font" -- Need review
L.font_subheader_threat = "Threat meter font" -- Need review
L.font_subheader_raidcd = "Raid cooldowns font" -- Need review
L.font_subheader_cooldown = "Cooldowns timer font" -- Need review
L.font_subheader_loot = "Loot font" -- Need review
L.font_subheader_nameplates = "Nameplates font" -- Need review
L.font_subheader_unit = "Unit frames font" -- Need review
L.font_subheader_aura = "Auras font" -- Need review
L.font_subheader_filger = "Filger font" -- Need review
L.font_subheader_style = "Stylization font" -- Need review
L.font_subheader_bag = "Bags font" -- Need review
L.font_subheader_blizzard = "System font size" -- Need review
L.font_tooltip_header_font_size = "Tooltip header" -- Need review
L.font_tooltip_font_size = "Tooltip text" -- Need review
L.font_global_font = "Disable Pixel font" -- Need review

-- Skins options
L_GUI_SKINS = "Restyling"
L_GUI_SKINS_SUBTEXT = "Change the appearance of the standard interface." -- Need review
L_GUI_SKINS_BLIZZARD = "Attiva il restyling dei riquadri Blizzard"
L_GUI_SKINS_MINIMAP_BUTTONS = "Attiva il restyling dei pulsanti delle AddOns sulla minimappa"
L_GUI_SKINS_SUBHEADER = "Stylization of addons" -- Need review
L_GUI_SKINS_DBM_MOVABLE = "Consenti di poter spostare le barre di DBM"
L.skins_minimap_buttons_mouseover = "Addons icons on mouseover" -- Need review

-- Unit Frames options
L_GUI_UF_SUBTEXT = "Customize player, target frames and etc." -- Need review
L_GUI_UF_ENABLE = "Abilita i riquadri delle unità"
L_GUI_UF_OWN_COLOR = "Scegli il colore per la tua barra della salute"
L_GUI_UF_UF_COLOR = "Colore barre salute (se è attivo il colore per la tua barra della salute)"
L.unitframe_uf_color_bg = "Color of health background" -- Need review
L_GUI_UF_ENEMY_HEALTH_COLOR = "Colora di rosso la barra della salute dei nemici"
L_GUI_UF_TOTAL_VALUE = "Visualizza un testo sui riquadri di giocatore e bersaglio con i valori XXXX/Totale"
L_GUI_UF_COLOR_VALUE = "Valori di salute e mana colorati"
L_GUI_UF_BAR_COLOR_VALUE = "Barra della salute colorata in base alla salute restante"
L_GUI_UF_LINES = "Mostra le linee per giocatore e bersaglio"
L_GUI_UF_SUBHEADER_CAST = "Castbars" -- Need review
L_GUI_UF_UNIT_CASTBAR = "Mostra le barre incantesimi"
L_GUI_UF_CASTBAR_ICON = "Mostra le icone della barra incantesimi"
L_GUI_UF_CASTBAR_LATENCY = "Latenza della barra incantesimi"
L_GUI_UF_CASTBAR_TICKS = "Mostra le tacchette (ticks) sulla barra incantesimi"
L_GUI_UF_SUBHEADER_FRAMES = "Frames" -- Need review
L_GUI_UF_SHOW_PET = "Mostra il riquadro per il famiglio"
L_GUI_UF_SHOW_FOCUS = "Mostra il riquadro per il focus"
L_GUI_UF_SHOW_TOT = "Mostra il riquadro per il bersaglio del bersaglio"
L_GUI_UF_SHOW_BOSS = "Mostra i riquadri per i bosses"
L_GUI_UF_BOSS_RIGHT = "Riquadri per i bosses sulla destra"
L_GUI_UF_SHOW_ARENA = "Mostra i riquadri per l'arena"
L_GUI_UF_ARENA_RIGHT = "Riquadri per l'arena sulla destra"
L_GUI_UF_BOSS_DEBUFFS = "Number of debuffs" -- Need review
L_GUI_UF_BOSS_DEBUFFS_DESC = "Numero di penalità sui riquadri dei bosses"
L_GUI_UF_BOSS_BUFFS = "Number of buffs" -- Need review
L_GUI_UF_BOSS_BUFFS_DESC = "Numero di benefici sui riquadri dei bosses"
L.unitframe_icons_pvp = "PvP status text" -- Need review
L.unitframe_icons_pvp_desc = "Testo PvP (senza icona) al passaggio del mouse sui riquadri di giocatore e bersaglio"
L_GUI_UF_ICONS_COMBAT = "Icona di status 'in combattimento'"
L_GUI_UF_ICONS_RESTING = "Icona 'Riposato' per personaggi di basso livello"
L_GUI_UF_SUBHEADER_PORTRAIT = "Portraits" -- Need review
L_GUI_UF_PORTRAIT_ENABLE = "Attiva ritratti per giocatore e bersaglio"
L_GUI_UF_PORTRAIT_CLASSCOLOR_BORDER = "Bordi dei ritratti colorati in base alla classe"
L_GUI_UF_PORTRAIT_HEIGHT = "Altezza del ritratto"
L_GUI_UF_PORTRAIT_WIDTH = "Larghezza del ritratto"
L_GUI_UF_SUBHEADER_PLUGINS = "Plugins" -- Need review
L_GUI_UF_PLUGINS_GCD = "Scintilla del recupero globale"
L_GUI_UF_PLUGINS_SWING = "Attiva la barra dei fendenti"
L.unitframe_plugins_reputation_bar = "Reputation bar" -- Need review
L.unitframe_plugins_reputation_bar_desc = "Attiva la barra reputazioni" -- Need review
L.unitframe_plugins_experience_bar = "Experience bar" -- Need review
L.unitframe_plugins_experience_bar_desc = "Attiva la barra esperienza" -- Need review
L_GUI_UF_PLUGINS_SMOOTH_BAR = "Barra a cambiamento graduale"
L_GUI_UF_PLUGINS_ENEMY_SPEC = "Mostra la specializzazione dei talenti del nemico"
L_GUI_UF_PLUGINS_COMBAT_FEEDBACK = "Testo di combattimento sul riquadro del giocatore/bersaglio"
L_GUI_UF_PLUGINS_FADER = "Sfuma i riquadri delle unità"
L_GUI_UF_PLUGINS_DIMINISHING = "Diminuzione dell'effetto (diminishing return) sulle icone dei riquadri d'arena"
L_GUI_UF_PLUGINS_POWER_PREDICTION = "Previsione del costo in potere sulla barra del riquadro del giocatore"
L.unitframe_plugins_absorbs = "Absorbs value on player frame" -- Need review
L.unitframe_subheader_player_width = "Player and target frame size" -- Need review
L.unitframe_player_width = "Width" -- Need review
L.unitframe_subheader_boss_width = "Boss and arena frame size" -- Need review
L.unitframe_extra_height_auto = "Auto height for health/power" -- Need review
L.unitframe_extra_height_auto_desc = "Smart adjust depending on font size" -- Need review
L.unitframe_extra_health_height = "Additional height for health" -- Need review
L.unitframe_extra_power_height = "Additional height for power" -- Need review
L.unitframe_subheader_castbar = "Size of player and target castbar" -- Need review
L.unitframe_castbar_height = "Height" -- Need review

-- Unit Frames Class bar options
L_GUI_UF_PLUGINS_CLASS_BAR = "Barre di classe"
L_GUI_UF_PLUGINS_CLASS_BAR_SUBTEXT = "Control of special class resources." -- Need review
L_GUI_UF_PLUGINS_COMBO_BAR = "Icone punti combo per druido e ladro"
L_GUI_UF_PLUGINS_COMBO_BAR_ALWAYS = "Mostra sempre la barra combo per il druido"
L_GUI_UF_PLUGINS_COMBO_BAR_OLD = "Mostra i punti combo sul bersaglio"
L_GUI_UF_PLUGINS_ARCANE_BAR = "Attiva la barra carica arcana"
L_GUI_UF_PLUGINS_CHI_BAR = "Attiva la barra di classe del monaco"
L_GUI_UF_PLUGINS_STAGGER_BAR = "Attiva la barra noncuranza (per i monaci difensori)"
L_GUI_UF_PLUGINS_HOLY_BAR = "Attiva la barra di classe del paladino"
L_GUI_UF_PLUGINS_SHARD_BAR = "Attiva la barra di classe dello stregone"
L_GUI_UF_PLUGINS_RUNE_BAR = "Attiva la barra di classe del cavaliere della morte"
L_GUI_UF_PLUGINS_TOTEM_BAR = "Attiva la barra dei totems dello sciamano"

-- Raid Frames options
L_GUI_UF_RAIDFRAMES_SUBTEXT = "Customize the appearance of the raid frames." -- Need review
L_GUI_UF_BY_ROLE = "Suddividi i giocatori in gruppo a seconda del ruolo"
L_GUI_UF_AGGRO_BORDER = "Cambio di colore dei bordi in base al grado di aggressione"
L_GUI_UF_DEFICIT_HEALTH = "Deficit salute in incursione"
L_GUI_UF_SHOW_PARTY = "Mostra i riquadri del gruppo"
L_GUI_UF_SHOW_RAID = "Mostra i riquadri d'incursione"
L.raidframe_show_target = "Show target frames" -- Needs review
L.raidframe_show_pet = "Show pet frames" -- Needs review
L.raidframe_vertical_health = "Orientamento verticale della salute"
L.raidframe_vertical_health_desc = "Only for heal layout" -- Needs review
L_GUI_UF_ALPHA_HEALTH = "Trasparenza delle barre della salute quando i punti sono al 100%"
L_GUI_UF_SHOW_RANGE = "Abilita l'opacità dei riquadri d'incursione in base alla distanza"
L_GUI_UF_RANGE_ALPHA = "Alpha" -- Need review
L_GUI_UF_RANGE_ALPHA_DESC = "Trasparenza dei riquadri delle unità quando un'unità è fuori portata"
L_GUI_UF_SUBHEADER_RAIDFRAMES = "Frames" -- Need review
L_GUI_UF_SOLO_MODE = "Mostra sempre il riquadro del giocatore"
L_GUI_UF_PLAYER_PARTY = "Mostra il riquadro del giocatore in gruppo"
L_GUI_UF_SHOW_TANK = "Mostra i difensori dell'incursione"
L_GUI_UF_SHOW_TANK_TT = "Mostra il bersaglio del bersaglio dei difensori dell'incursione"
L_GUI_UF_RAID_GROUP = "Numero dei gruppi nell'incursione"
L.raidframe_party_vertical = "Vertical party frames" -- Needs review
L.raidframe_raid_groups_vertical = "Gruppi dell'incursione verticali" -- Needs review
L.raidframe_raid_groups_vertical_desc = "Gruppi dell'incursione verticali (solo per la Disposizione da Guaritore)" -- Needs review
L_GUI_UF_SUBHEADER_ICONS = "Icons" -- Need review
L_GUI_UF_ICONS_ROLE = "Icona del ruolo sui riquadri"
L_GUI_UF_ICONS_RAID_MARK = "Marchi d'incursione"
L_GUI_UF_ICONS_READY_CHECK = "Icone dell'appello"
L_GUI_UF_ICONS_LEADER = "Icona del capoincursione, dell'assistente"
L_GUI_UF_ICONS_SUMON = "Icone d’evocazione sui riquadri"
L.raidframe_icons_phase = "Phase" -- Need review
L_GUI_UF_PLUGINS_DEBUFFHIGHLIGHT_ICON = "Evidenzia texture + icona delle penalità"
L_GUI_UF_PLUGINS_AURA_WATCH = "Icone delle penalità d'incursione"
L_GUI_UF_PLUGINS_AURA_WATCH_TIMER = "Timer sulle icone delle penalità d'incursione"
L_GUI_UF_PLUGINS_PVP_DEBUFFS = "Mostra anche un’icona per le penalità PvP (dall’elenco)"
L_GUI_UF_PLUGINS_HEALCOMM = "Mostra le cure in arrivo sul riquadro"
L.raidframe_plugins_auto_resurrection = "Auto cast resurrection" -- Need review
L.raidframe_plugins_auto_resurrection_desc = "'Auto-lancia' resurrezione col tasto centrale quando l'unità è morta (non funziona con Clique attiva)"
L.raidframe_hide_health_value = "Hide raid health value" -- Needs review
L.raidframe_auto_position = "Auto reposition raid frame" -- Need review
L.raidframe_auto_position_desc = "If there are more than 5 groups, the frame points changes. \nOnly for heal layout" -- Need review
L.raidframe_auto_position_dynamic = "Dynamic" -- Need review
L.raidframe_auto_position_static = "Static" -- Need review
L.raidframe_subheader_heal_size = "Size for heal layout" -- Need review
L.raidframe_heal_width = "Frame width" -- Need review
L.raidframe_heal_height = "Frame height" -- Need review
L.raidframe_heal_power_height = "Power height" -- Need review
L.raidframe_subheader_dps_size = "Size for dps layout" -- Need review
L.raidframe_dps_party_width = "Party width" -- Need review
L.raidframe_dps_party_height = "Party height" -- Need review
L.raidframe_dps_raid_width = "Raid width" -- Need review
L.raidframe_dps_raid_height = "Raid height" -- Need review
L.raidframe_dps_party_power_height = "Party power height" -- Need review
L.raidframe_dps_raid_power_height = "Raid power height" -- Need review

-- ActionBar options
L_GUI_ACTIONBAR = "Barre delle azioni"
L_GUI_ACTIONBAR_ENABLE = "Attiva le barre delle azioni"
L_GUI_ACTIONBAR_HOTKEY = "Mostra i nomi dei tasti di scelta rapida sugli scomparti"
L_GUI_ACTIONBAR_MACRO = "Mostra i nomi delle macro sugli scomparti"
L_GUI_ACTIONBAR_GRID = "Mostra lo sfondo degli scomparti vuoti sulle barre delle azioni"
L_GUI_ACTIONBAR_BUTTON_SIZE = "Dimensioni degli scomparti"
L_GUI_ACTIONBAR_BUTTON_SPACE = "Spazio tra gli scomparti"
L_GUI_ACTIONBAR_SPLIT_BARS = "Dividi la quinta barra in 2 barre da 6 scomparti ciascuna"
L_GUI_ACTIONBAR_CLASSCOLOR_BORDER = "Colora i bordi degli scomparti con i colori delle classi"
L.actionbar_toggle_mode = "Attiva la modalità a scomparsa"
L.actionbar_toggle_mode_desc = "The quick change in the number of panels. For the lower panels, hover the mouse over the hidden area above the panels. For right panels, hover the mouse over the area below the panels." -- Need review
L_GUI_ACTIONBAR_HIDE_HIGHLIGHT = "Nascondi il lumeggiare (highlight) di un proc."
L_GUI_ACTIONBAR_BOTTOMBARS = "Numero delle barre delle azioni in basso"
L_GUI_ACTIONBAR_RIGHTBARS = "Numero di barre delle azioni sulla destra"
L.actionbar_bottombars_mouseover = "Bottom bars on mouseover" -- Needs review
L_GUI_ACTIONBAR_RIGHTBARS_MOUSEOVER = "Barre sulla destra al passaggio del mouse"
L_GUI_ACTIONBAR_PETBAR_HIDE = "Nascondi la barra famiglio"
L_GUI_ACTIONBAR_PETBAR_HORIZONTAL = "Rendi orizzontale la barra famiglio"
L_GUI_ACTIONBAR_PETBAR_MOUSEOVER = "Barra famiglio al passaggio del mouse (solo con la barra famiglio orizzontale)"
L_GUI_ACTIONBAR_STANCEBAR_HIDE = "Nascondi barra postura"
L_GUI_ACTIONBAR_STANCEBAR_HORIZONTAL = "Rendi orizzontale la barra postura"
L.actionbar_stancebar_horizontal_desc = "Located below the player's frame" -- Needs review
L_GUI_ACTIONBAR_STANCEBAR_MOUSEOVER = "Barra postura al passaggio del mouse"
L_GUI_ACTIONBAR_MICROMENU = "Attiva il micromenu"
L_GUI_ACTIONBAR_MICROMENU_MOUSEOVER = "Micromenu al passaggio del mouse"
L.actionbar_editor = "Bars editor" -- Needs review
L.actionbar_editor_desc = "Allow to move and change each panel individually" -- Needs review
L.actionbar_bar1_num = "Number of buttons" -- Needs review
L.actionbar_bar1_row = "Buttons per row" -- Needs review
L.actionbar_bar1_mouseover = "Bar on mouseover" -- Needs review

-- Tooltip options
L.tooltip = "Suggerimenti"
L.tooltip_subtext = "In this block, you can change the standard tips when mouseovering." -- Need review
L.tooltip_enable = "Attiva i suggerimenti"
L.tooltip_shift_modifer = "Mostra i suggerimenti quando è premuto il tasto Shift"
L.tooltip_cursor = "Suggerimenti sopra il cursore"
L.tooltip_item_icon = "Icone degli oggetti nei suggerimenti"
L.tooltip_health_value = "Valore numerico della salute"
L.tooltip_hidebuttons = "Nascondi i suggerimenti relativi alle barre delle azioni"
L.tooltip_hide_combat = "Nascondi i suggerimenti in combattimento"
L.tooltip_subheader = "Plugins" -- Need review
L.tooltip_talents = "Mostra i talenti nei suggerimenti"
L.tooltip_show_shift = "Show when Shift is pushed" -- Need review
L.tooltip_show_shift_desc = "Show items level and spec when Shift is pushed" -- Need review
L.tooltip_achievements = "Mostra il paragone delle imprese nei suggerimenti"
L.tooltip_target = "Mostra nei suggerimenti chi ha il giocatore come bersaglio"
L.tooltip_title = "Titolo del giocatore nei suggerimenti"
L.tooltip_realm = "Reame del giocatore nei suggerimenti"
L.tooltip_rank = "Rango in gilda nei suggerimenti"
L.tooltip_spell_id = "ID Incantesimo/Abilità"
L.tooltip_average_lvl_desc = "The average item level" -- Need review
L.tooltip_raid_icon = "Visualizza i marchi d'incursione nei suggerimenti"
L.tooltip_who_targetting = "Visualizza chi ha in bersaglio l'unità che è nel tuo gruppo/incursione"
L.tooltip_item_count = "Conteggio oggetti"
L.tooltip_unit_role = "Ruolo dell'unità"
L.tooltip_instance_lock = "Info incursione nei suggerimenti"
L.tooltip_mount = "Source of mount" -- Needs review

-- Chat options
L_GUI_CHAT_SUBTEXT = "Here you can change the settings of the chat window." -- Need review
L_GUI_CHAT_ENABLE = "Attiva chat"
L_GUI_CHAT_BACKGROUND = "Attiva lo sfondo della chat"
L_GUI_CHAT_BACKGROUND_ALPHA = "Trasparenza sfondo della chat"
L_GUI_CHAT_SPAM = "Rimozione di un po' di spam di sistema ('Giocatore1' sconfigge 'Giocatore2' in un duello.)"
L_GUI_CHAT_GOLD = "Rimozione di un po' di spam degli altri giocatori"
L.chat_spam_list = "Black list" -- Need review
L.chat_spam_list_desc = "List of words (separated by space, lowercase letters) to hide messages" -- Need review
L_GUI_CHAT_WIDTH = "Larghezza chat"
L_GUI_CHAT_HEIGHT = "Altezza chat"
L_GUI_CHAT_BAR = "Barra con pulsanti per passare velocemente da un canale all'altro della chat"
L_GUI_CHAT_BAR_MOUSEOVER = "Barra canali chat al passaggio del mouse"
L_GUI_CHAT_WHISP = "Suono quando ricevi un sussurro"
L_GUI_CHAT_SKIN_BUBBLE = "Restyling dei fumetti delle chats"
L_GUI_CHAT_CL_TAB = "Mostra la linguetta del Registro di combattimento"
L_GUI_CHAT_TABS_MOUSEOVER = "Linguette delle chats al passaggio del mouse"
L_GUI_CHAT_STICKY = "Ricorda l'ultimo canale"
L_GUI_CHAT_DAMAGE_METER_SPAM = "Riunisce lo spam di un contatore dei danni in un singolo link"
L.chat_loot_icons = "Icons for loot" -- Needs review
L.chat_custom_time_color = "Enable custom timestamp coloring" -- Needs review
L.chat_time_color = "Colorazione orario dei messaggi"

-- Nameplate options
L_GUI_NAMEPLATE_SUBTEXT = "Nameplate settings" -- Need review
L_GUI_NAMEPLATE_ENABLE = "Attiva le barre delle unità"
L_GUI_NAMEPLATE_COMBAT = "Mostra automaticamente le barre delle unità in combattimento"
L_GUI_NAMEPLATE_HEALTH = "Valore numerico della salute"
L_GUI_NAMEPLATE_HEIGHT = "Altezza delle barre delle unità"
L_GUI_NAMEPLATE_WIDTH = "Larghezza delle barre delle unità"
L.nameplate_alpha = "Alpha" -- Needs review
L.nameplate_alpha_desc = "Non-target nameplate alpha" -- Needs review
L.nameplate_ad_height = "Additional height" -- Need review
L.nameplate_ad_width = "Additional width" -- Need review
L.nameplate_ad_height_desc = "Additional height for selected nameplate" -- Needs review
L.nameplate_ad_width_desc = "Additional width for selected nameplate" -- Needs review
L_GUI_NAMEPLATE_CASTBAR_NAME = "Mostra il nome di incantesimi/abilità sulle barre incantesimi"
L_GUI_NAMEPLATE_CLASS_ICON = "Icone delle classi in PvP"
L_GUI_NAMEPLATE_NAME_ABBREV = "Mostra nomi abbreviati"
L_GUI_NAMEPLATE_CLAMP = "Aggancia le barre delle unità in cima allo schermo quando sono fuori portata visiva"
L_GUI_NAMEPLATE_SHOW_DEBUFFS = "Mostra le penalità sulle barre delle unità (l'ozpione 'Mostra nomi abbreviati' deve essere disabilitata)"
L_GUI_NAMEPLATE_SHOW_BUFFS = "Show dispellable enemy buffs and buffs from the list" -- Need review
L_GUI_NAMEPLATE_DEBUFFS_SIZE = "Dimensioni delle penalità sulle barre delle unità" -- Need review
L_GUI_NAMEPLATE_HEALER_ICON = "Nei Campi di Battaglia, mostra un'icona 'guaritore' accanto alle barre delle unità di tutti i guaritori nemici"
L_GUI_NAMEPLATE_TOTEM_ICONS = "Mostra un’icona sopra la barra dei totem nemici"
L.nameplate_target_glow = "Show glow texture for target" -- Need review
L.nameplate_only_name = "Show only name for friendly units" -- Need review
L.nameplate_quests = "Show quest icon" -- Need review
L.nameplate_cast_color = "Show color border for casting important spells" -- Need review
L.nameplate_low_health_value = "Health value" -- Need review
L.nameplate_low_health = "Low health highlight" -- Need review
L_GUI_NAMEPLATE_THREAT = "Attiva il sensore di rilevamento minaccia (si adatta automaticamente al tuo ruolo)"
L_GUI_NAMEPLATE_GOOD_COLOR = "Colore se il PG è minacciato (in base a difensore o assaltatore/guaritore)"
L_GUI_NAMEPLATE_NEAR_COLOR = "Colore per perdita/guadagno minaccia"
L_GUI_NAMEPLATE_BAD_COLOR = "Colore se il PG non è minacciato (se difensore o assaltatore/guaritore)"
L_GUI_NAMEPLATE_OFFTANK_COLOR = "Colore della minaccia per il difensore secondario"
L.nameplate_extra_color = "Explosive and Spiteful affix color" -- Need review

-- Combat text options
L_GUI_COMBATTEXT = "Testo di combattimento"
L_GUI_COMBATTEXT_SUBTEXT = "For moving type in the chat '/xct'" -- Need review
L_GUI_COMBATTEXT_ENABLE = "Attiva il testo di combattimento"
L.combattext_blizz_head_numbers = "Enable Blizzard combat text" -- Need review
L.combattext_blizz_head_numbers_desc = "Usa il testo di combattimento della Blizzard per danni/cure"
L.combattext_damage_style = "Change default combat font" -- Need review
L.combattext_damage_style_desc = "Cambia il carattere di base per danni/cure (è necessario riavviare il gioco)"
L_GUI_COMBATTEXT_DAMAGE = "Mostra i danni in un proprio riquadro dedicato"
L_GUI_COMBATTEXT_HEALING = "Mostra le cure in un proprio riquadro dedicato"
L.combattext_incoming = "Show incoming damage and healing" -- Need review
L_GUI_COMBATTEXT_HOTS = "Mostra gli effetti delle cure periodiche nel riquadro delle cure"
L_GUI_COMBATTEXT_OVERHEALING = "Mostra le cure in eccesso"
L_GUI_COMBATTEXT_PET_DAMAGE = "Mostra i danni del tuo famiglio"
L_GUI_COMBATTEXT_DOT_DAMAGE = "Mostra i tuoi danni nel tempo"
L_GUI_COMBATTEXT_DAMAGE_COLOR = "Colora i numeri dei danni in base alla scuola di magia"
L_GUI_COMBATTEXT_CRIT_PREFIX = "Simbolo che sarà aggiunto prima dei critici"
L_GUI_COMBATTEXT_CRIT_POSTFIX = "Simbolo che sarà aggiunto dopo i critici"
L_GUI_COMBATTEXT_ICONS = "Mostra le icone dei danni"
L_GUI_COMBATTEXT_ICON_SIZE = "Icon size" -- Need review
L_GUI_COMBATTEXT_ICON_SIZE_DESC = "Dimensioni icone danni (influenza anche le dimensioni del carattere dei danni)"
L_GUI_COMBATTEXT_TRESHOLD = "Danno minimo da mostrare nel riquadro dei danni"
L_GUI_COMBATTEXT_HEAL_TRESHOLD = "Cure minime da mostrare nei messaggi delle cure"
L_GUI_COMBATTEXT_SCROLLABLE = "Attiva la 'modalità scorrimento': consente di scorrere tra le righe dei riquadri con la rotellina del mouse"
L_GUI_COMBATTEXT_MAX_LINES = "Max lines" -- Need review
L_GUI_COMBATTEXT_MAX_LINES_DESC = "Massimo numero righe da ricordare in 'scorrimento' (più righe = più memoria)"
L_GUI_COMBATTEXT_TIME_VISIBLE = "Time" -- Need review
L_GUI_COMBATTEXT_TIME_VISIBLE_DESC = "Tempo (in secondi) in cui un singolo messaggio sarà visibile"
L_GUI_COMBATTEXT_DK_RUNES = "Mostra la ricarica delle rune dei cavalieri della morte"
L_GUI_COMBATTEXT_KILLINGBLOW = "Comunica i tuoi colpi di grazia"
L_GUI_COMBATTEXT_MERGE_AOE_SPAM = "Unisci lo spam per danni multipli a più bersagli in un singolo messaggio"
L_GUI_COMBATTEXT_MERGE_MELEE = "Unifica lo spam di attacchi automatici multipli"
L_GUI_COMBATTEXT_DISPEL = "Comunica le tue dissoluzioni (dispels)"
L_GUI_COMBATTEXT_INTERRUPT = "Comunica le tue interruzioni (interrupts)"
L_GUI_COMBATTEXT_DIRECTION = "Change scrolling direction from bottom to top" -- Need review
L_GUI_COMBATTEXT_SHORT_NUMBERS = "Usa abbreviazioni numeriche ('25.3k' invece di '25342')"

-- Auras/Buffs/Debuffs
L_GUI_AURA_PLAYER_BUFF_SIZE = "Buffs size" -- Need review
L_GUI_AURA_PLAYER_BUFF_SIZE_DESC = "Dimensione benefici giocatore"
L.aura_player_debuff_size = "Debuffs size" -- Need review
L_GUI_AURA_SHOW_SPIRAL = "Spirale trascorrere tempo sulle icone delle auree"
L_GUI_AURA_SHOW_TIMER = "Mostra il timer del recupero sulle icone delle auree"
L_GUI_AURA_PLAYER_AURAS = "Auree sul riquadro del giocatore"
L_GUI_AURA_TARGET_AURAS = "Auree sul riquadro del bersaglio"
L_GUI_AURA_FOCUS_DEBUFFS = "Penalità sul riquadro del focus"
L_GUI_AURA_FOT_DEBUFFS = "Penalità sul riquadro del bersaglio del focus"
L_GUI_AURA_PET_DEBUFFS = "Penalità sul riquadro del famiglio"
L_GUI_AURA_TOT_DEBUFFS = "Penalità sul riquadro del bersaglio del bersaglio"
L.aura_boss_buffs = "Benefici sul riquadro del boss" -- Need review
L_GUI_AURA_PLAYER_AURA_ONLY = "Mostra solo le tue penalità sul riquadro del bersaglio"
L_GUI_AURA_DEBUFF_COLOR_TYPE = "Colora le penalità a seconda del tipo"
L_GUI_AURA_CAST_BY = "Mostra chi ha lanciato un beneficio o una penalità nei suggerimenti"
L_GUI_AURA_CLASSCOLOR_BORDER = "Colora i bordi dei benefici del giocatore in base al colore della classi"

-- Bag options
L_GUI_BAGS = "Sacche"
L_GUI_BAGS_SUBTEXT = "Right click on the close button to open the menu. To move the bags, hold down Shift - click." -- Need review
L_GUI_BAGS_ENABLE = "Attiva le sacche"
L_GUI_BAGS_ILVL = "Mostra il livello oggetto di armi e armature"
L.bag_new_items = "Show animation for new items" -- Need review
L_GUI_BAGS_BUTTON_SIZE = "Dimensioni degli scomparti"
L_GUI_BAGS_BUTTON_SPACE = "Spazio tra gli scomparti"
L_GUI_BAGS_BANK = "Numero di colonne in banca"
L_GUI_BAGS_BAG = "Numero di colonne nella sacca principale"

-- Minimap options
L_GUI_MINIMAP_SUBTEXT = "Minimap settings." -- Need review
L_GUI_MINIMAP_ENABLE = "Attiva la minimappa"
L_GUI_MINIMAP_ICON = "Icona tracciamento"
L_GUI_GARRISON_ICON = "Icona della guarnigione" -- Need review
L_GUI_MINIMAP_SIZE = "Dimensioni della minimappa"
L_GUI_MINIMAP_HIDE_COMBAT = "Nascondi la minimappa in combattimento"
L_GUI_MINIMAP_TOGGLE_MENU = "Mostra il menu a scomparsa"
L.minimap_bg_map_stylization = "Restyling della mappa dei Campi di Battaglia"
L.minimap_fog_of_war = "Nebbia della guerra sulla mappa del mondo"

-- Loot options
L_GUI_LOOT_SUBTEXT = "Settings for loot frame." -- Need review
L_GUI_LOOT_ENABLE = "Attiva il riquadro bottino"
L_GUI_LOOT_ROLL_ENABLE = "Attiva il riquadro del bottino di gruppo"
L_GUI_LOOT_ICON_SIZE = "Dimensioni delle icone"
L_GUI_LOOT_WIDTH = "Larghezza del riquadro bottino"
L_GUI_LOOT_AUTOGREED = "A livello massimo, attiva automaticamente la bramosia per gli oggetti verdi"
L_GUI_LOOT_AUTODE = "'Auto-conferma' il disincantamento degli oggetti"
L.loot_faster_loot = "Faster looting" -- Need review
L.loot_faster_loot_desc = "Works only if enabled auto loot" -- Need review

-- Filger
L_GUI_FILGER = "Timers (Filger)"
L_GUI_FILGER_SUBTEXT = "Filger - analogue WeakAuras, but more simple and easy. Allows you to display in the form of icons and bars your auras and timers." -- Need review
L_GUI_FILGER_ENABLE = "Attiva Filger"
L_GUI_FILGER_TEST_MODE = "Modalità di prova delle icone"
L_GUI_FILGER_MAX_TEST_ICON = "Il numero di icone da sottoporre alla prova"
L_GUI_FILGER_SHOW_TOOLTIP = "Mostra suggerimenti"
L.filger_subheader_elements = "Showing elements" -- Need review
L.filger_show_buff = "Player buffs" -- Need review
L.filger_show_proc = "Player procs" -- Need review
L.filger_show_debuff = "Debuffs on target" -- Need review
L.filger_show_aura_bar = "Aura bars on target" -- Need review
L.filger_show_special = "Special buffs on player" -- Need review
L.filger_show_pvp_player = "SPvP debuffs on player" -- Need review
L.filger_show_pvp_target = "PvP auras on target" -- Need review
L.filger_show_cd = "Cooldowns" -- Need review
L.filger_subheader_size = "Icons size" -- Need review
L.filger_subheader_test = "Test mode" -- Need review
L_GUI_FILGER_EXPIRATION = "Sort cooldowns by expiration time" -- Need review
L_GUI_FILGER_BUFFS_SIZE = "Dimensione dei benefici"
L_GUI_FILGER_COOLDOWN_SIZE = "Dimensione dei recuperi"
L_GUI_FILGER_PVP_SIZE = "Dimensione delle penalità PvP"
L.filger_buffs_space = "Buffs space" -- Need review
L.filger_pvp_space = "PvP auras space" -- Need review
L.filger_cooldown_space = "Cooldowns space" -- Need review
L.filger_subheader_spells = "Adding new spells" -- Need review
L.filger_category_list = "Spell list category" -- Need review

-- Announcements options
L_GUI_ANNOUNCEMENTS = "Annunci"
L_GUI_ANNOUNCEMENTS_SUBTEXT = "Settings that add chat announcements about spells or items." -- Need review
L_GUI_ANNOUNCEMENTS_DRINKING = "Annuncia in chat quando un nemico in arena sta bevendo"
L_GUI_ANNOUNCEMENTS_INTERRUPTS = "Annuncia in gruppo/incursione quando tu interrompi un incantesimo/abilità"
L_GUI_ANNOUNCEMENTS_SPELLS = "Annuncia in gruppo/incursione quando usi alcuni incantesimi/abilità"
L_GUI_ANNOUNCEMENTS_SPELLS_FROM_ALL = "Controlla incantesimi/abilità lanciati da tutti i compagni di gruppo/incursione"
L_GUI_ANNOUNCEMENTS_TOY_TRAIN = "Annuncia l'uso del Trenino Giocattolo o del Telecomando di Birranera"
L_GUI_ANNOUNCEMENTS_PULL_COUNTDOWN = "Annuncia il conto alla rovescia di avvio incontro '/pc #'"
L_GUI_ANNOUNCEMENTS_FLASK_FOOD = "Annuncia l'uso di tonici e cibo (/ffcheck)"
L_GUI_ANNOUNCEMENTS_FLASK_FOOD_RAID = "Annuncia l'uso di cibi e tonici nel canale incursione"
L_GUI_ANNOUNCEMENTS_FLASK_FOOD_AUTO = "Annuncia automaticamente l'uso di cibi e tonici all'appello" -- Needs review
L_GUI_ANNOUNCEMENTS_FEASTS = "Annuncia l'uso di tripudi/calderoni/anime/robots per le riparazioni"
L_GUI_ANNOUNCEMENTS_PORTALS = "Annuncia l'uso di un portale/Rituale d'Evocazione"
L.announcements_bad_gear = "Check your bad gear" -- Need review
L.announcements_bad_gear_desc = "Controlla l'equip. non idoneo in instance"
L_GUI_ANNOUNCEMENTS_SAFARI_HAT = "Controlla se il Cappello da Safari sia indossato o meno"

-- Automation options
L_GUI_AUTOMATION = "Automatismi"
L_GUI_AUTOMATION_SUBTEXT = "This block contains settings that facilitate the routine." -- Need review
L.automation_release = "'Auto-risorgi' nei Campi di Battaglia"
L.automation_screenshot = "Cattura una schermata quando completi un'impresa"
L.automation_solve_artifact = "Popup automatico restauro manufatto"
L.automation_solve_artifact_desc = "If there are enough fragments for an artifact, a popup will appear to solve it." -- Need review
L.automation_accept_invite = "'Auto-accetta' gli inviti"
L.automation_decline_duel = "'Auto-declina' i duelli"
L.automation_accept_quest = "'Auto-accetta' le missioni"
L.automation_auto_collapse = "Auto collapse Objective Tracker" -- Need review
L.automation_auto_collapse_raid = "In Instance" -- Need review
L.automation_auto_collapse_reload = "After reload" -- Need review
L.automation_skip_cinematic = "'Auto-salta' i filmati"
L.automation_auto_role = "'Auto-imposta' il tuo ruolo"
L.automation_cancel_bad_buffs = "'Auto-cancella' alcuni benefici"
L.automation_tab_binder = "Usando il tasto TAB, consente di prendere come bersaglio soltanto nemici controllati da altri giocatori (se presenti)"
L.automation_tab_binder_desc = "'Tab' key target only enemy players when in PvP zones, ignores pets and mobs" -- Need review
L.automation_logging_combat = "In instances da incursione, 'auto-attiva' la registrazione del Registro di combattimento in un file di testo"
L.automation_buff_on_scroll = "Lancia benefici con la rotellina del mouse"
L.automation_buff_on_scroll_desc = "If the buff from the list is not applied to the player, it will cast by the mouse scroll" -- Need review
L.automation_open_items = "Apertura automatica degli oggetti nelle sacche"
L.automation_resurrection = "Confirm resurrection" -- Needs review
L.automation_summon = "Confirm summon" -- Needs review
L.automation_whisper_invite = "Auto invite when whisper keyword" -- Needs review
L.automation_invite_keyword = "List of keyword (separated by space)" -- Needs review
L.automation_invite_keyword_desc = "When player whisper you keyword he will be invited in your group" -- Needs revieww

-- Buffs reminder options
L_GUI_REMINDER = "Promemoria benefici"
L_GUI_REMINDER_SUBTEXT = "Display of missed auras." -- Need review
L_GUI_REMINDER_SOLO_ENABLE = "Mostra i propri benefici mancanti"
L_GUI_REMINDER_SOLO_SOUND = "Attiva un suono d'avviso per il promemoria dei propri benefici mancanti"
L_GUI_REMINDER_SOLO_SIZE = "Icon size" -- Need review
L_GUI_REMINDER_SOLO_SIZE_DESC = "Dimensione dell'icona dei propri benefici"
L_GUI_REMINDER_SUBHEADER = "Raid buffs" -- Need review
L_GUI_REMINDER_RAID_ENABLE = "Mostra i benefici d'incursione mancanti"
L_GUI_REMINDER_RAID_ALWAYS = "Mostra sempre il promemoria benefici"
L_GUI_REMINDER_RAID_SIZE = "Icon size" -- Need review
L_GUI_REMINDER_RAID_SIZE_DESC = "Dimensioni delle icone del promemoria benefici d'incursione"
L_GUI_REMINDER_RAID_ALPHA = "Transparent" -- Need review
L_GUI_REMINDER_RAID_ALPHA_DESC = "Trasparenza icona quando il beneficio è presente"

-- Raid cooldowns options
L_GUI_COOLDOWN_RAID = "Recuperi d'incursione"
L_GUI_COOLDOWN_RAID_SUBTEXT = "Tracking raid abilities in the upper left corner." -- Need review
L_GUI_COOLDOWN_RAID_ENABLE = "Visualizza i recuperi d'incursione"
L_GUI_COOLDOWN_RAID_HEIGHT = "Bars height" -- Need review
L_GUI_COOLDOWN_RAID_WIDTH = "Bars width" -- Need review
L_GUI_COOLDOWN_RAID_SORT = "Disposizione verso l'alto delle barre dei recuperi d'incursione"
L_GUI_COOLDOWN_RAID_EXPIRATION = "Ordina in base al tempo di scadenza"
L_GUI_COOLDOWN_RAID_SHOW_SELF = "Mostra i miei recuperi"
L_GUI_COOLDOWN_RAID_ICONS = "Icone dei recuperi d'incursione"
L_GUI_COOLDOWN_RAID_IN_RAID = "Mostra i recuperi d'incursione nelle aree da incursione"
L_GUI_COOLDOWN_RAID_IN_PARTY = "Mostra i recuperi d'incursione nelle aree da gruppo"
L_GUI_COOLDOWN_RAID_IN_ARENA = "Mostra i recuperi d'incursione nelle aree da arena"

-- Enemy cooldowns options
L_GUI_COOLDOWN_ENEMY = "Recuperi del nemico"
L_GUI_COOLDOWN_ENEMY_SUBTEXT = "Tracking enemy abilities as icons above your spell casting bar." -- Need review
L_GUI_COOLDOWN_ENEMY_ENABLE = "Visualizza i recuperi del nemico"
L_GUI_COOLDOWN_ENEMY_SIZE = "Dimensioni delle icone dei recuperi del nemico"
L_GUI_COOLDOWN_ENEMY_DIRECTION = "Direzione icone recuperi del nemico"
L_GUI_COOLDOWN_ENEMY_EVERYWHERE = "Mostra i recuperi del nemico in qualsiasi area"
L_GUI_COOLDOWN_ENEMY_IN_BG = "Mostra i recuperi del nemico nelle aree da Campo di Battaglia"
L_GUI_COOLDOWN_ENEMY_IN_ARENA = "Mostra i recuperi del nemico nelle aree da arena"
L.enemycooldown_show_inparty = "Show in party zone for allies" -- Need review
L.enemycooldown_class_color = "Enable classcolor border" -- Need review

-- Pulse cooldowns options
L_GUI_COOLDOWN_PULSE = "Recuperi effetto 'pulse'"
L_GUI_COOLDOWN_PULSE_SUBTEXT = "Track your cd using a pulse icon in the center of the screen." -- Need review
L_GUI_COOLDOWN_PULSE_ENABLE = "Mostra i recuperi con effetto 'pulse'"
L_GUI_COOLDOWN_PULSE_SIZE = "Dimensione dell'icona dei recuperi con effetto 'pulse'"
L_GUI_COOLDOWN_PULSE_SOUND = "Attiva un suono di avviso"
L_GUI_COOLDOWN_PULSE_ANIM_SCALE = "Regolazione dell'animazione"
L_GUI_COOLDOWN_PULSE_HOLD_TIME = "Opacità del tempo d'attesa massimo"
L_GUI_COOLDOWN_PULSE_THRESHOLD = "Threshold time" -- Need review
L_GUI_COOLDOWN_PULSE_THRESHOLD_DESC = "Soglia di tempo minimo"

-- Threat options
L_GUI_THREAT = "Barre di minaccia"
L_GUI_THREAT_SUBTEXT = "Display of the threat list (a simple analogue of Omen)." -- Need review
L_GUI_THREAT_ENABLE = "Attiva le barre di minaccia"
L_GUI_THREAT_HEIGHT = "Altezza delle barre di minaccia"
L_GUI_THREAT_WIDTH = "Larghezza delle barre di minaccia"
L_GUI_THREAT_ROWS = "Numero delle barre di minaccia"
L_GUI_THREAT_HIDE_SOLO = "Mostra soltanto in gruppo/incursione"

-- Top panel options
L_GUI_TOP_PANEL = "Pannello superiore"
L_GUI_TOP_PANEL_SUBTEXT = "Manage built-in top panel with information." -- Need review
L_GUI_TOP_PANEL_ENABLE = "Attiva il pannello superiore"
L_GUI_TOP_PANEL_MOUSE = "Pannello superiore al passaggio del mouse"
L_GUI_TOP_PANEL_WIDTH = "Larghezza pannello"
L_GUI_TOP_PANEL_HEIGHT = "Altezza pannello"

-- Stats options
L_GUI_STATS = "Stats"
L_GUI_STATS_SUBTEXT = "Statistics blocks located at the bottom of the screen. Type in the chat '/ls' for info." -- Need review
L_GUI_STATS_CLOCK = "Orologio"
L_GUI_STATS_LATENCY = "Latenza"
L_GUI_STATS_FPS = "Frames Per Seconds"
L_GUI_STATS_EXPERIENCE = "Esperienza"
L_GUI_STATS_TALENTS_DESC = "Date-text allows you to change the spec and loot on click" -- Need review
L_GUI_STATS_COORDS = "Coordinate"
L_GUI_STATS_LOCATION = "Località"
L_GUI_STATS_BG = "Campi di Battaglia"
L.stats_bottom_line = "Bottom classcolor line" -- Need review
L_GUI_STATS_SUBHEADER_CURRENCY = "Currency (displayed in gold data text)" -- Need review
L_GUI_STATS_CURRENCY_ARCHAEOLOGY = "Mostra i frammenti di archeologia sotto la linguetta della valuta"
L_GUI_STATS_CURRENCY_COOKING = "Mostra le ricompense di cucina sotto la linguetta della valuta"
L_GUI_STATS_CURRENCY_RAID = "Mostra i sigilli delle incursioni"

-- Trade options
L_GUI_TRADE = "Trade" -- Need review
L_GUI_TRADE_SUBTEXT = "Settings related to professions and trade" -- Need review"
L.trade_profession_tabs = "Professions tabs" -- Need review
L.trade_profession_tabs_desc = "Visualizza la linguetta delle professioni sul riquadro abilità di commercio/commercio"
L.trade_already_known = "Colorizes already known items" -- Need review
L.trade_already_known_desc = "Colora ricette/cavalcature/mascottes possedute"
L.trade_disenchanting = "Quick Disenchanting" -- Need review
L.trade_disenchanting_desc = "Disincantamento, Pestatura e Prospezione in un solo click"
L.trade_sum_buyouts = "Somma assieme tutte le aste correnti"
L.trade_sum_buyouts_desc = "At auctions tab shows sum up all current auctions" -- Need review
L.trade_enchantment_scroll = "Pergamena Incantamento sul riquadro sul riquadro abilità di commercio"
L.trade_archaeology = "Archeologia: reliquie e recuperi"
L.trade_archaeology_desc = "Archaeology tracker ('/arch' or right mouseover minimap button to show)" -- Need review
L.trade_merchant_itemlevel = "Item level in merchant" -- Need review
L.trade_merchant_itemlevel_desc = "Mostra il livello dell’oggetto di armi e armature in vendita"

-- Miscellaneous options
L_GUI_MISC_SUBTEXT = "Other settings that add interesting features." -- Need review
L.misc_shift_marking = "Marks mouseover target" -- Need review
L.misc_shift_marking_desc = "Marks mouseover target when you push Shift (only in group)" -- Need review
L.misc_afk_spin_camera = "Ruota la camera mentre sei assente"
L.misc_quest_auto_button = "Quest items auto button" -- Need review
L.misc_quest_auto_button_desc = "Pulsante automatico missione/oggetto" -- Need review
L.misc_raid_tools = "Strumenti per le incursioni"
L.misc_raid_tools_desc = "Button at the top of the screen for ready check (Left-click), checking roles (Middle-click), setting marks, etc. (for leader and assistants)" -- Need review
L.misc_item_level = "Item level on slot buttons" -- Need review
L.misc_item_level_desc = "Livello oggetto sugli scomparti della schermata Personaggio"
L.misc_click_cast = "Scorciatoie da mouse (Click2Cast)"
L.misc_click_cast_desc = "Allows you to assign spells (analog Clique) to the mouse buttons. Setup through the side bookmark in the spell book" -- Need review
L.misc_click_cast_filter = "Ignora i riquadri di giocatore e bersaglio con Click2Cast"
L.misc_chars_currency = "Traccia la valuta complessiva posseduta dai tuoi personaggi"
L.misc_chars_currency_desc = "Hover over the icon of the required currency in the character window to display information in the tooltip" -- Need review
L.misc_hide_raid_button = "Nascondi il pulsante di oUF_RaidDPS"
L.misc_hide_raid_button_desc = "The button is displayed by hovering the mouse in the upper left corner" -- Need review