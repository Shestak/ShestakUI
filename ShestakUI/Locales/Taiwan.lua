local T, C, L, _ = unpack(select(2, ...))
if T.client ~= "zhTW" then return end

----------------------------------------------------------------------------------------
--	Localization for zhTW client
--	Translation: Aelb, Ianchan, Leg883, Mania, Nanjiqq, Spacedragon, Tat2dawn, Tibles
----------------------------------------------------------------------------------------
-- Announce flasks and food
L_ANNOUNCE_FF_NOFOOD = "缺少食物: "
L_ANNOUNCE_FF_NOFLASK = "缺少精煉: "
L_ANNOUNCE_FF_ALLBUFFED = "已獲得所有增益 !"
L_ANNOUNCE_FF_CHECK_BUTTON = "檢查食物和精煉"

-- Says thanks for some spells
L_ANNOUNCE_SS_THANKS = "謝謝你的 "
L_ANNOUNCE_SS_RECEIVED = " 收到來自于 "

-- Pull countdown announce
L_ANNOUNCE_PC_GO = "開始 !"
L_ANNOUNCE_PC_MSG = "準備接怪: %s，倒數 %s.."
L_ANNOUNCE_PC_ABORTED = "取消拉怪 !"

-- Announce feasts and portals
L_ANNOUNCE_FP_STAT = "%s 放置了 %s - [%s]。"
L_ANNOUNCE_FP_PRE = "%s 放置了 %s"
L_ANNOUNCE_FP_PUT = "%s 放置了 %s"
L_ANNOUNCE_FP_CAST = "%s 開啟了 %s"
L_ANNOUNCE_FP_CLICK = "%s 正在開啟 %s... 請點擊 !"
L_ANNOUNCE_FP_USE = "%s 使用了 %s。"

-- Announce your interrupts
L_ANNOUNCE_INTERRUPTED = "已打斷"

-- Tooltip
L_TOOLTIP_NO_TALENT = "沒有天賦"
L_TOOLTIP_LOADING = "讀取中..."
L_TOOLTIP_ACH_STATUS = "你的狀態: "
L_TOOLTIP_ACH_COMPLETE = "你的狀態: 完成"
L_TOOLTIP_ACH_INCOMPLETE = "你的狀態: 未完成"
L_TOOLTIP_SPELL_ID = "法術ID: "
L_TOOLTIP_ITEM_ID = "物品ID: "
L_TOOLTIP_WHO_TARGET = "關注"
L_TOOLTIP_ITEM_COUNT = "物品數量: "
L_TOOLTIP_INSPECT_OPEN = "檢查框體已開啟"

-- Misc
L_MISC_UNDRESS = "無裝備"
L_MISC_DRINKING = " 進食中..."
L_MISC_BUY_STACK = "Alt+右鍵批量購買"
L_MISC_UI_OUTDATED = "ShestakUI 版本已過期，請至 www.shestak.org 下載最新版。"
L_MISC_HEADER_MARK = "滑鼠懸停顯示團隊圖標"
L_MISC_BINDER_OPEN = "滑鼠綁定"
L_MISC_SCROLL = "附魔皮紙"

-- Raid Utility
L_RAID_UTIL_DISBAND = "解散團隊"

-- Zone name
L_ZONE_ANCIENTDALARAN = "達拉然陷坑"

-- WatchFrame Wowhead link
L_WATCH_WOWHEAD_LINK = "Wowhead鏈接"

-- Toggle Menu
L_TOGGLE_ADDON = "插件 "
L_TOGGLE_ADDONS = " 插件系列"
L_TOGGLE_EXPAND = "展開 "
L_TOGGLE_COLLAPSE = "折疊 "
L_TOGGLE_RCLICK = "右鍵 啟用/禁用"
L_TOGGLE_LCLICK = "左鍵 顯示/隱藏窗口 "
L_TOGGLE_RELOAD = " (需要重載插件)"
L_TOGGLE_NOT_FOUND = " 未創建"

-- UnitFrame
L_UF_GHOST = "靈魂"
L_UF_DEAD = "死亡"
L_UF_OFFLINE = "離線"
L_UF_MANA = "低法力值"

-- Map
L_MAP_CURSOR = "滑鼠: "
L_MAP_BOUNDS = "超出範圍 !"
L_MAP_FOG = "地圖全亮"
L_MAP_COORDS = "坐標"

