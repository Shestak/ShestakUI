local T, C, L = unpack(select(2, ...))
if T.client ~= "koKR" then return end

----------------------------------------------------------------------------------------
--	Localization for koKR client(Need full translation)
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
L_ZONE_WINTERGRASP = "겨울손아귀 호수"
L_ZONE_TOLBARAD = "톨 바라드"
L_ZONE_TOLBARADPEN = "톨 바라드 반도"
L_ZONE_ARATHIBASIN = "아라시 분지"
L_ZONE_GILNEAS = "길니아스 전투지"

-- WatchFrame Wowhead link
L_WATCH_WOWHEAD_LINK = "Wowhead link"

-- Toggle Menu
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
L_ALOAD_DEP = "Dependencies: "
L_ALOAD_OP_DEP = "Optional Dependencies: "
L_ALOAD_PROFILES = "Profiles"
L_ALOAD_ENABLE_ALL = "Enable All"
L_ALOAD_DISABLE_ALL = "Disable All"
L_ALOAD_PROFILE_NAME = "Profile Name"
L_ALOAD_SET_TO = "Set To.."
L_ALOAD_ADD_TO = "Add To.."
L_ALOAD_REMOVE_FROM = "Remove From.."
L_ALOAD_DELETE_PROFILE = "Delete Profile.."
L_ALOAD_CONFIRM_DELETE = "Are you sure you want to delete this profile? Hold down shift and click again if you are."

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
L_CHAT_PET_BATTLE = "PB"
L_CHAT_COME_ONLINE = "has come online."
L_CHAT_GONE_OFFLINE = "has gone offline."
L_CHAT_COME_ONLINE_COLOR = "is now |cff298F00online|r !"
L_CHAT_GONE_OFFLINE_COLOR = "is now |cffff0000offline|r !"

-- Errors frame
L_ERRORFRAME_L = "Click to view errors."

-- Bags
L_BAG_BANK = "Bank"
L_BAG_NO_SLOTS = "소지품이 가득 찼습니다."
L_BAG_COSTS = "가격: %.2f 골"
L_BAG_BUY_SLOTS = "가방 보관함을 추가로 구입하시기 위해서는 /bags를 입력해주세요."
L_BAG_OPEN_BANK = "먼저 은행을 열어야 합니다."
L_BAG_SORT = "열려있는 가방이나 은행에 있는 아이템을 정리합니다."
L_BAG_STACK = "띄엄띄엄 있는 아이템을 정리합니다."
L_BAG_BUY_BANKS_SLOT = "가방 보관함을 추가로 구입합니다."
L_BAG_SORT_MENU = "분류"
L_BAG_SORT_SPECIAL = "특수물품 분류"
L_BAG_STACK_MENU = "정리"
L_BAG_STACK_SPECIAL = "특수물품 정리"
L_BAG_SHOW_BAGS = "가방 보기"
L_BAG_SORTING_BAGS = "분류 완료."
L_BAG_NOTHING_SORT = "분류할 것이 없습니다."
L_BAG_BAGS_BIDS = "사용 중인 가방: "
L_BAG_STACK_END = "재정리 완료."
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
L_INVITE_ENABLE = "자동초대 활성화: "
L_INVITE_DISABLE = "자동초대 비활성화"

-- Bind key
L_BIND_SAVED = "All keybindings have been saved."
L_BIND_DISCARD = "All newly set keybindings have been discarded."
L_BIND_INSTRUCT = "Hover your mouse over any actionbutton to bind it. Press the escape key or right click to clear the current actionbutton's keybinding."
L_BIND_CLEARED = "All keybindings cleared for"
L_BIND_BINDING = "Binding"
L_BIND_KEY = "Key"
L_BIND_NO_SET = "No bindings set"

