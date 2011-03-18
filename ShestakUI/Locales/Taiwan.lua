local T, C, L = unpack(select(2, ...))
if not (T.client == "zhTW") then return end

----------------------------------------------------------------------------------------
--	Localization for zhTW client(Thanks to Ianchan, Aelb, nanjiqq, Spacedragon and Mania for the translation)
----------------------------------------------------------------------------------------
-- Tooltip
L_TOOLTIP_NO_TALENT = "沒有天賦"
L_TOOLTIP_LOADING = "讀取中..."
L_TOOLTIP_ACH_STATUS = "你的狀態:"
L_TOOLTIP_ACH_COMPLETE = "你的狀態: 完成 "
L_TOOLTIP_ACH_INCOMPLETE = "你的狀態: 未完成"
L_TOOLTIP_SPELL_ID = "法術ID:"
L_TOOLTIP_ITEM_ID = "物品ID:"
L_TOOLTIP_WHO_TARGET = "Targeted By" -- Needs review

-- Raid Utility
L_RAID_UTIL_DISBAND = "解散團隊"

-- Zone name
L_ZONE_WINTERGRASP = "冬握湖"

-- WatchFrame Wowhead link
L_WATCH_WOWHEAD_LINK = "Wowhead link" -- Needs review

-- Toogle Menu
L_TOGGLE_ADDON = "Addon " -- Needs review
L_TOGGLE_ADDONS = " addons" -- Needs review
L_TOGGLE_EXPAND = "Expand " -- Needs review
L_TOGGLE_COLLAPSE = "Collapse " -- Needs review
L_TOGGLE_RCLICK = "Right click to enable or disable " -- Needs review
L_TOGGLE_LCLICK = "Left click to toggle window " -- Needs review
L_TOGGLE_RELOAD = " (needs UI reload)" -- Needs review

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
L_ALOAD_TRADE = "經商"
L_ALOAD_SOLO = "獨自"
L_ALOAD_DEP = "依賴: "

-- Chat
L_CHAT_WHISPER = "From"
L_CHAT_BN_WHISPER = "From"
L_CHAT_AFK = "[AFK]"
L_CHAT_DND = "[DND]"
L_CHAT_GM = "[GM]"
L_CHAT_GUILD = "公會"
L_CHAT_PARTY = "小隊"
L_CHAT_PARTY_LEADER = "隊長"
L_CHAT_RAID	= "團隊"
L_CHAT_RAID_LEADER = "團長"
L_CHAT_RAID_WARNING	= "團隊警告"
L_CHAT_BATTLEGROUND	= "戰場"
L_CHAT_BATTLEGROUND_LEADER = "戰場領袖"
L_CHAT_OFFICER = "官員"
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
L_MAIL_COMPLETE = "完成."
L_MAIL_NEED = "需要一個信箱."
L_MAIL_MESSAGES =  "新郵件"

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

-- Class script
L_CLASS_HUNTER_UNHAPPY = "你的寵物感到不高興!"
L_CLASS_HUNTER_CONTENT = "你的寵物感到滿足!"
L_CLASS_HUNTER_HAPPY = "你的寵物感到高興!"

-- Info text
L_INFO_ERRORS = "目前沒有錯誤."
L_INFO_INVITE = "接受邀請自: "
L_INFO_DUEL = "拒絕決鬥請求: "
L_INFO_DISBAND = "解散隊伍..."
L_INFO_ADDON_SETS1 = "鍵入 /addons <solo/party/raid/pvp/trade/quest>, 載入預設的UI設定."
L_INFO_ADDON_SETS2 = "你可以通過編輯`scripts`資料夾的wtf.lua 以添加,刪除或改變設置."
L_INFO_SETTINGS_DBM = "鍵入 /settings dbm, 載入 DBM 的設定."
L_INFO_SETTINGS_MSBT = "鍵入 /settings msbt, 載入 MSBT 的設定."
L_INFO_SETTINGS_SKADA = "鍵入 /settings skada, 載入 Skada 的設定."
L_INFO_SETTINGS_RECOUNT = "鍵入 /settings recount, 載入 Reount 的設定."
L_INFO_SETTINGS_DXE = "鍵入 /settings dxe, 載入 DXE 的設定."
L_INFO_SETTINGS_ALL = "鍵入 /settings all, 載入所有UI設定."

-- Popups
L_POPUP_INSTALLUI = "該角色首次使用ShestakUI.你必須重新加載UI來配置."
L_POPUP_RESETUI = "你確定要重新加載ShestakUI?"
L_POPUP_RESETSTATS = "Are you sure you want to reset statistics for time spent in game and gold." -- Needs review
L_POPUP_SWITCH_RAID = "多個團隊樣式被加載,請選擇一個樣式."
L_POPUP_DISBAND_RAID = "你確定要解散團隊?"
L_POPUP_DISABLEUI = "ShestakUI並不支援此解析度, 你想要停用ShestakUI嗎? (若果您想要嘗試其他解析度, 請按取消)"
L_POPUP_SETTINGS_ALL = "應用所有的UI設置? (DBM/DXE, Skada/Recount and MSBT)"
L_POPUP_SETTINGS_DBM = "需要改變DBM描點及風格化元素。"
L_POPUP_SETTINGS_BW = "需要改變BigWigs描點及風格化元素。"
L_POPUP_SETTINGS_CLIQUE = "你的Clique設置沒有正確安裝，現在應用Clique設置?"

-- Welcome message
L_WELCOME_LINE_1 = "歡迎使用ShestakUI "
L_WELCOME_LINE_2_1 = "輸入/cfg進行UI設置,或者訪問http://shestak.org"
L_WELCOME_LINE_2_2 = "得到更多信息."

-- Combat text
L_COMBATTEXT_KILLING_BLOW = "擊殺信息"
L_COMBATTEXT_ALREADY_UNLOCKED = "戰鬥記錄已經解鎖."
L_COMBATTEXT_ALREADY_LOCKED = "戰鬥記錄已經鎖定."
L_COMBATTEXT_TEST_DISABLED = "戰鬥記錄測試模式關閉."
L_COMBATTEXT_TEST_ENABLED = "戰鬥記錄測試模式開啟." 
L_COMBATTEXT_TEST_USE_UNLOCK = "輸入/xct unlock解鎖並調整戰鬥記錄大小與位置."
L_COMBATTEXT_TEST_USE_LOCK = "輸入/xct lock鎖定戰鬥記錄框體."
L_COMBATTEXT_TEST_USE_TEST = "輸入/xct test 切換測試模式."
L_COMBATTEXT_POPUP = "保存戰鬥記錄位置需要重載."
L_COMBATTEXT_UNSAVED = "Combat text window positions unsaved, don't forget to reload UI." -- Needs review
L_COMBATTEXT_UNLOCKED = "戰鬥記錄解鎖."