-- Minimap
L_MINIMAP_CALENDAR = "日曆"
L_MINIMAP_HEAL_LAYOUT = "左鍵 - HPS 佈局"
L_MINIMAP_DPS_LAYOUT = "右鍵 - DPS 佈局"
L_MINIMAP_BLIZZ_LAYOUT = "中鍵 - 暴雪 佈局"
L_MINIMAP_FARM = "小地圖縮放"
L_MINIMAP_TOGGLE = "快捷列自由折疊"

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
L_CHAT_COME_ONLINE = "|cff298F00上線了|r"
L_CHAT_GONE_OFFLINE = "|cffff0000下線了|r"

-- Errors frame
L_ERRORFRAME_L = "點擊查看錯誤"

-- Bags
L_BAG_SHOW_BAGS = "顯示背包"
L_BAG_RIGHT_CLICK_SEARCH = "右鍵搜尋物品"
L_BAG_STACK_MENU = "堆疊"
L_BAG_RIGHT_CLICK_CLOSE = "右鍵開啟菜單"

-- Grab mail
L_MAIL_STOPPED = "無法拾取，背包已滿。"
L_MAIL_UNIQUE = "中止，在背包或銀行發現重複的唯一物品。"
L_MAIL_COMPLETE = "完成"
L_MAIL_NEED = "需要信箱"
L_MAIL_MESSAGES = "新郵件"

-- Loot
L_LOOT_RANDOM = "隨機拾取"
L_LOOT_SELF = "個人拾取"
L_LOOT_FISH = "釣魚拾取"
L_LOOT_ANNOUNCE = "向頻道通告"
L_LOOT_TO_RAID = " 團隊"
L_LOOT_TO_PARTY = " 隊伍"
L_LOOT_TO_GUILD = " 公會"
L_LOOT_TO_SAY = " 說"

-- LitePanels AFK module
L_PANELS_AFK = "正處于暫離狀態 !"
L_PANELS_AFK_RCLICK = "右鍵隱藏"
L_PANELS_AFK_LCLICK = "左鍵脫離暫離狀態"

-- Cooldowns
L_COOLDOWNS = "CD: "
L_COOLDOWNS_COMBATRESS = "戰復"
L_COOLDOWNS_COMBATRESS_REMAINDER = "戰復剩餘: "
L_COOLDOWNS_NEXTTIME = "下次: "

-- Bind key
L_BIND_SAVED = "快捷鍵設置已保存"
L_BIND_DISCARD = "新的快捷鍵設置已取消"
L_BIND_INSTRUCT = "將滑鼠懸停至任意快捷鍵進行綁定。按ESC或者右鍵清除當前快捷鍵的按鍵綁定。"
L_BIND_CLEARED = "已清除所有快捷鍵設置"
L_BIND_BINDING = "綁定"
L_BIND_KEY = "按鍵"
L_BIND_NO_SET = "沒有綁定快捷鍵"

-- Info text
L_INFO_ERRORS = "目前沒有錯誤"
L_INFO_INVITE = "接受邀請"
L_INFO_DUEL = "拒絕決鬥請求"
L_INFO_PET_DUEL = "拒絕寵物對戰請求"
L_INFO_DISBAND = "解散隊伍..."
L_INFO_SETTINGS_DBM = "鍵入 /settings dbm 載入 DBM 的設定"
L_INFO_SETTINGS_BIGWIGS = "鍵入 /settings bw 載入 BigWigs 的設定"
L_INFO_SETTINGS_MSBT = "鍵入 /settings msbt 載入 MSBT 的設定"
L_INFO_SETTINGS_SKADA = "鍵入 /settings skada 載入 Skada 的設定"
L_INFO_SETTINGS_ALL = "鍵入 /settings all 載入所有UI設定"
L_INFO_NOT_INSTALLED = " 沒有安裝"
L_INFO_SKIN_DISABLED1 = "界面美化啟用"
L_INFO_SKIN_DISABLED2 = " 已禁用"

