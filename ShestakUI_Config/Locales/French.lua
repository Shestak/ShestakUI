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
L_GUI_LAYOUT = "Change layout" -- Need review
L_GUI_SPELL_LIST = "List of spells" -- Need review
L_GUI_SPELL_INPUT = "Spell ID" -- Need review
L_GUI_TIME_INPUT = "Time" -- Need review
L_GUI_EXPERT_MODE = "Expert mode" -- Need review
L_GUI_EXPERT_MODE_DESC = "Custom editing of Lua profile" -- Need review
L_GUI_RESET_SPELLS_DESC = "CTRL-click to reset list" -- Need review

-- General options
L_GUI_GENERAL_SUBTEXT = "Ces paramètres controllent les rendus de l'interface utilisateur. Saisir '/uihelp' dans le chat pour plus d'information."
L_GUI_GENERAL_WELCOME_MESSAGE = "Message de bienvenue dans la fenêtre de dialogue"
L_GUI_GENERAL_AUTOSCALE = "Mise à l'échelle automatique"
L_GUI_GENERAL_UISCALE = "Mettre l'interface à l'échelle (si 'Mise à l'échelle automatique' est désactivée)"
L.general_subheader_blizzard = "Blizzard UI elements" -- Need review
L.general_error_filter = "Error filtering" -- Need review
L.general_error_blacklist = "Blacklist" -- Need review
L.general_error_whitelist = "Whitelist" -- Need review
L.general_error_combat = "In combat" -- Need review
L.general_error_none = "None" -- Need review
L.general_vehicle_mouseover = "Fenêtre de véhicule en mouseover"
L.general_move_blizzard = "Autorise le déplacement de certains fenêtres de l'interface Blizzard"
L.general_color_picker = "Palette de couleurs améliorée"
L.general_color_picker_desc = "Add copy/paste buttons and digit text entry for Blizzard color picker frame" -- Need review
L.general_minimize_mouseover = "Survol par la souris pour réduire les quêtes"
L.general_hide_banner = "Masquer la fenêtre/bannière de loot des Boss"
L.general_hide_talking_head = "Masquer la fenêtre de discussion principale"

-- Media options
L.media_border_color = "Couleurs des bordures (fenêtres, barres, info-bulles, etc)"
L.media_classborder_color = "Color for class borders" -- Need review
L.media_backdrop_color = "Couleurs du remplissage des bordures (fenêtres, barres, info-bulles, etc)"
L.media_backdrop_alpha = "Transparence du fond des bordures"
L.media_texture = "Main texture" -- Need review
L.media_subheader_normal = "Change general font" -- Need review
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
L.font_subheader_blizzard = "System font size" -- Need review
L.font_tooltip_header_font_size = "Tooltip header" -- Need review
L.font_tooltip_font_size = "Tooltip text" -- Need review
L.font_global_font = "Disable Pixel font" -- Need review

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
L.unitframe_uf_color_bg = "Color of health background" -- Need review
L.unitframe_enemy_health_color = "Si activée, la couleur des cibles ennemi est rouge"
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
L.unitframe_icons_pvp = "PvP status text" -- Need review
L.unitframe_icons_pvp_desc = "Texte JcJ en Mouseover pour la barre du joueur et celle de la cible"
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
L_GUI_UF_PLUGINS_SMOOTH_BAR = "Lissage des barres"
L_GUI_UF_PLUGINS_ENEMY_SPEC = "Afficher les talent de l'ennemi"
L_GUI_UF_PLUGINS_COMBAT_FEEDBACK = "Texte de combat sur les barres du joueur et de la cible"
L_GUI_UF_PLUGINS_FADER = "Barres de unités"
L_GUI_UF_PLUGINS_DIMINISHING = "Icones de rendement décroissants sur les fenêtre d'arène"
L_GUI_UF_PLUGINS_POWER_PREDICTION = "Prédiction du coût des sorts sur la fenêtre du joueur"
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
L.unitframe_class_bar_totem_other = "Enable Totem bar for other classes" -- Need review

