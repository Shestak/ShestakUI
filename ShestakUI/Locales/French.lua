local T, C, L, _ = unpack(select(2, ...))
if T.client ~= "frFR" then return end

----------------------------------------------------------------------------------------
--	Localization for frFR client
--	Translation: Cranan, Puree, AlbertDuval
----------------------------------------------------------------------------------------
-- Announce flasks and food
L_ANNOUNCE_FF_NOFOOD = "Sans nourriture : "
L_ANNOUNCE_FF_NOFLASK = "Sans flacon : "
L_ANNOUNCE_FF_ALLBUFFED = "Tout le monde possède sa nourriture et son flacon !"
L_ANNOUNCE_FF_CHECK_BUTTON = "Vérifier nourriture et flacon"

-- Says thanks for some spells
L_ANNOUNCE_SS_THANKS = "Merci pour "
L_ANNOUNCE_SS_RECEIVED = " reçu de "

-- Pull countdown announce
L_ANNOUNCE_PC_GO = "Départ !"
L_ANNOUNCE_PC_MSG = "Pull %s dans %s.."
L_ANNOUNCE_PC_ABORTED = "Pull ABANDONNE !"

-- Announce feasts and portals
L_ANNOUNCE_FP_STAT = "%s a préparé un %s - [%s]."
L_ANNOUNCE_FP_PRE = "%s a préparé un %s."
L_ANNOUNCE_FP_PUT = "%s a déposé au sol un %s."
L_ANNOUNCE_FP_CAST = "%s lance le sort %s."
L_ANNOUNCE_FP_CLICK = "%s invoque %s. Cliquez !"
L_ANNOUNCE_FP_USE = "%s a utilisé : %s."

-- Announce your interrupts
L_ANNOUNCE_INTERRUPTED = INTERRUPTED

-- Tooltip
L_TOOLTIP_NO_TALENT = "Aucun talent"
L_TOOLTIP_LOADING = "Chargement..."
L_TOOLTIP_ACH_STATUS = "Votre statut : "
L_TOOLTIP_ACH_COMPLETE = "Votre statut : Terminé"
L_TOOLTIP_ACH_INCOMPLETE = "Votre statut : Non terminé"
L_TOOLTIP_SPELL_ID = "ID du sort :"
L_TOOLTIP_ITEM_ID = "ID de l'objet :"
L_TOOLTIP_WHO_TARGET = "Est la cible de :"
L_TOOLTIP_ITEM_COUNT = "Objet(s) possédé(s) :"
L_TOOLTIP_INSPECT_OPEN = "La fenêtre d'inspection est ouverte"

-- Misc
L_MISC_UNDRESS = "Déshabillé"
L_MISC_DRINKING = " est entrain de boire."
L_MISC_BUY_STACK = "Alt-Clic pour acheter une pile d'objet"
L_MISC_ONECLICK_BUYOUT = "Maj-Clic-Droit pour acheter l'objet sélectionné sans confirmation"
L_MISC_ONECLICK_BID = "Maj-Clic-Droit pour enchérir sur l'objet sélectionné sans confirmation"
L_MISC_ONECLICK_CANCEL = "Maj-Clic-Droit pour annuler l'objet sélectionné sans confirmation"
L_MISC_UI_OUTDATED = "Une version plus récente de ShestakUI est disponible. Vous pouvez la télécharger sur www.shestak.org"
L_MISC_HEADER_MARK = "Icône de raid au survol de la souris"
L_MISC_BINDER_OPEN = "Assignations des boutons de la souris"
L_MISC_SCROLL = "Parchemin"

-- Raid Utility
L_RAID_UTIL_DISBAND = "Dissoudre le raid"

-- Zone name
L_ZONE_ARATHIBASIN = "Bassin d'Arathi"
L_ZONE_GILNEAS = "La bataille de Gilnéas"
L_ZONE_ANCIENTDALARAN = "Cratère de Dalaran"

-- WatchFrame Wowhead link
L_WATCH_WOWHEAD_LINK = "Lien Wowhead"

