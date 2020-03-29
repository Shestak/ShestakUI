local _, L = ...
if GetLocale() ~= "frFR" then return end

----------------------------------------------------------------------------------------
--	Localization for frFR client
--	Translation: Cranan, Puree, AlbertDuval
----------------------------------------------------------------------------------------
L_GUI_SET_SAVED_SETTTINGS = "Sauvegarder la configuration par personnage"
L_GUI_SET_SAVED_SETTTINGS_DESC = "Switch between a profile that applies to all characters and one that is unique to this character." -- Need review
L_GUI_RESET_CHAR = "Réinitialiser les paramètres de votre personnage sur ShestakUI ?"
L_GUI_RESET_ALL = "Réinitialiser tous les paramètres de ShestakUI ?"
L_GUI_PER_CHAR = "Modifier la configuration du personnage ?"
L_GUI_RESET_CAT = "Are you sure you want to reset category's settings?" -- Need review
L_GUI_RESET_CAT_DESC = "Reset category's settings. \nCTRL-click to reset all" -- Need review
L_GUI_NEED_RELOAD = "Vous devez recharger l'Interface pour appliquer vos changements."

-- General options
L_GUI_GENERAL_SUBTEXT = "Ces paramètres controllent les rendus de l'interface utilisateur. Saisir '/uihelp' dans le chat pour plus d'information."
L_GUI_GENERAL_WELCOME_MESSAGE = "Message de bienvenue dans la fenêtre de dialogue"
L_GUI_GENERAL_AUTOSCALE = "Mise à l'échelle automatique"
L_GUI_GENERAL_UISCALE = "Mettre l'interface à l'échelle (si 'Mise à l'échelle automatique' est désactivée)"
L.media_border_color = "Couleurs des bordures (fenêtres, barres, info-bulles, etc)"
L.media_backdrop_color = "Couleurs du remplissage des bordures (fenêtres, barres, info-bulles, etc)"
L.media_backdrop_alpha = "Transparence du fond des bordures"
L.media_subheader_pixel = "Modification de la Police Pixel" -- Need review

-- Font options
L.font = "Polices" -- Need review
L.font_subtext = "Personnalisation de la police pour chaque éléments." -- Need review
L.font_stats_font = "Selectionner la police"
L.font_stats_font_style = "Police de contour"
L.font_stats_font_shadow = "Activer l'ombre"
L.font_subheader_stats = "Police des Statistiques"
L.font_subheader_combat = "Police des Textes de Combat"
L.font_subheader_chat = "Police de l'espace de discussions"
L.font_subheader_chat_tabs = "Police des onglets de l'espace de discussions"
L.font_subheader_action = "Police des Barres d'Actions"
L.font_subheader_threat = "Police de l'indicateur de menace"
L.font_subheader_raidcd = "Police des temps de recharde du Raid"
L.font_subheader_cooldown = "Police des temps de recharge"
L.font_subheader_loot = "Police du Butin"
L.font_subheader_nameplates = "Police des Barres de Noms"
L.font_subheader_unit = "Police des Barres de vie"
L.font_subheader_aura = "Police des Auras"
L.font_subheader_filger = "Police de Filger"
L.font_subheader_style = "Police de la stylisation"
L.font_subheader_bag = "Police des Sacs"

-- Skins options
L_GUI_SKINS = "Personnalisation d'addon"
L_GUI_SKINS_SUBTEXT = "Change the appearance of the standard interface." -- Need review
L_GUI_SKINS_BLIZZARD = "Activer la personnalisation des fenêtres Blizzard"
L_GUI_SKINS_MINIMAP_BUTTONS = "Activer la personnalisation des icônes de la minimap"
L_GUI_SKINS_SUBHEADER = "Stylization of addons" -- Need review
L_GUI_SKINS_DBM_MOVABLE = "Autoriser le déplacement des barres DBM"
L.skins_minimap_buttons_mouseover = "Addons icons on mouseover" -- Need review