-- Raid Frames options
L_GUI_UF_RAIDFRAMES_SUBTEXT = "Customize the appearance of the raid frames." -- Need review
L_GUI_UF_BY_ROLE = "Trier les joueurs par rôle dans les groupes"
L_GUI_UF_AGGRO_BORDER = "Aggro signalée en bordure"
L_GUI_UF_DEFICIT_HEALTH = "Déficit en vie du raid"
L_GUI_UF_SHOW_PARTY = "Afficher les barres du groupe"
L_GUI_UF_SHOW_RAID = "Afficher les barres du raid"
L.raidframe_layout = "Raid layout" -- Needs review
L.raidframe_heal_layout = "Heal" -- Needs review
L.raidframe_dps_layout = "DPS" -- Needs review
L.raidframe_auto_layout = "Auto" -- Needs review
L.raidframe_show_target = "Show target frames" -- Needs review
L.raidframe_show_pet = "Show pet frames" -- Needs review
L.raidframe_vertical_health = "Orientation vertical des barres de vie"
L.raidframe_vertical_health_desc = "Only for heal layout" -- Needs review
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
L.raidframe_party_vertical = "Vertical party frames" -- Needs review
L.raidframe_raid_groups_vertical = "Groupe de raid verticaux" -- Needs review
L.raidframe_raid_groups_vertical_desc = "Groupe de raid verticaux(pour l'interface Heal)" -- Needs review
L_GUI_UF_SUBHEADER_ICONS = "Icons" -- Need review
L_GUI_UF_ICONS_ROLE = "Icone de rôle sur les barres de vie"
L_GUI_UF_ICONS_RAID_MARK = "Signe de raid"
L_GUI_UF_ICONS_READY_CHECK = "Icone d'appel"
L_GUI_UF_ICONS_LEADER = "Icone du Chef de raid, icone de l'assistant"
L_GUI_UF_ICONS_SUMON = "Faire apparaître les icones sur les barres"
L.raidframe_icons_phase = "Phase" -- Need review
L.raidframe_plugins_debuffhighlight_icon = "Mise en évidence des debuffs texture + îcone" -- Need review
L.raidframe_plugins_aura_watch = "Aura/debuff de raid"
L.raidframe_plugins_aura_watch_timer = "Durée sur les icônes de débuff du raid"
L.raidframe_plugins_pvp_debuffs = "Afficher aussi les debuff JcJ (de la liste)"
L_GUI_UF_PLUGINS_HEALCOMM = "Barre de soin entrant (incoming)"
L.raidframe_plugins_auto_resurrection = "Auto cast resurrection" -- Need review
L.raidframe_plugins_auto_resurrection_desc = "Lance automatiquement le sort de résurrection de masse avec un clic central souris sur une cible morte (ne fonctionne pas avec l'addon Clique activé)"
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
L.actionbar_bottombars_mouseover = "Bottom bars on mouseover" -- Needs review
L_GUI_ACTIONBAR_RIGHTBARS_MOUSEOVER = "Barres de droite en 'mouseover'"
L_GUI_ACTIONBAR_PETBAR_HIDE = "Cacher la barre du familier"
L_GUI_ACTIONBAR_PETBAR_HORIZONTAL = "Activer la barre du familier horizontale"
L_GUI_ACTIONBAR_PETBAR_MOUSEOVER = "Barre du familier en 'mouseover'(uniquement pour la barre horizontale)"
L_GUI_ACTIONBAR_STANCEBAR_HIDE = "Cacher changeforme"
L_GUI_ACTIONBAR_STANCEBAR_HORIZONTAL = "Activer la barre de posture horizontale"
L.actionbar_stancebar_horizontal_desc = "Located below the player's frame" -- Needs review
L_GUI_ACTIONBAR_STANCEBAR_MOUSEOVER = "Changeforme/Posture/barre de totems en 'mouseover'" -- Need review
L_GUI_ACTIONBAR_MICROMENU = "Active le Micro menu"
L_GUI_ACTIONBAR_MICROMENU_MOUSEOVER = "Affiche le Micro menu au survol de la souris"
L.actionbar_editor = "Bars editor" -- Needs review
L.actionbar_editor_desc = "Allow to move and change each panel individually" -- Needs review
L.actionbar_bar1_num = "Number of buttons" -- Needs review
L.actionbar_bar1_row = "Buttons per row" -- Needs review
L.actionbar_bar1_mouseover = "Bar on mouseover" -- Needs review

