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
L_GUI_NEED_RELOAD = "|cffff2735You need to reload the UI to apply your changes.|r" -- Need review

-- General options
L_GUI_GENERAL_SUBTEXT = "These settings control the general user interface settings. Type in chat '/uihelp' for help." -- Need review
L_GUI_GENERAL_AUTOSCALE = "Mise à l'échelle automatique"
L_GUI_GENERAL_UISCALE = "Mettre l'interface à l'échelle (si 'Mise à l'échelle automatique' est désactivée)"
L_GUI_GENERAL_WELCOME_MESSAGE = "Message de bienvenue dans la fenêtre de dialogue"
L_GUI_GENERAL_LAG_TOLERANCE = "Ajuste automatiquement la barre de latence Blizzard avec votre propre latence"

-- Miscellaneous options
L_GUI_MISC_SUBTEXT = "Other settings that add interesting features." -- Need review
L_GUI_MISC_MARKING = "Marque la cible quand vous appuyez sur MAJ"
L_GUI_MISC_INVKEYWORD = "Mot clé pour l'invitation automatique (/ainv)"
L_GUI_MISC_SPIN_CAMERA = "Faire tourner la caméra quand absent"
L_GUI_MISC_VEHICLE_MOUSEOVER = "Fenêtre de véhicule en mouseover"
L_GUI_MISC_QUEST_AUTOBUTTON = "Accepte les quêtes automatiquement"
L_GUI_MISC_RAID_TOOLS = "Outils de raid"
L_GUI_MISC_PROFESSION_TABS = "Onglet des professions sur les fenêtres de métiers et de craft"
L_GUI_MISC_HIDE_BG_SPAM = "Désactive les annonces durant les champs de bataille"
L.misc_hide_bg_spam_desc = "Remove Boss Emote spam about capture/losing node during BG Arathi and Gilneas" -- Need review
L_GUI_MISC_ITEM_LEVEL = "Affiche le niveau d'objet sur bouton d'équipement dans la fiche de personnage"
L_GUI_MISC_ALREADY_KNOWN = "Colorisation des recettes/montures/familiers que vous connaissez déjà"
L_GUI_MISC_DISENCHANTING = "Mouture, Prospection et Désenchantement avec Alt + click"
L_GUI_MISC_SUM_BUYOUTS = "Somme totale des objets actuellement mis en enchère"
L_GUI_MISC_CLICK_CAST = "Simple addon d'assignation de sorts : click2cast"
L_GUI_MISC_CLICK_CAST_FILTER = "Ignore les cadres Joueur et Cible pour l'addon click2cast"
L_GUI_MISC_MOVE_BLIZZARD = "Autorise le déplacement de certains fenêtres de l'interface Blizzard"
L_GUI_MISC_COLOR_PICKER = "Palette de couleurs améliorée"
L_GUI_MISC_ENCHANTMENT_SCROLL = "Onglet : parchemin d'enchantement sur la fenêtre de métiers"
L_GUI_MISC_ARCHAEOLOGY = "Artéfacts et temps de recharge en Archéologie"
L_GUI_MISC_CHARS_CURRENCY = "Affiche les jetons et autres monnaies de vos différents personnages"
L_GUI_MISC_ARMORY_LINK = "Ajouter un lien d'armurerie dans une fenêtre UnitPopupMenus (Cela casse les UnitPopupMenus)"
L_GUI_MISC_MERCHANT_ITEMLEVEL = "Montrer le niveau d'objet des armes et amures chez le marchand"
L_GUI_MISC_MINIMIZE_MOUSEOVER = "Survol par la souris pour réduire les quêtes"
L_GUI_MISC_HIDE_BANNER = "Masquer la fenêtre/bannière de loot des Boss"
L_GUI_MISC_HIDE_TALKING_HEAD = "Masquer la fenêtre de discussion principale"
L_GUI_MISC_HIDE_RAID_BUTTON = "Masquer le button pour activer oUF_RaidDPS"

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
L_GUI_ANNOUNCEMENTS_FLASK_FOOD = "Annonce l'usage de flasques et nourriture"
L_GUI_ANNOUNCEMENTS_FLASK_FOOD_AUTO = "Annonce automatiquement la prise de flasque et nourriture après un appel raid"
L_GUI_ANNOUNCEMENTS_FLASK_FOOD_RAID = "Announce flasque et nourriture sur le canal raid"
L_GUI_ANNOUNCEMENTS_FEASTS = "Annonce la pose de Festins/Pierre de soins/Robots de réparation"
L_GUI_ANNOUNCEMENTS_PORTALS = "Annonce le lancement de Portails/Pierre de téléportation"
L_GUI_ANNOUNCEMENTS_BAD_GEAR = "Vérifie si un mauvais équipement est porté en instance"
L_GUI_ANNOUNCEMENTS_SAFARI_HAT = "Vérifie l'équipement du Chapeau de Safari"

