local _, L = ...
if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end

----------------------------------------------------------------------------------------
--	Localization for esES and esMX client
--	Translation: eXecrate
----------------------------------------------------------------------------------------
L_GUI_SET_SAVED_SETTTINGS = "Cambios aplicables sólo a este PJ"
L_GUI_SET_SAVED_SETTTINGS_DESC = "Switch between a profile that applies to all characters and one that is unique to this character." -- Need review
L_GUI_RESET_CHAR = "¿Estás seguro de que quieres reiniciar tus preferencias de ShestakUI para este PJ?"
L_GUI_RESET_ALL = "¿Estás seguro de que quieres reiniciar tus preferencias de ShestakUI para todos los PJs?"
L_GUI_PER_CHAR = "¿Estás segudo de que quieres cambiar a o desde 'Cambios sólo a este PJ'?"
L_GUI_RESET_CAT = "Are you sure you want to reset category's settings?" -- Need review
L_GUI_RESET_CAT_DESC = "Reset category's settings. \nCTRL-click to reset all" -- Need review
L_GUI_NEED_RELOAD = "You need to reload the UI to apply your changes." -- Need review
L_GUI_LAYOUT = "Change layout" -- Need review
L_GUI_SPELL_LIST = "List of spells" -- Need review
L_GUI_SPELL_INPUT = "Spell ID" -- Need review
L_GUI_TIME_INPUT = "Time" -- Need review
L_GUI_EXPERT_MODE = "Expert mode" -- Need review
L_GUI_EXPERT_MODE_DESC = "Custom editing of Lua profile" -- Need review
L_GUI_RESET_SPELLS_DESC = "CTRL-click to reset list" -- Need review

-- General options
L_GUI_GENERAL_SUBTEXT = "These settings control the general user interface settings. Type in chat '/uihelp' for help." -- Need review
L_GUI_GENERAL_WELCOME_MESSAGE = "Mensaje de bienvenida en el chat"
L_GUI_GENERAL_AUTOSCALE = "Auto escalado de la UI"
L_GUI_GENERAL_UISCALE = "Escalado de la UI (si auto escalado está desactivado)"
L.general_subheader_blizzard = "Blizzard UI elements" -- Need review
L.general_error_filter = "Error filtering" -- Need review
L.general_error_blacklist = "Blacklist" -- Need review
L.general_error_whitelist = "Whitelist" -- Need review
L.general_error_combat = "In combat" -- Need review
L.general_error_none = "None" -- Need review
L.general_vehicle_mouseover = "Marco del Vehículo al pasar el ratón por encima"
L.general_move_blizzard = "Move some Blizzard frames" -- Needs review
L.general_color_picker = "Improved ColorPicker" -- Needs review
L.general_color_picker_desc = "Add copy/paste buttons and digit text entry for Blizzard color picker frame" -- Need review
L.general_minimize_mouseover = "Mouseover for quest minimize button" -- Need review
L.general_hide_banner = "Hide Boss Banner Loot Frame" -- Need review
L.general_hide_talking_head = "Hide Talking Head Frame" -- Need review

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
L_GUI_SKINS = "Estilización"
L_GUI_SKINS_SUBTEXT = "Change the appearance of the standard interface." -- Need review
L_GUI_SKINS_BLIZZARD = "Activar estilizado de marcos de Blizzard"
L_GUI_SKINS_MINIMAP_BUTTONS = "Activar estilizado de los iconos de los addons en el minimapa"
L_GUI_SKINS_SUBHEADER = "Stylization of addons" -- Need review
L_GUI_SKINS_DBM_MOVABLE = "Allow to move DBM bars" -- Need review
L.skins_minimap_buttons_mouseover = "Addons icons on mouseover" -- Need review