-- Unit Frames options
L_GUI_UF_SUBTEXT = "Customize player, target frames and etc." -- Need review
L_GUI_UF_ENABLE = "Activer les barres d'unité"
L_GUI_UF_OWN_COLOR = "Mettre la couleur de classe comme couleur pour la barre de vie"
L_GUI_UF_UF_COLOR = "Couleur de la barre de vie"
L_GUI_UF_ENEMY_HEALTH_COLOR = "Si activée, la couleur des cibles ennemi est rouge"
L_GUI_UF_TOTAL_VALUE = "Afficher la vie des joueur/cible avec XXXX/Total"
L_GUI_UF_COLOR_VALUE = "Valeur de vie/mana colorée"
L_GUI_UF_BAR_COLOR_VALUE = "Couleur de barre de vie en fonction des points de vie"
L_GUI_UF_LINES = "Afficher les barres réduites du Joueur et de la Cible" -- Need review
L_GUI_UF_SUBHEADER_CAST = "Castbars" -- Need review
L_GUI_UF_UNIT_CASTBAR = "Voir la barre de cast"
L_GUI_UF_CASTBAR_ICON = "Voir l'icone de la barre de cast"
L_GUI_UF_CASTBAR_LATENCY = "Voir la latence de la barre de cast"
L_GUI_UF_CASTBAR_TICKS = "Affiche les ticks de sort de la barre de sort"
L_GUI_UF_SUBHEADER_FRAMES = "Frames" -- Need review
L_GUI_UF_SHOW_PET = "Afficher la barre du familier"
L_GUI_UF_SHOW_FOCUS = "Afficher la barre du focus"
L_GUI_UF_SHOW_TOT = "Afficher la barre de la cible de la cible"
L_GUI_UF_SHOW_BOSS = "Afficher les barres du boss"
L_GUI_UF_BOSS_RIGHT = "Barres des boss à droite"
L_GUI_UF_SHOW_ARENA = "Afficher les barres d'arène"
L_GUI_UF_ARENA_RIGHT = "Barres d'arène sur la droite"
L_GUI_UF_BOSS_DEBUFFS = "Number of debuffs" -- Need review
L_GUI_UF_BOSS_DEBUFFS_DESC = "Afficher le nombre de debuffs sur la fenêtre des boss" -- Need review
L_GUI_UF_BOSS_BUFFS = "Number of buffs" -- Need review
L_GUI_UF_BOSS_BUFFS_DESC = "Afficher le nombre de buffs sur la fenêtre des boss" -- Need review
L_GUI_UF_ICONS_PVP = "Texte JcJ en Mouseover pour la barre du joueur et celle de la cible"
L_GUI_UF_ICONS_COMBAT = "Icone de combat"
L_GUI_UF_ICONS_RESTING = "Icone Resting pour les personnage de bas niveau"
L_GUI_UF_SUBHEADER_PORTRAIT = "Portraits" -- Need review
L_GUI_UF_PORTRAIT_ENABLE = "Activer les portraits du joueur et de la cible"
L_GUI_UF_PORTRAIT_CLASSCOLOR_BORDER = "Activer la bordure aux couleurs de la classe"
L_GUI_UF_PORTRAIT_HEIGHT = "Hauteur des portraits"
L_GUI_UF_PORTRAIT_WIDTH = "Largeur des portraits"
L_GUI_UF_SUBHEADER_PLUGINS = "Plugins" -- Need review
L_GUI_UF_PLUGINS_GCD = "Scintillement du GCD"
L_GUI_UF_PLUGINS_SWING = "Barre d'attaque automatique / tir automatique"
L.unitframe_plugins_reputation_bar = "Reputation bar" -- Need review
L.unitframe_plugins_reputation_bar_desc = "Barre de réputation" -- Need review
L.unitframe_plugins_experience_bar = "Experience bar" -- Need review
L.unitframe_plugins_experience_bar_desc = "Barre d'expérience" -- Need review
L.unitframe_plugins_artifact_bar = "Azerite Power bar" -- Need review
L.unitframe_plugins_artifact_bar_desc = "Barre de puissance d'Artefact" -- Need review
L_GUI_UF_PLUGINS_SMOOTH_BAR = "Lissage des barres"
L_GUI_UF_PLUGINS_ENEMY_SPEC = "Afficher les talent de l'ennemi"
L_GUI_UF_PLUGINS_COMBAT_FEEDBACK = "Texte de combat sur les barres du joueur et de la cible"
L_GUI_UF_PLUGINS_FADER = "Barres de unités"
L_GUI_UF_PLUGINS_DIMINISHING = "Icones de rendement décroissants sur les fenêtre d'arène"
L_GUI_UF_PLUGINS_POWER_PREDICTION = "Prédiction du coût des sorts sur la fenêtre du joueur"
L.unitframe_plugins_absorbs = "Absorbs value on player frame" -- Need review
L.unitframe_extra_height_auto = "Auto height for health/power" -- Need review
L.unitframe_extra_height_auto_desc = "Smart adjust depending on font size" -- Need review
L.unitframe_extra_health_height = "Additional height for health" -- Need review
L.unitframe_extra_power_height = "Additional height for power" -- Need review

-- Unit Frames Class bar options
L_GUI_UF_PLUGINS_CLASS_BAR = "Barres de classe"
L_GUI_UF_PLUGINS_CLASS_BAR_SUBTEXT = "Control of special class resources." -- Need review
L_GUI_UF_PLUGINS_COMBO_BAR = "Afficher la barre des points de combo pour les Voleurs/Druides"
L_GUI_UF_PLUGINS_COMBO_BAR_ALWAYS = "Toujours montrer la barre des points de combo pour la classe Druide"
L_GUI_UF_PLUGINS_COMBO_BAR_OLD = "Activer les points de Combo sur la cible"
L_GUI_UF_PLUGINS_ARCANE_BAR = "Activer la barre de charge Arcanique"
L_GUI_UF_PLUGINS_CHI_BAR = "Activer la barre de Chi"
L_GUI_UF_PLUGINS_STAGGER_BAR = "Activer la barre de chancelement (pour les Tanks Monk)"
L_GUI_UF_PLUGINS_HOLY_BAR = "Activer la barre de Puissance sacrée"
L_GUI_UF_PLUGINS_SHARD_BAR = "Activier la barre de Fragment d'âme"
L_GUI_UF_PLUGINS_RUNE_BAR = "Activer la barre de Rune"
L_GUI_UF_PLUGINS_TOTEM_BAR = "Activer la barre de Totem"
L_GUI_UF_PLUGINS_RANGE_BAR = "Active la barre de distance (pour la classe Prêtre)"

