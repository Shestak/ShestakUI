local T, C, L = unpack(select(2, ...))
if T.client ~= "zhTW" then return end

----------------------------------------------------------------------------------------
--	Localization for zhTW client(Thanks to Ianchan, Aelb, nanjiqq, Spacedragon, Mania and tat2dawn for the translation)
----------------------------------------------------------------------------------------
-- Tooltip
L_TOOLTIP_NO_TALENT = "沒有天賦"
L_TOOLTIP_LOADING = "讀取中..."
L_TOOLTIP_ACH_STATUS = "你的狀態:"
L_TOOLTIP_ACH_COMPLETE = "你的狀態: 完成 "
L_TOOLTIP_ACH_INCOMPLETE = "你的狀態: 未完成"
L_TOOLTIP_SPELL_ID = "法術ID:"
L_TOOLTIP_ITEM_ID = "物品ID:"
L_TOOLTIP_WHO_TARGET = "以其為目標的"
L_TOOLTIP_ITEM_COUNT = "物品數量:"

-- Misc
L_MISC_UNDRESS = "無裝備"
L_MISC_DRINKING = " 吃喝中"
L_MISC_BUY_STACK = "Alt-右鍵點擊購買一疊"
L_MISC_ONECLICK_BUYOUT = "Shift-左鍵,不彈出確認窗口直接購買"
L_MISC_ONECLICK_BID = "Shift-左鍵,不彈出確認窗口直接競標"

-- Raid Utility
L_RAID_UTIL_DISBAND = "解散團隊"

-- Zone name
L_ZONE_WINTERGRASP = "冬握湖"
L_ZONE_TOLBARAD = "托巴拉德"
L_ZONE_TOLBARADPEN = "托巴拉德半島"
L_ZONE_ARATHIBASIN = "阿拉希盆地"
L_ZONE_GILNEAS = "吉爾尼斯之戰"

-- WatchFrame Wowhead link
L_WATCH_WOWHEAD_LINK = "Wowhead鏈接"

-- Toggle Menu
L_TOGGLE_ADDON = "插件 "
L_TOGGLE_ADDONS = " 插件系列"
L_TOGGLE_EXPAND = "展開 "
L_TOGGLE_COLLAPSE = "折疊 "
L_TOGGLE_RCLICK = "右鍵點擊以啟用或禁用 "
L_TOGGLE_LCLICK = "左鍵點擊來顯示/隱藏窗口 "
L_TOGGLE_RELOAD = " (需要重載插件)"

-- UnitFrame
L_UF_GHOST = "靈魂"
L_UF_DEAD = "死亡"
L_UF_OFFLINE = "離線"
L_UF_MANA = "低法力"
L_UF_TRINKET_READY = "PVP飾品準備就緒: "
L_UF_TRINKET_USED = "PVP飾品已使用: "
L_UF_WOTF_USED = "亡靈意志已使用: "

-- Map
L_MAP_CURSOR = "鼠標: "
L_MAP_BOUNDS = "超出範圍!"

-- Minimap
L_MINIMAP_CALENDAR = "日曆"

-- Addons list
L_ALOAD_RL = "重新加載UI"
L_ALOAD_DEP = "依賴關係: "
L_ALOAD_OP_DEP = "Optional Dependencies: " -- Needs review
L_ALOAD_PROFILES = "Profiles" -- Needs review
L_ALOAD_ENABLE_ALL = "Enable All" -- Needs review
L_ALOAD_DISABLE_ALL = "Disable All" -- Needs review
L_ALOAD_PROFILE_NAME = "Profile Name" -- Needs review
L_ALOAD_SET_TO = "Set To.." -- Needs review
L_ALOAD_ADD_TO = "Add To.." -- Needs review
L_ALOAD_REMOVE_FROM = "Remove From.." -- Needs review
L_ALOAD_DELETE_PROFILE = "Delete Profile.." -- Needs review
L_ALOAD_CONFIRM_DELETE = "Are you sure you want to delete this profile? Hold down shift and click again if you are." -- Needs review