-- Automation options
L_GUI_AUTOMATION = "Automatisation"
L_GUI_AUTOMATION_SUBTEXT = "This block contains settings that facilitate the routine." -- Need review
L_GUI_AUTOMATION_RELEASE = "Libération automatique du corps en champ de bataille"
L_GUI_AUTOMATION_SCREENSHOT = "Prend une capture d'écran quand un haut-fait est accomplie"
L_GUI_AUTOMATION_SOLVE_ARTIFACT = "Affiche automatiquement une fenêtre pour la résolution d'un artéfact"
L_GUI_AUTOMATION_ACCEPT_INVITE = "Accepter automatiquement les invitations"
L_GUI_AUTOMATION_DECLINE_DUEL = "Décliner les duels automatiquement"
L_GUI_AUTOMATION_ACCEPT_QUEST = "Accepter les quêtes automatiquement"
L_GUI_AUTOMATION_AUTO_COLLAPSE = "Rétrécie automatiquement la liste des quêtes en instance"
L_GUI_AUTOMATION_AUTO_COLLAPSE_RELOAD = "Fermeture automatique de la fenêtre de suivi des objectifs après rechargement"
L_GUI_AUTOMATION_SKIP_CINEMATIC = "Désactive automatiquement les cinématiques/film (inactif si la touche Ctrl est appuyée)"
L_GUI_AUTOMATION_AUTO_ROLE = "Active automatiquement l'affichage de votre rôle"
L_GUI_AUTOMATION_CANCEL_BAD_BUFFS = "Annule automatiquement certains buffs"
L_GUI_AUTOMATION_TAB_BINDER = "Active la touche Tab pour ne cibler que les personnages joueurs ennemis"
L_GUI_AUTOMATION_LOGGING_COMBAT = "Active automatiquement l'enregistrement du journal de combat en raid"
L_GUI_AUTOMATION_BUFF_ON_SCROLL = "Lancement de sort via la molette souris"
L_GUI_AUTOMATION_OPEN_ITEMS = "Ouverture automatique des objets dans les sacs"