-- Raid Frames options
L_GUI_UF_RAIDFRAMES_SUBTEXT = "Customize the appearance of the raid frames." -- Need review
L_GUI_UF_BY_ROLE = "Trier les joueurs par rôle dans les groupes"
L_GUI_UF_AGGRO_BORDER = "Aggro signalée en bordure"
L_GUI_UF_DEFICIT_HEALTH = "Déficit en vie du raid"
L_GUI_UF_SHOW_PARTY = "Afficher les barres du groupe"
L_GUI_UF_SHOW_RAID = "Afficher les barres du raid"
L_GUI_UF_VERTICAL_HEALTH = "Orientation vertical des barres de vie"
L_GUI_UF_ALPHA_HEALTH = "Opacité des barres de vie quand 100%hp"
L_GUI_UF_SHOW_RANGE = "Changer l'opacité par rapport ? la portée sur les barres de raid"
L_GUI_UF_RANGE_ALPHA = "Alpha" -- Need review
L_GUI_UF_RANGE_ALPHA_DESC = "Opacité de la barre vie quand hors de portée"
L_GUI_UF_SUBHEADER_RAIDFRAMES = "Frames" -- Need review
L_GUI_UF_SOLO_MODE = "Toujours afficher la barre du joueur"
L_GUI_UF_PLAYER_PARTY = "Afficher la barre du joueur en groupe"
L_GUI_UF_SHOW_TANK = "Afficher les tanks de raid"
L_GUI_UF_SHOW_TANK_TT = "Afficher la cible de la cible des tanks"
L_GUI_UF_RAID_GROUP = "Nombre de groupe dans le raid"
L_GUI_UF_RAID_VERTICAL_GROUP = "Groupe de raid verticaux(pour l'interface Heal)"
L_GUI_UF_SUBHEADER_ICONS = "Icons" -- Need review
L_GUI_UF_ICONS_ROLE = "Icone de rôle sur les barres de vie"
L_GUI_UF_ICONS_RAID_MARK = "Signe de raid"
L_GUI_UF_ICONS_READY_CHECK = "Icone d'appel"
L_GUI_UF_ICONS_LEADER = "Icone du Chef de raid, icone de l'assistant"
L_GUI_UF_ICONS_SUMON = "Faire apparaître les icones sur les barres"
L_GUI_UF_PLUGINS_DEBUFFHIGHLIGHT_ICON = "Mise en évidence des debuffs texture + îcone"
L_GUI_UF_PLUGINS_AURA_WATCH = "Aura/debuff de raid"
L_GUI_UF_PLUGINS_AURA_WATCH_TIMER = "Durée sur les icônes de débuff du raid"
L_GUI_UF_PLUGINS_PVP_DEBUFFS = "Afficher aussi les debuff JcJ (de la liste)"
L_GUI_UF_PLUGINS_HEALCOMM = "Barre de soin entrant (incoming)"
L.raidframe_plugins_auto_resurrection = "Auto cast resurrection" -- Need review
L.raidframe_plugins_auto_resurrection_desc = "Lance automatiquement le sort de résurrection de masse avec un clic central souris sur une cible morte (ne fonctionne pas avec l'addon Clique activé)"
L.raidframe_hide_health_value = "Hide health value (only for heal layout)" -- Need review
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
L_GUI_ACTIONBAR = "Barres d'action"
L_GUI_ACTIONBAR_ENABLE = "Activer les barres d'action"
L_GUI_ACTIONBAR_HOTKEY = "Afficher le texte des macros"
L_GUI_ACTIONBAR_MACRO = "Afficher le nom des macros sur les touches"
L_GUI_ACTIONBAR_GRID = "Afficher les boutons vides"
L_GUI_ACTIONBAR_BUTTON_SIZE = "Taille des boutons"
L_GUI_ACTIONBAR_BUTTON_SPACE = "Espacement des boutons"
L_GUI_ACTIONBAR_SPLIT_BARS = "Séparation de la 5ème barre en 2 barres de 6 boutons de chaque côté"
L_GUI_ACTIONBAR_CLASSCOLOR_BORDER = "Active la couleur de votre classe pour la bordure de boutons"
L.actionbar_toggle_mode = "Active le mode pour bloquer les combinaisons des barres d'action"
L.actionbar_toggle_mode_desc = "The quick change in the number of panels. For the lower panels, hover the mouse over the hidden area above the panels. For right panels, hover the mouse over the area below the panels." -- Need review
L_GUI_ACTIONBAR_HIDE_HIGHLIGHT = "Cache la surbrillance des effets à déclenchement"
L_GUI_ACTIONBAR_BOTTOMBARS = "Nombre de barres d'action en bas"
L_GUI_ACTIONBAR_RIGHTBARS = "Nombre de barres d'action à droite"
L_GUI_ACTIONBAR_RIGHTBARS_MOUSEOVER = "Barres de droite en 'mouseover'"
L_GUI_ACTIONBAR_PETBAR_HIDE = "Cacher la barre du familier"
L_GUI_ACTIONBAR_PETBAR_HORIZONTAL = "Activer la barre du familier horizontale"
L_GUI_ACTIONBAR_PETBAR_MOUSEOVER = "Barre du familier en 'mouseover'(uniquement pour la barre horizontale)"
L_GUI_ACTIONBAR_STANCEBAR_HIDE = "Cacher changeforme"
L_GUI_ACTIONBAR_STANCEBAR_HORIZONTAL = "Activer la barre de posture horizontale"
L_GUI_ACTIONBAR_STANCEBAR_MOUSEOVER = "Changeforme/Posture/barre de totems en 'mouseover'" -- Need review
L_GUI_ACTIONBAR_MICROMENU = "Active le Micro menu"
L_GUI_ACTIONBAR_MICROMENU_MOUSEOVER = "Affiche le Micro menu au survol de la souris"

-- Tooltip options
L_GUI_TOOLTIP = "Tooltip"
L_GUI_TOOLTIP_SUBTEXT = "In this block, you can change the standard tips when mouseovering." -- Need review
L_GUI_TOOLTIP_ENABLE = "Activer les tooltips"
L_GUI_TOOLTIP_SHIFT = "Afficher la tooltip quand la touche 'MAJ' est appuyée"
L_GUI_TOOLTIP_CURSOR = "Afficher la Tooltip sous le curseur"
L_GUI_TOOLTIP_ICON = "Afficher l'îcone de l'objet"
L_GUI_TOOLTIP_HEALTH = "Afficher les points de vie"
L_GUI_TOOLTIP_HIDE = "Cacher le tooltip pour les barres d'action"
L_GUI_TOOLTIP_HIDE_COMBAT = "Cacher les tooltips en combat"
L_GUI_TOOLTIP_SUBHEADER_PLUGINS = "Plugins" -- Need review
L_GUI_TOOLTIP_TALENTS = "Afficher les talents"
L_GUI_TOOLTIP_ACHIEVEMENTS = "Afficher Comparer les Hauts Faits"
L_GUI_TOOLTIP_TARGET = "Afficher la cible"
L_GUI_TOOLTIP_TITLE = "Afficher les titres"
L_GUI_TOOLTIP_REALM = "Affiche le serveur du joueur"
L_GUI_TOOLTIP_RANK = "Afficher le rang de guilde"
L_GUI_TOOLTIP_ARENA_EXPERIENCE = "Expérience en arène"
L_GUI_TOOLTIP_SPELL_ID = "Afficher l'ID du sort"
L_GUI_TOOLTIP_AVERAGE_LVL_DESC = "The average item level" -- Need review
L_GUI_TOOLTIP_RAID_ICON = "Afficher l'îcone de raid"
L_GUI_TOOLTIP_WHO_TARGETTING = "Afficher qui cible actuellement l'unité qui est dans votre groupe/raid"
L_GUI_TOOLTIP_ITEM_COUNT = "Afficher le nombre d'objets possédés"
L_GUI_TOOLTIP_UNIT_ROLE = "Afficher les rôles"
L_GUI_TOOLTIP_INSTANCE_LOCK = "Afficher le verrouillage de votre instance"