-- Unit Frames options
L_GUI_UF_SUBTEXT = "Customize player, target frames and etc." -- Need review
L_GUI_UF_ENABLE = "Activar marcos de unidades"
L_GUI_UF_OWN_COLOR = "Color para las barras de vida"
L_GUI_UF_UF_COLOR = "Color de las Barras de vida (si color para las barras de vida está activo)"
L.unitframe_uf_color_bg = "Color of health background" -- Need review
L.unitframe_enemy_health_color = "Barra de vida del enemigo objetivo en rojo"
L_GUI_UF_TOTAL_VALUE = "Mostrar vida restante en jugador y objetivo con XXXX/Total"
L_GUI_UF_COLOR_VALUE = "Colorear valor de Vida/Maná"
L_GUI_UF_BAR_COLOR_VALUE = "Color de la barra de vida dependiendo de la vida restante"
L_GUI_UF_LINES = "Show Player and Target lines" -- Need review
L_GUI_UF_SUBHEADER_CAST = "Castbars" -- Need review
L_GUI_UF_UNIT_CASTBAR = "Mostrar barras de lanzamiento"
L_GUI_UF_CASTBAR_ICON = "Mostrar iconos en las barras de lanzamiento"
L_GUI_UF_CASTBAR_LATENCY = "Latencia en la barra de lanzamiento"
L_GUI_UF_CASTBAR_TICKS = "Castbar ticks" -- Needs review
L_GUI_UF_SUBHEADER_FRAMES = "Frames" -- Need review
L_GUI_UF_SHOW_PET = "Mostrar marco de la mascota"
L_GUI_UF_SHOW_FOCUS = "Mostrar marco del foco"
L_GUI_UF_SHOW_TOT = "Mostrar marco del objetivo del objetivo"
L_GUI_UF_SHOW_BOSS = "Mostrar marco del jefe"
L_GUI_UF_BOSS_RIGHT = "Marco/Marcos del/de los jefe/jefes en la derecha"
L_GUI_UF_SHOW_ARENA = "Mostrar marcos de arena"
L_GUI_UF_ARENA_RIGHT = "Marcos de arena en la derecha"
L_GUI_UF_BOSS_DEBUFFS = "Number of debuffs" -- Need review
L_GUI_UF_BOSS_DEBUFFS_DESC = "Number of debuffs on the boss frames" -- Need review
L_GUI_UF_BOSS_BUFFS = "Number of buffs" -- Need review
L_GUI_UF_BOSS_BUFFS_DESC = "Number of buffs on the boss frames" -- Need review
L.unitframe_icons_pvp = "PvP status text" -- Need review
L.unitframe_icons_pvp_desc = "Texto JcJ (iconos no) al pasar el ratón sobre los marcos del jugador y objetivo"
L_GUI_UF_ICONS_COMBAT = "Icono de combate"
L_GUI_UF_ICONS_RESTING = "Icono de descansado para pjs con nivel bajo"
L_GUI_UF_SUBHEADER_PORTRAIT = "Portraits" -- Need review
L_GUI_UF_PORTRAIT_ENABLE = "Activar retratos del jugador/objetivo"
L_GUI_UF_PORTRAIT_CLASSCOLOR_BORDER = "Borde de color de clase para los retratos"
L_GUI_UF_PORTRAIT_HEIGHT = "Altura del retrato"
L_GUI_UF_PORTRAIT_WIDTH = "Anchura del retrato"
L_GUI_UF_SUBHEADER_PLUGINS = "Plugins" -- Need review
L_GUI_UF_PLUGINS_GCD = "Brillo de tiempo de reutilización global"
L_GUI_UF_PLUGINS_SWING = "Activar barra de oscilación"
L.unitframe_plugins_reputation_bar = "Reputation bar" -- Need review
L.unitframe_plugins_reputation_bar_desc = "Activar barra de reputación" -- Need review
L.unitframe_plugins_experience_bar = "Experience bar" -- Need review
L.unitframe_plugins_experience_bar_desc = "Activar barra de experiencia" -- Need review
L_GUI_UF_PLUGINS_SMOOTH_BAR = "Activar barra de suavizado"
L_GUI_UF_PLUGINS_ENEMY_SPEC = "Mostrar configuración de los talentos del enemigo"
L_GUI_UF_PLUGINS_COMBAT_FEEDBACK = "Texto de combate en el marco del jugador/objetivo"
L_GUI_UF_PLUGINS_FADER = "Desvanecer marcos de unidades"
L_GUI_UF_PLUGINS_DIMINISHING = "Diminishing Returns icons on arena frames" -- Needs review
L_GUI_UF_PLUGINS_POWER_PREDICTION = "Power cost prediction bar on player frame" -- Need review
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
L_GUI_UF_PLUGINS_CLASS_BAR = "Unit Frames Class bars" -- Needs review
L_GUI_UF_PLUGINS_CLASS_BAR_SUBTEXT = "Control of special class resources." -- Need review
L_GUI_UF_PLUGINS_COMBO_BAR = "Iconos de puntos de combo de Pícaros/Druidas"
L_GUI_UF_PLUGINS_COMBO_BAR_ALWAYS = "Always show Combo bar for Druid" -- Need review
L_GUI_UF_PLUGINS_COMBO_BAR_OLD = "Show combo point on the target" -- Need review
L_GUI_UF_PLUGINS_ARCANE_BAR = "Enable Arcane Charge bar" -- Need review
L_GUI_UF_PLUGINS_CHI_BAR = "Enable Chi bar" -- Needs review
L_GUI_UF_PLUGINS_STAGGER_BAR = "Enable Stagger bar (for Monk Tanks)" -- Need review
L_GUI_UF_PLUGINS_HOLY_BAR = "Activar barra de poder sagrado"
L_GUI_UF_PLUGINS_SHARD_BAR = "Activar barra de fragmentos"
L_GUI_UF_PLUGINS_RUNE_BAR = "Activar barra de Runas"
L_GUI_UF_PLUGINS_TOTEM_BAR = "Activar barra de totems"

