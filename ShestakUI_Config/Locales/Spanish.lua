if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end

----------------------------------------------------------------------------------------
--	Localization for esES and esMX client
--	Translation: eXecrate
----------------------------------------------------------------------------------------
L_GUI_BUTTON_RESET = "Reinicio total de la UI"
L_GUI_SET_SAVED_SETTTINGS = "Cambios aplicables sólo a este PJ"
L_GUI_RESET_CHAR = "¿Estás seguro de que quieres reiniciar tus preferencias de ShestakUI para este PJ?"
L_GUI_RESET_ALL = "¿Estás seguro de que quieres reiniciar tus preferencias de ShestakUI para todos los PJs?"
L_GUI_PER_CHAR = "¿Estás segudo de que quieres cambiar a o desde 'Cambios sólo a este PJ'?"
L_GUI_MAKE_SELECTION = "Debes hacer una selección antes de continuar la configuración."

-- General options
L_GUI_GENERAL_AUTOSCALE = "Auto escalado de la UI"
L_GUI_GENERAL_UISCALE = "Escalado de la UI (si auto escalado está desactivado)"
L_GUI_GENERAL_WELCOME_MESSAGE = "Mensaje de bienvenida en el chat"
L_GUI_GENERAL_LAG_TOLERANCE = "Actualizar automaticamente la opción de Tolerancia al Lag Personalizada de Blizzard a tu latencia"

-- Miscellaneous options
L_GUI_MISC_MARKING = "Marca el objetivo cuando pulsas Shift"
L_GUI_MISC_INVKEYWORD = "Acrónimo para invitaciones (/ainv)"
L_GUI_MISC_SPIN_CAMERA = "Rotar cámara mientras estás ausente"
L_GUI_MISC_VEHICLE_MOUSEOVER = "Marco del Vehículo al pasar el ratón por encima"
L_GUI_MISC_QUEST_AUTOBUTTON = "Auto botón misión/objeto"
L_GUI_MISC_RAID_TOOLS = "Herramientas de Raid"
L_GUI_MISC_PROFESSION_TABS = "Pestanas de profesiones de artesania y marcos de comercio"
L_GUI_MISC_HIDE_BG_SPAM = "Remove Boss Emote spam during BG" -- Needs review
L_GUI_MISC_ITEM_LEVEL = "Item level on character slot buttons" -- Needs review
L_GUI_MISC_ALREADY_KNOWN = "Colorizes recipes/mounts/pets/toys that is already known" -- Needs review
L_GUI_MISC_DISENCHANTING = "Milling, Prospecting and Disenchanting by Alt + click" -- Needs review
L_GUI_MISC_SUM_BUYOUTS = "Sum up all current auctions" -- Needs review
L_GUI_MISC_CLICK_CAST = "Simple click2cast spell binder" -- Needs review
L_GUI_MISC_CLICK_CAST_FILTER = "Ignore Player and Target frames for click2cast" -- Needs review
L_GUI_MISC_MOVE_BLIZZARD = "Move some Blizzard frames" -- Needs review
L_GUI_MISC_COLOR_PICKER = "Improved ColorPicker" -- Needs review
L_GUI_MISC_ENCHANTMENT_SCROLL = "Enchantment scroll on TradeSkill frame" -- Needs review
L_GUI_MISC_ARCHAEOLOGY = "Archaeology artifacts and cooldown" -- Needs review
L_GUI_MISC_CHARS_CURRENCY = "Tracks your currency tokens across multiple characters" -- Needs review
L_GUI_MISC_ARMORY_LINK = "Add Armory link in UnitPopupMenus (It breaks set focus)" -- Needs review
L_GUI_MISC_MERCHANT_ITEMLEVEL = "Show item level for weapons and armor in merchant" -- Need review
L_GUI_MISC_MINIMIZE_MOUSEOVER = "Mouseover for quest minimize button" -- Need review
L_GUI_MISC_HIDE_BANNER = "Hide Boss Banner Loot Frame" -- Need review
L_GUI_MISC_HIDE_TALKING_HEAD = "Hide Talking Head Frame" -- Need review

-- Announcements options
L_GUI_ANNOUNCEMENTS = "Anuncios"
L_GUI_ANNOUNCEMENTS_DRINKING = "Anunciar en el chat cuando un enemigo en la arena beba"
L_GUI_ANNOUNCEMENTS_INTERRUPTS = "Anunciar en el grupo/banda cuando interrumpes"
L_GUI_ANNOUNCEMENTS_SPELLS = "Anunciar en grupo/banda cuando lanzas el mismo hechizo que otro"
L_GUI_ANNOUNCEMENTS_SPELLS_FROM_ALL = "Comprueba los lanzamientos de hechizo de todos los miembros"
L_GUI_ANNOUNCEMENTS_TOY_TRAIN = "Announce Toy Train or Direbrew's Remote cast" -- Needs review
L_GUI_ANNOUNCEMENTS_SAYS_THANKS = "Says thanks for some spells" -- Needs review
L_GUI_ANNOUNCEMENTS_PULL_COUNTDOWN = "Pull countdown announce'/pc #'" -- Needs review
L_GUI_ANNOUNCEMENTS_FLASK_FOOD = "Announce the usage of flasks and food" -- Needs review
L_GUI_ANNOUNCEMENTS_FLASK_FOOD_AUTO = "Auto announce when ReadyCheck" -- Needs review
L_GUI_ANNOUNCEMENTS_FLASK_FOOD_RAID = "Announce to raid channel" -- Needs review
L_GUI_ANNOUNCEMENTS_FEASTS = "Announce Feasts/Souls/Repair Bots cast" -- Needs review
L_GUI_ANNOUNCEMENTS_PORTALS = "Announce Portals/Ritual of Summoning cast" -- Needs review
L_GUI_ANNOUNCEMENTS_BAD_GEAR = "Check bad gear in instance" -- Needs review
L_GUI_ANNOUNCEMENTS_SAFARI_HAT = "Check Safari Hat" -- Needs review