-- Skins options
L_GUI_SKINS = "Personnalisation d'addon"
L_GUI_SKINS_SUBTEXT = "Change the appearance of the standard interface." -- Need review
L_GUI_SKINS_BLIZZARD = "Activer la personnalisation des fenêtres Blizzard"
L_GUI_SKINS_MINIMAP_BUTTONS = "Activer la personnalisation des icônes de la minimap"
L_GUI_SKINS_SUBHEADER = "Stylization of addons" -- Need review
L_GUI_SKINS_ACE3 = "Ace3"
L_GUI_SKINS_ATLASLOOT = "AtlasLoot"
L_GUI_SKINS_BLOOD_SHIELD_TRACKER = "BloodShieldTracker"
L_GUI_SKINS_BW = "BigWigs"
L_GUI_SKINS_CAPPING = "Capping"
L_GUI_SKINS_CLIQUE = "Clique"
L_GUI_SKINS_COOL_LINE = "CoolLine"
L_GUI_SKINS_DBM = "DBM"
L_GUI_SKINS_DBM_MOVABLE = "Autoriser le déplacement des barres DBM"
L_GUI_SKINS_DOMINOS = "Dominos"
L_GUI_SKINS_FLYOUT_BUTTON = "FlyoutButtonCustom"
L_GUI_SKINS_LS_TOASTS = "ls: Toasts"
L_GUI_SKINS_MAGE_NUGGETS = "MageNuggets"
L_GUI_SKINS_MY_ROLE_PLAY = "MyRolePlay"
L_GUI_SKINS_NPCSCAN = "NPCScan"
L_GUI_SKINS_NUG_RUNNING = "NugRunning"
L_GUI_SKINS_OMEN = "Omen"
L_GUI_SKINS_OPIE = "OPie"
L_GUI_SKINS_OVALE = "OvaleSpellPriority"
L_GUI_SKINS_POSTAL = "Postal"
L_GUI_SKINS_RECOUNT = "Recount"
L_GUI_SKINS_REMATCH = "Rematch"
L_GUI_SKINS_SKADA = "Skada"
L_GUI_SKINS_TINY_DPS = "TinyDPS"
L_GUI_SKINS_VANASKOS = "VanasKoS"
L_GUI_SKINS_WEAK_AURAS = "WeakAuras"

-- Combat text options
L_GUI_COMBATTEXT = "Texte de combat"
L_GUI_COMBATTEXT_ENABLE = "Activer les textes de combat"
L_GUI_COMBATTEXT_BLIZZ_HEAD_NUMBERS = "Utiliser les textes de combat de Blizzard"
L_GUI_COMBATTEXT_DAMAGE_STYLE = "Change la police par défaut des dégâts/soins au dessus de la tête de la cible (Vous devez redémarrer WoW pour valider le changement)"
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
L_GUI_CHAT_TIMESTAMP = "Coloration du temps"
L_GUI_CHAT_WHISP = "Alerte sonore quand murmure"
L_GUI_CHAT_SKIN_BUBBLE = "Skin des bulles de discussions"
L_GUI_CHAT_CL_TAB = "Afficher l'onglet du journal de combat"
L_GUI_CHAT_TABS_MOUSEOVER = "Affiche les onglets de discussion au survol de la souris"
L_GUI_CHAT_STICKY = "Active le dernier canal utilisé(canal persistant)"
L_GUI_CHAT_DAMAGE_METER_SPAM = "Rassemble les lignes de statistiques de dégâts en un seul lien/ligne"

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

-- Map options
L_GUI_MAP_BG_STYLIZATION = "Personnalisation de l'arrière plan de la carte"
L_GUI_MAP_FOG_OF_WAR = "Retire le brouillard des zones non explorées sur la carte du monde"

-- Loot options
L_GUI_LOOT_SUBTEXT = "Settings for loot frame." -- Need review
L_GUI_LOOT_ENABLE = "Activer la fenêtre de butin"
L_GUI_LOOT_ROLL_ENABLE = "Activer la fenêtre de butin de groupe"
L_GUI_LOOT_ICON_SIZE = "Taille de l'icône"
L_GUI_LOOT_WIDTH = "Largeur de la fenêtre de butin"
L_GUI_LOOT_AUTOGREED = "Activer désenchantement automatique pour les objets verts au niveau maximum"
L_GUI_LOOT_AUTODE = "Confirmation automatique pour le désenchantement"