-- Raid Frames options
L_GUI_UF_RAIDFRAMES_SUBTEXT = "Customize the appearance of the raid frames." -- Need review
L_GUI_UF_BY_ROLE = "Sorting players in group by role" -- Needs review
L_GUI_UF_AGGRO_BORDER = "Borde de aggro"
L_GUI_UF_DEFICIT_HEALTH = "Déficit de vida de la banda"
L_GUI_UF_SHOW_PARTY = "Mostrar marcos de grupo en la banda"
L_GUI_UF_SHOW_RAID = "Mostrar marcos de banda"
L.raidframe_show_target = "Show target frames" -- Needs review
L.raidframe_show_pet = "Show pet frames" -- Needs review
L.raidframe_vertical_health = "Orientación vertical de la vida"
L.raidframe_vertical_health_desc = "Only for heal layout" -- Needs review
L_GUI_UF_ALPHA_HEALTH = "Opacidad de las barras de vida cuando están al 100%"
L_GUI_UF_SHOW_RANGE = "Mostrar rango de opacidad para los marcos de banda"
L_GUI_UF_RANGE_ALPHA = "Alpha" -- Need review
L_GUI_UF_RANGE_ALPHA_DESC = "Opacidad de los marcos de unidades cuando están fuera de rango"
L_GUI_UF_SUBHEADER_RAIDFRAMES = "Frames" -- Need review
L_GUI_UF_SOLO_MODE = "Mostrar marco del jugador siempre"
L_GUI_UF_PLAYER_PARTY = "Mostrar marco del jugador en grupo"
L_GUI_UF_SHOW_TANK = "Mostrar tanques de la banda"
L_GUI_UF_SHOW_TANK_TT = "Mostrar el objetivo del objetivo de los tanques de la banda"
L_GUI_UF_RAID_GROUP = "Número de grupos en la banda"
L.raidframe_party_vertical = "Vertical party frames" -- Needs review
L.raidframe_raid_groups_vertical = "Grupos de la banda en vertical" -- Needs review
L.raidframe_raid_groups_vertical_desc = "Only for heal layout" -- Needs review
L_GUI_UF_SUBHEADER_ICONS = "Icons" -- Need review
L_GUI_UF_ICONS_ROLE = "Role icon on frames" -- Needs review
L_GUI_UF_ICONS_RAID_MARK = "Marcas de banda"
L_GUI_UF_ICONS_READY_CHECK = "Iconos de comprobación"
L_GUI_UF_ICONS_LEADER = "Iconos de líder, ayudantes en los marcos"
L_GUI_UF_ICONS_SUMON = "Sumon icons" -- Need review
L.raidframe_icons_phase = "Phase" -- Need review
L_GUI_UF_PLUGINS_DEBUFFHIGHLIGHT_ICON = "Remarcar textura de desventajas + icono"
L_GUI_UF_PLUGINS_AURA_WATCH = "'BANDA' Ver las auras"
L_GUI_UF_PLUGINS_AURA_WATCH_TIMER = "Temporizador en los iconos de perjuicios de la banda"
L_GUI_UF_PLUGINS_PVP_DEBUFFS = "Show also PvP debuff icons (from the list)" -- Need review
L_GUI_UF_PLUGINS_HEALCOMM = "Barra de sanación entrante"
L.raidframe_plugins_auto_resurrection = "Auto cast resurrection" -- Need review
L.raidframe_plugins_auto_resurrection_desc = "Auto lanzar resurreción con click central cuando la unidad este muerta (no funciona cuando Clique está activado)"
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
L_GUI_ACTIONBAR = "Action Bars" -- Need review
L_GUI_ACTIONBAR_ENABLE = "Activar barras de acción"
L_GUI_ACTIONBAR_HOTKEY = "Mostrar texto los atajos de teclado"
L_GUI_ACTIONBAR_MACRO = "Mostrar nombre de la macro en los botones"
L_GUI_ACTIONBAR_GRID = "Mostrar botones de la barra de acción vacíos"
L_GUI_ACTIONBAR_BUTTON_SIZE = "Tamaño de los botones"
L_GUI_ACTIONBAR_BUTTON_SPACE = "Espacio entre botones"
L_GUI_ACTIONBAR_SPLIT_BARS = "Dividir la quinta barra en dos de 6 botones cada una"
L_GUI_ACTIONBAR_CLASSCOLOR_BORDER = "Activar borde por color de clase para los botones"
L.actionbar_toggle_mode = "Activar modo cambiar"
L.actionbar_toggle_mode_desc = "The quick change in the number of panels. For the lower panels, hover the mouse over the hidden area above the panels. For right panels, hover the mouse over the area below the panels." -- Need review
L_GUI_ACTIONBAR_HIDE_HIGHLIGHT = "Hide proc highlight" -- Needs review
L_GUI_ACTIONBAR_BOTTOMBARS = "Número de barras de acción abajo"
L_GUI_ACTIONBAR_RIGHTBARS = "Número de barras de acción en la derecha"
L.actionbar_bottombars_mouseover = "Bottom bars on mouseover" -- Needs review
L_GUI_ACTIONBAR_RIGHTBARS_MOUSEOVER = "Barras de la derecha se muestran al pasar el ratón"
L_GUI_ACTIONBAR_PETBAR_HIDE = "Ocultar barra de mascota"
L_GUI_ACTIONBAR_PETBAR_HORIZONTAL = "Activar barra de mascota horizontal"
L_GUI_ACTIONBAR_PETBAR_MOUSEOVER = "Barra de mascota al pasar el ratón (sólo para la barra de mascota horizontal)"
L_GUI_ACTIONBAR_STANCEBAR_HIDE = "Ocultar cambio de forma"
L_GUI_ACTIONBAR_STANCEBAR_HORIZONTAL = "Activar barra de estancia horizontal"
L.actionbar_stancebar_horizontal_desc = "Located below the player's frame" -- Needs review
L_GUI_ACTIONBAR_STANCEBAR_MOUSEOVER = "Barras de Cambios de forma/Estancias al pasar el ratón" -- Needs review
L_GUI_ACTIONBAR_MICROMENU = "Enable micro menu" -- Needs review
L_GUI_ACTIONBAR_MICROMENU_MOUSEOVER = "Micro menu on mouseover" -- Needs review
L.actionbar_editor = "Bars editor" -- Needs review
L.actionbar_editor_desc = "Allow to move and change each panel individually" -- Needs review
L.actionbar_bar1_num = "Number of buttons" -- Needs review
L.actionbar_bar1_row = "Buttons per row" -- Needs review
L.actionbar_bar1_mouseover = "Bar on mouseover" -- Needs review

-- Tooltip options
L.tooltip = "Descripciones"
L.tooltip_subtext = "In this block, you can change the standard tips when mouseovering." -- Need review
L.tooltip_enable = "Activar descripciones"
L.tooltip_shift_modifer = "Mostrar descripción mientras Shift está pulsado"
L.tooltip_cursor = "Descripción bajo el cursos"
L.tooltip_item_icon = "Icono del objeto en la descripción"
L.tooltip_health_value = "Valor de la vida en números"
L.tooltip_hidebuttons = "Ocultar descripciones de las barras de acción"
L.tooltip_hide_combat = "Ocultar descripción en combate"
L.tooltip_subheader = "Plugins" -- Need review
L.tooltip_talents = "Mostrar descripción de los talentos"
L.tooltip_show_shift = "Show when Shift is pushed" -- Need review
L.tooltip_show_shift_desc = "Show items level and spec when Shift is pushed" -- Need review
L.tooltip_achievements = "Comparar logros en la descripción"
L.tooltip_target = "Jugador objetivo en la descripción"
L.tooltip_title = "Player title in tooltip" -- Need review
L.tooltip_realm = "Player realm name in tooltip" -- Need review
L.tooltip_rank = "Rango del jugador en la hermandad en la descripción"
L.tooltip_spell_id = "ID del hechizo"
L.tooltip_average_lvl_desc = "The average item level" -- Need review
L.tooltip_raid_icon = "Icono de banda"
L.tooltip_who_targetting = "Muestra quien está marcando la unidad que está en tu grupo/banda"
L.tooltip_item_count = "Contador del objeto"
L.tooltip_unit_role = "Unit role" -- Needs review
L.tooltip_instance_lock = "Your instance lock status in tooltip" -- Needs review
L.tooltip_mount = "Source of mount" -- Needs review

