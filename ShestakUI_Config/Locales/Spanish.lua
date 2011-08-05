if GetLocale() ~= "esES" or GetLocale() ~= "esMX" then return end

----------------------------------------------------------------------------------------
--	Localization for esES and esMX client(Thanks to eXecrate for the translation)
----------------------------------------------------------------------------------------
L_GUI_BUTTON_RESET = "Reinicio total de la UI"
L_GUI_SET_SAVED_SETTTINGS = "Cambios aplicables sólo a este PJ"
L_GUI_RESET_CHAR = "¿Estás seguro de que quieres reiniciar tus preferencias de ShestakUI para este PJ?"
L_GUI_RESET_ALL = "¿Estás seguro de que quieres reiniciar tus preferencias de ShestakUI para todos los PJs?"
L_GUI_PER_CHAR = "¿Estás segudo de que quieres cambiar a o desde 'Cambios sólo a este PJ'?"
L_GUI_MAKE_SELECTION = "Debes hacer una selección antes de continuar la configuración."

-- General options
L_GUI_GENERAL_AUTOSCALE = "Auto escalado de la UI"
L_GUI_GENERAL_MULTISAMPLE = "Protección del Multimuestreo (elimina el borde de 1px)"
L_GUI_GENERAL_UISCALE = "Escalado de la UI (si auto escalado está desactivado)"
L_GUI_GENERAL_WELCOME_MESSAGE = "Mensaje de bienvenida en el chat"
L_GUI_GENERAL_LAG_TOLERANCE = "Actualizar automaticamente la opción de Tolerancia al Lag Personalizada de Blizzard a tu latencia"

-- Miscellaneous options
L_GUI_MISC_AUTOQUEST = "Auto aceptar misiones"
L_GUI_MISC_AUTODUEL = "Auto rechazar duelos"
L_GUI_MISC_AUTOACCEPT = "Auto aceptar invitaciones"
L_GUI_MISC_AUTORESSURECT = "Auto resurrección en los Campos de Batalla"
L_GUI_MISC_MARKING = "Marca el objetivo cuando pulsas *shift*"
L_GUI_MISC_INVKEYWORD = "Acrónimo para invitaciones (/ainv)"
L_GUI_MISC_SPIN_CAMERA = "Rotar cámara mientras estás ausente"
L_GUI_MISC_VEHICLE_MOUSEOVER = "Marco del Vehículo al pasar el ratón por encima"
L_GUI_MISC_QUEST_AUTOBUTTON = "Auto botón misión/objeto"
L_GUI_MISC_RAID_TOOLS = "Herramientas de Raid"
L_GUI_MISC_ACH_SCREENS = "Tomar una captura de pantalla cuando consigas un logro"

-- Announcements options
L_GUI_ANNOUNCEMENTS = "Announcements" -- Needs review
L_GUI_ANNOUNCEMENTS_DRINKING = "Announce in chat when arena enemy is drinking" -- Needs review
L_GUI_ANNOUNCEMENTS_INTERRUPTS = "Anunciar en el grupo/banda cuando interrumpes"
L_GUI_ANNOUNCEMENTS_SPELLS = "Announce in party/raid when you cast same spell" -- Needs review

-- Skins options
L_GUI_SKINS = "Estilización"
L_GUI_SKINS_BW = "Activar estilo del BigWigs"
L_GUI_SKINS_DBM = "Activar estilo del DBM"
L_GUI_SKINS_DXE = "Activar estilo del DXE"
L_GUI_SKINS_KLE = "Activar estilo del KLE"
L_GUI_SKINS_OMEN = "Activar estilo del Omen"
L_GUI_SKINS_PP = "Activar estilo del PallyPower"
L_GUI_SKINS_RECOUNT = "Activar estilo del Recount"