-- Chat options
L_GUI_CHAT_SUBTEXT = "Here you can change the settings of the chat window." -- Need review
L_GUI_CHAT_ENABLE = "Activer la fenêtre de dialogue"
L_GUI_CHAT_BACKGROUND = "Activer l'arrière plan"
L_GUI_CHAT_BACKGROUND_ALPHA = "Transparence de l'arrière"
L_GUI_CHAT_SPAM = "Supprime certains spam(Player1 gagne contre Player2)"
L_GUI_CHAT_GOLD = "Supprime tous les spams joueur"
L_GUI_CHAT_WIDTH = "Largeur de la fenêtre"
L_GUI_CHAT_HEIGHT = "Hauteur de la fenêtre"
L_GUI_CHAT_BAR = "Bouton pour changer de canal"
L_GUI_CHAT_BAR_MOUSEOVER = "Affiche les boutons de canaux au survol de la souris"
L_GUI_CHAT_WHISP = "Alerte sonore quand murmure"
L_GUI_CHAT_SKIN_BUBBLE = "Skin des bulles de discussions"
L_GUI_CHAT_CL_TAB = "Afficher l'onglet du journal de combat"
L_GUI_CHAT_TABS_MOUSEOVER = "Affiche les onglets de discussion au survol de la souris"
L_GUI_CHAT_STICKY = "Active le dernier canal utilisé(canal persistant)"
L_GUI_CHAT_DAMAGE_METER_SPAM = "Rassemble les lignes de statistiques de dégâts en un seul lien/ligne"
L.chat_loot_icons = "Icons for loot" -- Needs review
L.chat_custom_time_color = "Enable custom timestamp coloring" -- Needs review
L.chat_time_color = "Coloration du temps"

-- Nameplate options
L_GUI_NAMEPLATE_SUBTEXT = "Paramètres des Barres de Noms" -- Need review
L_GUI_NAMEPLATE_ENABLE = "Activer les barres de nom"
L_GUI_NAMEPLATE_COMBAT = "Afficher automatiquement les barres de nom en combat"
L_GUI_NAMEPLATE_HEALTH = "Valeur de points de vie"
L_GUI_NAMEPLATE_DISTANCE = "Distance d'affichage"
L_GUI_NAMEPLATE_HEIGHT = "Hauteur des barres de nom"
L_GUI_NAMEPLATE_WIDTH = "Largeur des barres de nom"
L.nameplate_alpha = "Transparence"
L.nameplate_alpha_desc = "Transparce des barres de Noms autres que la Cible"
L.nameplate_ad_height = "Epaisseur additionnelle"
L.nameplate_ad_width = "Largeur additionnelle"
L.nameplate_ad_height_desc = "Epaisseur additionnelle pour la barre de Noms de la cible"
L.nameplate_ad_width_desc = "LArgeur additionnelle pour la barre de Noms de la cible"
L_GUI_NAMEPLATE_CASTBAR_NAME = "Afficher le nom du sort"
L_GUI_NAMEPLATE_CLASS_ICON = "Icône de classe en JcJ"
L_GUI_NAMEPLATE_NAME_ABBREV = "Afficher les noms abrégés"
L_GUI_NAMEPLATE_CLAMP = "Afficher les barres en haut de l'écran quand celles-ci sont au delà de la vision"
L_GUI_NAMEPLATE_SHOW_DEBUFFS = "Affiche les affaiblissements (Les noms abrégés doivent être désactivés)"
L_GUI_NAMEPLATE_SHOW_BUFFS = "Afficher les améliorations au dessus des barres des alliés (contenu dans la liste)"
L_GUI_NAMEPLATE_DEBUFFS_SIZE = "Taille des affaiblissements"
L_GUI_NAMEPLATE_HEALER_ICON = "Affiche une icône de soigneur sur toutes les barres de vie des soigneurs ennemis dans les champs de bataille"
L_GUI_NAMEPLATE_TOTEM_ICONS = "Afficher une icone au dessus des barres de vie des totems ennemis"
L_GUI_NAMEPLATE_THREAT = "Activer la gestion de la menace, change automatiquement selon votre rôle"
L_GUI_NAMEPLATE_GOOD_COLOR = "Bonne couleur de menace, dépend de si vous êtes un tank ou dps/heal"
L_GUI_NAMEPLATE_NEAR_COLOR = "Perte/Gain de couleur de menace"
L_GUI_NAMEPLATE_BAD_COLOR = "Mauvaise couleur de menace, dépend de si vous êtes un tank ou dps/heal"
L_GUI_NAMEPLATE_OFFTANK_COLOR = "Coloration de la menace du tank secondaire"