-- Chat options
L_GUI_CHAT_SUBTEXT = "Here you can change the settings of the chat window." -- Need review
L_GUI_CHAT_ENABLE = "Activar chat"
L_GUI_CHAT_BACKGROUND = "Activar fondo del chat"
L_GUI_CHAT_BACKGROUND_ALPHA = "Opacidad del fondo del chat"
L_GUI_CHAT_SPAM = "Remover ciertos mensajes de spam ('Jugador1' ha ganado un duelo a 'Jugador2')"
L_GUI_CHAT_GOLD = "Remover spam del algunos jugadores (Vendedores de oro)"
L.chat_spam_list = "Black list" -- Need review
L.chat_spam_list_desc = "List of words (separated by space, lowercase letters) to hide messages" -- Need review
L_GUI_CHAT_WIDTH = "Anchura del chat"
L_GUI_CHAT_HEIGHT = "Altura del chat"
L_GUI_CHAT_BAR = "Pequeña barra de botones para cambiar de canal en el chat"
L_GUI_CHAT_BAR_MOUSEOVER = "Lite Button Bar on mouseover" -- Needs review
L_GUI_CHAT_WHISP = "Sonido cuando te susurran"
L_GUI_CHAT_SKIN_BUBBLE = "Estilizar las burbujas de chat"
L_GUI_CHAT_CL_TAB = "Mostrar la pestaña del Registro de Combate"
L_GUI_CHAT_TABS_MOUSEOVER = "Chat tabs on mouseover" -- Needs review
L_GUI_CHAT_STICKY = "Recordar último canal"
L_GUI_CHAT_DAMAGE_METER_SPAM = "Merge damage meter spam in one line-link" -- Needs review
L.chat_loot_icons = "Icons for loot" -- Needs review
L.chat_custom_time_color = "Enable custom timestamp coloring" -- Needs review
L.chat_time_color = "Color de la marca de tiempo"

-- Nameplate options
L_GUI_NAMEPLATE_SUBTEXT = "Nameplate settings" -- Need review
L_GUI_NAMEPLATE_ENABLE = "Activar placas de nombre"
L_GUI_NAMEPLATE_COMBAT = "Mostrar automáticamente placa de nombre en combate"
L_GUI_NAMEPLATE_HEALTH = "Valor de la vida en números"
L_GUI_NAMEPLATE_HEIGHT = "Altura de la placa de nombre"
L_GUI_NAMEPLATE_WIDTH = "Anchura de la placa de nombre"
L.nameplate_alpha = "Alpha" -- Needs review
L.nameplate_alpha_desc = "Non-target nameplate alpha" -- Needs review
L.nameplate_ad_height = "Additional height" -- Need review
L.nameplate_ad_width = "Additional width" -- Need review
L.nameplate_ad_height_desc = "Additional height for selected nameplate" -- Needs review
L.nameplate_ad_width_desc = "Additional width for selected nameplate" -- Needs review
L_GUI_NAMEPLATE_CASTBAR_NAME = "Mostrar nombre del hechizo en la barra de lanzamiento"
L_GUI_NAMEPLATE_CLASS_ICON = "Iconos de clase en JcJ"
L_GUI_NAMEPLATE_NAME_ABBREV = "Mostrar los nombres abreviados"
L.nameplate_clamp = "Clamp nameplates to the top of the screen when outside of view" -- Need review
L.nameplate_clamp_desc = "Clamp nameplates to the top of the screen when outside of view" -- Need review
L_GUI_NAMEPLATE_SHOW_DEBUFFS = "Mostrar perjuicios (Nombres abreviados debe ser desactivado)"
L_GUI_NAMEPLATE_SHOW_BUFFS = "Show dispellable enemy buffs and buffs from the list" -- Need review
L_GUI_NAMEPLATE_DEBUFFS_SIZE = "Tamaño de los perjuicios" -- Need review
L_GUI_NAMEPLATE_HEALER_ICON = "Show icon above enemy healers nameplate in battlegrounds" -- Needs review
L_GUI_NAMEPLATE_TOTEM_ICONS = "Show icon above enemy totems nameplate" -- Need review
L.nameplate_target_glow = "Show glow texture for target" -- Need review
L.nameplate_only_name = "Show only name for friendly units" -- Need review
L.nameplate_quests = "Show quest icon" -- Need review
L.nameplate_cast_color = "Show color border for casting important spells" -- Need review
L.nameplate_kick_color = "Change cast color if interrupt on cd" -- Need review
L.nameplate_low_health_value = "Health value" -- Need review
L.nameplate_low_health = "Low health highlight" -- Need review
L_GUI_NAMEPLATE_THREAT = "Activar visor de amenaza, cambia automáticamente según tu rol"
L_GUI_NAMEPLATE_GOOD_COLOR = "Color de alta amenaza, varía dependiendo si eres tanque o dps/sanador"
L_GUI_NAMEPLATE_NEAR_COLOR = "Color de perdiendo/ganando amenaza"
L_GUI_NAMEPLATE_BAD_COLOR = "Color de baja amenaza, varía dependiendo si eres tanque o dps/sanador"
L_GUI_NAMEPLATE_OFFTANK_COLOR = "Offtank threat color" -- Need review
L.nameplate_extra_color = "Explosive and Spiteful affix color" -- Need review
L.nameplate_mob_color_enable = "Change color for important mobs in dungeons" -- Need review
L.nameplate_mob_color = "Color for mobs" -- Need review