-- Tooltip options
L.tooltip = "Tooltip"
L.tooltip_subtext = "In this block, you can change the standard tips when mouseovering." -- Need review
L.tooltip_enable = "Activer les tooltips"
L.tooltip_shift_modifer = "Afficher la tooltip quand la touche 'MAJ' est appuyée"
L.tooltip_cursor = "Afficher la Tooltip sous le curseur"
L.tooltip_item_icon = "Afficher l'îcone de l'objet"
L.tooltip_health_value = "Afficher les points de vie"
L.tooltip_hidebuttons = "Cacher le tooltip pour les barres d'action"
L.tooltip_hide_combat = "Cacher les tooltips en combat"
L.tooltip_subheader = "Plugins" -- Need review
L.tooltip_talents = "Afficher les talents"
L.tooltip_show_shift = "Show when Shift is pushed" -- Need review
L.tooltip_show_shift_desc = "Show items level and spec when Shift is pushed" -- Need review
L.tooltip_achievements = "Afficher Comparer les Hauts Faits"
L.tooltip_target = "Afficher la cible"
L.tooltip_title = "Afficher les titres"
L.tooltip_realm = "Affiche le serveur du joueur"
L.tooltip_rank = "Afficher le rang de guilde"
L.tooltip_spell_id = "Afficher l'ID du sort"
L.tooltip_average_lvl_desc = "The average item level" -- Need review
L.tooltip_raid_icon = "Afficher l'îcone de raid"
L.tooltip_who_targetting = "Afficher qui cible actuellement l'unité qui est dans votre groupe/raid"
L.tooltip_item_count = "Afficher le nombre d'objets possédés"
L.tooltip_unit_role = "Afficher les rôles"
L.tooltip_instance_lock = "Afficher le verrouillage de votre instance"
L.tooltip_mount = "Source of mount" -- Needs review

