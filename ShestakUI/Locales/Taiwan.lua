local T, C, L, _ = unpack(select(2, ...))
if T.client ~= "zhTW" then return end

----------------------------------------------------------------------------------------
--	Localization for zhTW client
--	Translation: Aelb, Ianchan, Leg883, Mania, Nanjiqq, Spacedragon, Tat2dawn, Tibles
----------------------------------------------------------------------------------------
-- Announce flasks and food
L_ANNOUNCE_FF_NOFOOD = "缺少食物Buff: "
L_ANNOUNCE_FF_NOFLASK = "缺少精煉藥劑: "
L_ANNOUNCE_FF_ALLBUFFED = "已獲得所有增益!"
L_ANNOUNCE_FF_CHECK_BUTTON = "檢查食物和精煉"

-- Says thanks for some spells
L_ANNOUNCE_SS_THANKS = "謝謝你的 "
L_ANNOUNCE_SS_RECEIVED = " 收到來自于 "

-- Pull countdown announce
L_ANNOUNCE_PC_GO = "開始！"
L_ANNOUNCE_PC_MSG = "正在拉: %s, 倒數 %s.."
L_ANNOUNCE_PC_ABORTED = "取消拉怪！"

-- Announce feasts and portals
L_ANNOUNCE_FP_STAT = "%s 放置了 %s - [%s]."
L_ANNOUNCE_FP_PRE = "%s 放置了 %s"
L_ANNOUNCE_FP_PUT = "%s 放置了 %s"
L_ANNOUNCE_FP_CAST = "%s 開啟了 %s"
L_ANNOUNCE_FP_CLICK = "%s 正在開啟 %s... 請點擊！"
L_ANNOUNCE_FP_USE = "%s 使用了 %s."

-- Announce your interrupts
L_ANNOUNCE_INTERRUPTED = "已打斷"

-- Tooltip
L_TOOLTIP_NO_TALENT = "沒有天賦"
L_TOOLTIP_LOADING = "讀取中..."
L_TOOLTIP_ACH_STATUS = "你的狀態:"
L_TOOLTIP_ACH_COMPLETE = "你的狀態: 完成 "
L_TOOLTIP_ACH_INCOMPLETE = "你的狀態: 未完成"
L_TOOLTIP_SPELL_ID = "法術ID:"
L_TOOLTIP_ITEM_ID = "物品ID:"
L_TOOLTIP_WHO_TARGET = "關注"
L_TOOLTIP_ITEM_COUNT = "物品數量:"
L_TOOLTIP_INSPECT_OPEN = "檢查框體已打開"

-- Misc
L_MISC_UNDRESS = "無裝備"
L_MISC_DRINKING = " 進食中..."
L_MISC_BUY_STACK = "Alt+右鍵點擊購買一疊"
L_MISC_ONECLICK_BUYOUT = "Shift+右鍵,不彈出確認窗口直接購買"
L_MISC_ONECLICK_BID = "Shift+右鍵,不彈出確認窗口直接競標"
L_MISC_ONECLICK_CANCEL = "Shift+右鍵,不彈出確認窗口直接取消選擇的物品"
L_MISC_UI_OUTDATED = "ShestakUI 版本已過期，請至 www.shestak.org 下載最新版"
L_MISC_HEADER_MARK = "鼠標懸停顯示團隊圖標"
L_MISC_BINDER_OPEN = "鼠標綁定"
L_MISC_SCROLL = "附魔卷軸"

-- Raid Utility
L_RAID_UTIL_DISBAND = "解散團隊"

-- Zone name
L_ZONE_ARATHIBASIN = "阿拉希盆地"
L_ZONE_GILNEAS = "吉爾尼斯之戰"
L_ZONE_ANCIENTDALARAN = "達拉然陷坑"

-- WatchFrame Wowhead link
L_WATCH_WOWHEAD_LINK = "Wowhead鏈接"

-- Toggle Menu
L_TOGGLE_ADDON = "插件 "
L_TOGGLE_ADDONS = " 插件系列"
L_TOGGLE_EXPAND = "展開 "
L_TOGGLE_COLLAPSE = "折疊 "
L_TOGGLE_RCLICK = "右鍵點擊以啟用或禁用"
L_TOGGLE_LCLICK = "左鍵點擊來顯示/隱藏窗口 "
L_TOGGLE_RELOAD = " (需要重載插件)"
L_TOGGLE_NOT_FOUND = " 未創建."