-- Automation options
L_GUI_AUTOMATION = "Automation" -- Needs review
L_GUI_AUTOMATION_RELEASE = "Auto resurrección en los Campos de Batalla" -- Need review
L_GUI_AUTOMATION_SCREENSHOT = "Tomar una captura de pantalla cuando consigas un logro"
L_GUI_AUTOMATION_SOLVE_ARTIFACT = "Auto popup for solve artifact" -- Needs review
L_GUI_AUTOMATION_ACCEPT_INVITE = "Auto aceptar invitaciones"
L_GUI_AUTOMATION_DECLINE_DUEL = "Auto rechazar duelos"
L_GUI_AUTOMATION_ACCEPT_QUEST = "Auto aceptar misiones"
L_GUI_AUTOMATION_AUTO_COLLAPSE = "Auto collapse WatchFrame in instance" -- Needs review
L_GUI_AUTOMATION_AUTO_COLLAPSE_RELOAD = "Auto collapse ObjectiveTrackerFrame after reload" -- Need review
L_GUI_AUTOMATION_SKIP_CINEMATIC = "Auto skip cinematics/movies (disabled if hold Ctrl)" -- Needs review
L_GUI_AUTOMATION_AUTO_ROLE = "Auto set your role" -- Needs review
L_GUI_AUTOMATION_CANCEL_BAD_BUFFS = "Auto cancel various buffs" -- Needs review
L_GUI_AUTOMATION_TAB_BINDER = "Auto change Tab key to only target enemy players" -- Needs review
L_GUI_AUTOMATION_LOGGING_COMBAT = "Auto enables combat log text file in raid instances" -- Needs review
L_GUI_AUTOMATION_CURRENCY_CAP = "Auto popup for currency cap" -- Needs review
L_GUI_AUTOMATION_BUFF_ON_SCROLL = "Cast buff on mouse scroll" -- Needs review
L_GUI_AUTOMATION_OPEN_ITEMS = "Auto opening of items in bag" -- Needs review

-- Skins options
L_GUI_SKINS = "Estilización"
L_GUI_SKINS_BLIZZARD = "Activar estilizado de marcos de Blizzard"
L_GUI_SKINS_MINIMAP_BUTTONS = "Activar estilizado de los iconos de los addons en el minimapa"
L_GUI_SKINS_CLCR = "Activar estilo del CLCRet"
L_GUI_SKINS_CLCP = "Activar estilo del CLCProt"
L_GUI_SKINS_COMBUSTION_HELPER = "Activar estilo del CombustionHelper"
L_GUI_SKINS_BW = "Activar estilo del BigWigs"
L_GUI_SKINS_DBM = "Activar estilo del DBM"
L_GUI_SKINS_DBM_MOVABLE = "Allow to move DBM bars" -- Need review
L_GUI_SKINS_DXE = "Activar estilo del DXE"
L_GUI_SKINS_OMEN = "Activar estilo del Omen"
L_GUI_SKINS_RECOUNT = "Activar estilo del Recount"
L_GUI_SKINS_BLOOD_SHIELD_TRACKER = "Activar estilo del BloodShieldTracker"
L_GUI_SKINS_DOMINOS = "Activar estilo del Dominos"
L_GUI_SKINS_FLYOUT_BUTTON = "Activar estilo del FlyoutButtonCustom"
L_GUI_SKINS_NUG_RUNNING = "Activar estilo del NugRunning"
L_GUI_SKINS_OVALE = "Activar estilo del OvaleSpellPriority"
L_GUI_SKINS_CLIQUE = "Activar estilo del Clique"
L_GUI_SKINS_ACE3 = "Ace3 options elements skin" -- Needs review
L_GUI_SKINS_CAPPING = "Activar estilo del Capping"
L_GUI_SKINS_COOL_LINE = "Activar estilo del CoolLine"
L_GUI_SKINS_ATLASLOOT = "Activar estilo del AtlasLoot"
L_GUI_SKINS_TINY_DPS = "Activar estilo del TinyDPS"
L_GUI_SKINS_FACE_SHOOTER = "Activar estilo del FaceShooter"
L_GUI_SKINS_MAGE_NUGGETS = "Activar estilo del MageNuggets"
L_GUI_SKINS_NPCSCAN = "Activar estilo del NPCScan"
L_GUI_SKINS_VANASKOS = "Activar estilo del VanasKoS"
L_GUI_SKINS_WEAK_AURAS = "Activar estilo del WeakAuras"
L_GUI_SKINS_SKADA = "Activar estilo del Skada"
L_GUI_SKINS_MY_ROLE_PLAY = "Activar estilo del MyRolePlay"
L_GUI_SKINS_ARH = "Enable styling Archaeology Helper" -- Need review
L_GUI_SKINS_POSTAL = "Enable styling Postal" -- Need review
L_GUI_SKINS_OPIE = "Enable styling OPie" -- Need review
L_GUI_SKINS_REMATCH = "Enable styling Rematch" -- Need review
L_GUI_SKINS_LS_TOASTS = "Enable styling ls: Toasts" -- Need review