-- Combat text options
L_GUI_COMBATTEXT = "Texte de combat"
L_GUI_COMBATTEXT_SUBTEXT = "For moving type in the chat '/xct'" -- Need review
L_GUI_COMBATTEXT_ENABLE = "Activer les textes de combat"
L.combattext_blizz_head_numbers = "Enable Blizzard combat text" -- Need review
L.combattext_blizz_head_numbers_desc = "Utiliser les textes de combat de Blizzard"
L.combattext_damage_style = "Change default combat font" -- Need review
L.combattext_damage_style_desc = "Change la police par défaut des dégâts/soins au dessus de la tête de la cible (Vous devez redémarrer WoW pour valider le changement)"
L_GUI_COMBATTEXT_DAMAGE = "Afficher les dégâts dans une fenêtre dédiée"
L_GUI_COMBATTEXT_HEALING = "Afficher les soins dans une fenêtre dédiée"
L_GUI_COMBATTEXT_HOTS = "Afficher les effets des soins périodiques dans la fenêtre de soin"
L_GUI_COMBATTEXT_OVERHEALING = "Afficher les excès de soins sortants"
L_GUI_COMBATTEXT_PET_DAMAGE = "Afficher les dégâts du familier"
L_GUI_COMBATTEXT_DOT_DAMAGE = "Afficher les dégâts des dots"
L_GUI_COMBATTEXT_DAMAGE_COLOR = "Afficher les dégâts en fonction de l'école de magie"
L_GUI_COMBATTEXT_CRIT_PREFIX = "Caractère à afficher avant le montant d'un critique"
L_GUI_COMBATTEXT_CRIT_POSTFIX = "Caractère à afficher après le montant d'un critique"
L_GUI_COMBATTEXT_ICONS = "Afficher l'icône du sort"
L_GUI_COMBATTEXT_ICON_SIZE = "Icon size" -- Need review
L_GUI_COMBATTEXT_ICON_SIZE_DESC = "Taille de l'icône du sort"
L_GUI_COMBATTEXT_TRESHOLD = "Dégâts minimum pour afficher dans la fenêtre de dégâts"
L_GUI_COMBATTEXT_HEAL_TRESHOLD = "Soins minimum pour afficher dans la fenêtre de dégâts"
L_GUI_COMBATTEXT_SCROLLABLE = "Autoriser le défilement avec la molette dans la fenêtre de dégâts/soins"
L_GUI_COMBATTEXT_MAX_LINES = "Max lines" -- Need review
L_GUI_COMBATTEXT_MAX_LINES_DESC = "Nombre de lignes maximum à conserver si l'option de défilement est activée (plus de ligne = plus de mémoire utilisée)"
L_GUI_COMBATTEXT_TIME_VISIBLE = "Time" -- Need review
L_GUI_COMBATTEXT_TIME_VISIBLE_DESC = "Temps en seconde durant lequel un message est affiché"
L_GUI_COMBATTEXT_DK_RUNES = "Afficher le rechargement des runes du chevalier de la mort"
L_GUI_COMBATTEXT_KILLINGBLOW = "Afficher les coups fatals"
L_GUI_COMBATTEXT_MERGE_AOE_SPAM = "Rassembler tous les dégâts d'un aoe en un seul message"
L_GUI_COMBATTEXT_MERGE_MELEE = "Rassemble les dégâts multiples en auto attaque"
L_GUI_COMBATTEXT_DISPEL = "Affiche les sorts que vous avez dissipé"
L_GUI_COMBATTEXT_INTERRUPT = "Affiche les sorts que vous avez interrompu"
L_GUI_COMBATTEXT_DIRECTION = "Change scrolling direction from bottom to top" -- Need review
L_GUI_COMBATTEXT_SHORT_NUMBERS = "Rendre plus lisible les nombres ('25.3k' au lieu de '25342')"

-- Auras/Buffs/Debuffs
L_GUI_AURA_PLAYER_BUFF_SIZE = "Buffs size" -- Need review
L_GUI_AURA_PLAYER_BUFF_SIZE_DESC = "Taille des buffs du joueur"
L.aura_player_debuff_size = "Debuffs size" -- Need review
L_GUI_AURA_SHOW_SPIRAL = "Spirale sur les icones d'aura"
L_GUI_AURA_SHOW_TIMER = "Afficher le cooldown des icones d'aura"
L_GUI_AURA_PLAYER_AURAS = "Auras sur la barre du joueur"
L_GUI_AURA_TARGET_AURAS = "Auras sur la barre de cible"
L_GUI_AURA_FOCUS_DEBUFFS = "Afficher les debuffs du focus"
L_GUI_AURA_FOT_DEBUFFS = "Afficher les debuffs de la cible du focus"
L_GUI_AURA_PET_DEBUFFS = "Afficher les debuffs du pet"
L_GUI_AURA_TOT_DEBUFFS = "Afficher les debuffs de la cible de la cible"
L_GUI_AURA_BOSS_BUFFS = "Afficher les améliorations sur le cadre du Boss"
L_GUI_AURA_PLAYER_AURA_ONLY = "Afficher seulement ses propres debuffs sur la cible"
L_GUI_AURA_DEBUFF_COLOR_TYPE = "Coleur de debuff par type"
L_GUI_AURA_CAST_BY = "Voir qui a jeté un buff / debuff sur son tooltip"
L_GUI_AURA_CLASSCOLOR_BORDER = "Active la couleur de votre classe pour la bordure de vos buffs"

-- Bag options
L_GUI_BAGS = "Sacs"
L_GUI_BAGS_SUBTEXT = "Changing the built-in bags." -- Need review
L_GUI_BAGS_ENABLE = "Activer les sacs"
L_GUI_BAGS_ILVL = "Afficher le niveau d'objet des armes et armures"
L_GUI_BAGS_BUTTON_SIZE = "Taille des boutons"
L_GUI_BAGS_BUTTON_SPACE = "Espacement des boutons"
L_GUI_BAGS_BANK = "Nombre de colonne pour la banque"
L_GUI_BAGS_BAG = "Nombre de colonne pour les sacs"

-- Minimap options
L_GUI_MINIMAP_SUBTEXT = "Minimap settings." -- Need review
L_GUI_MINIMAP_ENABLE = "Activer la minicarte"
L_GUI_MINIMAP_ICON = "Icone de pistage"
L_GUI_GARRISON_ICON = "Icone de la Garnison"
L_GUI_MINIMAP_SIZE = "Taille de la minicarte"
L_GUI_MINIMAP_HIDE_COMBAT = "Cacher la minimap en combat"
L_GUI_MINIMAP_TOGGLE_MENU = "Montre le menu déroulant"
L.minimap_bg_map_stylization = "Personnalisation de l'arrière plan de la carte"
L.minimap_fog_of_war = "Retire le brouillard des zones non explorées sur la carte du monde"
L.minimap_fog_of_war_desc = "Right click on the close button of World Map to activate the option to hide fog of war" -- Need review