-- Chat options
L_GUI_CHAT_SUBTEXT = "Here you can change the settings of the chat window." -- Need review
L_GUI_CHAT_ENABLE = "Activer la fenêtre de dialogue"
L_GUI_CHAT_BACKGROUND = "Activer l'arrière plan"
L_GUI_CHAT_BACKGROUND_ALPHA = "Transparence de l'arrière"
L.chat_filter = "Supprime certains spam"
L.chat_filter_desc = "Duels, change talents, NPC dialogue in city" -- Need review
L.chat_spam = "Supprime tous les spams joueur"
L.chat_spam_list = "Black list" -- Need review
L.chat_spam_list_desc = "List of words (separated by space, lowercase letters) to hide messages" -- Need review
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
L.nameplate_clamp = "Afficher les barres en haut de l'écran quand celles-ci sont au delà de la vision" -- Need review
L.nameplate_clamp_desc = "Afficher les barres en haut de l'écran quand celles-ci sont au delà de la vision"
L_GUI_NAMEPLATE_SHOW_DEBUFFS = "Affiche les affaiblissements (Les noms abrégés doivent être désactivés)"
L_GUI_NAMEPLATE_SHOW_BUFFS = "Show dispellable enemy buffs and buffs from the list" -- Need review
L_GUI_NAMEPLATE_DEBUFFS_SIZE = "Taille des affaiblissements" -- Need review
L_GUI_NAMEPLATE_HEALER_ICON = "Affiche une icône de soigneur sur toutes les barres de vie des soigneurs ennemis dans les champs de bataille"
L_GUI_NAMEPLATE_TOTEM_ICONS = "Afficher une icone au dessus des barres de vie des totems ennemis"
L.nameplate_target_glow = "Show glow texture for target" -- Need review
L.nameplate_only_name = "Show only name for friendly units" -- Need review
L.nameplate_quests = "Show quest icon" -- Need review
L.nameplate_cast_color = "Show color border for casting important spells" -- Need review
L.nameplate_kick_color = "Change cast color if interrupt on cd" -- Need review
L.nameplate_low_health_value = "Health value" -- Need review
L.nameplate_low_health = "Low health highlight" -- Need review
L_GUI_NAMEPLATE_THREAT = "Activer la gestion de la menace, change automatiquement selon votre rôle"
L_GUI_NAMEPLATE_GOOD_COLOR = "Bonne couleur de menace, dépend de si vous êtes un tank ou dps/heal"
L_GUI_NAMEPLATE_NEAR_COLOR = "Perte/Gain de couleur de menace"
L_GUI_NAMEPLATE_BAD_COLOR = "Mauvaise couleur de menace, dépend de si vous êtes un tank ou dps/heal"
L_GUI_NAMEPLATE_OFFTANK_COLOR = "Coloration de la menace du tank secondaire"
L.nameplate_extra_color = "Explosive and Spiteful affix color" -- Need review
L.nameplate_mob_color_enable = "Change color for important mobs in dungeons" -- Need review
L.nameplate_mob_color = "Color for mobs" -- Need review

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
L.combattext_incoming = "Show incoming damage and healing" -- Need review
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
L.aura_boss_buffs = "Afficher les améliorations sur le cadre du Boss" -- Need review
L_GUI_AURA_PLAYER_AURA_ONLY = "Afficher seulement ses propres debuffs sur la cible"
L_GUI_AURA_DEBUFF_COLOR_TYPE = "Coleur de debuff par type"
L_GUI_AURA_CAST_BY = "Voir qui a jeté un buff / debuff sur son tooltip"
L_GUI_AURA_CLASSCOLOR_BORDER = "Active la couleur de votre classe pour la bordure de vos buffs"

-- Bag options
L_GUI_BAGS = "Sacs"
L_GUI_BAGS_SUBTEXT = "Right click on the close button to open the menu. To move the bags, hold down Shift - click." -- Need review
L_GUI_BAGS_ENABLE = "Activer les sacs"
L_GUI_BAGS_ILVL = "Afficher le niveau d'objet des armes et armures"
L.bag_new_items = "Show animation for new items" -- Need review
L_GUI_BAGS_BUTTON_SIZE = "Taille des boutons"
L_GUI_BAGS_BUTTON_SPACE = "Espacement des boutons"
L_GUI_BAGS_BANK = "Nombre de colonne pour la banque"
L_GUI_BAGS_BAG = "Nombre de colonne pour les sacs"

-- Minimap options
L_GUI_MINIMAP_SUBTEXT = "Minimap settings." -- Need review
L_GUI_MINIMAP_ENABLE = "Activer la minicarte"
L_GUI_MINIMAP_ICON = "Icone de pistage"
L_GUI_GARRISON_ICON = "Icone de la Garnison" -- Need review
L_GUI_MINIMAP_SIZE = "Taille de la minicarte"
L_GUI_MINIMAP_HIDE_COMBAT = "Cacher la minimap en combat"
L_GUI_MINIMAP_TOGGLE_MENU = "Montre le menu déroulant"
L.minimap_bg_map_stylization = "Personnalisation de l'arrière plan de la carte"
L.minimap_fog_of_war = "Retire le brouillard des zones non explorées sur la carte du monde"

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
L_GUI_FILGER_EXPIRATION = "Organiser les temps de recharge par temps d'expiration"
L_GUI_FILGER_BUFFS_SIZE = "Taille des buffs"
L_GUI_FILGER_COOLDOWN_SIZE = "Taille des temps de recharge"
L_GUI_FILGER_PVP_SIZE = "Taille des debuffs JcJ"
L.filger_buffs_space = "Buffs space" -- Need review
L.filger_pvp_space = "PvP auras space" -- Need review
L.filger_cooldown_space = "Cooldowns space" -- Need review
L.filger_subheader_spells = "Adding new spells" -- Need review
L.filger_category_list = "Spell list category" -- Need review