-- Nameplate options
L_GUI_NAMEPLATE_SUBTEXT = "Nameplates settings" -- Need review
L_GUI_NAMEPLATE_ENABLE = "Activer les barres de nom"
L_GUI_NAMEPLATE_COMBAT = "Afficher automatiquement les barres de nom en combat"
L_GUI_NAMEPLATE_HEALTH = "Valeur de points de vie"
L_GUI_NAMEPLATE_HEIGHT = "Hauteur des barres de nom"
L_GUI_NAMEPLATE_WIDTH = "Largeur des barres de nom"
L_GUI_NAMEPLATE_DISTANCE = "Display range" -- Need review
L_GUI_NAMEPLATE_AD_HEIGHT = "Additional height" -- Need review
L_GUI_NAMEPLATE_AD_WIDTH = "Additional width" -- Need review
L_GUI_NAMEPLATE_CASTBAR_NAME = "Afficher le nom du sort"
L_GUI_NAMEPLATE_THREAT = "Activer la gestion de la menace, change automatiquement selon votre rôle"
L_GUI_NAMEPLATE_CLASS_ICON = "Icône de classe en JcJ"
L_GUI_NAMEPLATE_NAME_ABBREV = "Afficher les noms abrégés"
L_GUI_NAMEPLATE_CLAMP = "Afficher les barres en haut de l'écran quand celles-ci sont au delà de la vision"
L_GUI_NAMEPLATE_GOOD_COLOR = "Bonne couleur de menace, dépend de si vous êtes un tank ou dps/heal"
L_GUI_NAMEPLATE_NEAR_COLOR = "Perte/Gain de couleur de menace"
L_GUI_NAMEPLATE_BAD_COLOR = "Mauvaise couleur de menace, dépend de si vous êtes un tank ou dps/heal"
L_GUI_NAMEPLATE_OFFTANK_COLOR = "Coloration de la menace du tank secondaire"
L_GUI_NAMEPLATE_SHOW_DEBUFFS = "Affiche les affaiblissements (Les noms abrégés doivent être désactivés)"
L_GUI_NAMEPLATE_SHOW_BUFFS = "Afficher les améliorations au dessus des barres des alliés (contenu dans la liste)"
L_GUI_NAMEPLATE_DEBUFFS_SIZE = "Taille des affaiblissements"
L_GUI_NAMEPLATE_HEALER_ICON = "Affiche une icône de soigneur sur toutes les barres de vie des soigneurs ennemis dans les champs de bataille"
L_GUI_NAMEPLATE_TOTEM_ICONS = "Afficher une icone au dessus des barres de vie des totems ennemis"

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
L_GUI_ACTIONBAR_TOGGLE_MODE = "Active le mode pour bloquer les combinaisons des barres d'action"
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

-- Auras/Buffs/Debuffs
L_GUI_AURA_PLAYER_BUFF_SIZE = "Buffs size" -- Need review
L_GUI_AURA_PLAYER_BUFF_SIZE_DESC = "Taille des buffs du joueur"
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

-- Filger
L_GUI_FILGER = "Timers (Filger)" -- Need review
L_GUI_FILGER_SUBTEXT = "Filger - analogue WeakAuras, but more simple and easy. Allows you to display in the form of icons and bars your auras and timers." -- Need review
L_GUI_FILGER_ENABLE = "Activer Filger"
L_GUI_FILGER_TEST_MODE = "Activer le mode Test" -- Need review
L_GUI_FILGER_MAX_TEST_ICON = "Nombre d'icône pour le mode Test"
L_GUI_FILGER_SHOW_TOOLTIP = "Afficher l'info-bulle"
L_GUI_FILGER_DISABLE_CD = "Ne pas afficher les temps de recharge"
L_GUI_FILGER_DISABLE_PVP = "Disable PvP debuffs on Player and Target" -- Need review
L_GUI_FILGER_EXPIRATION = "Sort cooldowns by expiration time" -- Need review
L_GUI_FILGER_BUFFS_SIZE = "Taille des buffs"
L_GUI_FILGER_COOLDOWN_SIZE = "Taille des temps de recharge"
L_GUI_FILGER_PVP_SIZE = "Taille des debuffs JcJ"

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
L_GUI_UF_PLUGINS_REPUTATION_BAR = "Barre de réputation"
L_GUI_UF_PLUGINS_EXPERIENCE_BAR = "Barre d'expérience"
L_GUI_UF_PLUGINS_ARTIFACT_BAR = "Barre de puissance d'Artefact"
L_GUI_UF_PLUGINS_SMOOTH_BAR = "Lissage des barres"
L_GUI_UF_PLUGINS_ENEMY_SPEC = "Afficher les talent de l'ennemi"
L_GUI_UF_PLUGINS_COMBAT_FEEDBACK = "Texte de combat sur les barres du joueur et de la cible"
L_GUI_UF_PLUGINS_FADER = "Barres de unités"
L_GUI_UF_PLUGINS_DIMINISHING = "Icones de rendement décroissants sur les fenêtre d'arène"
L_GUI_UF_PLUGINS_POWER_PREDICTION = "Prédiction du coût des sorts sur la fenêtre du joueur"

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
L_GUI_UF_ICONS_LEADER = "Icone du Chef de raid, icone de l'assistant, icone du maître du butin"
L_GUI_UF_ICONS_SUMON = "Faire apparaître les icones sur les barres"
L_GUI_UF_PLUGINS_DEBUFFHIGHLIGHT_ICON = "Mise en évidence des debuffs texture + îcone"
L_GUI_UF_PLUGINS_AURA_WATCH = "Aura/debuff de raid"
L_GUI_UF_PLUGINS_AURA_WATCH_TIMER = "Durée sur les icônes de débuff du raid"
L_GUI_UF_PLUGINS_PVP_DEBUFFS = "Afficher aussi les debuff JcJ (de la liste)"
L_GUI_UF_PLUGINS_HEALCOMM = "Barre de soin entrant (incoming)"
L_GUI_UF_PLUGINS_AUTO_RESURRECTION = "Lance automatiquement le sort de résurrection de masse avec un clic central souris sur une cible morte (ne fonctionne pas avec l'addon Clique activé)"