-- Toggle Menu
L_TOGGLE_ADDON = "Addon "
L_TOGGLE_ADDONS = " addons"
L_TOGGLE_EXPAND = "Permet d'ajouter des barres "
L_TOGGLE_COLLAPSE = "Permet de réduire les barres "
L_TOGGLE_RCLICK = "Faites un clic droit pour activer ou désactiver "
L_TOGGLE_LCLICK = "Clic gauche pour basculer la fenêtre "
L_TOGGLE_RELOAD = " (recharger votre UI)"
L_TOGGLE_NOT_FOUND = " non trouvé."

-- UnitFrame
L_UF_GHOST = "Fantôme"
L_UF_DEAD = "Mort"
L_UF_OFFLINE = "Hors ligne"
L_UF_MANA = "Mana faible"

-- Map
L_MAP_CURSOR = "Curseur : "
L_MAP_BOUNDS = "En dehors de la carte !"
L_MAP_FOG = "Zone non découverte"
L_MAP_COORDS = "Coordonnées"

-- Minimap
L_MINIMAP_CALENDAR = "Calendrier"
L_MINIMAP_HEAL_LAYOUT = "Clic-Gauche - Interface Heal"
L_MINIMAP_DPS_LAYOUT = "Clic-Droit - Interface DPS"
L_MINIMAP_BLIZZ_LAYOUT = "Clic-Centre - Interface Blizzard"

-- Chat
L_CHAT_WHISPER = "De"
L_CHAT_BN_WHISPER = "De"
L_CHAT_AFK = "[AFK]"
L_CHAT_DND = "[DND]"
L_CHAT_GM = "[GM]"
L_CHAT_GUILD = "G"
L_CHAT_PARTY = "P"
L_CHAT_PARTY_LEADER = "PL"
L_CHAT_RAID = "R"
L_CHAT_RAID_LEADER = "RL"
L_CHAT_RAID_WARNING = "AR"
L_CHAT_INSTANCE_CHAT = "I"
L_CHAT_INSTANCE_CHAT_LEADER = "IL"
L_CHAT_OFFICER = "O"
L_CHAT_PET_BATTLE = "BP"
L_CHAT_COME_ONLINE = "vient de se |cff298F00connecter|r."
L_CHAT_GONE_OFFLINE = "vient de se |cffff0000déconnecter|r."

-- Errors frame
L_ERRORFRAME_L = "Clic gauche pour afficher les erreurs."

-- Bags
L_BAG_SHOW_BAGS = "Montrer les sacs"
L_BAG_RIGHT_CLICK_SEARCH = "Clic droit pour rechercher"
L_BAG_STACK_MENU = "Empiler"
L_BAG_RIGHT_CLICK_CLOSE = "Clic droit pour ouvrir le menu"

-- Grab mail
L_MAIL_STOPPED = "Inventaire plein."
L_MAIL_UNIQUE = "Arrêt. Un objet unique a été trouvé dans le sac ou à la banque."
L_MAIL_COMPLETE = "Terminé."
L_MAIL_NEED = "Vous avez besoin d'une boîte aux lettres."
L_MAIL_MESSAGES = "messages"

-- Loot
L_LOOT_RANDOM = "Joueur aléatoire"
L_LOOT_SELF = "Procurez-vous un"
L_LOOT_FISH = "Pêche"
L_LOOT_ANNOUNCE = "Déclarer"
L_LOOT_TO_RAID = "  raid"
L_LOOT_TO_PARTY = "  groupe"
L_LOOT_TO_GUILD = "  corps"
L_LOOT_TO_SAY = "  dire"

-- LitePanels AFK module
L_PANELS_AFK = "Tu es AFK !"
L_PANELS_AFK_RCLICK = "Clic droit pour cacher."
L_PANELS_AFK_LCLICK = "Clic gauche pour revenir."

-- Cooldowns
L_COOLDOWNS = "Temps de recharge : "
L_COOLDOWNS_COMBATRESS = "Résurrection en combat"
L_COOLDOWNS_COMBATRESS_REMAINDER = "Résurrection en combat : "
L_COOLDOWNS_NEXTTIME = "Suivant : "

-- Autoinvite
L_INVITE_ENABLE = "Invitation automatique activée : "
L_INVITE_DISABLE = "Invitation automatique désactivée"