-- Chat
L_CHAT_WHISPER = "From"
L_CHAT_BN_WHISPER = "From"
L_CHAT_AFK = "[AFK]"
L_CHAT_DND = "[DND]"
L_CHAT_GM = "[GM]"
L_CHAT_GUILD = "公會"
L_CHAT_PARTY = "小隊"
L_CHAT_PARTY_LEADER = "隊長"
L_CHAT_RAID = "團隊"
L_CHAT_RAID_LEADER = "團長"
L_CHAT_RAID_WARNING = "團隊警告"
L_CHAT_BATTLEGROUND = "戰場"
L_CHAT_BATTLEGROUND_LEADER = "戰場領袖"
L_CHAT_OFFICER = "官員"
L_CHAT_PET_BATTLE = "PB" -- Needs review
L_CHAT_COME_ONLINE = "上線了."
L_CHAT_GONE_OFFLINE = "離線了."
L_CHAT_COME_ONLINE_COLOR = "|cff298F00上線了|r !"
L_CHAT_GONE_OFFLINE_COLOR = "|cffff0000離線了|r !"

-- Errors frame
L_ERRORFRAME_L = "點擊查看錯誤."

-- Bags
L_BAG_BANK = "銀行"
L_BAG_NO_SLOTS = "不能再購買更多的背包欄位!"
L_BAG_COSTS = "花費: %.2f 金"
L_BAG_BUY_SLOTS = "輸入 /bags purchase yes 以購買銀行背包欄位"
L_BAG_OPEN_BANK = "您需要先造訪您的銀行"
L_BAG_SORT = "將背包或銀行內的物品分類及排序"
L_BAG_STACK = "將背包或銀行內的不完整的物品堆疊重新堆疊"
L_BAG_BUY_BANKS_SLOT = "購買銀行背包欄位. (需要造訪銀行)"
L_BAG_SORT_MENU = "分類及排序"
L_BAG_SORT_SPECIAL = "分類及排序特殊物品"
L_BAG_STACK_MENU = "堆疊"
L_BAG_STACK_SPECIAL = "堆疊特殊物品"
L_BAG_SHOW_BAGS = "顯示背包"
L_BAG_SORTING_BAGS = "分類及排序完成"
L_BAG_NOTHING_SORT = "不需要分類"
L_BAG_BAGS_BIDS = "使用背包: "
L_BAG_STACK_END = "重新堆疊完成"
L_BAG_RIGHT_CLICK_SEARCH = "點擊右鍵以搜尋物品"

-- Grab mail
L_MAIL_STOPPED = "無法拾取, 背囊已滿."
L_MAIL_UNIQUE = "中止,在背包或銀行發現重複的唯一物品."
L_MAIL_COMPLETE = "完成."
L_MAIL_NEED = "需要一個信箱."
L_MAIL_MESSAGES = "新郵件"

-- Loot
L_LOOT_RANDOM = "隨機玩家"
L_LOOT_SELF = "自己拾取"
L_LOOT_UNKNOWN = "未知"
L_LOOT_FISH = "釣魚拾取"
L_LOOT_MONSTER = ">> 撿取自 "
L_LOOT_CHEST = ">> 撿取自寶箱"
L_LOOT_ANNOUNCE = "向頻道通告"
L_LOOT_TO_RAID = "  團隊"
L_LOOT_TO_PARTY = "  隊伍"
L_LOOT_TO_GUILD = "  公會"
L_LOOT_TO_SAY = "  說"
L_LOOT_CANNOT = "不能拾取"

-- LitePanels AFK module
L_PANELS_AFK = "你處于暫離狀態!"
L_PANELS_AFK_RCLICK = "右鍵點擊隱藏."
L_PANELS_AFK_LCLICK = "左鍵點擊脫離暫離狀態." 

-- Cooldowns
L_COOLDOWNS = "CD: "

-- Autoinvite
L_INVITE_ENABLE = "自動邀請功能已啟用: "
L_INVITE_DISABLE = "自動邀請功能已關閉"

-- Bind key
L_BIND_SAVED = "所有快捷鍵設置被保存."
L_BIND_DISCARD = "所有新的快捷鍵設置被取消."
L_BIND_INSTRUCT = "將滑鼠懸停至任意快捷欄進行綁定. 按ESC或者右鍵點擊以清除當前快捷欄的按鍵綁定."
L_BIND_CLEARED = "已經清除所有的快捷鍵設置"
L_BIND_BINDING = "綁定"
L_BIND_KEY = "按鍵"
L_BIND_NO_SET = "沒有綁定快捷鍵"