-- Panel options
L_GUI_TOP_PANEL = "Panneau supérieur"
L_GUI_TOP_PANEL_SUBTEXT = "Manage built-in top panel with information." -- Need review
L_GUI_TOP_PANEL_ENABLE = "Activer le panneau supérieur"
L_GUI_TOP_PANEL_MOUSE = "Panneau supérieur en 'mouseover'"
L_GUI_TOP_PANEL_WIDTH = "Largeur du panneau"
L_GUI_TOP_PANEL_HEIGHT = "Hauteur du panneau"

-- Stats options
L_GUI_STATS = "Stats"
L_GUI_STATS_SUBTEXT = "Statistics blocks located at the bottom of the screen. Type in the chat '/ls' for info." -- Need review
L_GUI_STATS_BG = "Champ de bataille"
L_GUI_STATS_CLOCK = "Horloge"
L_GUI_STATS_LATENCY = "Latence"
L_GUI_STATS_MEMORY = "Mémoire"
L_GUI_STATS_FPS = "FPS"
L_GUI_STATS_EXPERIENCE = "Expérience"
L_GUI_STATS_TALENTS_DESC = "Date-text allows you to change the spec and loot on click" -- Need review
L_GUI_STATS_COORDS = "Coordonnées"
L_GUI_STATS_LOCATION = "Lieu actuel"
L_GUI_STATS_SUBHEADER_CURRENCY = "Currency (displayed in gold data text)" -- Need review
L_GUI_STATS_CURRENCY_ARCHAEOLOGY = "Afficher les fragments d'Archéologie dans l'onglet des devises"
L_GUI_STATS_CURRENCY_COOKING = "Afficher les marques de Cuisine dans l'onglet des devises"
L_GUI_STATS_CURRENCY_PROFESSIONS = "Afficher les marques de métiers dans l'onglet des devises"
L_GUI_STATS_CURRENCY_RAID = "Afficher les sceaux de raid dans l'onglet des devises"
L_GUI_STATS_CURRENCY_MISCELLANEOUS = "Afficher les jetons/monnaie divers dans l'onglet des devises"

-- Error options
L_GUI_ERROR = "Erreurs"
L_GUI_ERROR_SUBTEXT = "Filtering standard text at the top of the screen from Blizzard." -- Need review
L_GUI_ERROR_BLACK = "Cacher les erreurs de la liste noire"
L_GUI_ERROR_WHITE = "Afficher les erreurs de la liste blanche"
L_GUI_ERROR_HIDE_COMBAT = "Cacher toutes les erreurs en combat"