-- Announcements options
L_GUI_ANNOUNCEMENTS = "Annonces"
L_GUI_ANNOUNCEMENTS_SUBTEXT = "Settings that add chat announcements about spells or items." -- Need review
L.announcements_drinking = "Annonce dans la fenêtre de discussion quand un joueur ennemi est entrain de boire"
L.announcements_interrupts = "Annonce /gr, /raid si vous interrompez un sort"
L.announcements_spells = "Annonce dans la fenêtre groupe/raid quand vous lancez certains sorts"
L.announcements_spells_from_all = "Annonce les sorts lancés par tous les membres"
L.announcements_toys = "Annonce le lancement du sort Train électrique ou Télécommande navrebière"
L.announcements_pull_countdown = "Annonce le compte à rebours pou Pull '/pc #'"
L.announcements_flask_food = "Annonce l'usage de flasques et nourriture (/ffcheck)"
L.announcements_flask_food_raid = "Announce flasque et nourriture sur le canal raid"
L.announcements_flask_food_auto = "Annonce automatiquement la prise de flasque et nourriture après un appel raid" -- Needs review
L.announcements_feasts = "Annonce la pose de Festins/Pierre de soins/Robots de réparation"
L.announcements_portals = "Annonce le lancement de Portails/Pierre de téléportation"
L.announcements_bad_gear = "Check your bad gear" -- Need review
L.announcements_bad_gear_desc = "Vérifie si un mauvais équipement est porté en instance"
L.announcements_safari_hat = "Vérifie l'équipement du Chapeau de Safari"

-- Automation options
L_GUI_AUTOMATION = "Automatisation"
L_GUI_AUTOMATION_SUBTEXT = "This block contains settings that facilitate the routine." -- Need review
L.automation_release = "Libération automatique du corps en champ de bataille"
L.automation_screenshot = "Prend une capture d'écran quand un haut-fait est accomplie"
L.automation_solve_artifact = "Affiche automatiquement une fenêtre pour la résolution d'un artéfact"
L.automation_solve_artifact_desc = "If there are enough fragments for an artifact, a popup will appear to solve it." -- Need review
L.automation_accept_invite = "Accepter automatiquement les invitations"
L.automation_decline_duel = "Décliner les duels automatiquement"
L.automation_accept_quest = "Accepter les quêtes automatiquement"
L.automation_auto_collapse = "Auto collapse Objective Tracker" -- Need review
L.automation_auto_collapse_raid = "In Instance" -- Need review
L.automation_auto_collapse_reload = "After reload" -- Need review
L.automation_auto_collapse_scenario = "Partially" -- Need review
L.automation_skip_cinematic = "Désactive automatiquement les cinématiques/film (inactif si la touche Ctrl est appuyée)"
L.automation_auto_role = "Active automatiquement l'affichage de votre rôle"
L.automation_cancel_bad_buffs = "Annule automatiquement certains buffs"
L.automation_tab_binder = "Active la touche Tab pour ne cibler que les personnages joueurs ennemis"
L.automation_tab_binder_desc = "'Tab' key target only enemy players when in PvP zones, ignores pets and mobs" -- Need review
L.automation_logging_combat = "Active automatiquement l'enregistrement du journal de combat en raid"
L.automation_buff_on_scroll = "Lancement de sort via la molette souris"
L.automation_buff_on_scroll_desc = "If the buff from the list is not applied to the player, it will cast by the mouse scroll" -- Need review
L.automation_open_items = "Ouverture automatique des objets dans les sacs"
L.automation_resurrection = "Confirm resurrection" -- Needs review
L.automation_summon = "Confirm summon" -- Needs review
L.automation_whisper_invite = "Auto invite when whisper keyword" -- Needs review
L.automation_invite_keyword = "List of keyword (separated by space)" -- Needs review
L.automation_invite_keyword_desc = "When player whisper you keyword he will be invited in your group" -- Needs review

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
L.stats_bottom_line = "Bottom classcolor line" -- Need review
L_GUI_STATS_SUBHEADER_CURRENCY = "Currency (displayed in gold data text)" -- Need review
L_GUI_STATS_CURRENCY_ARCHAEOLOGY = "Afficher les fragments d'Archéologie dans l'onglet des devises"
L_GUI_STATS_CURRENCY_COOKING = "Afficher les marques de Cuisine dans l'onglet des devises"
L_GUI_STATS_CURRENCY_RAID = "Afficher les sceaux de raid dans l'onglet des devises"

