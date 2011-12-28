local T, C, L = unpack(select(2, ...))
if T.client ~= "ptBR" then return end

----------------------------------------------------------------------------------------
--	Localization for ptBR client(Need full translation)
----------------------------------------------------------------------------------------
-- Tooltip
L_TOOLTIP_NO_TALENT = "No Talents"
L_TOOLTIP_LOADING = "Loading..."
L_TOOLTIP_ACH_STATUS = "Your Status:"
L_TOOLTIP_ACH_COMPLETE = "Your Status: Completed on "
L_TOOLTIP_ACH_INCOMPLETE = "Your Status: Incomplete"
L_TOOLTIP_SPELL_ID = "Spell ID:"
L_TOOLTIP_ITEM_ID = "Item ID:"
L_TOOLTIP_WHO_TARGET = "Targeted By"
L_TOOLTIP_ITEM_COUNT = "Item count:"

-- Misc
L_MISC_UNDRESS = "Undress"
L_MISC_DRINKING = " is drinking."
L_MISC_BUY_STACK = "Alt-Click to buy a stack"
L_MISC_ONECLICK_BUYOUT = "Shift-Click to buyout the selected item without confirmation"
L_MISC_ONECLICK_BID = "Shift-Click to bid on the selected item without confirmation"

-- Raid Utility
L_RAID_UTIL_DISBAND = "Disband Group"

-- Zone name
L_ZONE_WINTERGRASP = "Wintergrasp"

-- WatchFrame Wowhead link
L_WATCH_WOWHEAD_LINK = "Wowhead link"

-- Toogle Menu
L_TOGGLE_ADDON = "Addon "
L_TOGGLE_ADDONS = " addons"
L_TOGGLE_EXPAND = "Expand "
L_TOGGLE_COLLAPSE = "Collapse "
L_TOGGLE_RCLICK = "Right click to enable or disable "
L_TOGGLE_LCLICK = "Left click to toggle window "
L_TOGGLE_RELOAD = " (needs UI reload)"

-- UnitFrame
L_UF_GHOST = "Ghost"
L_UF_DEAD = "Dead"
L_UF_OFFLINE = "Offline"
L_UF_MANA = "Low mana"
L_UF_TRINKET_READY = "Trinket ready: "
L_UF_TRINKET_USED = "Trinket used: "
L_UF_WOTF_USED = "WotF used: "

-- Map
L_MAP_CURSOR = "Cursor: "
L_MAP_BOUNDS = "Out of bounds!"

-- Minimap
L_MINIMAP_CALENDAR = "Calendar"

-- Addons list
L_ALOAD_RL = "Reload UI"
L_ALOAD_TRADE = "Trade"
L_ALOAD_SOLO = "Solo"
L_ALOAD_DEP = "Dependencies: "

-- Chat
L_CHAT_WHISPER = "From"
L_CHAT_BN_WHISPER = "From"
L_CHAT_AFK = "[AFK]"
L_CHAT_DND = "[DND]"
L_CHAT_GM = "[GM]"
L_CHAT_GUILD = "G"
L_CHAT_PARTY = "P"
L_CHAT_PARTY_LEADER = "PL"
L_CHAT_RAID = "R"
L_CHAT_RAID_LEADER = "RL"
L_CHAT_RAID_WARNING = "RW"
L_CHAT_BATTLEGROUND = "BG"
L_CHAT_BATTLEGROUND_LEADER = "BGL"
L_CHAT_OFFICER = "O"
L_CHAT_COME_ONLINE = "has come online."
L_CHAT_GONE_OFFLINE = "has gone offline."
L_CHAT_COME_ONLINE_COLOR = "is now |cff298F00online|r !"
L_CHAT_GONE_OFFLINE_COLOR = "is now |cffff0000offline|r !"

-- Errors frame
L_ERRORFRAME_L = "Click to view errors."