-- Bind key
L_BIND_SAVED = "Vos assignations de touches ont été sauvegardées."
L_BIND_DISCARD = "Vos nouvelles assignations de touches n'ont pas été sauvegardées."
L_BIND_INSTRUCT = "Passez votre souris sur la barre d'action pour l'assigner. Appuyez sur la touche échappe ou faites un clic droit pour effacer le bouton d'action en cours."
L_BIND_CLEARED = "Tous les raccourcis ont été réinitialisés pour"
L_BIND_BINDING = "Raccourcis"
L_BIND_KEY = "Touche"
L_BIND_NO_SET = "Pas encore de raccourcis"

-- Info text
L_INFO_ERRORS = "Pas d'erreur pour le moment."
L_INFO_INVITE = "Invitation acceptée par "
L_INFO_DUEL = "Duel rejetée par "
L_INFO_PET_DUEL = "Duel de familier décliné par "
L_INFO_DISBAND = "Groupe dissous..."
L_INFO_SETTINGS_DBM = "Taper /settings dbm, pour configurer DBM automatiquement."
L_INFO_SETTINGS_BIGWIGS = "Taper /settings bw, pour configurer BigWigs automatiquement."
L_INFO_SETTINGS_MSBT = "Taper /settings msbt, pour configurer msbt automatiquement."
L_INFO_SETTINGS_SKADA = "Taper /settings skada, pour configurer skada automatiquement."
L_INFO_SETTINGS_ALL = "Taper /settings all, pour tout configurer automatiquement."
L_INFO_NOT_INSTALLED = " n'est pas installé."
L_INFO_SKIN_DISABLED1 = "Personnalisation pour "
L_INFO_SKIN_DISABLED2 = " est désactivé."

-- Popups
L_POPUP_INSTALLUI = "Première utilisation de ShestakUI avec ce personnage. Vous devez recharger l'interface utilisateur pour le configurer."
L_POPUP_RESETUI = "Etes-vous sûr de vouloir réinitialiser ShestakUI ?"
L_POPUP_RESETSTATS = "Réinitialiser les statistiques pour le temps passé dans le jeu ?"
L_POPUP_SWITCH_RAID = "Sélectionner une interface raid."
L_POPUP_DISBAND_RAID = "Etes-vous sûr de vouloir dissoudre le groupe ?"
L_POPUP_DISABLEUI = "ShestakUI ne fonctionne pas avec cette résolution, voulez-vous désactiver ShestakUI ? (Annuler si vous souhaitez essayer une autre résolution)"
L_POPUP_SETTINGS_ALL = "Voulez-vous appliquer les modifications pour tout ? (DBM, BigWigs, Skada et MSBT)"
L_POPUP_SETTINGS_DBM = "La position des éléments de DBM doit être changée."
L_POPUP_SETTINGS_BW = "La position des éléments de BigWigs doit être changée."
L_POPUP_ARMORY = "Armurerie"

-- Welcome message
L_WELCOME_LINE_1 = "Bienvenue sur ShestakUI "
L_WELCOME_LINE_2_1 = "Tapez /cfg pour configurer l'interface, ou visitez http://shestak.org"
L_WELCOME_LINE_2_2 = "pour plus d'informations"

-- Combat text
L_COMBATTEXT_KILLING_BLOW = "Coup Fatal"
L_COMBATTEXT_ALREADY_UNLOCKED = "Fenêtre des textes de combat déjà déverrouillée."
L_COMBATTEXT_ALREADY_LOCKED = "Fenêtre des textes de combat déjà verrouillée."
L_COMBATTEXT_TEST_DISABLED = "Mode test de la fenêtre des textes de combat désactivé."
L_COMBATTEXT_TEST_ENABLED = "Mode test de la fenêtre des textes de combat activé."
L_COMBATTEXT_TEST_USE_UNLOCK = "Tapez /xct unlock pour bouger et redimensionner la fenêtre des textes de combat."
L_COMBATTEXT_TEST_USE_LOCK = "Tapez /xct lock pour verrouiller la fenêtre des textes de combat."
L_COMBATTEXT_TEST_USE_TEST = "Tapez /xct test pour activer le mode test de la fenêtre des textes de combat."
L_COMBATTEXT_TEST_USE_RESET = "Type /xct reset pour réstaurer les positions par défaut."
L_COMBATTEXT_POPUP = "Pour sauvegardez vos modifications vous devez recharger l'interface."
L_COMBATTEXT_UNSAVED = "Position de la fenêtre des textes de combat non saugardez, n'oubliez pas de recharger l'interface."
L_COMBATTEXT_UNLOCKED = "Fenêtre des textes de combat déverrouillée."