-- Combat text options
L_GUI_COMBATTEXT = "Texto de Combate"
L_GUI_COMBATTEXT_ENABLE = "Activar Texto de Combate"
L_GUI_COMBATTEXT_BLIZZ_HEAD_NUMBERS = "Usar la salida de daño/curación de Blizzard (sobre la cabeza del monstruo/jugador)"
L_GUI_COMBATTEXT_DAMAGE_STYLE = "Cambiar la fuente de daño/sanación por defecto de encima de los monstruos/jugadores (tendrás que reiniciar WoW para ver los cambios)"
L_GUI_COMBATTEXT_DAMAGE = "Mostrar daño saliente en su propio marco"
L_GUI_COMBATTEXT_HEALING = "Mostrar sanación saliente en su propio marco"
L_GUI_COMBATTEXT_HOTS = "Mostrar efectos de cura periódicos en el marco de curas"
L_GUI_COMBATTEXT_OVERHEALING = "Mostrar la sobrecuracion saliente"
L_GUI_COMBATTEXT_PET_DAMAGE = "Mostrar el daño de tu mascota"
L_GUI_COMBATTEXT_DOT_DAMAGE = "Mostrar el daño de tus dots (Daño periodico)"
L_GUI_COMBATTEXT_DAMAGE_COLOR = "Mostrar números de daño dependiendo de la escuela de magia"
L_GUI_COMBATTEXT_CRIT_PREFIX = "Símbolo que se añadirá antes de un crítico"
L_GUI_COMBATTEXT_CRIT_POSTFIX = "Símbolo que se añadirá después de un crítico"
L_GUI_COMBATTEXT_ICONS = "Mostrar iconos de daño saliente"
L_GUI_COMBATTEXT_ICON_SIZE = "Tamaño de los iconos de los hechizos en el marco de daño saliente, también tiene efecto sobre el tamaño de la fuente de daño"
L_GUI_COMBATTEXT_TRESHOLD = "Daño mínimo que se mostrar en el marco de daño"
L_GUI_COMBATTEXT_HEAL_TRESHOLD = "Sanación mínima que se mostrar en los mensajes de sanación entrante/saliente"
L_GUI_COMBATTEXT_SCROLLABLE = "Permitir usar la rueda del ratón para desplazar las líneas de los marcos"
L_GUI_COMBATTEXT_MAX_LINES = "Máx de líneas para mantener desplazables (a más lineas, más memoria requerida)"
L_GUI_COMBATTEXT_TIME_VISIBLE = "Tiempo (segundos) en que un mensaje es visible"
L_GUI_COMBATTEXT_DK_RUNES = "Mostrar recarga de runas de los Caballeros de la Muerte"
L_GUI_COMBATTEXT_KILLINGBLOW = "Mostrar tus golpes de gracia"
L_GUI_COMBATTEXT_MERGE_AOE_SPAM = "Unir el spam de daño de area en un solo mensaje"
L_GUI_COMBATTEXT_MERGE_MELEE = "Merges multiple auto attack damage spam" -- Needs review
L_GUI_COMBATTEXT_DISPEL = "Mostrar tus disipaciones"
L_GUI_COMBATTEXT_INTERRUPT = "Mostrar tus interrupciones"
L_GUI_COMBATTEXT_DIRECTION = "Scrolling Direction('top'(goes down) or 'bottom'(goes up))" -- Needs review
L_GUI_COMBATTEXT_SHORT_NUMBERS = "Use short numbers ('25.3k' instead of '25342')" -- Need review

-- Buffs reminder options
L_GUI_REMINDER = "Recordatorio de Ventajas"
L_GUI_REMINDER_SOLO_ENABLE = "Mostrar ventajas propias que faltan"
L_GUI_REMINDER_SOLO_SOUND = "Alerta sonora para avisar de ventajas propias"
L_GUI_REMINDER_SOLO_SIZE = "Tamaño de los iconos de las ventajas propias"
L_GUI_REMINDER_RAID_ENABLE = "Mostrar ventajas que faltan en la Banda"
L_GUI_REMINDER_RAID_ALWAYS = "Mostrar Recordatorio de Ventajas siempre"
L_GUI_REMINDER_RAID_SIZE = "Tamaño de los iconos de las ventajas de la Banda"
L_GUI_REMINDER_RAID_ALPHA = "Icono transparente cuando la ventaja está presente"