-- Combat text options
L_GUI_COMBATTEXT = "Texto de Combate"
L_GUI_COMBATTEXT_SUBTEXT = "For moving type in the chat '/xct'" -- Need review
L_GUI_COMBATTEXT_ENABLE = "Activar Texto de Combate"
L.combattext_blizz_head_numbers = "Enable Blizzard combat text" -- Need review
L.combattext_blizz_head_numbers_desc = "Usar la salida de daño/curación de Blizzard (sobre la cabeza del monstruo/jugador)"
L.combattext_damage_style = "Change default combat font" -- Need review
L.combattext_damage_style_desc = "Cambiar la fuente de daño/sanación por defecto de encima de los monstruos/jugadores (tendrás que reiniciar WoW para ver los cambios)"
L_GUI_COMBATTEXT_DAMAGE = "Mostrar daño saliente en su propio marco"
L_GUI_COMBATTEXT_HEALING = "Mostrar sanación saliente en su propio marco"
L.combattext_incoming = "Show incoming damage and healing" -- Need review
L_GUI_COMBATTEXT_HOTS = "Mostrar efectos de cura periódicos en el marco de curas"
L_GUI_COMBATTEXT_OVERHEALING = "Mostrar la sobrecuracion saliente"
L_GUI_COMBATTEXT_PET_DAMAGE = "Mostrar el daño de tu mascota"
L_GUI_COMBATTEXT_DOT_DAMAGE = "Mostrar el daño de tus dots (Daño periodico)"
L_GUI_COMBATTEXT_DAMAGE_COLOR = "Mostrar números de daño dependiendo de la escuela de magia"
L_GUI_COMBATTEXT_CRIT_PREFIX = "Símbolo que se añadirá antes de un crítico"
L_GUI_COMBATTEXT_CRIT_POSTFIX = "Símbolo que se añadirá después de un crítico"
L_GUI_COMBATTEXT_ICONS = "Mostrar iconos de daño saliente"
L_GUI_COMBATTEXT_ICON_SIZE = "Icon size" -- Need review
L_GUI_COMBATTEXT_ICON_SIZE_DESC = "Tamaño de los iconos de los hechizos en el marco de daño saliente, también tiene efecto sobre el tamaño de la fuente de daño"
L_GUI_COMBATTEXT_TRESHOLD = "Daño mínimo que se mostrar en el marco de daño"
L_GUI_COMBATTEXT_HEAL_TRESHOLD = "Sanación mínima que se mostrar en los mensajes de sanación entrante/saliente"
L_GUI_COMBATTEXT_SCROLLABLE = "Permitir usar la rueda del ratón para desplazar las líneas de los marcos"
L_GUI_COMBATTEXT_MAX_LINES = "Max lines" -- Need review
L_GUI_COMBATTEXT_MAX_LINES_DESC = "Máx de líneas para mantener desplazables (a más lineas, más memoria requerida)"
L_GUI_COMBATTEXT_TIME_VISIBLE = "Time" -- Need review
L_GUI_COMBATTEXT_TIME_VISIBLE_DESC = "Tiempo (segundos) en que un mensaje es visible"
L_GUI_COMBATTEXT_DK_RUNES = "Mostrar recarga de runas de los Caballeros de la Muerte"
L_GUI_COMBATTEXT_KILLINGBLOW = "Mostrar tus golpes de gracia"
L_GUI_COMBATTEXT_MERGE_AOE_SPAM = "Unir el spam de daño de area en un solo mensaje"
L_GUI_COMBATTEXT_MERGE_MELEE = "Merges multiple auto attack damage spam" -- Needs review
L_GUI_COMBATTEXT_DISPEL = "Mostrar tus disipaciones"
L_GUI_COMBATTEXT_INTERRUPT = "Mostrar tus interrupciones"
L_GUI_COMBATTEXT_DIRECTION = "Change scrolling direction from bottom to top" -- Need review
L_GUI_COMBATTEXT_SHORT_NUMBERS = "Use short numbers ('25.3k' instead of '25342')" -- Need review

-- Auras/Buffs/Debuffs
L_GUI_AURA_PLAYER_BUFF_SIZE = "Buffs size" -- Need review
L_GUI_AURA_PLAYER_BUFF_SIZE_DESC = "Tamaño de las beneficios del jugador"
L.aura_player_debuff_size = "Debuffs size" -- Need review
L_GUI_AURA_SHOW_SPIRAL = "Espiral en los iconos de las auras"
L_GUI_AURA_SHOW_TIMER = "Mostrar tiempo de reutilización en los iconos de las auras"
L_GUI_AURA_PLAYER_AURAS = "Auras en el marco del jugador"
L_GUI_AURA_TARGET_AURAS = "Auras en el marco del objetivo"
L_GUI_AURA_FOCUS_DEBUFFS = "Perjuicios en el marco del foco"
L_GUI_AURA_FOT_DEBUFFS = "Perjuicios en el marco del objetivo del foco"
L_GUI_AURA_PET_DEBUFFS = "Perjuicios en el marco de la mascota"
L_GUI_AURA_TOT_DEBUFFS = "Perjuicios en el marco del objetivo del objetivo"
L.aura_boss_buffs = "Beneficios en el marco del jefe" -- Need review
L_GUI_AURA_PLAYER_AURA_ONLY = "Solo tus perjuicios en el marco del objetivo"
L_GUI_AURA_DEBUFF_COLOR_TYPE = "Color de los perjuicios por tipo"
L_GUI_AURA_CAST_BY = "Mostrar quién lanza un beneficio/perjuicio en su descripción"
L_GUI_AURA_CLASSCOLOR_BORDER = "Activar borde por color de clase para los beneficios del jugador"