-- Combat text options
L_GUI_COMBATTEXT = "Texto de Combate"
L_GUI_COMBATTEXT_ENABLE = "Activar Texto de Combate"
L_GUI_COMBATTEXT_BLIZZ_HEAD_NUMBERS = "Usar la salida de daño/curación de Blizzard (sobre la cabeza del monstruo/jugador)"
L_GUI_COMBATTEXT_DAMAGE_STYLE = "Cambiar la fuente de daño/sanación por defecto de encima de los monstruos/jugadores (tendrás que reiniciar WoW para ver los cambios)"
L_GUI_COMBATTEXT_DAMAGE = "Mostrar daño saliente en su propio marco"
L_GUI_COMBATTEXT_HEALING = "Mostrar sanación saliente en su propio marco"
L_GUI_COMBATTEXT_HOTS = "Mostrar efectos de cura periódicos en el marco de curas"
L_GUI_COMBATTEXT_OVERHEALING = "Show outgoing overhealing" -- Needs review
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
L_GUI_COMBATTEXT_STOP_VE_SPAM = "Ocultar automáticamente el spam de sanación del Sacerdote cuando estás en Forma de las Sombras"
L_GUI_COMBATTEXT_DK_RUNES = "Mostrar recarga de runas de los Caballeros de la Muerte"
L_GUI_COMBATTEXT_KILLINGBLOW = "Mostrar tus golpes de gracia"
L_GUI_COMBATTEXT_MERGE_AOE_SPAM = "Unir el spam de daño de area en un solo mensaje"
L_GUI_COMBATTEXT_MERGE_AOE_SPAM_TIME = "Tiempo en segundos que se unirá en un solo mensaje de daño de area"
L_GUI_COMBATTEXT_DISPEL = "Mostrar tus disipaciones"
L_GUI_COMBATTEXT_INTERRUPT = "Mostrar tus interrupciones"

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

-- Threat options
L_GUI_THREAT = "Barras de Amenaza"
L_GUI_THREAT_ENABLE = "Activar Barras de Amenaza"
L_GUI_THREAT_HEIGHT = "Altura de las barras de amenaza"
L_GUI_THREAT_WIDTH = "Anchura de las barras de amenaza"
L_GUI_THREAT_ROWS = "Número de barras de amenaza"
L_GUI_THREAT_HIDE_SOLO = "Show only in party/raid" -- Needs review

-- Tooltip options
L_GUI_TOOLTIP = "Descripciones"
L_GUI_TOOLTIP_ENABLE = "Activar descripciones"
L_GUI_TOOLTIP_SHIFT = "Mostrar descripción mientras *shift* está pulsado"
L_GUI_TOOLTIP_CURSOR = "Descripción bajo el cursos"
L_GUI_TOOLTIP_ICON = "Icono del objeto en la descripción"
L_GUI_TOOLTIP_HEALTH = "Valor de la vida en números"
L_GUI_TOOLTIP_HIDE = "Ocultar descripciones de las barras de acción"
L_GUI_TOOLTIP_HIDE_COMBAT = "Ocultar descripción en combate"
L_GUI_TOOLTIP_TALENTS = "Mostrar descripción de los talentos"
L_GUI_TOOLTIP_ACHIEVEMENTS = "Comparar logros en la descripción"
L_GUI_TOOLTIP_TARGET = "Jugador objetivo en la descripción"
L_GUI_TOOLTIP_TITLE = "Título del jugador en la descripción"
L_GUI_TOOLTIP_RANK = "Rango del jugador en la hermandad en la descripción"
L_GUI_TOOLTIP_ARENA_EXPERIENCE = "Experiencia JcJ del jugador en Arenas en la descripción"
L_GUI_TOOLTIP_SPELL_ID = "ID del hechizo"
L_GUI_TOOLTIP_RAID_ICON = "Icono de banda"
L_GUI_TOOLTIP_WHO_TARGETTING = "Muestra quien está marcando la unidad que está en tu grupo/banda"
L_GUI_TOOLTIP_ITEM_COUNT = "Item count" -- Needs review