-- Raid cooldowns options
L_GUI_COOLDOWN_RAID = "Tiempos de reutilización de la Banda"
L_GUI_COOLDOWN_RAID_ENABLE = "Mostrar tiempos de reutilización de la Banda"
L_GUI_COOLDOWN_RAID_HEIGHT = "Altura de las barras de tiempo de reutilización de la Banda"
L_GUI_COOLDOWN_RAID_WIDTH = "Anchura de las barras de tiempo de reutilización de la Banda (Si el icono estб activado, anchura+28)"
L_GUI_COOLDOWN_RAID_SORT = "Barras de tiempos de reutilización de la Banda ordenadas hacia arriba"
L_GUI_COOLDOWN_RAID_EXPIRATION = "Sort by expiration time" -- Needs review
L_GUI_COOLDOWN_RAID_SHOW_SELF = "Show self cooldowns" -- Needs review
L_GUI_COOLDOWN_RAID_ICONS = "Iconos de tiempos de reutilización de la Banda"
L_GUI_COOLDOWN_RAID_IN_RAID = "Mostrar tiempos de reutilización de la Banda en zona de Banda"
L_GUI_COOLDOWN_RAID_IN_PARTY = "Mostrar tiempos de reutilización de la Banda en zona de Grupo"
L_GUI_COOLDOWN_RAID_IN_ARENA = "Mostrar tiempos de reutilización de la Banda en zona de Arena"

-- Enemy cooldowns options
L_GUI_COOLDOWN_ENEMY = "Tiempos de reutilización del enemigo"
L_GUI_COOLDOWN_ENEMY_ENABLE = "Activar tiempos de reutilización del enemigo"
L_GUI_COOLDOWN_ENEMY_SIZE = "Tamaño del icono de tiempos de reutilización del enemigo"
L_GUI_COOLDOWN_ENEMY_DIRECTION = "Icono de dirección de tiempos de reutilización del enemigo (RIGHT|LEFT|UP|DOWN)"
L_GUI_COOLDOWN_ENEMY_EVERYWHERE = "Mostrar tiempos de reutilización del enemigo siempre"
L_GUI_COOLDOWN_ENEMY_IN_BG = "Mostrar tiempos de reutilización del enemigo en zona de CB"
L_GUI_COOLDOWN_ENEMY_IN_ARENA = "Mostrar tiempos de reutilización del enemigo en zona de Arena"

-- Pulse cooldowns options
L_GUI_COOLDOWN_PULSE = "Cuenta atrás de tiempos de reutilización"
L_GUI_COOLDOWN_PULSE_ENABLE = "Mostrar cuentas atrás de tiempos de reutilización"
L_GUI_COOLDOWN_PULSE_SIZE = "Tamaño de los icono de las cuentas atras de tiempos de reutilización"
L_GUI_COOLDOWN_PULSE_SOUND = "Aviso sonoro"
L_GUI_COOLDOWN_PULSE_ANIM_SCALE = "Escalado animado"
L_GUI_COOLDOWN_PULSE_HOLD_TIME = "Opacidad máxima del tiempo de espera"
L_GUI_COOLDOWN_PULSE_THRESHOLD = "Umbral de tiempo mínimo"

-- Threat options
L_GUI_THREAT = "Barras de Amenaza"
L_GUI_THREAT_ENABLE = "Activar Barras de Amenaza"
L_GUI_THREAT_HEIGHT = "Altura de las barras de amenaza"
L_GUI_THREAT_WIDTH = "Anchura de las barras de amenaza"
L_GUI_THREAT_ROWS = "Número de barras de amenaza"
L_GUI_THREAT_HIDE_SOLO = "Mostrar solo en grupo/raid"

-- Tooltip options
L_GUI_TOOLTIP = "Descripciones"
L_GUI_TOOLTIP_ENABLE = "Activar descripciones"
L_GUI_TOOLTIP_SHIFT = "Mostrar descripción mientras Shift está pulsado"
L_GUI_TOOLTIP_CURSOR = "Descripción bajo el cursos"
L_GUI_TOOLTIP_ICON = "Icono del objeto en la descripción"
L_GUI_TOOLTIP_HEALTH = "Valor de la vida en números"
L_GUI_TOOLTIP_HIDE = "Ocultar descripciones de las barras de acción"
L_GUI_TOOLTIP_HIDE_COMBAT = "Ocultar descripción en combate"
L_GUI_TOOLTIP_TALENTS = "Mostrar descripción de los talentos"
L_GUI_TOOLTIP_ACHIEVEMENTS = "Comparar logros en la descripción"
L_GUI_TOOLTIP_TARGET = "Jugador objetivo en la descripción"
L_GUI_TOOLTIP_TITLE = "Player title in tooltip" -- Need review
L_GUI_TOOLTIP_REALM = "Player realm name in tooltip" -- Need review
L_GUI_TOOLTIP_RANK = "Rango del jugador en la hermandad en la descripción"
L_GUI_TOOLTIP_ARENA_EXPERIENCE = "Experiencia JcJ del jugador en Arenas en la descripción"
L_GUI_TOOLTIP_SPELL_ID = "ID del hechizo"
L_GUI_TOOLTIP_RAID_ICON = "Icono de banda"
L_GUI_TOOLTIP_WHO_TARGETTING = "Muestra quien está marcando la unidad que está en tu grupo/banda"
L_GUI_TOOLTIP_ITEM_COUNT = "Contador del objeto"
L_GUI_TOOLTIP_UNIT_ROLE = "Unit role" -- Needs review
L_GUI_TOOLTIP_INSTANCE_LOCK = "Your instance lock status in tooltip" -- Needs review