-- Bag options
L_GUI_BAGS = "Bolsas"
L_GUI_BAGS_SUBTEXT = "Right click on the close button to open the menu. To move the bags, hold down Shift - click." -- Need review
L_GUI_BAGS_ENABLE = "Activar bolsas"
L_GUI_BAGS_ILVL = "Show item level for weapons and armor" -- Need review
L.bag_new_items = "Show animation for new items" -- Need review
L_GUI_BAGS_BUTTON_SIZE = "Tamaño de los huecos"
L_GUI_BAGS_BUTTON_SPACE = "Espacio entre huecos"
L_GUI_BAGS_BANK = "Número de columnas en el banco"
L_GUI_BAGS_BAG = "Número de columnas en la bolsa principal"

-- Minimap options
L_GUI_MINIMAP_SUBTEXT = "Minimap settings." -- Need review
L_GUI_MINIMAP_ENABLE = "Activar minimapa"
L_GUI_MINIMAP_ICON = "Icono de seguimiento"
L_GUI_GARRISON_ICON = "Covenant icon" -- Need review
L_GUI_MINIMAP_SIZE = "Tamaño del minimapa"
L_GUI_MINIMAP_HIDE_COMBAT = "Ocultar minimapa en combate"
L_GUI_MINIMAP_TOGGLE_MENU = "Show toggle menu" -- Needs review
L.minimap_bg_map_stylization = "Estilizado del mapa de CB"
L.minimap_fog_of_war = "Remove fog of war on World Map" -- Needs review

-- Loot options
L_GUI_LOOT_SUBTEXT = "Settings for loot frame." -- Need review
L_GUI_LOOT_ENABLE = "Activar el marco de botín"
L_GUI_LOOT_ROLL_ENABLE = "Activar el marco de botín de grupo"
L_GUI_LOOT_ICON_SIZE = "Tamaño de los iconos"
L_GUI_LOOT_WIDTH = "Anchura del marco de botín"
L_GUI_LOOT_AUTOGREED = "Activar auto-codicia para objetos verdes cuando eres nivel máx"
L_GUI_LOOT_AUTODE = "Auto confirmar desencantar"
L.loot_faster_loot = "Faster looting" -- Need review
L.loot_faster_loot_desc = "Works only if enabled auto loot" -- Need review

-- Filger
L_GUI_FILGER = "Timers (Filger)" -- Need review
L_GUI_FILGER_SUBTEXT = "Filger - analogue WeakAuras, but more simple and easy. Allows you to display in the form of icons and bars your auras and timers." -- Need review
L_GUI_FILGER_ENABLE = "Enable Filger" -- Need review
L_GUI_FILGER_TEST_MODE = "Test icon mode" -- Need review
L_GUI_FILGER_MAX_TEST_ICON = "The number of icons to the test" -- Need review
L_GUI_FILGER_SHOW_TOOLTIP = "Show tooltip" -- Need review
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
L_GUI_FILGER_BUFFS_SIZE = "Buffs size" -- Need review
L_GUI_FILGER_COOLDOWN_SIZE = "Cooldowns size" -- Need review
L_GUI_FILGER_PVP_SIZE = "PvP debuffs size" -- Need review
L.filger_buffs_space = "Buffs space" -- Need review
L.filger_pvp_space = "PvP auras space" -- Need review
L.filger_cooldown_space = "Cooldowns space" -- Need review
L.filger_subheader_spells = "Adding new spells" -- Need review
L.filger_category_list = "Spell list category" -- Need review

-- Announcements options
L_GUI_ANNOUNCEMENTS = "Anuncios"
L_GUI_ANNOUNCEMENTS_SUBTEXT = "Settings that add chat announcements about spells or items." -- Need review
L.announcements_drinking = "Anunciar en el chat cuando un enemigo en la arena beba"
L.announcements_interrupts = "Anunciar en el grupo/banda cuando interrumpes"
L.announcements_spells = "Anunciar en grupo/banda cuando lanzas el mismo hechizo que otro"
L.announcements_spells_from_all = "Comprueba los lanzamientos de hechizo de todos los miembros"
L.announcements_toys = "Announce Toy Train or Direbrew's Remote cast" -- Needs review
L.announcements_pull_countdown = "Pull countdown announce (/pc #)" -- Needs review
L.announcements_flask_food = "Announce the usage of flasks and food (/ffcheck)" -- Needs review
L.announcements_flask_food_raid = "Announce to raid channel" -- Needs review
L.announcements_flask_food_auto = "Auto check when ReadyCheck" -- Needs review
L.announcements_feasts = "Announce Feasts/Souls/Repair Bots cast" -- Needs review
L.announcements_portals = "Announce Portals/Ritual of Summoning cast" -- Needs review
L.announcements_bad_gear = "Check your bad gear" -- Need review
L.announcements_bad_gear_desc = "Check your bad gear in instance (fishing pole, from the list)" -- Needs review
L.announcements_safari_hat = "Check Safari Hat when starting Pet Battle" -- Needs review