-- Chat options
L_GUI_CHAT_ENABLE = "Activar chat"
L_GUI_CHAT_BACKGROUND = "Activar fondo del chat"
L_GUI_CHAT_BACKGROUND_ALPHA = "Opacidad del fondo del chat"
L_GUI_CHAT_SPAM = "Remover ciertos mensajes de spam (*Jugador1* ha ganado un duelo a *Jugador2*)"
L_GUI_CHAT_GOLD = "Remover spam del algunos jugadores (Vendedores de oro)"
L_GUI_CHAT_WIDTH = "Anchura del chat"
L_GUI_CHAT_HEIGHT = "Altura del chat"
L_GUI_CHAT_BAR = "Pequeña barra de botones para cambiar de canal en el chat"
L_GUI_CHAT_TIMESTAMP = "Color de la marca de tiempo"
L_GUI_CHAT_WHISP = "Sonido cuando te susurran"
L_GUI_CHAT_SKIN_BUBBLE = "Estilizar las burbujas de chat"
L_GUI_CHAT_CL_TAB = "Mostrar la pestaña del Registro de Combate"
L_GUI_CHAT_STICKY = "Recordar último canal"

-- Bag options
L_GUI_BAGS = "Bolsas"
L_GUI_BAGS_ENABLE = "Activar bolsas"
L_GUI_BAGS_BUTTON_SIZE = "Tamaño de los huecos"
L_GUI_BAGS_BUTTON_SPACE = "Espacio entre huecos"
L_GUI_BAGS_BANK = "Número de columnas en el banco"
L_GUI_BAGS_BAG = "Número de columnas en la bolsa principal"

-- Minimap options
L_GUI_MINIMAP_ENABLE = "Activar minimapa"
L_GUI_MINIMAP_ICON = "Icono de seguimiento"
L_GUI_MINIMAP_SIZE = "Tamaño del minimapa"
L_GUI_MINIMAP_HIDE_COMBAT = "Ocultar minimapa en combate"
L_GUI_MINIMAP_MERGE_MENUS = "Merge main and addon buttons in toggle menu"

-- Map options
L_GUI_MAP_ENABLE = "Activar mapa del mundo"
L_GUI_MAP_SCALE = "Escalado del mapa del mundo"
L_GUI_MAP_BG_STYLIZATION = "Estilizado del mapa de CB"

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
L_GUI_NAMEPLATE_AD_HEIGHT = "Additional height for selected nameplate" -- Needs review
L_GUI_NAMEPLATE_AD_WIDTH = "Additional width for selected nameplate" -- Needs review
L_GUI_NAMEPLATE_CASTBAR_NAME = "Mostrar nombre del hechizo en la barra de lanzamiento"
L_GUI_NAMEPLATE_THREAT = "Activar visor de amenaza, cambia automáticamente según tu rol"
L_GUI_NAMEPLATE_CLASS_ICON = "Iconos de clase en JcJ"
L_GUI_NAMEPLATE_NAME_ABBREV = "Mostrar los nombres abreviados"
L_GUI_NAMEPLATE_GOOD_COLOR = "Color de alta amenaza, varía dependiendo si eres tanque o dps/sanador"
L_GUI_NAMEPLATE_NEAR_COLOR = "Color de perdiendo/ganando amenaza"
L_GUI_NAMEPLATE_BAD_COLOR = "Color de baja amenaza, varía dependiendo si eres tanque o dps/sanador"
L_GUI_NAMEPLATE_SHOW_DEBUFFS = "Show debuffs (Abbreviated names must be turned off)" -- Needs review