-- Bags
L_BAG_BANK = "Bank"
L_BAG_NO_SLOTS = "Can't buy anymore slots!"
L_BAG_COSTS = "Cost: %.2f gold"
L_BAG_BUY_SLOTS = "Buy new slot with /bags purchase yes"
L_BAG_OPEN_BANK = "You need to open your bank first."
L_BAG_SORT = "Sort your bags or your bank, if open."
L_BAG_STACK = "Fill up partial stacks in your bags or bank, if open."
L_BAG_BUY_BANKS_SLOT = "Buy bank slot (need to have bank open)."
L_BAG_SORT_MENU = "Sort"
L_BAG_SORT_SPECIAL = "Sort Special"
L_BAG_STACK_MENU = "Stack"
L_BAG_STACK_SPECIAL = "Stack Special"
L_BAG_SHOW_BAGS = "Show Bags"
L_BAG_SORTING_BAGS = "Sorting finished."
L_BAG_NOTHING_SORT = "Nothing to sort."
L_BAG_BAGS_BIDS = "Using bags: "
L_BAG_STACK_END = "Restacking finished."
L_BAG_RIGHT_CLICK_SEARCH = "Right-click to search"

-- Grab mail
L_MAIL_STOPPED = "Stopped, inventory is full."
L_MAIL_UNIQUE = "Stopped. Found a duplicate unique item in bag or in bank."
L_MAIL_COMPLETE = "All done."
L_MAIL_NEED = "Need a mailbox."
L_MAIL_MESSAGES = "messages"

-- Loot
L_LOOT_RANDOM = "Random Player"
L_LOOT_SELF = "Self Loot"
L_LOOT_UNKNOWN = "Unknown"
L_LOOT_FISH = "Fishing loot"
L_LOOT_MONSTER = ">> Loot from "
L_LOOT_CHEST = ">> Loot from chest"
L_LOOT_ANNOUNCE = "Announce to"
L_LOOT_TO_RAID = "  raid"
L_LOOT_TO_PARTY = "  party"
L_LOOT_TO_GUILD = "  guild"
L_LOOT_TO_SAY = "  say"
L_LOOT_CANNOT = "Cannot roll"

-- LitePanels AFK module
L_PANELS_AFK = "You are AFK!"
L_PANELS_AFK_RCLICK = "Right-Click to hide."
L_PANELS_AFK_LCLICK = "Left-Click to go back."

-- Cooldowns
L_COOLDOWNS = "CD: "

-- Autoinvite
L_INVITE_ENABLE = "Autoinvite ON: "
L_INVITE_DISABLE = "Autoinvite OFF"

-- Bind key
L_BIND_SAVED = "All keybindings have been saved."
L_BIND_DISCARD = "All newly set keybindings have been discarded."
L_BIND_INSTRUCT = "Hover your mouse over any actionbutton to bind it. Press the escape key or right click to clear the current actionbutton's keybinding."
L_BIND_CLEARED = "All keybindings cleared for"
L_BIND_BINDING = "Binding"
L_BIND_KEY = "Key"
L_BIND_NO_SET = "No bindings set"

-- Talent spec
L_PLANNER_DEATHKNIGHT_1 = "Blood"
L_PLANNER_DEATHKNIGHT_2 = "Frost"
L_PLANNER_DEATHKNIGHT_3 = "Unholy"
L_PLANNER_WARRIOR_1 = "Arms"
L_PLANNER_WARRIOR_2 = "Fury"
L_PLANNER_WARRIOR_3 = "Protection"
L_PLANNER_ROGUE_1 = "Assassination"
L_PLANNER_ROGUE_2 = "Combat"
L_PLANNER_ROGUE_3 = "Subtlety"
L_PLANNER_MAGE_1 = "Arcane"
L_PLANNER_MAGE_2 = "Fire"
L_PLANNER_MAGE_3 = "Frost"
L_PLANNER_PRIEST_1 = "Discipline"
L_PLANNER_PRIEST_2 = "Holy"
L_PLANNER_PRIEST_3 = "Shadow"
L_PLANNER_WARLOCK_1 = "Affliction"
L_PLANNER_WARLOCK_2 = "Demonology"
L_PLANNER_WARLOCK_3 = "Destruction"
L_PLANNER_HUNTER_1 = "Beast Mastery"
L_PLANNER_HUNTER_2 = "Marksmanship"
L_PLANNER_HUNTER_3 = "Survival"
L_PLANNER_DRUID_1 = "Balance"
L_PLANNER_DRUID_2 = "Feral Combat"
L_PLANNER_DRUID_3 = "Restoration"
L_PLANNER_SHAMAN_1 = "Elemental"
L_PLANNER_SHAMAN_2 = "Enhancement"
L_PLANNER_SHAMAN_3 = "Restoration"
L_PLANNER_PALADIN_1 = "Holy"
L_PLANNER_PALADIN_2 = "Protection"
L_PLANNER_PALADIN_3 = "Retribution"