-- Chat options
L_GUI_CHAT_ENABLE = "Activar chat"
L_GUI_CHAT_BACKGROUND = "Activar fondo del chat"
L_GUI_CHAT_BACKGROUND_ALPHA = "Opacidad del fondo del chat"
L_GUI_CHAT_SPAM = "Remover ciertos mensajes de spam ('Jugador1' ha ganado un duelo a 'Jugador2')"
L_GUI_CHAT_GOLD = "Remover spam del algunos jugadores (Vendedores de oro)"
L_GUI_CHAT_WIDTH = "Anchura del chat"
L_GUI_CHAT_HEIGHT = "Altura del chat"
L_GUI_CHAT_BAR = "Pequeña barra de botones para cambiar de canal en el chat"
L_GUI_CHAT_BAR_MOUSEOVER = "Lite Button Bar on mouseover" -- Needs review
L_GUI_CHAT_TIMESTAMP = "Color de la marca de tiempo"
L_GUI_CHAT_WHISP = "Sonido cuando te susurran"
L_GUI_CHAT_SKIN_BUBBLE = "Estilizar las burbujas de chat"
L_GUI_CHAT_CL_TAB = "Mostrar la pestaña del Registro de Combate"
L_GUI_CHAT_TABS_MOUSEOVER = "Chat tabs on mouseover" -- Needs review
L_GUI_CHAT_STICKY = "Recordar último canal"
L_GUI_CHAT_DAMAGE_METER_SPAM = "Merge damage meter spam in one line-link" -- Needs review

-- Bag options
L_GUI_BAGS = "Bolsas"
L_GUI_BAGS_ENABLE = "Activar bolsas"
L_GUI_BAGS_ILVL = "Show item level for weapons and armor" -- Need review
L_GUI_BAGS_BUTTON_SIZE = "Tamaño de los huecos"
L_GUI_BAGS_BUTTON_SPACE = "Espacio entre huecos"
L_GUI_BAGS_BANK = "Número de columnas en el banco"
L_GUI_BAGS_BAG = "Número de columnas en la bolsa principal"

-- Minimap options
L_GUI_MINIMAP_ENABLE = "Activar minimapa"
L_GUI_MINIMAP_ICON = "Icono de seguimiento"
L_GUI_GARRISON_ICON = "Garrison icon" -- Need review
L_GUI_MINIMAP_SIZE = "Tamaño del minimapa"
L_GUI_MINIMAP_HIDE_COMBAT = "Ocultar minimapa en combate"
L_GUI_MINIMAP_TOGGLE_MENU = "Show toggle menu" -- Needs review

-- Map options
L_GUI_MAP_BG_STYLIZATION = "Estilizado del mapa de CB"
L_GUI_MAP_BOSS_COUNT = "Show boss count in World Map" -- Needs review
L_GUI_MAP_EXPLORE = "Tracking Explorer and Lore Master achievements in World Map" -- Needs review
L_GUI_MAP_FOG_OF_WAR = "Remove fog of war on World Map" -- Needs review

-- Loot options
L_GUI_LOOT_ENABLE = "Activar el marco de botín"
L_GUI_LOOT_ROLL_ENABLE = "Activar el marco de botín de grupo"
L_GUI_LOOT_ICON_SIZE = "Tamaño de los iconos"
L_GUI_LOOT_WIDTH = "Anchura del marco de botín"
L_GUI_LOOT_AUTOGREED = "Activar auto-codicia para objetos verdes cuando eres nivel máx"
L_GUI_LOOT_AUTODE = "Auto confirmar desencantar"