-- ActionBar options
L_GUI_ACTIONBAR_ENABLE = "Activar barras de acción"
L_GUI_ACTIONBAR_HOTKEY = "Mostrar texto los atajos de teclado"
L_GUI_ACTIONBAR_MACRO = "Show macro name on buttons" -- Needs review
L_GUI_ACTIONBAR_GRID = "Mostrar botones de la barra de acción vacíos"
L_GUI_ACTIONBAR_BUTTON_SIZE = "Tamaño de los botones"
L_GUI_ACTIONBAR_BUTTON_SPACE = "Espacio entre botones"
L_GUI_ACTIONBAR_SPLIT_BARS = "Dividir la quinta barra en dos de 6 botones cada una"
L_GUI_ACTIONBAR_CLASSCOLOR_BORDER = "Activar borde por color de clase para los botones"
L_GUI_ACTIONBAR_TOGGLE_MODE = "Activar modo cambiar"
L_GUI_ACTIONBAR_BOTTOMBARS = "Número de barras de acción abajo (1, 2 o 3)"
L_GUI_ACTIONBAR_RIGHTBARS = "Número de barras de acción en la derecha (0, 1, 2 o 3)"
L_GUI_ACTIONBAR_RIGHTBARS_MOUSEOVER = "Barras de la derecha se muestran al pasar el ratón"
L_GUI_ACTIONBAR_PETBAR_MOUSEOVER = "Barra de mascota al pasar el ratón (sólo para la barra de mascota horizontal)"
L_GUI_ACTIONBAR_PETBAR_HIDE = "Ocultar barra de mascota"
L_GUI_ACTIONBAR_PETBAR_HORIZONTAL = "Activar barra de mascota horizontal"
L_GUI_ACTIONBAR_SHAPESHIFT_MOUSEOVER = "Barras de Cambios de forma/Estancias/Totems al pasar el ratón"
L_GUI_ACTIONBAR_SHAPESHIFT_HIDE = "Ocultar cambio de forma"
L_GUI_ACTIONBAR_SHAPESHIFT_HORIZONTAL = "Activar barra de estancia horizontal"

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
L_GUI_AURA_BOSS_BUFFS = "Buffs on boss frame" -- Needs review
L_GUI_AURA_PLAYER_AURA_ONLY = "Solo tus perjuicios en el marco del objetivo"
L_GUI_AURA_DEBUFF_COLOR_TYPE = "Color de los perjuicios por tipo"
L_GUI_AURA_CAST_BY = "Mostrar quién lanza un beneficio/perjuicio en su descripción"
L_GUI_AURA_CLASSCOLOR_BORDER = "Activar borde por color de clase para los beneficios del jugador"