-- Talent spec
L_PLANNER_DEATHKNIGHT_1 = "血魄"
L_PLANNER_DEATHKNIGHT_2 = "冰霜"
L_PLANNER_DEATHKNIGHT_3 = "穢邪"
L_PLANNER_WARRIOR_1 = "武器"
L_PLANNER_WARRIOR_2 = "狂怒"
L_PLANNER_WARRIOR_3 = "防護"
L_PLANNER_ROGUE_1 = "刺殺"
L_PLANNER_ROGUE_2 = "戰鬥"
L_PLANNER_ROGUE_3 = "敏銳"
L_PLANNER_MAGE_1 = "秘法"
L_PLANNER_MAGE_2 = "火焰"
L_PLANNER_MAGE_3 = "冰霜"
L_PLANNER_PRIEST_1 = "戒律"
L_PLANNER_PRIEST_2 = "神聖"
L_PLANNER_PRIEST_3 = "暗影"
L_PLANNER_WARLOCK_1 = "痛苦"
L_PLANNER_WARLOCK_2 = "惡魔"
L_PLANNER_WARLOCK_3 = "毀滅"
L_PLANNER_HUNTER_1 = "野獸控制"
L_PLANNER_HUNTER_2 = "射擊"
L_PLANNER_HUNTER_3 = "生存"
L_PLANNER_DRUID_1 = "平衡"
L_PLANNER_DRUID_2 = "野性戰鬥"
L_PLANNER_DRUID_3 = "恢復"
L_PLANNER_SHAMAN_1 = "元素"
L_PLANNER_SHAMAN_2 = "增強"
L_PLANNER_SHAMAN_3 = "恢復"
L_PLANNER_PALADIN_1 = "神聖"
L_PLANNER_PALADIN_2 = "防護"
L_PLANNER_PALADIN_3 = "懲戒"

-- BG stats
L_DATATEXT_BASESASSAULTED = "基地突襲:"
L_DATATEXT_BASESDEFENDED = "基地防禦:"
L_DATATEXT_TOWERSASSAULTED = "哨塔突襲:"
L_DATATEXT_TOWERSDEFENDED = "哨塔防禦:"
L_DATATEXT_FLAGSCAPTURED = "佔領旗幟:"
L_DATATEXT_FLAGSRETURNED = "交還旗幟:"
L_DATATEXT_GRAVEYARDSASSAULTED = "墓地突襲:"
L_DATATEXT_GRAVEYARDSDEFENDED = "墓地防守:"
L_DATATEXT_DEMOLISHERSDESTROYED = "石毀車摧毀:"
L_DATATEXT_GATESDESTROYED = "大門摧毀:"
L_DATATEXT_CONTROL = "控制:"

-- Info text
L_INFO_ERRORS = "目前沒有錯誤."
L_INFO_INVITE = "接受邀請自: "
L_INFO_DUEL = "拒絕決鬥請求: "
L_INFO_DISBAND = "解散隊伍..."
L_INFO_SETTINGS_DBM = "鍵入 /settings dbm, 載入 DBM 的設定."
L_INFO_SETTINGS_DXE = "鍵入 /settings dxe, 載入 DXE 的設定."
L_INFO_SETTINGS_MSBT = "鍵入 /settings msbt, 載入 MSBT 的設定."
L_INFO_SETTINGS_SKADA = "鍵入 /settings skada, 載入 Skada 的設定."
L_INFO_SETTINGS_ALL = "鍵入 /settings all, 載入所有UI設定."
L_INFO_NOT_INSTALLED = " 沒有安裝."
L_INFO_SKIN_DISABLED1 = "風格化 "
L_INFO_SKIN_DISABLED2 = " 已禁用."

-- Popups
L_POPUP_INSTALLUI = "該角色首次使用ShestakUI.你必須重新加載UI來配置."
L_POPUP_RESETUI = "你確定要重新加載ShestakUI?"
L_POPUP_RESETSTATS = "你確定要重置本次遊戲時間和金幣收益統計數據嗎?"
L_POPUP_SWITCH_RAID = "多個團隊樣式被加載,請選擇一個樣式."
L_POPUP_DISBAND_RAID = "你確定要解散團隊?"
L_POPUP_DISABLEUI = "ShestakUI並不支援此解析度, 你想要停用ShestakUI嗎? (若果您想要嘗試其他解析度, 請按取消)"
L_POPUP_SETTINGS_ALL = "應用所有的UI設置? (DBM/DXE, Skada and MSBT)"
L_POPUP_SETTINGS_DBM = "需要改變DBM描點及風格化元素。"
L_POPUP_SETTINGS_DXE = "需要改變DXE描點及風格化元素。"
L_POPUP_SETTINGS_BW = "需要改變BigWigs描點及風格化元素。"
L_POPUP_ARMORY = "軍械庫"