-- Nameplate options
L_GUI_NAMEPLATE_ENABLE = "Activar placas de nombre"
L_GUI_NAMEPLATE_COMBAT = "Mostrar automáticamente placa de nombre en combate"
L_GUI_NAMEPLATE_HEALTH = "Valor de la vida en números"
L_GUI_NAMEPLATE_CASTBAR = "Mostrar barra de lanzamiento en la placa de nombre"
L_GUI_NAMEPLATE_HEIGHT = "Altura de la placa de nombre"
L_GUI_NAMEPLATE_WIDTH = "Anchura de la placa de nombre"
L_GUI_NAMEPLATE_DISTANCE = "Show nameplates for units within this range" -- Need review
L_GUI_NAMEPLATE_AD_HEIGHT = "Altura adicional para la placa de nombre seleccionada"
L_GUI_NAMEPLATE_AD_WIDTH = "Anchura adicional para la placa de nombre seleccionada"
L_GUI_NAMEPLATE_CASTBAR_NAME = "Mostrar nombre del hechizo en la barra de lanzamiento"
L_GUI_NAMEPLATE_THREAT = "Activar visor de amenaza, cambia automáticamente según tu rol"
L_GUI_NAMEPLATE_CLASS_ICON = "Iconos de clase en JcJ"
L_GUI_NAMEPLATE_NAME_ABBREV = "Mostrar los nombres abreviados"
L_GUI_NAMEPLATE_CLAMP = "Clamp nameplates to the top of the screen when outside of view" -- Need review
L_GUI_NAMEPLATE_GOOD_COLOR = "Color de alta amenaza, varía dependiendo si eres tanque o dps/sanador"
L_GUI_NAMEPLATE_NEAR_COLOR = "Color de perdiendo/ganando amenaza"
L_GUI_NAMEPLATE_BAD_COLOR = "Color de baja amenaza, varía dependiendo si eres tanque o dps/sanador"
L_GUI_NAMEPLATE_OFFTANK_COLOR = "Offtank threat color" -- Need review
L_GUI_NAMEPLATE_SHOW_DEBUFFS = "Mostrar perjuicios (Nombres abreviados debe ser desactivado)"
L_GUI_NAMEPLATE_SHOW_BUFFS = "Show buffs above player nameplate (from the list)" -- Need review
L_GUI_NAMEPLATE_DEBUFFS_SIZE = "Tamaño de los perjuicios"
L_GUI_NAMEPLATE_HEALER_ICON = "Show icon above enemy healers nameplate in battlegrounds" -- Needs review
L_GUI_NAMEPLATE_TOTEM_ICONS = "Show icon above enemy totems nameplate" -- Need review

-- ActionBar options
L_GUI_ACTIONBAR_ENABLE = "Activar barras de acción"
L_GUI_ACTIONBAR_HOTKEY = "Mostrar texto los atajos de teclado"
L_GUI_ACTIONBAR_MACRO = "Mostrar nombre de la macro en los botones"
L_GUI_ACTIONBAR_GRID = "Mostrar botones de la barra de acción vacíos"
L_GUI_ACTIONBAR_BUTTON_SIZE = "Tamaño de los botones"
L_GUI_ACTIONBAR_BUTTON_SPACE = "Espacio entre botones"
L_GUI_ACTIONBAR_SPLIT_BARS = "Dividir la quinta barra en dos de 6 botones cada una"
L_GUI_ACTIONBAR_CLASSCOLOR_BORDER = "Activar borde por color de clase para los botones"
L_GUI_ACTIONBAR_TOGGLE_MODE = "Activar modo cambiar"
L_GUI_ACTIONBAR_HIDE_HIGHLIGHT = "Hide proc highlight" -- Needs review
L_GUI_ACTIONBAR_BOTTOMBARS = "Número de barras de acción abajo (1, 2 o 3)"
L_GUI_ACTIONBAR_RIGHTBARS = "Número de barras de acción en la derecha (0, 1, 2 o 3)"
L_GUI_ACTIONBAR_RIGHTBARS_MOUSEOVER = "Barras de la derecha se muestran al pasar el ratón"
L_GUI_ACTIONBAR_PETBAR_MOUSEOVER = "Barra de mascota al pasar el ratón (sólo para la barra de mascota horizontal)"
L_GUI_ACTIONBAR_PETBAR_HIDE = "Ocultar barra de mascota"
L_GUI_ACTIONBAR_PETBAR_HORIZONTAL = "Activar barra de mascota horizontal"
L_GUI_ACTIONBAR_STANCEBAR_MOUSEOVER = "Barras de Cambios de forma/Estancias al pasar el ratón"
L_GUI_ACTIONBAR_STANCEBAR_HIDE = "Ocultar cambio de forma"
L_GUI_ACTIONBAR_STANCEBAR_HORIZONTAL = "Activar barra de estancia horizontal"
L_GUI_ACTIONBAR_MICROMENU = "Enable micro menu" -- Needs review
L_GUI_ACTIONBAR_MICROMENU_MOUSEOVER = "Micro menu on mouseover" -- Needs review

-- Auras/Buffs/Debuffs
L_GUI_AURA_PLAYER_BUFF_SIZE = "Tamaño de las beneficios del jugador"
L_GUI_AURA_SHOW_SPIRAL = "Espiral en los iconos de las auras"
L_GUI_AURA_SHOW_TIMER = "Mostrar tiempo de reutilización en los iconos de las auras"
L_GUI_AURA_PLAYER_AURAS = "Auras en el marco del jugador"
L_GUI_AURA_TARGET_AURAS = "Auras en el marco del objetivo"
L_GUI_AURA_FOCUS_DEBUFFS = "Perjuicios en el marco del foco"
L_GUI_AURA_FOT_DEBUFFS = "Perjuicios en el marco del objetivo del foco"
L_GUI_AURA_PET_DEBUFFS = "Perjuicios en el marco de la mascota"
L_GUI_AURA_TOT_DEBUFFS = "Perjuicios en el marco del objetivo del objetivo"
L_GUI_AURA_BOSS_BUFFS = "Beneficios en el marco del jefe"
L_GUI_AURA_PLAYER_AURA_ONLY = "Solo tus perjuicios en el marco del objetivo"
L_GUI_AURA_DEBUFF_COLOR_TYPE = "Color de los perjuicios por tipo"
L_GUI_AURA_CAST_BY = "Mostrar quién lanza un beneficio/perjuicio en su descripción"
L_GUI_AURA_CLASSCOLOR_BORDER = "Activar borde por color de clase para los beneficios del jugador"