-- Loot options
L_GUI_LOOT_SUBTEXT = "Settings for loot frame." -- Need review
L_GUI_LOOT_ENABLE = "Activer la fenêtre de butin"
L_GUI_LOOT_ROLL_ENABLE = "Activer la fenêtre de butin de groupe"
L_GUI_LOOT_ICON_SIZE = "Taille de l'icône"
L_GUI_LOOT_WIDTH = "Largeur de la fenêtre de butin"
L_GUI_LOOT_AUTOGREED = "Activer désenchantement automatique pour les objets verts au niveau maximum"
L_GUI_LOOT_AUTODE = "Confirmation automatique pour le désenchantement"
L.loot_faster_loot = "Faster looting" -- Need review
L.loot_faster_loot_desc = "Works only if enabled auto loot" -- Need review

-- Filger
L_GUI_FILGER = "Temps de recharge (Filger)" -- Need review
L_GUI_FILGER_SUBTEXT = "Filger - Semblable à WeakAuras, mais plus simple et facile d'utilisation. Vous permet d'afficher sous forme d'icones ou de barres vos auras et temps de recharge."
L_GUI_FILGER_ENABLE = "Activer Filger"
L_GUI_FILGER_TEST_MODE = "Activer le mode test"
L_GUI_FILGER_MAX_TEST_ICON = "Nombre d'icône pour le mode Test"
L_GUI_FILGER_SHOW_TOOLTIP = "Afficher l'info-bulle"
L_GUI_FILGER_DISABLE_CD = "Ne pas afficher les temps de recharge"
L_GUI_FILGER_DISABLE_PVP = "Cacher les debuff JcJ sur le Joueur et la Cible"
L_GUI_FILGER_EXPIRATION = "Organiser les temps de recharge par temps d'expiration"
L_GUI_FILGER_BUFFS_SIZE = "Taille des buffs"
L_GUI_FILGER_COOLDOWN_SIZE = "Taille des temps de recharge"
L_GUI_FILGER_PVP_SIZE = "Taille des debuffs JcJ"

-- Announcements options
L_GUI_ANNOUNCEMENTS = "Annonces"
L_GUI_ANNOUNCEMENTS_SUBTEXT = "Settings that add chat announcements about spells or items." -- Need review
L_GUI_ANNOUNCEMENTS_DRINKING = "Annonce dans la fenêtre de discussion quand un joueur ennemi est entrain de boire"
L_GUI_ANNOUNCEMENTS_INTERRUPTS = "Annonce /gr, /raid si vous interrompez un sort"
L_GUI_ANNOUNCEMENTS_SPELLS = "Annonce dans la fenêtre groupe/raid quand vous lancez certains sorts"
L_GUI_ANNOUNCEMENTS_SPELLS_FROM_ALL = "Annonce les sorts lancés par tous les membres"
L_GUI_ANNOUNCEMENTS_TOY_TRAIN = "Annonce le lancement du sort Train électrique ou Télécommande navrebière"
L_GUI_ANNOUNCEMENTS_SAYS_THANKS = "Dire merci pour certains sorts"
L_GUI_ANNOUNCEMENTS_PULL_COUNTDOWN = "Annonce le compte à rebours pou Pull '/pc #'"
L_GUI_ANNOUNCEMENTS_FLASK_FOOD = "Annonce l'usage de flasques et nourriture (/ffcheck)"
L_GUI_ANNOUNCEMENTS_FLASK_FOOD_RAID = "Announce flasque et nourriture sur le canal raid"
L_GUI_ANNOUNCEMENTS_FLASK_FOOD_AUTO = "Annonce automatiquement la prise de flasque et nourriture après un appel raid"
L_GUI_ANNOUNCEMENTS_FEASTS = "Annonce la pose de Festins/Pierre de soins/Robots de réparation"
L_GUI_ANNOUNCEMENTS_PORTALS = "Annonce le lancement de Portails/Pierre de téléportation"
L_GUI_ANNOUNCEMENTS_BAD_GEAR = "Vérifie si un mauvais équipement est porté en instance"
L_GUI_ANNOUNCEMENTS_SAFARI_HAT = "Vérifie l'équipement du Chapeau de Safari"

-- Automation options
L_GUI_AUTOMATION = "Automatisation"
L_GUI_AUTOMATION_SUBTEXT = "This block contains settings that facilitate the routine." -- Need review
L_GUI_AUTOMATION_RELEASE = "Libération automatique du corps en champ de bataille"
L_GUI_AUTOMATION_SCREENSHOT = "Prend une capture d'écran quand un haut-fait est accomplie"
L.automation_solve_artifact = "Affiche automatiquement une fenêtre pour la résolution d'un artéfact"
L.automation_solve_artifact_desc = "If there are enough fragments for an artifact, a popup will appear to solve it." -- Need review
L_GUI_AUTOMATION_ACCEPT_INVITE = "Accepter automatiquement les invitations"
L_GUI_AUTOMATION_DECLINE_DUEL = "Décliner les duels automatiquement"
L_GUI_AUTOMATION_ACCEPT_QUEST = "Accepter les quêtes automatiquement"
L_GUI_AUTOMATION_AUTO_COLLAPSE = "Rétrécie automatiquement la liste des quêtes en instance"
L_GUI_AUTOMATION_AUTO_COLLAPSE_RELOAD = "Fermeture automatique de la fenêtre de suivi des objectifs après rechargement"
L_GUI_AUTOMATION_SKIP_CINEMATIC = "Désactive automatiquement les cinématiques/film (inactif si la touche Ctrl est appuyée)"
L_GUI_AUTOMATION_AUTO_ROLE = "Active automatiquement l'affichage de votre rôle"
L_GUI_AUTOMATION_CANCEL_BAD_BUFFS = "Annule automatiquement certains buffs"
L.automation_tab_binder = "Active la touche Tab pour ne cibler que les personnages joueurs ennemis"
L.automation_tab_binder_desc = "'Tab' key target only enemy players when in PvP zones, ignores pets and mobs" -- Need review
L_GUI_AUTOMATION_LOGGING_COMBAT = "Active automatiquement l'enregistrement du journal de combat en raid"
L.automation_buff_on_scroll = "Lancement de sort via la molette souris"
L.automation_buff_on_scroll_desc = "If the buff from the list is not applied to the player, it will cast by the mouse scroll" -- Need review
L_GUI_AUTOMATION_OPEN_ITEMS = "Ouverture automatique des objets dans les sacs"
L.automation_invite_keyword = "Mot clé pour l'invitation automatique"
L.automation_invite_keyword_desc = "When player whisper you keyword he will be invited in your group. \nFor enable - type '/ainv'. Also after the command, you can write your word '/ainv inv'" -- Need review