-- Unit Frames options
L_GUI_UF_ENABLE = "Activar marcos de unidades"
L_GUI_UF_OWN_COLOR = "Color para las barras de vida"
L_GUI_UF_UF_COLOR = "Color de las Barras de vida (si color para las barras de vida está activo)"
L_GUI_UF_ENEMY_HEALTH_COLOR = "Barra de vida del enemigo objetivo en rojo"
L_GUI_UF_TOTAL_VALUE = "Mostrar vida restante en jugador y objetivo con XXXX/Total"
L_GUI_UF_COLOR_VALUE = "Colorear valor de Vida/Maná"
L_GUI_UF_BAR_COLOR_VALUE = "Color de la barra de vida dependiendo de la vida restante"
L_GUI_UF_UNIT_CASTBAR = "Mostrar barras de lanzamiento"
L_GUI_UF_CASTBAR_ICON = "Mostrar iconos en las barras de lanzamiento"
L_GUI_UF_CASTBAR_LATENCY = "Latencia en la barra de lanzamiento"
L_GUI_UF_SHOW_PET = "Mostrar marco de la mascota"
L_GUI_UF_SHOW_FOCUS = "Mostrar marco del foco"
L_GUI_UF_SHOW_TOT = "Mostrar marco del objetivo del objetivo"
L_GUI_UF_SHOW_BOSS = "Mostrar marco del jefe"
L_GUI_UF_BOSS_RIGHT = "Marco/Marcos del/de los jefe/jefes en la derecha"
L_GUI_UF_SHOW_ARENA = "Mostrar marcos de arena"
L_GUI_UF_ARENA_RIGHT = "Marcos de arena en la derecha"
L_GUI_UF_ICONS_PVP = "Texto JcJ (iconos no) al pasar el ratón sobre los marcos del jugador y objetivo"
L_GUI_UF_ICONS_COMBAT = "Icono de combate"
L_GUI_UF_ICONS_RESTING = "Icono de descansado para pjs con nivel bajo"
L_GUI_UF_ICONS_COMBO_POINT = "Iconos de puntos de combo de Pícaros|Druidas"
L_GUI_UF_ICONS_COMBO_POINT_NEW = "New style for combo points" -- Needs review
L_GUI_UF_PORTRAIT_ENABLE = "Activar retratos del jugador/objetivo"
L_GUI_UF_PORTRAIT_CLASSCOLOR_BORDER = "Borde de color de clase para los retratos"
L_GUI_UF_PORTRAIT_HEIGHT = "Altura del retrato"
L_GUI_UF_PORTRAIT_WIDTH = "Anchura del retrato"
L_GUI_UF_PLUGINS_GCD = "Brillo de tiempo de reutilización global"
L_GUI_UF_PLUGINS_SWING = "Activar barra de oscilación"
L_GUI_UF_PLUGINS_ECLIPSE_BAR = "Activar barra de eclipse"
L_GUI_UF_PLUGINS_HOLY_BAR = "Activar barra de poder sagrado"
L_GUI_UF_PLUGINS_SHARD_BAR = "Activar barra de fragmentos"
L_GUI_UF_PLUGINS_RUNE_BAR = "Activar barra de Runas"
L_GUI_UF_PLUGINS_VENGEANCE_BAR = "Activar barra de venganza"
L_GUI_UF_PLUGINS_TOTEM_BAR = "Activar barra de totems"
L_GUI_UF_PLUGINS_TOTEM_BAR_NAME = "Nombre de la barra de totems"
L_GUI_UF_PLUGINS_REPUTATION_BAR = "Activar barra de reputación"
L_GUI_UF_PLUGINS_EXPERIENCE_BAR = "Activar barra de experiencia"
L_GUI_UF_PLUGINS_SMOOTH_BAR = "Activar barra de suavizado"
L_GUI_UF_PLUGINS_TALENTS = "Mostrar configuración de los talentos del enemigo"
L_GUI_UF_PLUGINS_COMBAT_FEEDBACK = "Texto de combate en el marco del jugador/objetivo"
L_GUI_UF_PLUGINS_FADER = "Desvanecer marcos de unidades"

-- Raid Frames options
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
L_GUI_UF_RAID_GROUP = "Número de grupos en la banda (Sólo para ShestakUI_Heal)"
L_GUI_UF_RAID_VERTICAL_GROUP = "Grupos de la banda en vertical (Sólo para ShestakUI_Heal)"
L_GUI_UF_ICONS_LEADER = "Iconos de líder, ayudantes y maestro despojador en los marcos"
L_GUI_UF_ICONS_LFD_ROLE = "Iconos de rol en el grupo en los marcos"
L_GUI_UF_ICONS_RAID_MARK = "Marcas de banda"
L_GUI_UF_ICONS_READY_CHECK = "Iconos de comprobación"
L_GUI_UF_PLUGINS_DEBUFFHIGHLIGHT_ICON = "Remarcar textura de desventajas + icono"
L_GUI_UF_PLUGINS_AURA_WATCH = "*BANDA* Ver las auras"
L_GUI_UF_PLUGINS_AURA_WATCH_TIMER = "Timer on raid debuff icons" -- Needs review
L_GUI_UF_PLUGINS_HEALCOMM = "Barra de sanación entrante"

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
L_GUI_STATS_GUILD_REPAIR = "Reparar con dinero de la hermandad"

-- Error options
L_GUI_ERROR = "Errores"
L_GUI_ERROR_HIDE = "Ocultar errores"
L_GUI_ERROR_BLACK = "Ocultar errores de la lista negra"
L_GUI_ERROR_WHITE = "Mostrar errores de la lista blanca"
L_GUI_ERROR_HIDE_COMBAT = "Ocultar errores en combate"