-- BG stats
L_DATATEXT_BASESASSAULTED = "Bases Assaulted:"
L_DATATEXT_BASESDEFENDED = "Bases Defended:"
L_DATATEXT_TOWERSASSAULTED = "Towers Assaulted:"
L_DATATEXT_TOWERSDEFENDED = "Towers Defended:"
L_DATATEXT_FLAGSCAPTURED = "Flags Captured:"
L_DATATEXT_FLAGSRETURNED = "Flags Returned:"
L_DATATEXT_GRAVEYARDSASSAULTED = "Graveyards Assaulted:"
L_DATATEXT_GRAVEYARDSDEFENDED = "Graveyards Defended:"
L_DATATEXT_DEMOLISHERSDESTROYED = "Demolishers Destroyed:"
L_DATATEXT_GATESDESTROYED = "Gates Destroyed:"
L_DATATEXT_CONTROL = " under control:"

-- Info text
L_INFO_ERRORS = "No error yet."
L_INFO_INVITE = "Accepted invite from: "
L_INFO_DUEL = "Declined duel request from: "
L_INFO_DISBAND = "Disbanding group..."
L_INFO_ADDON_SETS1 = "Type /addons <solo/party/raid/pvp/trade/quest>, to load the preinstalled set of modifications."
L_INFO_ADDON_SETS2 = "You can add, delete or change lists of modifications, modifying wtf.lua in *modules* folder."
L_INFO_SETTINGS_DBM = "Type /settings dbm, to apply the settings DBM."
L_INFO_SETTINGS_DXE = "Type /settings dxe, to apply the settings DXE."
L_INFO_SETTINGS_MSBT = "Type /settings msbt, to apply the settings MSBT."
L_INFO_SETTINGS_SKADA = "Type /settings skada, to apply the settings Skada."
L_INFO_SETTINGS_ALL = "Type /settings all, to apply the settings for all modifications."
L_INFO_NOT_INSTALLED = " is not installed."
L_INFO_SKIN_DISABLED1 = "Stylization for "
L_INFO_SKIN_DISABLED2 = " is disabled."

-- Popups
L_POPUP_INSTALLUI = "First time on ShestakUI with this Character. You must reload UI to configure it."
L_POPUP_RESETUI = "Are you sure you want to reset all settings for ShestakUI?"
L_POPUP_RESETSTATS = "Are you sure you want to reset statistics for time spent in game and gold."
L_POPUP_SWITCH_RAID = "2 raid layouts are active, please select a layout."
L_POPUP_DISBAND_RAID = "Are you sure you want to disband the group?"
L_POPUP_DISABLEUI = "ShestakUI doesn't work for this resolution, do you want to disable ShestakUI? (Cancel if you want to try another resolution)"
L_POPUP_SETTINGS_ALL = "Apply settings for all modifications? (DBM/DXE, Skada and MSBT)"
L_POPUP_SETTINGS_DBM = "Need to change the position of elements DBM."
L_POPUP_SETTINGS_DXE = "Need to change the position of elements DXE."
L_POPUP_SETTINGS_BW = "Need to change the position of elements BigWigs."