-- LiteStats
L_STATS_AUTO_REPAIR = "Réparation automatique"
L_STATS_GUILD_REPAIR = "Réparation automatique avec la banque de guilde"
L_STATS_AUTO_SELL = "Vente automatique d'objet"
L_STATS_BANDWIDTH = "Bande passante :"
L_STATS_DOWNLOAD = "Téléchargement :"
L_STATS_CURRENCY_RAID = "Sceaux de raid"
L_STATS_MEMORY_USAGE = "Usage mémoire pour l'interface Blizzard :"
L_STATS_TOTAL_MEMORY_USAGE = "Utilisation mémoire :"
L_STATS_TOTAL_CPU_USAGE = "Utilisation processeur :"
L_STATS_GARBAGE_COLLECTED = "Déchets ramassés"
L_STATS_HIDDEN = "Caché"
L_STATS_JUNK_ALREADY_ADDITIONS = "est déjà dans la liste des objets indésirables."
L_STATS_JUNK_ITEMLINK = "élément Lien"
L_STATS_JUNK_ADDITIONS = "Ajout à la liste des indésirables"
L_STATS_JUNK_LIST = "Liste de camelote"
L_STATS_JUNK_PROFIT = "Camelote profit"
L_STATS_JUNK_CLEARED = "Liste des indésirables effacée."
L_STATS_JUNK_CLEAR_ADDITIONS = "Effacer la liste des indésirables."
L_STATS_JUNK_ADDED = "Ajouté à la liste des objets indésirables"
L_STATS_JUNK_ADD_ITEM = "Ajouter/retirer des objets."
L_STATS_JUNK_REMOVED = "Retiré de la liste des objets indésirables"
L_STATS_JUNK_ITEMS_LIST = "Liste des objets à vendre."
L_STATS_KILLS = "Tuer"
L_STATS_XP_RATE = "Niveau/taux de votre XP"
L_STATS_HR = "Par heure"
L_STATS_INF = "infini"
L_STATS_ON = "ON"
L_STATS_PLAYED_LEVEL = "Temps joué à ce niveau"
L_STATS_PLAYED_SESSION = "Temps joué à cette session"
L_STATS_ACC_PLAYED = "Temps joué pour le compte"
L_STATS_PLAYED_TOTAL = "Temps joué total"
L_STATS_QUEST = "Quête"
L_STATS_QUESTS_TO = "Quêtes/Tuer à %s"
L_STATS_CURRENT_XP = "XP courant/max"
L_STATS_REMAINING_XP = "XP restant"
L_STATS_RESTED_XP = "XP reposé"
L_STATS_SERVER_GOLD = "Or possédé sur le serveur"
L_STATS_SESSION_GAIN = "Session Gain/Perte"
L_STATS_SESSION_XP = "XP session taux"
L_STATS_SORTING_BY = "Tri par"
L_STATS_SEALS = "Sceau cette semaine"
L_STATS_SPEC = "Spé"
L_STATS_TIPS = "Conseils :"
L_STATS_OPEN_CALENDAR = "Clic-Gauche ouvre le calendrier."
L_STATS_RC_TIME_MANAGER = "Clic-Droit pour ouvrir la fenêtre de gestion du temps."
L_STATS_TOGGLE_TIME = "Local/Royaume & mode 24 heures le temps peut être changé, dans la gestion des fenêtres de temps."
L_STATS_MEMORY = "Mémoire"
L_STATS_RC_COLLECTS_GARBAGE = "Cliquez-droit sur Lua recueille les déchets."
L_STATS_VIEW_NOTES = "Maintenez enfoncé la touche Alt pour voir les grades, notes et notes d'officiers."
L_STATS_CHANGE_SORTING = "[Guild] Clic-Droit pour inviter et chuchoter, Clic-Milieu pour changer le type de tri, Maj-Clic-Centre pour inverser l'ordre."
L_STATS_OPEN_CHARACTER = "Clic-Gauche ouvre l'onglet caractère."
L_STATS_RC_AUTO_REPAIRING1 = "Clic-Droit permet de basculer en mode réparation auto."
L_STATS_RC_AUTO_REPAIRING2 = "Bouton du milieu pour activer la réparation automatique de Guilde."
L_STATS_EQUIPMENT_CHANGER = "Maj-clic ou alt-clic sur le gestionnaire équipement."
L_STATS_RC_EXPERIENCE = "Clic-Droit pour faire défiler l'expérience, le temps joué, et la faction à suivre."
L_STATS_WATCH_FACTIONS = "Superviser les factions de l'onglet de Réputation."
L_STATS_TOOLTIP_EXPERIENCE = "Quand vous êtes en dessous du niveau maximum, une bulle d'aide affichera les détails concernant votre expérience."
L_STATS_TOOLTIP_TIME_PLAYED = "Quand vous êtes au niveau maximum, la bulle d'aide affichera les détails du temps de jeu pour ce compte."
L_STATS_OPEN_TALENT = "Clic-Gauche permet de modifier votre spécialisation."
L_STATS_RC_TALENT = "Clic-Droit pour modifier la spécialisation utilisée pour le butin."
L_STATS_LOCATION = "Position/Coords"
L_STATS_WORLD_MAP = "Clic ouvre la carte du monde."
L_STATS_INSERTS_COORDS = "Maj-clic sur l'emplacement ou coords insère le module de vos coords au chat"
L_STATS_OPEN_CURRENCY = "Clic-Gauche ouvre l'onglet monnaie."
L_STATS_RC_AUTO_SELLING = "Clic-Droit permet de basculer en mode vente automatique."
L_STATS_NEED_TO_SELL = "Utiliser /junk pour définir quels objets doivent être vendu."
L_STATS_WATCH_CURRENCY = "Consulté onglet monnaie articles se reflétera dans l'info bulle."
L_STATS_OTHER_OPTIONS = "Les autres options peuvent être configurées dans %s"