-- UnitFrame
L_UF_GHOST = "靈魂"
L_UF_DEAD = "死亡"
L_UF_OFFLINE = "離線"
L_UF_MANA = "低法力"

-- Map
L_MAP_CURSOR = "鼠標: "
L_MAP_BOUNDS = "超出範圍"
L_MAP_FOG = "地圖全亮"
L_MAP_COORDS = "Coordinates" -- Needs review

-- Minimap
L_MINIMAP_CALENDAR = "日曆"
L_MINIMAP_HEAL_LAYOUT = "左鍵 - HPS 佈局"
L_MINIMAP_DPS_LAYOUT = "右鍵 - DPS 佈局"
L_MINIMAP_BLIZZ_LAYOUT = "中鍵 - 默認 佈局"

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
L_CHAT_INSTANCE_CHAT = "I"
L_CHAT_INSTANCE_CHAT_LEADER = "IL"
L_CHAT_OFFICER = "O"
L_CHAT_PET_BATTLE = "PB"
L_CHAT_COME_ONLINE = "|cff298F00上線了|r."
L_CHAT_GONE_OFFLINE = "|cffff0000下線了|r."

-- Errors frame
L_ERRORFRAME_L = "點擊查看錯誤"

-- Bags
L_BAG_SHOW_BAGS = "顯示背包"
L_BAG_RIGHT_CLICK_SEARCH = "點擊右鍵以搜尋物品"
L_BAG_STACK_MENU = "堆疊"
L_BAG_RIGHT_CLICK_CLOSE = "右鍵點擊打開菜單"

-- Grab mail
L_MAIL_STOPPED = "無法拾取, 背囊已滿."
L_MAIL_UNIQUE = "中止,在背包或銀行發現重複的唯一物品."
L_MAIL_COMPLETE = "完成"
L_MAIL_NEED = "需要一個信箱"
L_MAIL_MESSAGES = "新郵件"

-- Loot
L_LOOT_RANDOM = "隨機玩家"
L_LOOT_SELF = "自己拾取"
L_LOOT_FISH = "釣魚拾取"
L_LOOT_ANNOUNCE = "向頻道通告"
L_LOOT_TO_RAID = " 團隊"
L_LOOT_TO_PARTY = " 隊伍"
L_LOOT_TO_GUILD = " 公會"
L_LOOT_TO_SAY = " 說"

-- LitePanels AFK module
L_PANELS_AFK = "你處于暫離狀態"
L_PANELS_AFK_RCLICK = "右鍵點擊隱藏"
L_PANELS_AFK_LCLICK = "左鍵點擊脫離暫離狀態"

-- Cooldowns
L_COOLDOWNS = "CD: "
L_COOLDOWNS_COMBATRESS = "戰復"
L_COOLDOWNS_COMBATRESS_REMAINDER = "戰復剩餘: "
L_COOLDOWNS_NEXTTIME = "下次: "

-- Autoinvite
L_INVITE_ENABLE = "自動邀請功能已啟用: "
L_INVITE_DISABLE = "自動邀請功能已關閉"

-- Bind key
L_BIND_SAVED = "所有快捷鍵設置被保存"
L_BIND_DISCARD = "所有新的快捷鍵設置被取消"
L_BIND_INSTRUCT = "將滑鼠懸停至任意快捷欄進行綁定. 按ESC或者右鍵點擊以清除當前快捷欄的按鍵綁定."
L_BIND_CLEARED = "已經清除所有的快捷鍵設置"
L_BIND_BINDING = "綁定"
L_BIND_KEY = "按鍵"
L_BIND_NO_SET = "沒有綁定快捷鍵"

-- Info text
L_INFO_ERRORS = "目前沒有錯誤"
L_INFO_INVITE = "接受邀請 "
L_INFO_DUEL = "拒絕決鬥請求 "
L_INFO_PET_DUEL = "拒絕寵物對戰請求 "
L_INFO_DISBAND = "解散隊伍"
L_INFO_SETTINGS_DBM = "鍵入 /settings dbm, 載入 DBM 的設定"
L_INFO_SETTINGS_BIGWIGS = "鍵入 /settings bw, 載入 BigWigs 的設定"
L_INFO_SETTINGS_MSBT = "鍵入 /settings msbt, 載入 MSBT 的設定"
L_INFO_SETTINGS_SKADA = "鍵入 /settings skada, 載入 Skada 的設定"
L_INFO_SETTINGS_ALL = "鍵入 /settings all, 載入所有UI設定"
L_INFO_NOT_INSTALLED = " 沒有安裝"
L_INFO_SKIN_DISABLED1 = "介面樣式啟用"
L_INFO_SKIN_DISABLED2 = " 已禁用"