-- Filger
L_GUI_FILGER = "Timers (Filger)" -- Need review
L_GUI_FILGER_ENABLE = "Enable Filger" -- Need review
L_GUI_FILGER_TEST_MODE = "Test icon mode" -- Need review
L_GUI_FILGER_MAX_TEST_ICON = "The number of icons to the test" -- Need review
L_GUI_FILGER_SHOW_TOOLTIP = "Show tooltip" -- Need review
L_GUI_FILGER_DISABLE_CD = "Disable cooldowns" -- Need review
L_GUI_FILGER_BUFFS_SIZE = "Buffs size" -- Need review
L_GUI_FILGER_COOLDOWN_SIZE = "Cooldowns size" -- Need review
L_GUI_FILGER_PVP_SIZE = "PvP debuffs size" -- Need review

-- Unit Frames options
L_GUI_UF_ENABLE = "Activar marcos de unidades"
L_GUI_UF_OWN_COLOR = "Color para las barras de vida"
L_GUI_UF_UF_COLOR = "Color de las Barras de vida (si color para las barras de vida está activo)"
L_GUI_UF_ENEMY_HEALTH_COLOR = "Barra de vida del enemigo objetivo en rojo"
L_GUI_UF_TOTAL_VALUE = "Mostrar vida restante en jugador y objetivo con XXXX/Total"
L_GUI_UF_COLOR_VALUE = "Colorear valor de Vida/Maná"
L_GUI_UF_BAR_COLOR_VALUE = "Color de la barra de vida dependiendo de la vida restante"
L_GUI_UF_LINES = "Show Player and Target lines" -- Need review
L_GUI_UF_UNIT_CASTBAR = "Mostrar barras de lanzamiento"
L_GUI_UF_CASTBAR_ICON = "Mostrar iconos en las barras de lanzamiento"
L_GUI_UF_CASTBAR_LATENCY = "Latencia en la barra de lanzamiento"
L_GUI_UF_CASTBAR_TICKS = "Castbar ticks" -- Needs review
L_GUI_UF_SHOW_PET = "Mostrar marco de la mascota"
L_GUI_UF_SHOW_FOCUS = "Mostrar marco del foco"
L_GUI_UF_SHOW_TOT = "Mostrar marco del objetivo del objetivo"
L_GUI_UF_SHOW_BOSS = "Mostrar marco del jefe"
L_GUI_UF_BOSS_RIGHT = "Marco/Marcos del/de los jefe/jefes en la derecha"
L_GUI_UF_SHOW_ARENA = "Mostrar marcos de arena"
L_GUI_UF_ARENA_RIGHT = "Marcos de arena en la derecha"
L_GUI_UF_BOSS_DEBUFFS = "Number of debuffs on the boss frames" -- Need review
L_GUI_UF_BOSS_BUFFS = "Number of buffs on the boss frames" -- Need review
L_GUI_UF_ICONS_PVP = "Texto JcJ (iconos no) al pasar el ratón sobre los marcos del jugador y objetivo"
L_GUI_UF_ICONS_COMBAT = "Icono de combate"
L_GUI_UF_ICONS_RESTING = "Icono de descansado para pjs con nivel bajo"
L_GUI_UF_PORTRAIT_ENABLE = "Activar retratos del jugador/objetivo"
L_GUI_UF_PORTRAIT_CLASSCOLOR_BORDER = "Borde de color de clase para los retratos"
L_GUI_UF_PORTRAIT_HEIGHT = "Altura del retrato"
L_GUI_UF_PORTRAIT_WIDTH = "Anchura del retrato"
L_GUI_UF_PLUGINS_GCD = "Brillo de tiempo de reutilización global"
L_GUI_UF_PLUGINS_SWING = "Activar barra de oscilación"
L_GUI_UF_PLUGINS_REPUTATION_BAR = "Activar barra de reputación"
L_GUI_UF_PLUGINS_EXPERIENCE_BAR = "Activar barra de experiencia"
L_GUI_UF_PLUGINS_ARTIFACT_BAR = "Artifact Power bar" -- Need review
L_GUI_UF_PLUGINS_SMOOTH_BAR = "Activar barra de suavizado"
L_GUI_UF_PLUGINS_ENEMY_SPEC = "Mostrar configuración de los talentos del enemigo"
L_GUI_UF_PLUGINS_COMBAT_FEEDBACK = "Texto de combate en el marco del jugador/objetivo"
L_GUI_UF_PLUGINS_FADER = "Desvanecer marcos de unidades"
L_GUI_UF_PLUGINS_DIMINISHING = "Diminishing Returns icons on arena frames" -- Needs review