-- Slash commands
L_SLASHCMD_HELP = {
	"Les commandes en ligne disponibles:",
	"/rl - Recharge l'interface.",
	"/rc - Lance un appel raid (ready check).",
	"/gm - Ouvre un ticket MJ.",
	"/dis ADDON_NAME - Désactive nom_addon.",
	"/en ADDON_NAME - Active nom_addon.",
	"/rd - Dissout le groupe ou raid.",
	"/toraid - Active le mode raid.",
	"/teleport - Téléportation dans le donjon aléatoire en cours.",
	"/spec, /ss - Bascule d'une spécialisation talent à l'autre.",
	"/heal - Bascule vers l'interface 'Heal'.",
	"/dps - Bascule sur l'interface 'DPS'.",
	"/frame - Description is not ready.",
	"/farmmode - Agrandi la taille de la minimap.",
	"/moveui - Permet de déplacer des éléments de l'interface.", -- Need review
	"/resetui - Remet les paramètres généraux à leurs valeurs par défaut.",
	"/resetuf - Remet les cadres d'unité à leur position par défaut.",
	"/resetconfig - Remet les paramètres ShestakUI_Config à leurs valeurs par défaut.",
	"/resetstats - Remet à zéro les statitisques or et temps passé en jeu.",
	"/settings ADDON_NAME - Applique les paramètres pour msbt, dbm, skada, ou à tous les addons.",
	"/ls, /litestats - Menu d'aide pour LiteStats.",
	"/xct - Menu d'aide pour le texte de combat.",
	"/raidcd - Lance un test du temps de recharge Raid.",
	"/enemycd - Lance un test du temps de recharge Ennemi.",
	"/pulsecd - Lance un test local de Cooldown pulse.",
	"/threat - Lance un test des barres de menace.",
	"/tt - Chuchote à la cible.",
	"/ainv - Active l'invitation automatique.",
	"/testuf - Lance un test des cadres d'unité.",
	"/cfg - Ouvre les paramètres de l'interface.",
}