-- Trade options
L_GUI_TRADE = "Trade" -- Need review
L_GUI_TRADE_SUBTEXT = "Settings related to professions and trade" -- Need review
L.trade_profession_tabs = "Professions tabs" -- Need review
L.trade_profession_tabs_desc = "Onglet des professions sur les fenêtres de métiers et de craft"
L.trade_already_known = "Colorizes already known items" -- Need review
L.trade_already_known_desc = "Colorisation des recettes/montures/familiers que vous connaissez déjà"
L.trade_disenchanting = "Quick Disenchanting" -- Need review
L.trade_disenchanting_desc = "Mouture, Prospection et Désenchantement avec Alt + click"
L.trade_sum_buyouts = "Somme totale des objets actuellement mis en enchère"
L.trade_sum_buyouts_desc = "At auctions tab shows sum up all current auctions" -- Need review
L.trade_enchantment_scroll = "Onglet : parchemin d'enchantement sur la fenêtre de métiers"
L.trade_archaeology = "Artéfacts et temps de recharge en Archéologie"
L.trade_archaeology_desc = "Archaeology tracker ('/arch' or right mouseover minimap button to show)" -- Need review
L.trade_merchant_itemlevel = "Item level in merchant" -- Need review
L.trade_merchant_itemlevel_desc = "Montrer le niveau d'objet des armes et amures chez le marchand"

-- Miscellaneous options
L_GUI_MISC_SUBTEXT = "Other settings that add interesting features." -- Need review
L.misc_shift_marking = "Marks mouseover target" -- Need review
L.misc_shift_marking_desc = "Marks mouseover target when you push Shift (only in group)" -- Need review
L.misc_afk_spin_camera = "Faire tourner la caméra quand absent"
L.misc_quest_auto_button = "Quest items auto button" -- Need review
L.misc_quest_auto_button_desc = "Accepte les quêtes automatiquement" -- Need review
L.misc_raid_tools = "Outils de raid"
L.misc_raid_tools_desc = "Button at the top of the screen for ready check (Left-click), checking roles (Middle-click), setting marks, etc. (for leader and assistants)" -- Need review
L.misc_item_level = "Item level on slot buttons" -- Need review
L.misc_item_level_desc = "Affiche le niveau d'objet sur bouton d'équipement dans la fiche de personnage"
L.misc_click_cast = "Simple addon d'assignation de sorts : click2cast"
L.misc_click_cast_desc = "Allows you to assign spells (analog Clique) to the mouse buttons. Setup through the side bookmark in the spell book" -- Need review
L.misc_click_cast_filter = "Ignore les cadres Joueur et Cible pour l'addon click2cast"
L.misc_chars_currency = "Affiche les jetons et autres monnaies de vos différents personnages"
L.misc_chars_currency_desc = "Hover over the icon of the required currency in the character window to display information in the tooltip" -- Need review
L.misc_hide_raid_button = "Masquer le button pour activer oUF_RaidDPS"
L.misc_hide_raid_button_desc = "The button is displayed by hovering the mouse in the upper left corner" -- Need review