-- Welcome message
L_WELCOME_LINE_1 = "Welcome to ShestakUI "
L_WELCOME_LINE_2_1 = "Type /cfg to config interface, or visit http://shestak.org"
L_WELCOME_LINE_2_2 = "for more informations."

-- Combat text
L_COMBATTEXT_KILLING_BLOW = "Killing Blow"
L_COMBATTEXT_ALREADY_UNLOCKED = "Combat text already unlocked."
L_COMBATTEXT_ALREADY_LOCKED = "Combat text already locked."
L_COMBATTEXT_TEST_DISABLED = "Combat text test mode disabled."
L_COMBATTEXT_TEST_ENABLED = "Combat text test mode enabled."
L_COMBATTEXT_TEST_USE_UNLOCK = "Type /xct unlock to move and resize combat text frames."
L_COMBATTEXT_TEST_USE_LOCK = "Type /xct lock to lock combat text frames."
L_COMBATTEXT_TEST_USE_TEST = "Type /xct test to toggle combat text testmode."
L_COMBATTEXT_POPUP = "To save combat text window positions you need to reload your UI."
L_COMBATTEXT_UNSAVED = "Combat text window positions unsaved, don't forget to reload UI."
L_COMBATTEXT_UNLOCKED = "Combat text unlocked."

-- LiteStats
L_STATS_ACC_PLAYED = "Account Played"
L_STATS_ADDED_JUNK = "Added junk exception"
L_STATS_REMOVE_EXCEPTION = "Add/remove exception."
L_STATS_ALT = "ALT"
L_STATS_AUTO_REPAIR = "AutoRepair"
L_STATS_GUILD_REPAIR = "Repair from guild bank"
L_STATS_AUTO_SELL = "AutoSell junk"
L_STATS_BANDWIDTH = "Bandwidth:"
L_STATS_DOWNLOAD = "Download:"
L_STATS_CLEARED_JUNK = "Cleared junk exceptions list."
L_STATS_CLEAR_EXCEPTIONS = "Clear exceptions list."
L_STATS_WORLD_MAP = "Clicking opens world map."
L_STATS_CURRENT_XP = "Current/Max XP"
L_STATS_MEMORY_USAGE = "Default UI Memory Usage:"
L_STATS_GARBAGE_COLLECTED = "Garbage collected"
L_STATS_CHANGE_SORTING = "(Guild) Right-Click to change the sorting, shift-right-click to reverse order."
L_STATS_HIDDEN = "Hidden"
L_STATS_VIEW_NOTES = "Hold alt key to view ranks, notes and officer notes."
L_STATS_HR = "hr"
L_STATS_INF = "inf"
L_STATS_ALREADY_EXCEPTIONS = "is already in exceptions list."
L_STATS_NOT_JUNK = "is not junk."
L_STATS_ITEMLINK = "itemlink"
L_STATS_JUNK_EXCEPTIONS = "Junk exceptions"
L_STATS_JUNK_LIST = "Junk List"
L_STATS_JUNK_PROFIT = "Junk profit"
L_STATS_KILLS = "K"
L_STATS_OPEN_CALENDAR = "Left-Click opens calendar (/cal)."
L_STATS_OPEN_CHARACTER = "Left-Click opens character tab."
L_STATS_OPEN_CURRENCY = "Left-Click opens currency tab."
L_STATS_OPEN_TALENT = "Left-Click opens the talent UI frame."
L_STATS_XP_RATE = "Level XP rate"
L_STATS_IGNORED_ITEMS = "List currently ignored items."
L_STATS_TOGGLE_TIME = "Local/realm & 24hr time can be toggled from the time manager."
L_STATS_LOCATION = "Location/Coords"
L_STATS_MEMORY = "Memory"
L_STATS_ON = "ON"
L_STATS_OTHER_OPTIONS = "Other options may be configured in %s"
L_STATS_PLAYED_LEVEL = "Played this level"
L_STATS_PLAYED_SESSION = "Played this session"
L_STATS_PLAYED_TOTAL = "Played total"
L_STATS_QUEST = "Q"
L_STATS_QUESTS_TO = "Quests/Kills to %s"
L_STATS_REMAINING_XP = "Remaining XP"
L_STATS_REMOVED_JUNK = "Removed junk exception"
L_STATS_RESTED_XP = "Rested XP"
L_STATS_RC_COLLECTS_GARBAGE = "Right-Click collects Lua garbage."
L_STATS_RC_TIME_MANAGER = "Right-Click opens time manager frame."
L_STATS_RC_EXPERIENCE = "Right-Click to cycle through experience, time played, and faction watcher."
L_STATS_RC_AUTO_REPAIRING = "Right-Click toggles AutoRepairing."
L_STATS_RC_AUTO_SELLING = "Right-Click toggles AutoSelling."
L_STATS_RC_TALENT = "Right-Click toggles your talent specialization."
L_STATS_SERVER_GOLD = "Server Gold"
L_STATS_SESSION_GAIN = "Session Gain/Loss"
L_STATS_SESSION_XP = "Session XP rate"
L_STATS_INSERTS_COORDS = "Shift-Clicking location or coords module inserts your coords into chat."
L_STATS_EQUIPMENT_CHANGER = "Shift-Click or Middle-Click for equipment set changer."
L_STATS_SORTING_BY = "Sorting by"
L_STATS_TIPS = "tips:"
L_STATS_TOTAL = "Total"
L_STATS_TOTAL_MEMORY_USAGE = "Total Memory Usage:"
L_STATS_NOT_TO_SELL = "Use /junk to configure which items not to sell."
L_STATS_WATCH_CURRENCY = "Watched currency tab items will reflect onto the tooltip."
L_STATS_WATCH_FACTIONS = "Watch factions from the character faction UI."
L_STATS_TOOLTIP_TIME_PLAYED = "When at max level, the tooltip will show time played details for the account."
L_STATS_TOOLTIP_EXPERIENCE = "When below max level, a tooltip will be displayed with experience details."