-- Talent spec
L_PLANNER_DEATHKNIGHT_1 = "혈기"
L_PLANNER_DEATHKNIGHT_2 = "냉기"
L_PLANNER_DEATHKNIGHT_3 = "부정"
L_PLANNER_WARRIOR_1 = "무기"
L_PLANNER_WARRIOR_2 = "분노"
L_PLANNER_WARRIOR_3 = "방어"
L_PLANNER_ROGUE_1 = "암살"
L_PLANNER_ROGUE_2 = "전투"
L_PLANNER_ROGUE_3 = "잠행"
L_PLANNER_MAGE_1 = "비전"
L_PLANNER_MAGE_2 = "화염"
L_PLANNER_MAGE_3 = "냉기"
L_PLANNER_MONK_1 = "Brewmaster"	--need review
L_PLANNER_MONK_2 = "Mistweaver"	--need review
L_PLANNER_MONK_3 = "Windwalker"	--need review
L_PLANNER_PRIEST_1 = "수양"
L_PLANNER_PRIEST_2 = "신성"
L_PLANNER_PRIEST_3 = "암흑"
L_PLANNER_WARLOCK_1 = "고통"
L_PLANNER_WARLOCK_2 = "악마"
L_PLANNER_WARLOCK_3 = "파괴"
L_PLANNER_HUNTER_1 = "야수"
L_PLANNER_HUNTER_2 = "사격"
L_PLANNER_HUNTER_3 = "생존"
L_PLANNER_DRUID_1 = "조화"
L_PLANNER_DRUID_2 = "야성"
L_PLANNER_DRUID_3 = "Guardian"	--need review
L_PLANNER_DRUID_4 = "회복"
L_PLANNER_SHAMAN_1 = "정기"
L_PLANNER_SHAMAN_2 = "고양"
L_PLANNER_SHAMAN_3 = "복원"
L_PLANNER_PALADIN_1 = "신성"
L_PLANNER_PALADIN_2 = "보호"
L_PLANNER_PALADIN_3 = "징벌"

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
L_POPUP_ARMORY = "무기고"

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
L_STATS_ACC_PLAYED = "플레이한 시간의 산출 "
L_STATS_ADDED_JUNK = "잡동사니 제외 목록에 추가"
L_STATS_REMOVE_EXCEPTION = "잡동사니를 제외 목록에 추가/제거합니다."
L_STATS_ALT = "ALT"
L_STATS_AUTO_REPAIR = "자동수리"
L_STATS_GUILD_REPAIR = "Repair from guild bank"
L_STATS_AUTO_SELL = "잡동사니 자동 판매"
L_STATS_BANDWIDTH = "Bandwidth:"
L_STATS_DOWNLOAD = "Download:"
L_STATS_CLEARED_JUNK = "잡동사니 제외 목록을 삭제합니다."
L_STATS_CLEAR_EXCEPTIONS = "제외 목록 삭제"
L_STATS_WORLD_MAP = "세계지도를 열려면 클릭하십시오."
L_STATS_CURRENT_XP = "현재/최대 XP"
L_STATS_MEMORY_USAGE = "기본 UI 메모리 사용량:"
L_STATS_GARBAGE_COLLECTED = "메모리 찌꺼기 모음"
L_STATS_CHANGE_SORTING = "(길드)정돈 방식을 변경하려면 우-클릭, 순서를 뒤바꾸려면 shift-우-클릭하십시오."
L_STATS_HIDDEN = "숨김"
L_STATS_VIEW_NOTES = "레벨, 주의 사항, 관리자 주의 사항을 보려면 alt 키를 누르십시오."
L_STATS_HR = "시"
L_STATS_INF = "무한"
L_STATS_ALREADY_EXCEPTIONS = "|1은;는; 이미 제외 목록에 있습니다."
L_STATS_NOT_JUNK = "|1은;는; 잡동사니가 아닙니다."
L_STATS_ITEMLINK = "아이템 링크"
L_STATS_JUNK_EXCEPTIONS = "잡동사니 제외"
L_STATS_JUNK_LIST = "잡동사니 목록"
L_STATS_JUNK_PROFIT = "잡동사니 수익"
L_STATS_KILLS = "죽"
L_STATS_OPEN_CALENDAR = "좌-클릭으로 달력을 엽니다(/cal)."
L_STATS_OPEN_CHARACTER = "좌-클릭으로 캐릭터 탭을 엽니다."
L_STATS_OPEN_CURRENCY = "좌-클릭으로 화폐 탭을 엽니다."
L_STATS_OPEN_TALENT = "좌-클릭으로 특성 UI 틀을 엽니다."
L_STATS_XP_RATE = "레벨 XP율"
L_STATS_IGNORED_ITEMS = "현재무시된 아이템을 목록화합니다. "
L_STATS_TOGGLE_TIME = "시간 관리 틀에서 지역/서버 & 24시간제를 전환시킬 수 있습니다. "
L_STATS_LOCATION = "위치/좌표"
L_STATS_MEMORY = "메모리"
L_STATS_ON = "켜기"
L_STATS_OTHER_OPTIONS = "다른 옵션은 %s에서 설정할 수 있습니다."
L_STATS_PLAYED_LEVEL = "이 레벨에서의 플레이 시간"
L_STATS_PLAYED_SESSION = "이 접속의 플레이 시간"
L_STATS_PLAYED_TOTAL = "총 플레이 시간"
L_STATS_QUEST = "퀘"
L_STATS_QUESTS_TO = "퀘스트/죽임을 %s|1으로;로;"
L_STATS_REMAINING_XP = "남은 XP"
L_STATS_REMOVED_JUNK = "잡동사니 제외 목록 제거"
L_STATS_RESTED_XP = "휴식 XP"
L_STATS_RC_COLLECTS_GARBAGE = "우-클릭으로 Lua 메모리 찌꺼기를 모읍니다."
L_STATS_RC_TIME_MANAGER = "우-클릭으로 시간 관리 틀을 엽니다."
L_STATS_RC_EXPERIENCE = "경험치, 플레이한 시간, 진영 감시를 순환하려면 우-클릭하십시오."
L_STATS_RC_AUTO_REPAIRING = "우-클릭으로 자동 수리 기능을 전환합니다."
L_STATS_RC_AUTO_SELLING = "우-클릭으로 자동 판매 기능을 전환합니다."
L_STATS_RC_TALENT = "우-클릭으로 당신의 특성 전문화를 전환합니다."
L_STATS_SERVER_GOLD = "서버 소지금"
L_STATS_SESSION_GAIN = "접속 득/실"
L_STATS_SESSION_XP = "접속 XP율"
L_STATS_INSERTS_COORDS = "위치 혹은 좌표 모듈의 Shift-클릭으로 현재 좌표를 대화창에 삽입합니다. "
L_STATS_EQUIPMENT_CHANGER = "장비 세트 교체를 위해서는 Shift-클릭 혹은 가운데-클릭하십시오. "
L_STATS_SORTING_BY = "다음에 의해 정돈"
L_STATS_TIPS = "팁:"
L_STATS_TOTAL = "합계"
L_STATS_TOTAL_MEMORY_USAGE = "총 메모리 사용량:"
L_STATS_NOT_TO_SELL = "어떠한 아이템을 판매하지 않을지 설정하려면 /junk를 사용하십시오."
L_STATS_WATCH_CURRENCY = "감시한 화폐 탭 아이템은 툴팁에 반영될 것입니다."
L_STATS_WATCH_FACTIONS = "캐릭터 진영 UI에서 진영을 감시합니다. "
L_STATS_TOOLTIP_TIME_PLAYED = "최대 레벨인 경우에 툴팁은 산출을 위한 상세한 플레이 시간을 보여줄 것입니다."
L_STATS_TOOLTIP_EXPERIENCE = "최대 레벨 밑인 경우에 툴립은 경험치를 상세하게 표시할 것입니다."

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