-- Buffs reminder options
L_GUI_REMINDER = "Contrôle des buffs"
L_GUI_REMINDER_SUBTEXT = "Display of missed auras." -- Need review
L_GUI_REMINDER_SOLO_ENABLE = "Voir les buffs personnels manquants"
L_GUI_REMINDER_SOLO_SOUND = "Son d'alerte si buff manquant"
L_GUI_REMINDER_SOLO_SIZE = "Icon size" -- Need review
L_GUI_REMINDER_SOLO_SIZE_DESC = "Taille de l'icône pour les buffs personnels"
L_GUI_REMINDER_SUBHEADER = "Raid buffs" -- Need review
L_GUI_REMINDER_RAID_ENABLE = "Voir les buffs de raid manquants"
L_GUI_REMINDER_RAID_ALWAYS = "Toujours voir les buffs manquants"
L_GUI_REMINDER_RAID_SIZE = "Icon size" -- Need review
L_GUI_REMINDER_RAID_SIZE_DESC = "Taille de l'icône pour les buffs de raid"
L_GUI_REMINDER_RAID_ALPHA = "Transparent" -- Need review
L_GUI_REMINDER_RAID_ALPHA_DESC = "Icône transparente quand le buff de raid est présent"

-- Raid cooldowns options
L_GUI_COOLDOWN_RAID = "Temps de recharge du raid"
L_GUI_COOLDOWN_RAID_SUBTEXT = "Tracking raid abilities in the upper left corner." -- Need review
L_GUI_COOLDOWN_RAID_ENABLE = "Activer les CD de raid"
L_GUI_COOLDOWN_RAID_HEIGHT = "Bars height" -- Need review
L_GUI_COOLDOWN_RAID_WIDTH = "Bars width" -- Need review
L_GUI_COOLDOWN_RAID_SORT = "Nouvelle barre vers le haut"
L_GUI_COOLDOWN_RAID_EXPIRATION = "Tri par temps d'expiration"
L_GUI_COOLDOWN_RAID_SHOW_SELF = "Montrer mes temps de recharge"
L_GUI_COOLDOWN_RAID_ICONS = "Icônes des temps de recharge de raid"
L_GUI_COOLDOWN_RAID_IN_RAID = "Voir les temps de recharge alliés en raid"
L_GUI_COOLDOWN_RAID_IN_PARTY = "Voir les temps de recharge alliés en groupe"
L_GUI_COOLDOWN_RAID_IN_ARENA = "Voir les temps de recharge alliés en arène"

-- Enemy cooldowns options
L_GUI_COOLDOWN_ENEMY = "Temps de recharge des ennemis"
L_GUI_COOLDOWN_ENEMY_SUBTEXT = "Tracking enemy abilities as icons above your spell casting bar." -- Need review
L_GUI_COOLDOWN_ENEMY_ENABLE = "Activer les temps de recharge ennemis"
L_GUI_COOLDOWN_ENEMY_SIZE = "Taille de l'icône des temps de recharge ennemis"
L_GUI_COOLDOWN_ENEMY_DIRECTION = "Icône directionnelle du temps de recharge ennemis"
L_GUI_COOLDOWN_ENEMY_EVERYWHERE = "Voir les temps de recharge ennemis partout"
L_GUI_COOLDOWN_ENEMY_IN_BG = "Voir les temps de recharge ennemis dans les champs de bataille"
L_GUI_COOLDOWN_ENEMY_IN_ARENA = "Voir les temps de recharge ennemis en arène"
L.enemycooldown_show_inparty = "Show in party zone for allies" -- Need review
L.enemycooldown_class_color = "Enable classcolor border" -- Need review

-- Pulse cooldowns options
L_GUI_COOLDOWN_PULSE = "Temps de recharge par îcone d'impulsion"
L_GUI_COOLDOWN_PULSE_SUBTEXT = "Track your cd using a pulse icon in the center of the screen." -- Need review
L_GUI_COOLDOWN_PULSE_ENABLE = "Activation de l'îcone d'impulsion"
L_GUI_COOLDOWN_PULSE_SIZE = "Taille de l'îcone d'impulstion"
L_GUI_COOLDOWN_PULSE_SOUND = "Avertissement sonore"
L_GUI_COOLDOWN_PULSE_ANIM_SCALE = "Mise à l'échelle des animations"
L_GUI_COOLDOWN_PULSE_HOLD_TIME = "Temps maximum pour la rémanence de l'îcone"
L_GUI_COOLDOWN_PULSE_THRESHOLD = "Threshold time" -- Need review
L_GUI_COOLDOWN_PULSE_THRESHOLD_DESC = "Temps minimum de déclenchement"

-- Threat options
L_GUI_THREAT = "Barre de menace"
L_GUI_THREAT_SUBTEXT = "Display of the threat list (a simple analogue of Omen)." -- Need review
L_GUI_THREAT_ENABLE = "Activer les barres de menace"
L_GUI_THREAT_HEIGHT = "Hauteur des barres de menace"
L_GUI_THREAT_WIDTH = "Largeur des barres de menace"
L_GUI_THREAT_ROWS = "Nombre de barres de menace"
L_GUI_THREAT_HIDE_SOLO = "Afficher la menace seulement en groupe/raid"