-- Unit Frames Class bar options
L_GUI_UF_PLUGINS_CLASS_BAR = "Unit Frames Class bars" -- Needs review
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
L_GUI_UF_PLUGINS_RANGE_BAR = "Enable Range bar (for Priest)" -- Needs review

-- Raid Frames options
L_GUI_UF_BY_ROLE = "Sorting players in group by role" -- Needs review
L_GUI_UF_AGGRO_BORDER = "Borde de aggro"
L_GUI_UF_DEFICIT_HEALTH = "Déficit de vida de la banda"
L_GUI_UF_SHOW_PARTY = "Mostrar marcos de grupo en la banda"
L_GUI_UF_SHOW_RAID = "Mostrar marcos de banda"
L_GUI_UF_VERTICAL_HEALTH = "Orientación vertical de la vida"
L_GUI_UF_ALPHA_HEALTH = "Opacidad de las barras de vida cuando están al 100%"
L_GUI_UF_SHOW_RANGE = "Mostrar rango de opacidad para los marcos de banda"
L_GUI_UF_RANGE_ALPHA = "Opacidad de los marcos de unidades cuando están fuera de rango"
L_GUI_UF_SOLO_MODE = "Mostrar marco del jugador siempre"
L_GUI_UF_PLAYER_PARTY = "Mostrar marco del jugador en grupo"
L_GUI_UF_SHOW_TANK = "Mostrar tanques de la banda"
L_GUI_UF_SHOW_TANK_TT = "Mostrar el objetivo del objetivo de los tanques de la banda"
L_GUI_UF_RAID_GROUP = "Número de grupos en la banda"
L_GUI_UF_RAID_VERTICAL_GROUP = "Grupos de la banda en vertical (only for heal layout)" -- Needs review
L_GUI_UF_ICONS_LEADER = "Iconos de líder, ayudantes y maestro despojador en los marcos"
L_GUI_UF_ICONS_ROLE = "Role icon on frames" -- Needs review
L_GUI_UF_ICONS_RAID_MARK = "Marcas de banda"
L_GUI_UF_ICONS_READY_CHECK = "Iconos de comprobación"
L_GUI_UF_PLUGINS_DEBUFFHIGHLIGHT_ICON = "Remarcar textura de desventajas + icono"
L_GUI_UF_PLUGINS_AURA_WATCH = "'BANDA' Ver las auras"
L_GUI_UF_PLUGINS_AURA_WATCH_TIMER = "Temporizador en los iconos de perjuicios de la banda"
L_GUI_UF_PLUGINS_PVP_DEBUFFS = "Show also PvP debuff icons (from the list)" -- Need review
L_GUI_UF_PLUGINS_HEALCOMM = "Barra de sanación entrante"
L_GUI_UF_PLUGINS_AUTO_RESURRECTION = "Auto lanzar resurreción con click central cuando la unidad este muerta (no funciona cuando Clique está activado)"

-- Panel options
L_GUI_TOP_PANEL = "Panel superior"
L_GUI_TOP_PANEL_ENABLE = "Activar panel superior"
L_GUI_TOP_PANEL_MOUSE = "Panel superior al pasar el ratón"
L_GUI_TOP_PANEL_WIDTH = "Anchura del panel"
L_GUI_TOP_PANEL_HEIGHT = "Altura del panel"

-- Stats options
L_GUI_STATS = "Estadísticas"
L_GUI_STATS_BG = "Campo de Batalla"
L_GUI_STATS_CLOCK = "Reloj"
L_GUI_STATS_LATENCY = "Latencia"
L_GUI_STATS_MEMORY = "Memoria"
L_GUI_STATS_FPS = "FPS (Marcos por segundo)"
L_GUI_STATS_EXPERIENCE = "Experiencia"
L_GUI_STATS_COORDS = "Coordenadas"
L_GUI_STATS_LOCATION = "Localización"
L_GUI_STATS_CURRENCY_ARCHAEOLOGY = "Show Archaeology Fragments under currency tab" -- Needs review
L_GUI_STATS_CURRENCY_COOKING = "Show Cooking Awards under currency tab" -- Needs review
L_GUI_STATS_CURRENCY_PROFESSIONS = "Show Profession Tokens under currency tab" -- Needs review
L_GUI_STATS_CURRENCY_RAID = "Show Raid Seals under currency tab" -- Needs review
L_GUI_STATS_CURRENCY_PVP = "Show PvP Currency under currency tab" -- Needs review
L_GUI_STATS_CURRENCY_MISCELLANEOUS = "Show Miscellaneous Currency under currency tab" -- Needs review

-- Error options
L_GUI_ERROR = "Errores"
L_GUI_ERROR_BLACK = "Ocultar errores de la lista negra"
L_GUI_ERROR_WHITE = "Mostrar errores de la lista blanca"
L_GUI_ERROR_HIDE_COMBAT = "Hide all errors in combat" -- Needs review