-- Welcome message
L_WELCOME_LINE_1 = "歡迎使用ShestakUI "
L_WELCOME_LINE_2_1 = "輸入/cfg進行UI設置,或者訪問http://shestak.org"
L_WELCOME_LINE_2_2 = "得到更多信息."

-- Combat text
L_COMBATTEXT_KILLING_BLOW = "最後一擊"
L_COMBATTEXT_ALREADY_UNLOCKED = "戰鬥信息已經解鎖."
L_COMBATTEXT_ALREADY_LOCKED = "戰鬥信息已經鎖定."
L_COMBATTEXT_TEST_DISABLED = "戰鬥信息測試模式已禁用."
L_COMBATTEXT_TEST_ENABLED = "戰鬥信息測試模式已啟用."
L_COMBATTEXT_TEST_USE_UNLOCK = "輸入 /xct unlock 來移動或調整戰鬥信息框架大小."
L_COMBATTEXT_TEST_USE_LOCK = "輸入 /xct lock 來鎖定戰鬥信息框架."
L_COMBATTEXT_TEST_USE_TEST = "輸入 /xct test 來啟用或禁用戰鬥信息測試模式."
L_COMBATTEXT_POPUP = "要保存戰鬥信息窗口的位置你需要重新載入插件."
L_COMBATTEXT_UNSAVED = "戰鬥信息窗口位置尚未保存,不要忘記重新載入插件."
L_COMBATTEXT_UNLOCKED = "戰鬥信息已解鎖."