-- Automation options
L_GUI_AUTOMATION = "Automation" -- Needs review
L_GUI_AUTOMATION_SUBTEXT = "This block contains settings that facilitate the routine." -- Need review
L.automation_release = "Auto resurrección en los Campos de Batalla" -- Need review
L.automation_screenshot = "Tomar una captura de pantalla cuando consigas un logro"
L.automation_solve_artifact = "Auto popup for solve artifact" -- Needs review
L.automation_solve_artifact_desc = "If there are enough fragments for an artifact, a popup will appear to solve it." -- Need review
L.automation_accept_invite = "Auto aceptar invitaciones"
L.automation_decline_duel = "Auto rechazar duelos"
L.automation_accept_quest = "Auto aceptar misiones"
L.automation_auto_collapse = "Auto collapse Objective Tracker" -- Need review
L.automation_auto_collapse_raid = "In Instance" -- Need review
L.automation_auto_collapse_reload = "After reload" -- Need review
L.automation_auto_collapse_scenario = "Partially" -- Need review
L.automation_skip_cinematic = "Auto skip cinematics/movies (disabled if hold Ctrl)" -- Needs review
L.automation_auto_role = "Auto set your role" -- Needs review
L.automation_cancel_bad_buffs = "Auto cancel annoying holiday buffs (from the list)" -- Needs review
L.automation_tab_binder = "Auto change 'Tab' key binding in PvP" -- Needs review
L.automation_tab_binder_desc = "'Tab' key target only enemy players when in PvP zones, ignores pets and mobs" -- Need review
L.automation_logging_combat = "Auto enables combat log text file in raid instances" -- Needs review
L.automation_buff_on_scroll = "Cast buff on mouse scroll (from the list)" -- Needs review
L.automation_buff_on_scroll_desc = "If the buff from the list is not applied to the player, it will cast by the mouse scroll" -- Need review
L.automation_open_items = "Auto opening of items in bag" -- Needs review
L.automation_resurrection = "Confirm resurrection" -- Needs review
L.automation_summon = "Confirm summon" -- Needs review
L.automation_whisper_invite = "Auto invite when whisper keyword" -- Needs review
L.automation_invite_keyword = "List of keyword (separated by space)" -- Needs review
L.automation_invite_keyword_desc = "When player whisper you keyword he will be invited in your group" -- Needs review

-- Buffs reminder options
L_GUI_REMINDER = "Recordatorio de Ventajas"
L_GUI_REMINDER_SUBTEXT = "Display of missed auras." -- Need review
L_GUI_REMINDER_SOLO_ENABLE = "Mostrar ventajas propias que faltan"
L_GUI_REMINDER_SOLO_SOUND = "Alerta sonora para avisar de ventajas propias"
L_GUI_REMINDER_SOLO_SIZE = "Icon size" -- Need review
L_GUI_REMINDER_SOLO_SIZE_DESC = "Tamaño de los iconos de las ventajas propias"
L_GUI_REMINDER_SUBHEADER = "Raid buffs" -- Need review
L_GUI_REMINDER_RAID_ENABLE = "Mostrar ventajas que faltan en la Banda"
L_GUI_REMINDER_RAID_ALWAYS = "Mostrar Recordatorio de Ventajas siempre"
L_GUI_REMINDER_RAID_SIZE = "Icon size" -- Need review
L_GUI_REMINDER_RAID_SIZE_DESC = "Tamaño de los iconos de las ventajas de la Banda"
L_GUI_REMINDER_RAID_ALPHA = "Transparent" -- Need review
L_GUI_REMINDER_RAID_ALPHA_DESC = "Icono transparente cuando la ventaja está presente"

-- Raid cooldowns options
L_GUI_COOLDOWN_RAID = "Tiempos de reutilización de la Banda"
L_GUI_COOLDOWN_RAID_SUBTEXT = "Tracking raid abilities in the upper left corner." -- Need review
L_GUI_COOLDOWN_RAID_ENABLE = "Mostrar tiempos de reutilización de la Banda"
L_GUI_COOLDOWN_RAID_HEIGHT = "Bars height" -- Need review
L_GUI_COOLDOWN_RAID_WIDTH = "Bars width" -- Need review
L_GUI_COOLDOWN_RAID_SORT = "Barras de tiempos de reutilización de la Banda ordenadas hacia arriba"
L_GUI_COOLDOWN_RAID_EXPIRATION = "Sort by expiration time" -- Needs review
L_GUI_COOLDOWN_RAID_SHOW_SELF = "Show self cooldowns" -- Needs review
L_GUI_COOLDOWN_RAID_ICONS = "Iconos de tiempos de reutilización de la Banda"
L_GUI_COOLDOWN_RAID_IN_RAID = "Mostrar tiempos de reutilización de la Banda en zona de Banda"
L_GUI_COOLDOWN_RAID_IN_PARTY = "Mostrar tiempos de reutilización de la Banda en zona de Grupo"
L_GUI_COOLDOWN_RAID_IN_ARENA = "Mostrar tiempos de reutilización de la Banda en zona de Arena"

-- Enemy cooldowns options
L_GUI_COOLDOWN_ENEMY = "Tiempos de reutilización del enemigo"
L_GUI_COOLDOWN_ENEMY_SUBTEXT = "Tracking enemy abilities as icons above your spell casting bar." -- Need review
L_GUI_COOLDOWN_ENEMY_ENABLE = "Activar tiempos de reutilización del enemigo"
L_GUI_COOLDOWN_ENEMY_SIZE = "Tamaño del icono de tiempos de reutilización del enemigo"
L_GUI_COOLDOWN_ENEMY_DIRECTION = "Icono de dirección de tiempos de reutilización del enemigo"
L_GUI_COOLDOWN_ENEMY_EVERYWHERE = "Mostrar tiempos de reutilización del enemigo siempre"
L_GUI_COOLDOWN_ENEMY_IN_BG = "Mostrar tiempos de reutilización del enemigo en zona de CB"
L_GUI_COOLDOWN_ENEMY_IN_ARENA = "Mostrar tiempos de reutilización del enemigo en zona de Arena"
L.enemycooldown_show_inparty = "Show in party zone for allies" -- Need review
L.enemycooldown_class_color = "Enable classcolor border" -- Need review