-- Slash commands
L_SLASHCMD_HELP = {
	"Available slash commands:",
	"/rl - Reload interface.",
	"/rc - Activates a ready check.",
	"/gm - Opens GM frame.",
	"/dis ADDON_NAME - Disable Addon.",
	"/en ADDON_NAME - Enable Addon.",
	"/rd - Disband party or raid.",
	"/toraid - Convert to party or raid.",
	"/teleport - Teleportation from random dungeon.",
	"/luaerror ON|OFF - Toggles display of lua errors.",
	"/spec, /ss - Switches between talent spec's.",
	"/clfix - Fixes the combat log.",
	"/heal - Switches to 'Heal' layout.",
	"/dps - Switches to 'DPS' layout.",
	"/frame - Description is not ready.",
	"/addons solo|party|raid|pvp|trade - You can change addons list in ending of file ShestakUI\Config\Settings.lua, block - 'Addons group'.",
	"/farmmode - Increase the size of the minimap.",
	"/moveui - Allows the movement of interface elements.",
	"/resetui - Resets general settings to default.",
	"/resetuf - Resets the unit frames to their default position.",
	"/resetconfig - Resets ShestakUI_Config settings.",
	"/resetstats - Resets the statistics of gold and time spent.",
	"/settings ADDON_NAME - Applies settings to msbt, dbm, skada, or all addons.",
	"/ls, /litestats - Help for LiteStats.",
	"/bags - Managing for bags.",
	"/xct - Manage the combat text.",
	"/raidcd - Raid cooldown test.",
	"/enemycd - Enemy cooldown test.",
	"/pulsecd - Self cooldown pulse test.",
	"/threat - Threat meter test.",
	"/tt - Whisper target.",
	"/ainv - Enables automatic invitation.",
	"/testuf - Unit frame test.",
	"/cfg - Opens interface settings.",
}