-- LiteStats
L_STATS_ACC_PLAYED = "帳號啟用總時間"
L_STATS_ADDED_JUNK = "增加自動販售例外名單"
L_STATS_REMOVE_EXCEPTION = "新增/移除 例外名單"
L_STATS_ALT = "ALT鍵"
L_STATS_AUTO_REPAIR = "自動修裝"
L_STATS_GUILD_REPAIR = "公會銀行修理"
L_STATS_AUTO_SELL = "自動販售灰色物品"
L_STATS_BANDWIDTH = "寬頻:"
L_STATS_DOWNLOAD = "下載:"
L_STATS_CLEARED_JUNK = "清除自動販售例外名單列表"
L_STATS_CLEAR_EXCEPTIONS = "清除例外名單列表"
L_STATS_WORLD_MAP = "點擊開啟世界地圖"
L_STATS_CURRENT_XP = "目前/升級所需 經驗值"
L_STATS_MEMORY_USAGE = "内建插件資源耗用:"
L_STATS_GARBAGE_COLLECTED = "垃圾資源清除"
L_STATS_CHANGE_SORTING = "(公會)右鍵更改排列方式,SHIFT+右鍵反轉排列方式"
L_STATS_HIDDEN = "隱藏"
L_STATS_VIEW_NOTES = "按住ALT鍵檢視公會成員階級.註記.幹部註記"
L_STATS_HR = "小时"
L_STATS_INF = "无限"
L_STATS_ALREADY_EXCEPTIONS = "物品已在例外名單列表"
L_STATS_NOT_JUNK = "非自動販售物品"
L_STATS_ITEMLINK = "物品鏈結"
L_STATS_JUNK_EXCEPTIONS = "自動販售例外名單"
L_STATS_JUNK_LIST = "自動販售列表"
L_STATS_JUNK_PROFIT = "自動販售所得金額"
L_STATS_KILLS = "K"
L_STATS_OPEN_CALENDAR = "左鍵開啟行事曆"
L_STATS_OPEN_CHARACTER = "左鍵開啟人物欄"
L_STATS_OPEN_CURRENCY = "左鍵開啟貨幣欄"
L_STATS_OPEN_TALENT = "左鍵開啟天賦視窗"
L_STATS_XP_RATE = "當前等級經驗值趴數"
L_STATS_IGNORED_ITEMS = "列出目前忽略物品"
L_STATS_TOGGLE_TIME = "當地/伺服器 及24小時制可顯示於時間管理器"
L_STATS_LOCATION = "位置/座標"
L_STATS_MEMORY = "記憶體"
L_STATS_ON = "啟用"
L_STATS_OTHER_OPTIONS = "其它選項可能配置在 %s"
L_STATS_PLAYED_LEVEL = "當前等級總上線時間"
L_STATS_PLAYED_SESSION = "此次上線時段耗費時間"
L_STATS_PLAYED_TOTAL = "總上線時間"
L_STATS_QUEST = "任務"
L_STATS_QUESTS_TO = "任務/殺怪 得到經驗值 %s"
L_STATS_REMAINING_XP = "升級尚需經驗值"
L_STATS_REMOVED_JUNK = "移除自動販售例外名單"
L_STATS_RESTED_XP = "休息獎勵經驗值"
L_STATS_RC_COLLECTS_GARBAGE = "右鍵點擊清除插件垃圾資源"
L_STATS_RC_TIME_MANAGER = "右鍵開啟時間管理器"
L_STATS_RC_EXPERIENCE = "右鍵切換顯示經驗值.上線時間.角色資訊"
L_STATS_RC_AUTO_REPAIRING = "右鍵顯示自動修裝"
L_STATS_RC_AUTO_SELLING = "右鍵開啟自動販售"
L_STATS_RC_TALENT = "右鍵切換天賦"
L_STATS_SERVER_GOLD = "帳號總現金"
L_STATS_SESSION_GAIN = "此次上線時段 所得/損失 現金"
L_STATS_SESSION_XP = "此次上線時段所得經驗值"
L_STATS_INSERTS_COORDS = "SHIFT+點擊 地名或座標可在對話視窗發佈你所在座標"
L_STATS_EQUIPMENT_CHANGER = "左鍵或中鍵開啟裝備管理員"
L_STATS_SORTING_BY = "依...排列"
L_STATS_TIPS = "提示:"
L_STATS_TOTAL = "總計"
L_STATS_TOTAL_MEMORY_USAGE = "全部資源耗用:"
L_STATS_NOT_TO_SELL = "輸入/junk設定自動販售例外名單"
L_STATS_WATCH_CURRENCY = "從tooltip中顯示貨幣"
L_STATS_WATCH_FACTIONS = "從角色人物介面觀看資訊"
L_STATS_TOOLTIP_TIME_PLAYED = "達到最高等級後,提示將顯示角色上線時間紀錄"
L_STATS_TOOLTIP_EXPERIENCE = "未達最高等級時,提示將顯示經驗值訊息"

-- Slash commands
L_SLASHCMD_HELP = {
	"可用的斜杠命令:",
	"/rl - 重載介面.",
	"/rc - 提出準備就緒的確認.",
	"/gm - 打開GM面板.",
	"/dis ADDON_NAME - 禁用 插件名.",
	"/en ADDON_NAME - 開啟 插件名.",
	"/rd - 解散隊伍.",
	"/toraid - 轉換為團隊或隊伍.",
	"/teleport - 傳出隨機副本的命令.",
	"/luaerror - 打開/關閉 插件報錯的彈出窗口.",
	"/spec - 切換天賦.",
	"/clfix - 戰鬥記錄修復.",
	"/heal - 載入治療模式介面.",
	"/dps - 載入傷害輸出模式介面.",
	"/frame - 在聊天窗口輸出框架名稱.",
	"/farmmode - 打開/關閉 小地圖採集模式.",
	"/moveui - 解鎖/鎖定 介面內所有移動的框體.",
	"/resetui - 重置介面設置到初始狀態.",
	"/resetuf - 重置頭像面板到初始狀態.",
	"/resetconfig - 重置已修改的設置.",
	"/resetstats - 重置人物屬性狀態面板.",
	"/settings ADDON_NAME - 設置 插件_名.",
	"/ls - 載入設置.",
	"/bags - 背包選項.",
	"/xct - 戰鬥信息選項.",
	"/raidcd - 團隊技能冷卻監視條選項.",
	"/enemycd - 敵對技能冷卻監視選項.",
	"/pulsecd - 冷卻提醒選項.",
	"/threat - 仇恨條選項.",
	"/tt - 密語當前所選定的目標.",
	"/ainv - 打開/關閉 自動接受公會+好友 組隊邀請.",
	"/testuf - 測試頭像框體位置.",
	"/cfg - 打開介面設置面板.",
}