-- Popups
L_POPUP_INSTALLUI = "該角色首次使用ShestakUI，你必須重新加載UI來配置。"
L_POPUP_RESETUI = "你確定要重新加載ShestakUI?"
L_POPUP_RESETSTATS = "你確定要重置所有角色遊戲時間和金幣的統計數據?"
L_POPUP_SWITCH_RAID = "選擇團隊佈局"
L_POPUP_DISBAND_RAID = "你確定要解散團隊?"
L_POPUP_DISABLEUI = "ShestakUI不支援此解析度，是否停用ShestakUI? (若要嘗試其他解析度請按取消)"
L_POPUP_SETTINGS_ALL = "應用所有的UI設置?(DBM/BigWigs/Skada/MSBT)"
L_POPUP_SETTINGS_DBM = "需要改變DBM描點及風格元素"
L_POPUP_SETTINGS_BW = "需要改變BigWigs描點及風格元素"
L_POPUP_ARMORY = "英雄榜"

-- Welcome message
L_WELCOME_LINE_1 = "歡迎使用ShestakUI "
L_WELCOME_LINE_2_1 = "鍵入 /cfg 進行UI設置, 或者訪問 http://shestak.org"
L_WELCOME_LINE_2_2 = "獲取更多信息。"

-- Combat text
L_COMBATTEXT_KILLING_BLOW = "最後一擊"
L_COMBATTEXT_TEST_DISABLED = "戰鬥信息測試模式已禁用"
L_COMBATTEXT_TEST_ENABLED = "戰鬥信息測試模式已啟用"
L_COMBATTEXT_TEST_USE_MOVE = "鍵入 /xct move 移動/調整戰鬥信息框架大小"
L_COMBATTEXT_TEST_USE_TEST = "鍵入 /xct test 啟用/禁用戰鬥信息測試模式"
L_COMBATTEXT_TEST_USE_RESET = "鍵入 /xct reset 重置到初始位置"
L_COMBATTEXT_POPUP = "保存戰鬥信息窗口的位置須重載插件"
L_COMBATTEXT_UNSAVED = "戰鬥信息窗口位置尚未保存，不要忘記重新載入插件。"
L_COMBATTEXT_UNLOCKED = "戰鬥信息已解鎖"