-- Popups
L_POPUP_INSTALLUI = "該角色首次使用ShestakUI.你必須重新加載UI來配置."
L_POPUP_RESETUI = "你確定要重新加載ShestakUI?"
L_POPUP_RESETSTATS = "你確定要重置本次遊戲時間和金幣收益統計數據嗎?"
L_POPUP_SWITCH_RAID = "選擇團隊佈局."
L_POPUP_DISBAND_RAID = "你確定要解散團隊?"
L_POPUP_DISABLEUI = "ShestakUI並不支援此解析度, 你想要停用ShestakUI嗎? (若果您想要嘗試其他解析度, 請按取消)"
L_POPUP_SETTINGS_ALL = "應用所有的UI設置(DBM, BigWigs, Skada, MSBT)?"
L_POPUP_SETTINGS_DBM = "需要改變DBM描點及風格化元素."
L_POPUP_SETTINGS_BW = "需要改變BigWigs描點及風格化元素."
L_POPUP_ARMORY = "查看英雄榜"

-- Welcome message
L_WELCOME_LINE_1 = "歡迎使用ShestakUI "
L_WELCOME_LINE_2_1 = "輸入/cfg進行UI設置,或者訪問http://shestak.org"
L_WELCOME_LINE_2_2 = "獲取更多信息"

-- Combat text
L_COMBATTEXT_KILLING_BLOW = "最後一擊"
L_COMBATTEXT_ALREADY_UNLOCKED = "戰鬥信息已經解鎖."
L_COMBATTEXT_ALREADY_LOCKED = "戰鬥信息已經鎖定."
L_COMBATTEXT_TEST_DISABLED = "戰鬥信息測試模式已禁用."
L_COMBATTEXT_TEST_ENABLED = "戰鬥信息測試模式已啟用."
L_COMBATTEXT_TEST_USE_UNLOCK = "輸入 /xct unlock 來移動或調整戰鬥信息框架大小."
L_COMBATTEXT_TEST_USE_LOCK = "輸入 /xct lock 來鎖定戰鬥信息框架."
L_COMBATTEXT_TEST_USE_TEST = "輸入 /xct test 來啟用或禁用戰鬥信息測試模式."
L_COMBATTEXT_TEST_USE_RESET = "Type /xct reset to restore default positions." -- Need review
L_COMBATTEXT_POPUP = "要保存戰鬥信息窗口的位置你需要重新載入插件."
L_COMBATTEXT_UNSAVED = "戰鬥信息窗口位置尚未保存,不要忘記重新載入插件."
L_COMBATTEXT_UNLOCKED = "戰鬥信息已解鎖."