-- Pulse cooldowns options
L_GUI_COOLDOWN_PULSE = "Cuenta atrás de tiempos de reutilización"
L_GUI_COOLDOWN_PULSE_SUBTEXT = "Track your cd using a pulse icon in the center of the screen." -- Need review
L_GUI_COOLDOWN_PULSE_ENABLE = "Mostrar cuentas atrás de tiempos de reutilización"
L_GUI_COOLDOWN_PULSE_SIZE = "Tamaño de los icono de las cuentas atras de tiempos de reutilización"
L_GUI_COOLDOWN_PULSE_SOUND = "Aviso sonoro"
L_GUI_COOLDOWN_PULSE_ANIM_SCALE = "Escalado animado"
L_GUI_COOLDOWN_PULSE_HOLD_TIME = "Opacidad máxima del tiempo de espera"
L_GUI_COOLDOWN_PULSE_THRESHOLD = "Threshold time" -- Need review
L_GUI_COOLDOWN_PULSE_THRESHOLD_DESC = "Umbral de tiempo mínimo"

-- Threat options
L_GUI_THREAT = "Barras de Amenaza"
L_GUI_THREAT_SUBTEXT = "Display of the threat list (a simple analogue of Omen)." -- Need review
L_GUI_THREAT_ENABLE = "Activar Barras de Amenaza"
L_GUI_THREAT_HEIGHT = "Altura de las barras de amenaza"
L_GUI_THREAT_WIDTH = "Anchura de las barras de amenaza"
L_GUI_THREAT_ROWS = "Número de barras de amenaza"
L_GUI_THREAT_HIDE_SOLO = "Mostrar solo en grupo/raid"

-- Top panel options
L_GUI_TOP_PANEL = "Panel superior"
L_GUI_TOP_PANEL_SUBTEXT = "Manage built-in top panel with information." -- Need review
L_GUI_TOP_PANEL_ENABLE = "Activar panel superior"
L_GUI_TOP_PANEL_MOUSE = "Panel superior al pasar el ratón"
L_GUI_TOP_PANEL_WIDTH = "Anchura del panel"
L_GUI_TOP_PANEL_HEIGHT = "Altura del panel"

-- Stats options
L_GUI_STATS = "Estadísticas"
L_GUI_STATS_SUBTEXT = "Statistics blocks located at the bottom of the screen. Type in the chat '/ls' for info." -- Need review
L_GUI_STATS_CLOCK = "Reloj"
L_GUI_STATS_LATENCY = "Latencia"
L_GUI_STATS_FPS = "FPS (Marcos por segundo)"
L_GUI_STATS_EXPERIENCE = "Experiencia"
L_GUI_STATS_TALENTS_DESC = "Date-text allows you to change the spec and loot on click" -- Need review
L_GUI_STATS_COORDS = "Coordenadas"
L_GUI_STATS_LOCATION = "Localización"
L_GUI_STATS_BG = "Campo de Batalla"
L.stats_bottom_line = "Bottom classcolor line" -- Need review
L_GUI_STATS_SUBHEADER_CURRENCY = "Currency (displayed in gold data text)" -- Need review
L_GUI_STATS_CURRENCY_ARCHAEOLOGY = "Show Archaeology Fragments" -- Needs review
L_GUI_STATS_CURRENCY_COOKING = "Show Cooking Awards" -- Needs review
L_GUI_STATS_CURRENCY_RAID = "Show Raid Seals" -- Needs review

-- Trade options
L_GUI_TRADE = "Trade" -- Need review
L_GUI_TRADE_SUBTEXT = "Settings related to professions and trade" -- Need review
L.trade_profession_tabs = "Professions tabs" -- Need review
L.trade_profession_tabs_desc = "Pestanas de profesiones de artesania y marcos de comercio"
L.trade_already_known = "Colorizes already known items" -- Need review
L.trade_already_known_desc = "Colorizes recipes/mounts/pets/toys that is already known" -- Needs review
L.trade_disenchanting = "Quick Disenchanting" -- Need review
L.trade_disenchanting_desc = "Milling, Prospecting and Disenchanting by Alt + click" -- Needs review
L.trade_sum_buyouts = "Sum up all current auctions" -- Needs review
L.trade_sum_buyouts_desc = "At auctions tab shows sum up all current auctions" -- Need review
L.trade_enchantment_scroll = "Enchantment scroll on TradeSkill frame" -- Needs review
L.trade_archaeology = "Archaeology tracker" -- Needs review
L.trade_archaeology_desc = "Archaeology tracker ('/arch' or right mouseover minimap button to show)" -- Need review
L.trade_merchant_itemlevel = "Item level in merchant" -- Need review
L.trade_merchant_itemlevel_desc = "Show item level for weapons and armor in merchant" -- Need review

-- Miscellaneous options
L_GUI_MISC_SUBTEXT = "Other settings that add interesting features." -- Need review
L.misc_shift_marking = "Marks mouseover target" -- Need review
L.misc_shift_marking_desc = "Marks mouseover target when you push Shift (only in group)" -- Need review
L.misc_afk_spin_camera = "Rotar cámara mientras estás ausente"
L.misc_quest_auto_button = "Quest items auto button" -- Need review
L.misc_quest_auto_button_desc = "Auto botón misión/objeto" -- Need review
L.misc_raid_tools = "Herramientas de Raid"
L.misc_raid_tools_desc = "Button at the top of the screen for ready check (Left-click), checking roles (Middle-click), setting marks, etc. (for leader and assistants)" -- Need review
L.misc_item_level = "Item level on slot buttons" -- Need review
L.misc_item_level_desc = "Item level on character slot buttons" -- Needs review
L.misc_click_cast = "Simple click2cast spell binder" -- Needs review
L.misc_click_cast_desc = "Allows you to assign spells (analog Clique) to the mouse buttons. Setup through the side bookmark in the spell book" -- Need review
L.misc_click_cast_filter = "Ignore Player and Target frames for click2cast" -- Needs review
L.misc_chars_currency = "Tracks your currency tokens across multiple characters" -- Needs review
L.misc_chars_currency_desc = "Hover over the icon of the required currency in the character window to display information in the tooltip" -- Need review
L.misc_hide_raid_button = "Button to hide raid frames in dps layout" -- Need review
L.misc_hide_raid_button_desc = "The button is displayed by hovering the mouse in the upper left corner" -- Need review