-- Top panel options
L_GUI_TOP_PANEL = "Panneau supérieur"
L_GUI_TOP_PANEL_SUBTEXT = "Manage built-in top panel with information." -- Need review
L_GUI_TOP_PANEL_ENABLE = "Activer le panneau supérieur"
L_GUI_TOP_PANEL_MOUSE = "Panneau supérieur en 'mouseover'"
L_GUI_TOP_PANEL_WIDTH = "Largeur du panneau"
L_GUI_TOP_PANEL_HEIGHT = "Hauteur du panneau"

-- Stats options
L_GUI_STATS = "Stats"
L_GUI_STATS_SUBTEXT = "Statistics blocks located at the bottom of the screen. Type in the chat '/ls' for info." -- Need review
L_GUI_STATS_CLOCK = "Horloge"
L_GUI_STATS_LATENCY = "Latence"
L_GUI_STATS_FPS = "FPS"
L_GUI_STATS_EXPERIENCE = "Expérience"
L_GUI_STATS_TALENTS_DESC = "Date-text allows you to change the spec and loot on click" -- Need review
L_GUI_STATS_COORDS = "Coordonnées"
L_GUI_STATS_LOCATION = "Lieu actuel"
L_GUI_STATS_BG = "Champ de bataille"
L_GUI_STATS_SUBHEADER_CURRENCY = "Currency (displayed in gold data text)" -- Need review
L_GUI_STATS_CURRENCY_ARCHAEOLOGY = "Afficher les fragments d'Archéologie dans l'onglet des devises"
L_GUI_STATS_CURRENCY_COOKING = "Afficher les marques de Cuisine dans l'onglet des devises"
L_GUI_STATS_CURRENCY_RAID = "Afficher les sceaux de raid dans l'onglet des devises"

-- Error options
L_GUI_ERROR = "Erreurs"
L_GUI_ERROR_SUBTEXT = "Filtering standard text at the top of the screen from Blizzard." -- Need review
L_GUI_ERROR_BLACK = "Cacher les erreurs de la liste noire"
L_GUI_ERROR_WHITE = "Afficher les erreurs de la liste blanche"
L_GUI_ERROR_HIDE_COMBAT = "Cacher toutes les erreurs en combat"

-- Miscellaneous options
L_GUI_MISC_SUBTEXT = "Other settings that add interesting features." -- Need review
L.misc_shift_marking = "Marks mouseover target" -- Need review
L.misc_shift_marking_desc = "Marks mouseover target when you push Shift (only in group)" -- Need review
L_GUI_MISC_SPIN_CAMERA = "Faire tourner la caméra quand absent"
L_GUI_MISC_VEHICLE_MOUSEOVER = "Fenêtre de véhicule en mouseover"
L_GUI_MISC_QUEST_AUTOBUTTON = "Accepte les quêtes automatiquement"
L.misc_raid_tools = "Outils de raid"
L.misc_raid_tools_desc = "Button at the top of the screen for ready check (Left-click), checking roles (Middle-click), setting marks, etc. (for leader and assistants)" -- Need review
L_GUI_MISC_PROFESSION_TABS = "Onglet des professions sur les fenêtres de métiers et de craft"
L_GUI_MISC_HIDE_BG_SPAM = "Désactive les annonces durant les champs de bataille"
L.misc_hide_bg_spam_desc = "Remove Boss Emote spam about capture/losing node during BG Arathi and Gilneas" -- Need review
L_GUI_MISC_ITEM_LEVEL = "Affiche le niveau d'objet sur bouton d'équipement dans la fiche de personnage"
L_GUI_MISC_ALREADY_KNOWN = "Colorisation des recettes/montures/familiers que vous connaissez déjà"
L_GUI_MISC_DISENCHANTING = "Mouture, Prospection et Désenchantement avec Alt + click"
L.misc_sum_buyouts = "Somme totale des objets actuellement mis en enchère"
L.misc_sum_buyouts_desc = "At auctions tab shows sum up all current auctions" -- Need review
L.misc_click_cast = "Simple addon d'assignation de sorts : click2cast"
L.misc_click_cast_desc = "Allows you to assign spells (analog Clique) to the mouse buttons. Setup through the side bookmark in the spell book" -- Need review
L.misc_click_cast_filter = "Ignore les cadres Joueur et Cible pour l'addon click2cast"
L_GUI_MISC_MOVE_BLIZZARD = "Autorise le déplacement de certains fenêtres de l'interface Blizzard"
L.misc_color_picker = "Palette de couleurs améliorée"
L.misc_color_picker_desc = "Add copy/paste buttons and digit text entry for Blizzard color picker frame" -- Need review
L_GUI_MISC_ENCHANTMENT_SCROLL = "Onglet : parchemin d'enchantement sur la fenêtre de métiers"
L.misc_archaeology = "Artéfacts et temps de recharge en Archéologie"
L.misc_archaeology_desc = "Archaeology tracker ('/arch' or right mouseover minimap button to show)" -- Need review
L.misc_chars_currency = "Affiche les jetons et autres monnaies de vos différents personnages"
L.misc_chars_currency_desc = "Hover over the icon of the required currency in the character window to display information in the tooltip" -- Need review
L.misc_armory_link = "Add Armory link" -- Need review
L.misc_armory_link_desc = "Ajouter un lien d'armurerie dans une fenêtre UnitPopupMenus (Cela casse les UnitPopupMenus)"
L_GUI_MISC_MERCHANT_ITEMLEVEL = "Montrer le niveau d'objet des armes et amures chez le marchand"
L_GUI_MISC_MINIMIZE_MOUSEOVER = "Survol par la souris pour réduire les quêtes"
L_GUI_MISC_HIDE_BANNER = "Masquer la fenêtre/bannière de loot des Boss"
L_GUI_MISC_HIDE_TALKING_HEAD = "Masquer la fenêtre de discussion principale"
L.misc_hide_raid_button = "Masquer le button pour activer oUF_RaidDPS"
L.misc_hide_raid_button_desc = "The button is displayed by hovering the mouse in the upper left corner" -- Need review