-- LiteStats
L_STATS_ACC_PLAYED = "帳號啟用總時間"
L_STATS_ADDED_JUNK = "增加自動販售例外名單"
L_STATS_REMOVE_EXCEPTION = "新增/移除 例外名單"
L_STATS_AUTO_REPAIR = "自動修裝"
L_STATS_GUILD_REPAIR = "公會銀行修理"
L_STATS_AUTO_SELL = "自動販售灰色物品"
L_STATS_BANDWIDTH = "寬頻:"
L_STATS_DOWNLOAD = "下載:"
L_STATS_CLEARED_JUNK = "清除自動販售例外名單列表"
L_STATS_CLEAR_EXCEPTIONS = "清除例外名單列表"
L_STATS_CURRENCY_RAID = "Raid Seals" -- Needs review
L_STATS_WORLD_MAP = "點擊開啟世界地圖"
L_STATS_CURRENT_XP = "目前/升級所需 經驗值"
L_STATS_MEMORY_USAGE = "插件資源佔用:"
L_STATS_GARBAGE_COLLECTED = "垃圾資源清除"
L_STATS_CHANGE_SORTING = "[公會]右鍵更改排列方式,Shift+右鍵反轉排列方式"
L_STATS_HIDDEN = "隱藏"
L_STATS_VIEW_NOTES = "按住Alt鍵檢視公會成員階級/註記/幹部註記"
L_STATS_HR = "小時"
L_STATS_INF = "無限"
L_STATS_ALREADY_EXCEPTIONS = "物品已在例外名單列表"
L_STATS_ITEMLINK = "物品鏈結"
L_STATS_JUNK_EXCEPTIONS = "自動販售例外名單"
L_STATS_JUNK_LIST = "自動販售列表"
L_STATS_JUNK_PROFIT = "自動販售所得金額"
L_STATS_KILLS = "K"
L_STATS_OPEN_CALENDAR = "左鍵開啟行事曆"
L_STATS_OPEN_CHARACTER = "左鍵開啟人物欄"
L_STATS_OPEN_CURRENCY = "左鍵開啟貨幣欄"
L_STATS_OPEN_TALENT = "Left-Click toggles your talent specialization." -- Need review
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
L_STATS_RC_EXPERIENCE = "右鍵切換顯示經驗值/上線時間/角色資訊"
L_STATS_RC_AUTO_REPAIRING = "右鍵顯示自動修裝"
L_STATS_RC_AUTO_SELLING = "右鍵開啟自動販售"
L_STATS_RC_TALENT = "Right-Click toggles your loot specialization." -- Need review
L_STATS_SERVER_GOLD = "帳號總現金"
L_STATS_SESSION_GAIN = "此次上線時段獲得/損失金額"
L_STATS_SESSION_XP = "此次上線時段所得經驗值"
L_STATS_INSERTS_COORDS = "Shift+點擊地名或座標可在對話視窗發佈你所在座標"
L_STATS_EQUIPMENT_CHANGER = "左鍵或中鍵開啟裝備管理員"
L_STATS_SORTING_BY = "排列方式："
L_STATS_TIPS = "提示:"
L_STATS_TOTAL_MEMORY_USAGE = "全部資源耗用:"
L_STATS_TOTAL_CPU_USAGE = "Total CPU Usage:" -- Need review
L_STATS_NOT_TO_SELL = "輸入/junk設定自動販售例外名單"
L_STATS_WATCH_CURRENCY = "從tooltip中顯示貨幣"
L_STATS_WATCH_FACTIONS = "從角色人物介面觀看資訊"
L_STATS_TOOLTIP_TIME_PLAYED = "達到最高等級後,提示將顯示角色上線時間紀錄"
L_STATS_TOOLTIP_EXPERIENCE = "未達最高等級時,提示將顯示經驗值訊息"
L_STATS_SEALS = "Seals this week" -- Needs review
L_STATS_SPEC = "專精" -- Need review

-- Slash commands
L_SLASHCMD_HELP = {
	"可用的斜杠命令:",
	"/rl - 重載介面",
	"/rc - 提出準備就緒的確認",
	"/gm - 打開GM面板",
	"/dis ADDON_NAME - 禁用插件",
	"/en ADDON_NAME - 開啟插件",
	"/rd - 解散隊伍",
	"/toraid - 轉換為團隊或隊伍",
	"/teleport - 傳出隨機副本的命令",
	"/spec - 切換天賦",
	"/heal - 載入治療模式介面",
	"/dps - 載入傷害輸出模式介面",
	"/frame - 在聊天窗口輸出框架名稱",
	"/farmmode - 打開/關閉 小地圖採集模式",
	"/moveui - 解鎖/鎖定 介面內所有移動的框體",
	"/resetui - 重置介面設置到初始狀態",
	"/resetuf - 重置頭像面板到初始狀態",
	"/resetconfig - 重置已修改的設置",
	"/resetstats - 重置人物屬性狀態面板",
	"/settings ADDON_NAME - 設置插件",
	"/ls - 載入設置",
	"/xct - 戰鬥信息選項",
	"/raidcd - 團隊技能冷卻監視條選項",
	"/enemycd - 敵對技能冷卻監視選項",
	"/pulsecd - 冷卻提醒選項",
	"/threat - 仇恨條選項",
	"/tt - 密語當前所選定的目標",
	"/ainv - 打開/關閉 自動接受公會/好友組隊邀請",
	"/testuf - 測試頭像框體位置",
	"/cfg - 打開介面設置面板",
}