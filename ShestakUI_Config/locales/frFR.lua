----------------------------------------------------------------------------------------
--	Localization for frFR client(Thanks to Cranan for the translation)
----------------------------------------------------------------------------------------
if GetLocale() == "frFR" then
	L_GUI_BUTTON_RESET = "Réinitialisation totale de l'UI"
	-- General options
	L_GUI_GENERAL_UIICON = "Icone près de la minimap"
	L_GUI_GENERAL_AUTOSCALE = "Mise а l'échelle automatique"
	L_GUI_GENERAL_MULTISAMPLE = "Protection multi échantillonnage (bordure 1px)"
	L_GUI_GENERAL_UISCALE = "Mettre l'UI а l'échelle (si 'Mise а l'échelle automatique' est désactivée)"
	L_GUI_GENERAL_WELCOME_MESSAGE = "Message de bienvenue pour le chat"

	-- Miscellaneous options
	L_GUI_MISC_AUTOQUEST = "Accepter les quêtes automatiquement"
	L_GUI_MISC_AUTODUEL = "Décliner les duels automatiquement"
	L_GUI_MISC_AUTOACCEPT = "Accepter automatiquement les invitations"
	L_GUI_MISC_AUTORESSURECT = "Autorésurrection en champ de bataille"
	L_GUI_MISC_MARKING = "Marque la cible quand vous appuyez sur MAJ"
	L_GUI_MISC_INVKEYWORD = "Mot clé pour inviter (/ainv)"
	L_GUI_MISC_SPIN_CAMERA = "Faire tourner la caméra quand absent"
	L_GUI_MISC_MOVE_WATCH_FRAME = "Fenêtre de suivi des quête déplacable"
	L_GUI_MISC_VEHICLE_MOUSEOVER = "Fenêtre de véhicule en mouseover"
	L_GUI_MISC_QUEST_AUTOBUTTON = "Quest/item auto button" -- Needs review
	L_GUI_MISC_RAID_TOOLS = "Raid tools" -- Needs review
	
	-- Skins options
	L_GUI_SKINS = "Personalisation d'addon"
	L_GUI_SKINS_DBM = "Activier la personalisation pour DBM"
	L_GUI_SKINS_PP = "Activer  la personnalisation pour PallyPower"
	
	-- Combat text options
	L_GUI_COMBATTEXT = "Texte de combat"
	L_GUI_COMBATTEXT_BLIZZ_HEAD_NUMBERS = "Utiliser les textes de combat de Blizzard"
	L_GUI_COMBATTEXT_DAMAGE_STYLE = "Change default damage/healing font above mobs/player heads(you need to restart WoW to see changes)" -- Needs review
	L_GUI_COMBATTEXT_DAMAGE = "Afficher les dégâts dans une fenêtre dédiée"
	L_GUI_COMBATTEXT_HEALING = "Afficher les soins dans une fenêtre dédiée"
	L_GUI_COMBATTEXT_HOTS = "Show periodic healing effects in healing frame" -- Needs review
	L_GUI_COMBATTEXT_PET_DAMAGE = "Show your pet damage" -- Needs review
	L_GUI_COMBATTEXT_DOT_DAMAGE = "Show damage from your dots" -- Needs review
	L_GUI_COMBATTEXT_DAMAGE_COLOR = "Afficher les dégâts en fonction de l'école de magie"
	L_GUI_COMBATTEXT_CRIT_PREFIX = "Caractère à afficher avant le montant d'un critique"
	L_GUI_COMBATTEXT_CRIT_POSTFIX = "Caractère à afficher après le montant d'un critique"
	L_GUI_COMBATTEXT_ICONS = "Afficher l'icone du sort"
	L_GUI_COMBATTEXT_ICON_SIZE = "Taille de l'icone du sort"
	L_GUI_COMBATTEXT_TRESHOLD = "Dégâts minimum pour afficher dans la fenêtre de dégats"
	L_GUI_COMBATTEXT_HEAL_TRESHOLD = "Soins minimum pour afficher dans la fenêtre de dégats"
	L_GUI_COMBATTEXT_SCROLLABLE = "Autoriser le défilement avec la moulette dans la fenêtre de dégâts/soins"
	L_GUI_COMBATTEXT_MAX_LINES = "Nombre de lignes maximum à conserver si l'option de défilement est activer (plus de ligne = plus de mémoire utilisée)"
	L_GUI_COMBATTEXT_TIME_VISIBLE = "Time(seconds) a single message will be visible" -- Needs review
	L_GUI_COMBATTEXT_STOP_VE_SPAM = "Automaticly turns off healing spam for priests in shadowform" -- Needs review
	L_GUI_COMBATTEXT_DK_RUNES = "Afficher le recgargement des runes du chevalier de la mort"
	L_GUI_COMBATTEXT_KILLINGBLOW = "Tells you about your killingblows" -- Needs review
	L_GUI_COMBATTEXT_MERGE_AOE_SPAM = "Merges multiple aoe damage spam into single message" -- Needs review
	L_GUI_COMBATTEXT_MERGE_AOE_SPAM_TIME = "Time in seconds aoe spell will be merged into single message" -- Needs review
	
	-- Buffs reminder options
	L_GUI_REMINDER = "Contrôle des buffs"
	L_GUI_REMINDER_SOLO_ENABLE = "Voir les buffs personnels manquants"
	L_GUI_REMINDER_SOLO_SOUND = "Son d'alerte si buff manquant"
	L_GUI_REMINDER_SOLO_SIZE = "Taille de l'icone pour les buffs personnels"
	L_GUI_REMINDER_RAID_ENABLE = "Voir les buffs de raid manquants"
	L_GUI_REMINDER_RAID_ALWAYS = "Toujours voir les buffs manquants"
	L_GUI_REMINDER_RAID_SIZE = "Taille de l'icone pour les buffs de raid"
	L_GUI_REMINDER_RAID_ALPHA = "Icone transparente quand le buff de raid est présent"
	
	-- Raid/Enemy cooldown options
	L_GUI_COOLDOWN = "CD Raid/Ennemi"
	L_GUI_COOLDOWN_RAID_ENABLE = "Activer les CD de raid"
	L_GUI_COOLDOWN_RAID_HEIGHT = "Hauteur de la barre des CD de raid"
	L_GUI_COOLDOWN_RAID_WIDTH = "Largeur de la barre des CD de raid (+28 si l'icone est activй)"
	L_GUI_COOLDOWN_RAID_SORT = "Nouvelle barre au dessus"
	L_GUI_COOLDOWN_RAID_ICONS = "Icones des CD de raid"
	L_GUI_COOLDOWN_RAID_IN_RAID = "Voir les CD alliés en raid"
	L_GUI_COOLDOWN_RAID_IN_PARTY = "Voir les CD alliés en groupe"
	L_GUI_COOLDOWN_RAID_IN_ARENA = "Voir les CD alliés en arène"
	L_GUI_COOLDOWN_ENEMY = "Activier les CD ennemis"
	L_GUI_COOLDOWN_ENEMY_SIZE = "Taille de l'icone des CD ennemis"
	L_GUI_COOLDOWN_ENEMY_EVERYWHERE = "Voir les CD ennemis partout"
	L_GUI_COOLDOWN_ENEMY_IN_BG = "Voir les CD ennemis dans les champs de bataille"
	L_GUI_COOLDOWN_ENEMY_IN_ARENA = "Voir les CD ennemis en arène"
	L_GUI_COOLDOWN_PULSE_ENABLE = "Show cooldowns pulse" -- Needs review
	L_GUI_COOLDOWN_PULSE_SIZE = "Cooldowns pulse icon size" -- Needs review
	
	-- Threat options
	L_GUI_THREAT = "Barre de menace"
	L_GUI_THREAT_ENABLE = "Activer les barres de menace"
	L_GUI_THREAT_HEIGHT = "Hauteur des barres de menace"
	L_GUI_THREAT_WIDTH = "Largeur des barres de menace"
	L_GUI_THREAT_ROWS = "Nombre de barres de menace"
	L_GUI_THREAT_TEST_MODE = "Activer le mode test des barres de menace"
	
	-- Tooltip options
	L_GUI_TOOLTIP = "Tooltip"
	L_GUI_TOOLTIP_ENABLE = "Activer les tooltips"
	L_GUI_TOOLTIP_SHIFT = "Afficher le tooltip quand *MAJ* est appuyée"
	L_GUI_TOOLTIP_CURSOR = "Tooltip sous le curseur"
	L_GUI_TOOLTIP_ICON = "Icone de l'objet dans le tooltip"
	L_GUI_TOOLTIP_HEALTH = "Valeur de point de vie"
	L_GUI_TOOLTIP_HIDE = "Cacher le tooltip pour les barres d'action"
	L_GUI_TOOLTIP_TALENTS = "Afficher les talents dans le tooltip"
	L_GUI_TOOLTIP_ACHIEVEMENTS = "Afficher Comparer les Hauts Faits dans le tooltip"
	L_GUI_TOOLTIP_TARGET = "Afficher la cible dans le tooltip"
	L_GUI_TOOLTIP_TITLE = "Titre dans le tooltip"
	L_GUI_TOOLTIP_RANK = "Afficher le rang de guilde dans le tooltip"
	L_GUI_TOOLTIP_ARENA_EXPERIENCE = "Expérience en arène"
	L_GUI_TOOLTIP_SPELL_ID = "ID du sort"
	L_GUI_TOOLTIP_RAID_ICON = "Raid icon" -- Needs review
	
	-- Chat options
	L_GUI_CHAT_ENABLE = "Activer le chat"
	L_GUI_CHAT_BACKGROUND = "Activer l'arrière plan du chat"
	L_GUI_CHAT_BACKGROUND_ALPHA = "Transparence de l'arrière plan du chat"
	L_GUI_CHAT_SPAM = "Retirer certains spams (ex: joueur1 a battu en duel joueur2)"
	L_GUI_CHAT_WIDTH = "Largeur du chat"
	L_GUI_CHAT_HEIGHT = "Hauteur du chat"
	L_GUI_CHAT_BAR = "Bouton pour changer de canal"
	L_GUI_CHAT_TIMESTAMP = "Coloration du temps"
	L_GUI_CHAT_WHISP = "Alerte sonore quand murmure"
	L_GUI_CHAT_SKIN_BUBBLE = "Skin des bulles de discussions"
	
	-- Bag options
	L_GUI_BAGS = "Sacs"
	L_GUI_BAGS_ENABLE = "Activer les sacs"
	L_GUI_BAGS_BUTTON_SIZE = "Taille des boutons"
	L_GUI_BAGS_BUTTON_SPACE = "Espacement des boutons"
	L_GUI_BAGS_BANK = "Nombre de colonne pour la banque"
	L_GUI_BAGS_BAG = "Nombre de colonne pour les sacs"
	
	-- Minimap options
	L_GUI_MINIMAP_ENABLE = "Activer la minicarte"
	L_GUI_MINIMAP_ICON = "Icone de pistage"
	L_GUI_MINIMAP_SIZE = "Taille de la minicarte"
	L_GUI_MINIMAP_HIDE_COMBAT = "Cacher la minimap en combat"
	
	-- Map options
	L_GUI_MAP_ENABLE = "Activer la carte du monde"
	L_GUI_MAP_SCALE = "Echelle de la carte"
	L_GUI_MAP_BG_STYLIZATION = "Style d'arrière plan de la carte"
	
	-- Loot options
	L_GUI_LOOT_ENABLE = "Activer la fenêtre de butin"
	L_GUI_LOOT_ROLL_ENABLE = "Activier la fenêtre de butin de groupe"
	L_GUI_LOOT_ICON_SIZE = "Taille de l'icone"
	L_GUI_LOOT_WIDTH = "Loot frame width"
	L_GUI_LOOT_AUTOGREED = "Activer désenchantement automatique pour les objets verts au niveau maximum"
	L_GUI_LOOT_AUTODE = "Confirmation automatique pour le désenchantement"
	
	-- Nameplate options
	L_GUI_NAMEPLATE_ENABLE = "Activer les barres de nom"
	L_GUI_NAMEPLATE_COMBAT = "Afficher automatiquement les barres de nom en combat"
	L_GUI_NAMEPLATE_HEALTH = "Valeur de points de vie"
	L_GUI_NAMEPLATE_CASTBAR = "Afficher la barre de sort"
	L_GUI_NAMEPLATE_HEIGHT = "Hauteur des barres de nom"
	L_GUI_NAMEPLATE_WIDTH = "Largeur des barres de nom"
	L_GUI_NAMEPLATE_CASTBAR_NAME = "Afficher le nom du sort"
	L_GUI_NAMEPLATE_THREAT = "Afficher la menace (vert = aggro, rouge = OK)"
	L_GUI_NAMEPLATE_CLASS_ICON = "Icone de classe en JcJ"
	L_GUI_NAMEPLATE_NAME_ABBREV = "Afficher les noms abrégés"
	L_GUI_NAMEPLATE_OVERLAP = "Allow nameplates to overlap"  -- Needs review
	
	-- ActionBar options
	L_GUI_ACTIONBAR_ENABLE = "Activer les barres d'action"
	L_GUI_ACTIONBAR_HOTKEY = "Afficher le texte des macros"
	L_GUI_ACTIONBAR_GRID = "Afficher les boutons vides"
	L_GUI_ACTIONBAR_BUTTON_SIZE = "Taille des boutons"
	L_GUI_ACTIONBAR_BUTTON_SPACE = "Espacement des boutons"
	L_GUI_ACTIONBAR_BOTTOMBARS = "Nombre de barres d'action en bas (1, 2 ou 3)"
	L_GUI_ACTIONBAR_RIGHTBARS = "Nombre de barres d'action à droite (0, 1, 2 ou 3)"
	L_GUI_ACTIONBAR_RIGHTBARS_MOUSEOVER = "Barres de droite en 'mouseover'"
	L_GUI_ACTIONBAR_PETBAR_MOUSEOVER = "Barre du familier en 'mouseover'(uniquement pour la barre horizontale)"
	L_GUI_ACTIONBAR_PETBAR_HIDE = "Cacher la barre du familier"
	L_GUI_ACTIONBAR_PETBAR_HORIZONTAL = "Activer la barre du familier horizontale"
	L_GUI_ACTIONBAR_SHAPESHIFT_MOUSEOVER = "Changeforme/Posture/barre de totems en 'mouseover'"
	L_GUI_ACTIONBAR_SHAPESHIFT_HIDE = "Cacher changeforme"
	L_GUI_ACTIONBAR_SHAPESHIFT_HORIZONTAL = "Activer la barre de posture horizontale"
	
	-- Auras/Buffs/Debuffs
	L_GUI_AURA_PLAYER_BUFF_SIZE = "Taille des buffs du joueur"
	L_GUI_AURA_SHOW_SPIRAL = "Spirale sur les icones d'aura"
	L_GUI_AURA_SHOW_TIMER = "Afficher le cooldown des icones d'aura"
	L_GUI_AURA_PLAYER_AURAS = "Auras sur la barre du joueur"
	L_GUI_AURA_TARGET_AURAS = "Auras sur la barre de cible"
	L_GUI_AURA_FOCUS_DEBUFFS = "Afficher les debuffs du focus"
	L_GUI_AURA_FOT_DEBUFFS = "Afficher les debuffs de la cible du focus"
	L_GUI_AURA_PET_DEBUFFS = "Afficher les debuffs du pet"
	L_GUI_AURA_TOT_DEBUFFS = "Afficher les debuffs de la cible de la cible"
	L_GUI_AURA_PLAYER_AURA_ONLY = "Afficher seulement ses propres debuffs sur la cible"
	L_GUI_AURA_DEBUFF_COLOR_TYPE = "Coleur de debuff par type"
	
	-- Unit frame options
	L_GUI_UF_ENABLE = "Activer les barres d'unité"
	L_GUI_UF_AGGRO_BORDER = "Aggro signalée en bordure"
	L_GUI_UF_OWN_COLOR = "Mettre la couleur de classe comme couleur pour la barre de vie"
	L_GUI_UF_ENEMY_HEALTH_COLOR = "Si activée, la couleur des cibles ennemi est rouge"
	L_GUI_UF_TOTAL_VALUE = "Afficher la vie des joueur/cible avec XXXX/Total"
	L_GUI_UF_DEFICIT_HEALTH = "Déficit en vie du raid"
	L_GUI_UF_COLOR_VALUE = "Valeur de vie/mana colorée"
	L_GUI_UF_UNIT_CASTBAR = "Voir la barre de cast"
	L_GUI_UF_CASTBAR_ICON = "Voir l'icone de la barre de cast"
	L_GUI_UF_CASTBAR_LATENCY = "Voir la latence de la barre de cast"
	L_GUI_UF_SHOW_BOSS = "Afficher les barres du boss"
	L_GUI_UF_SHOW_ARENA = "Afficher les barres d'arène"
	L_GUI_UF_ARENA_RIGHT = "Arena frames on the right"
	L_GUI_UF_SHOW_PARTY = "Show party frames" -- Needs review
	L_GUI_UF_SHOW_RAID = "Show raid frames"
	L_GUI_UF_VERTICAL_HEALTH = "Orientation vertical des barres de vie"
	L_GUI_UF_ALPHA_HEALTH = "Alpha of healthbars when 100%hp"
	L_GUI_UF_SHOW_RANGE = "Changer l'opacité par rapport а la portée sur les barres de raid"
	L_GUI_UF_RANGE_ALPHA = "Alpha de la barre quand hors de portée"
	L_GUI_UF_SOLO_MODE = "Toujours afficher la barre du joueur"
	L_GUI_UF_PLAYER_PARTY = "Afficher la barre du joueur en groupe"
	L_GUI_UF_SHOW_TANK = "Afficher les tanks de raid"
	L_GUI_UF_SHOW_TANK_TT = "Show raid tanks target target" -- Needs review
	L_GUI_UF_RAID_GROUP = "Nombre de groupe dans le raid (Seulement pour ShestakUI_Heal)"
	L_GUI_UF_RAID_VERTICAL_GROUP = "Groupe de raid verticaux(Seulement pour ShestakUI_Heal)"
	L_GUI_UF_ICONS_PVP = "Texte JcJ en Mouseover pour la barre du joueur et celle de la cible"
	L_GUI_UF_ICONS_LEADER = "Icone du Chef de raid, icone de l'assistant, icone du maоtre du butin"
	L_GUI_UF_ICONS_COMBAT = "Icone de combat"
	L_GUI_UF_ICONS_RESTING = "Icone Resting pour les personnage de bas niveau"
	L_GUI_UF_ICONS_LFD_ROLE = "Icone de chef de raid"
	L_GUI_UF_ICONS_RAID_MARK = "Signe de raid"
	L_GUI_UF_ICONS_COMBO_POINT = "Affichage des points de combo pour les Voleurs/druides"
	L_GUI_UF_ICONS_READY_CHECK = "Icone d'appel"
	L_GUI_UF_PORTRAIT_ENABLE = "Activer les portraits du joueur et de la cible"
	L_GUI_UF_PORTRAIT_CLASSCOLOR_BORDER = "Activer la bordure aux couleurs de la classe"
	L_GUI_UF_PORTRAIT_HEIGHT = "Hauteur des portraits"
	L_GUI_UF_PORTRAIT_WIDTH = "Largeur des portraits"
	L_GUI_UF_PLUGINS_GCD = "Scintillement du GCD"
	L_GUI_UF_PLUGINS_SWING = "Barre d'attaque automatique / tir automatique"
	L_GUI_UF_PLUGINS_ECLIPSE_BAR = "Activer la barre d'eclipse"
	L_GUI_UF_PLUGINS_HOLY_BAR = "Activer la barre de puissance sacrée"
	L_GUI_UF_PLUGINS_SHARD_BAR = "Activier la barre de fragment d'âme"
	L_GUI_UF_PLUGINS_RUNE_BAR = "Barre de rune"
	L_GUI_UF_PLUGINS_TOTEM_BAR = "Barre de totem"
	L_GUI_UF_PLUGINS_TOTEM_BAR_NAME = "Nom des totems"
	L_GUI_UF_PLUGINS_REPUTATION_BAR = "Barre de réputation"
	L_GUI_UF_PLUGINS_EXPERIENCE_BAR = "Barre d'expérience"
	L_GUI_UF_PLUGINS_SMOOTH_BAR = "Barre lisse"
	L_GUI_UF_PLUGINS_TALENTS = "Afficher les talent de l'ennemi"
	L_GUI_UF_PLUGINS_COMBAT_FEEDBACK = "Texte de combat sur les barres du joueur et de la cible"
	L_GUI_UF_PLUGINS_DEBUFFHIGHLIGHT_ICON = "Mise en évidence des debuffs texture + icone"
	L_GUI_UF_PLUGINS_AURA_WATCH = "Aura/debuff de raid"
	L_GUI_UF_PLUGINS_HEALCOMM = "Barre de soin entrant (incoming)"
	
	-- Panel options
	L_GUI_TOP_PANEL = "Panneau supérieur"
	L_GUI_TOP_PANEL_ENABLE = "Enable top panel"	-- Needs review
	L_GUI_TOP_PANEL_MOUSE = "Panneau supérieur en 'mouseover'"
	L_GUI_TOP_PANEL_WIDTH = "Largeur du panneau"
	L_GUI_TOP_PANEL_HEIGHT = "Hauteur du panneau"
	
	-- Stats options
	L_GUI_STATS = "Stats"
	L_GUI_STATS_BG = "Champ de bataille"
	L_GUI_STATS_CLOCK = "Horloge"
	L_GUI_STATS_LATENCY = "Latence"
	L_GUI_STATS_MEMORY = "Memoire"
	L_GUI_STATS_FPS = "FPS"
	L_GUI_STATS_EXPERIENCE = "Experience"
	L_GUI_STATS_COORDS = "Coordonnées"
	L_GUI_STATS_LOCATION = "Lieu actuel"
	L_GUI_STATS_GUILD_REPAIR = "Repair from guild bank" -- Needs review
	
	-- Error options
	L_GUI_ERROR = "Erreurs"
	L_GUI_ERROR_HIDE = "Cacher les erreurs"
	L_GUI_ERROR_BLACK = "Cacher les erreurs de la liste noire"
	L_GUI_ERROR_WHITE = "Afficher les erreurs de la liste blanche"
	L_GUI_ERROR_HIDE_COMBAT = "Cacher les erreurs en combat"
end