-- LiteStats
L_STATS_AUTO_REPAIR = "自動修裝"
L_STATS_GUILD_REPAIR = "公會銀行修裝"
L_STATS_AUTO_SELL = "自動販售灰色物品"
L_STATS_BANDWIDTH = "寬頻: "
L_STATS_DOWNLOAD = "下載: "
L_STATS_CURRENCY_RAID = "徽印"
L_STATS_MEMORY_USAGE = "插件資源佔用: "
L_STATS_TOTAL_MEMORY_USAGE = "總資源佔用: "
L_STATS_TOTAL_CPU_USAGE = "總CPU使用率: "
L_STATS_GARBAGE_COLLECTED = "整理記憶體"
L_STATS_HIDDEN = "隱藏"
L_STATS_JUNK_ALREADY_ADDITIONS = "已加入自動販售列表"
L_STATS_JUNK_ITEMLINK = "物品鏈結"
L_STATS_JUNK_ADDITIONS = "自動販售列表"
L_STATS_JUNK_LIST = "自動販售常用命令"
L_STATS_JUNK_PROFIT = "自動販售所得金額"
L_STATS_JUNK_CLEARED = "自動販售列表已清除"
L_STATS_JUNK_CLEAR_ADDITIONS = "清除自動販售列表"
L_STATS_JUNK_ADDED = "自動販售 - 已加入"
L_STATS_JUNK_ADD_ITEM = "增加/移除 物品"
L_STATS_JUNK_REMOVED = "自動販售 - 已移除"
L_STATS_JUNK_ITEMS_LIST = "列出自動販售列表"
L_STATS_KILLS = "擊殺"
L_STATS_XP_RATE = "當前等級經驗值趴數"
L_STATS_HR = "小時"
L_STATS_INF = "無限"
L_STATS_ON = "啟用"
L_STATS_PLAYED_LEVEL = "當前等級總在線時間"
L_STATS_PLAYED_SESSION = "此次在線時長"
L_STATS_ACC_PLAYED = "帳號啟用總時間"
L_STATS_PLAYED_TOTAL = "總在線時長"
L_STATS_QUEST = "任務"
L_STATS_QUESTS_TO = "任務/殺怪得到經驗值 %s"
L_STATS_CURRENT_XP = "目前/升級所需經驗值"
L_STATS_REMAINING_XP = "升級尚需經驗值"
L_STATS_RESTED_XP = "休息獎勵經驗值"
L_STATS_SERVER_GOLD = "帳號總現金"
L_STATS_SESSION_GAIN = "此次在線時段獲得/損失金額"
L_STATS_SESSION_XP = "此次在線時段所得經驗值"
L_STATS_SORTING_BY = "排列方式: "
L_STATS_SEALS = "本週已領徽印"
L_STATS_SPEC = "專精"
L_STATS_TIPS = "提示: "
L_STATS_OPEN_CALENDAR = "左鍵開/關行事曆"
L_STATS_RC_TIME_MANAGER = "右鍵開/關計時器"
L_STATS_TOGGLE_TIME = "當地/伺服器及24小時制可於計時器中設置"
L_STATS_MEMORY = "記憶體"
L_STATS_RC_COLLECTS_GARBAGE = "幀數模塊上滑鼠懸停顯示，右鍵整理記憶體"
L_STATS_VIEW_NOTES = "按住Alt鍵檢視: 好友的所在地 公會成員的階級/註記/幹部註記"
L_STATS_CHANGE_SORTING = "[公會]右鍵密語/邀請，中鍵更改排列方式，Shift+中鍵反轉排序"
L_STATS_OPEN_CHARACTER = "左鍵開/關角色界面"
L_STATS_RC_AUTO_REPAIRING1 = "右鍵開/關自動修裝"
L_STATS_RC_AUTO_REPAIRING2 = "中鍵開/關公會修裝"
L_STATS_EQUIPMENT_CHANGER = "Shift+左鍵或Alt+左鍵開啟套裝選單"
L_STATS_RC_EXPERIENCE = "右鍵切換在線時間/神器信息/經驗值/聲望值"
L_STATS_WATCH_FACTIONS = "左鍵開/關相關界面"
L_STATS_TOOLTIP_EXPERIENCE = "未達最高等級時將優先顯示經驗值訊息"
L_STATS_TOOLTIP_TIME_PLAYED = "達到最高等級後將優先顯示角色在線時間"
L_STATS_OPEN_TALENT = "左鍵開啟專精選單，Shift+左鍵開啟專精界面"
L_STATS_RC_TALENT = "右鍵開啟拾取專精選單"
L_STATS_LOCATION = "位置/座標"
L_STATS_WORLD_MAP = "點擊開/關世界地圖"
L_STATS_INSERTS_COORDS = "Shift+左鍵地名/座標自動複製到輸入框"
L_STATS_OPEN_CURRENCY = "左鍵開/關兌換通貨界面"
L_STATS_RC_AUTO_SELLING = "右鍵開/關自動販售"
L_STATS_NEED_TO_SELL = "鍵入 /junk 列出常用命令"
L_STATS_WATCH_CURRENCY = "在兌換通貨界面已選定的通貨將在金幣提示信息中顯示"
L_STATS_OTHER_OPTIONS = "其它選項可以在這裡設置: %s"

-- Slash commands
L_SLASHCMD_HELP = {
	"可用的命令: ",
	"/rl - 重載界面",
	"/rc - 準備確認",
	"/gm - 開啟GM界面",
	"/dis ADDON_NAME - 禁用指定插件",
	"/en ADDON_NAME - 開啟指定插件",
	"/rd - 解散隊伍",
	"/toraid - 轉換為隊伍/團隊",
	"/teleport - 傳出隨機副本",
	"/ss - 切換天賦",
	"/tt - 密語當前目標",
	"/heal - 載入HPS佈局",
	"/dps - 載入DPS佈局",
	"/farmmode - 開啟/關閉小地圖採集模式",
	"/resetui - 重置一般設置到預設值",
	"/resetuf - 重置頭像框架到預設位置",
	"/resetconfig - 重置ShestakUI_Config到預設值",
	"/resetstats - 重置所有角色遊戲時間和金幣的統計數據",
	"/settings - 設置指定插件",
	"/ls - 信息條功能說明",
	"/xct - 戰鬥信息選項",
	"/raidcd - 團隊技能冷卻測試模式",
	"/enemycd - 敵對技能冷卻測試模式",
	"/pulsecd - 技能冷卻閃爍測試模式",
	"/threat - 仇恨欄測試模式",
	"/testuf - 頭像框架測試模式",
	"/moveui - 解鎖/鎖定 界面中所有可移動的框體，Ctrl+右鍵選中的框架重置到預設位置", -- Need review
	"/cfg - 開啟ShestakUI設置界面",
}