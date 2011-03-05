----------------------------------------------------------------------------------------
--	Localization for zhCN client(Thanks to Ianchan, nanjiqq and Mania for the translation)
----------------------------------------------------------------------------------------
local T, C, L = unpack(select(2, ...))

if T.client == "zhCN" then
	-- Tooltip
	L_TOOLTIP_NO_TALENT = "没有天赋"
	L_TOOLTIP_LOADING = "读取中..."
	L_TOOLTIP_ACH_STATUS = "你的状态:"
	L_TOOLTIP_ACH_COMPLETE = "你的状态: 完成 "
	L_TOOLTIP_ACH_INCOMPLETE = "你的状态: 未完成"
	L_TOOLTIP_SPELL_ID = "法术ID:"
	L_TOOLTIP_ITEM_ID = "物品ID:"
	
	-- Raid Utility
	L_RAID_UTIL_DISBAND = "解散团队"
	
	-- Zone name
    L_ZONE_WINTERGRASP = "冬握湖"
	
	-- UnitFrame
	L_UF_GHOST = "灵魂"
	L_UF_DEAD = "死亡"
	L_UF_OFFLINE = "离线"
	L_UF_MANA = "低法力值"
	L_UF_TRINKET_READY = "饰品准备: "
	L_UF_TRINKET_USED = "饰品使用: "
	L_UF_WOTF_USED = "被遗忘者的意志使用: "
	
	-- Map
	L_MAP_CURSOR = "指针: "
	L_MAP_BOUNDS = "超出范围!"

	-- Minimap
	L_MINIMAP_CALENDAR = "日历"
	
	-- Addons list
	L_ALOAD_RL = "重新加载UI"
	L_ALOAD_TRADE = "贸易"
	L_ALOAD_SOLO = "独自"
	L_ALOAD_DEP = "Dependencies: " -- Needs review
	
	-- ShestakUI_Config
	L_GUI_MINIMAP_ICON_LM = "左键点击 -- 进入GUI设置"
	L_GUI_MINIMAP_ICON_RM = "右键点击 -- 显示下拉菜单"
	L_GUI_MINIMAP_ICON_SD = "Shift拖动 -- 改变图标位置"
	L_GUI_MINIMAP_ICON_SRM = "Shift+右键点击 -- 重新加载UI"
	L_GUI_MINIMAP_ICON_SLASH = "命令"
	L_GUI_MINIMAP_ICON_SPEC = "切换天赋"
	L_GUI_MINIMAP_ICON_CL = "修正战斗记录"
	L_GUI_MINIMAP_ICON_DBM = "DBM测试模式"
	L_GUI_MINIMAP_ICON_HEAL = "切换到heal_layout样式"
	L_GUI_MINIMAP_ICON_DPS = "切换到dps_layout样式"

	-- Chat
	L_CHAT_WHISPER = "From"
	L_CHAT_BN_WHISPER = "From"
	L_CHAT_AFK = "[AFK]"
	L_CHAT_DND = "[DND]"
	L_CHAT_GM = "[GM]"
	L_CHAT_GUILD = "公会"
	L_CHAT_PARTY = "小队"
	L_CHAT_PARTY_LEADER = "队长"
	L_CHAT_RAID	= "团队"
	L_CHAT_RAID_LEADER = "团长"
	L_CHAT_RAID_WARNING	= "团队警告"
	L_CHAT_BATTLEGROUND	= "战场"
	L_CHAT_BATTLEGROUND_LEADER = "战场领袖"
	L_CHAT_OFFICER = "官员"
	L_CHAT_COME_ONLINE = "上线了."
	L_CHAT_GONE_OFFLINE = "下线了."
	L_CHAT_COME_ONLINE_COLOR = "|cff298F00上线了|r !"
	L_CHAT_GONE_OFFLINE_COLOR = "|cffff0000下线了|r !"

	-- Errors frame
	L_ERRORFRAME_L = "点击查看错误."
	
	-- Bags
	L_BAG_BANK = "银行"
	L_BAG_NO_SLOTS = "不能再购买更多的背包栏位!"
	L_BAG_COSTS = "花费: %.2f 金"
	L_BAG_BUY_SLOTS = "输入 /bags purchase yes 以购买银行背包栏位"
	L_BAG_OPEN_BANK = "您需要先造访您的银行"
	L_BAG_SORT = "将背包或银行内的物品分类及排序"
	L_BAG_STACK = "将背包或银行内的不完整的物品堆叠重新堆叠"
	L_BAG_BUY_BANKS_SLOT = "购买银行背包栏位. (需要造访银行)"
	L_BAG_SORT_MENU = "分类及排序"
	L_BAG_SORT_SPECIAL = "分类及排序特殊物品"
	L_BAG_STACK_MENU = "堆叠"
	L_BAG_STACK_SPECIAL = "堆叠特殊物品"
	L_BAG_SHOW_BAGS = "显示背包"
	L_BAG_SORTING_BAGS = "分类及排序完成"
	L_BAG_NOTHING_SORT = "不需要分类"
	L_BAG_BAGS_BIDS = "使用背包: "
	L_BAG_STACK_END = "重新堆叠完成"
	L_BAG_RIGHT_CLICK_SEARCH = "点击右键以搜寻物品"
	
	-- Grab mail
	L_MAIL_STOPPED = "无法拾取, 背包已满."
	L_MAIL_COMPLETE = "完成."
	L_MAIL_NEED = "需要一个信箱."
	L_MAIL_MESSAGES =  "新邮件"
	
	-- Loot
	L_LOOT_RANDOM = "随机拾取"
	L_LOOT_SELF = "自由拾取"
	L_LOOT_UNKNOWN = "未知"
	L_LOOT_FISH = "钓鱼拾取"
	L_LOOT_MONSTER = ">> 拾取自 "
	L_LOOT_CHEST = ">> 拾取自宝箱"
	L_LOOT_ANNOUNCE = "向频道通告"
	L_LOOT_TO_RAID = "  团队"
	L_LOOT_TO_PARTY = "  队伍"
	L_LOOT_TO_GUILD = "  公会"
	L_LOOT_TO_SAY = "  说"
	L_LOOT_CANNOT = "不能拾取"

	-- LitePanels AFK module
	L_PANELS_AFK = "你处于暂离状态!"
	L_PANELS_AFK_RCLICK = "右键点击隐藏."
	L_PANELS_AFK_LCLICK = "左键点击返回."

	-- Cooldowns
	L_COOLDOWNS = "CD: "
	
	-- Autoinvite
	L_INVITE_ENABLE = "自动邀请功能已启用: "
	L_INVITE_DISABLE = "自动邀请功能已关闭"
	
	-- Bind key
	L_BIND_SAVED = "所有快捷键设置被保存."
	L_BIND_DISCARD = "所有新的快捷键设置被取消."
	L_BIND_INSTRUCT = "将鼠标悬停至任意动作条进行绑定.按ESC或者右键点击以清除当前动作条的按键绑定."
	L_BIND_CLEARED = "已经清楚所有快捷键设置."
	L_BIND_BINDING = "绑定"
	L_BIND_KEY = "按键"
	L_BIND_NO_SET = "没有绑定快捷键"
	
	-- Talent spec
	L_PLANNER_DEATHKNIGHT_1 = "鲜血"
	L_PLANNER_DEATHKNIGHT_2 = "冰霜"
	L_PLANNER_DEATHKNIGHT_3 = "邪恶"
	L_PLANNER_WARRIOR_1 = "武器"
	L_PLANNER_WARRIOR_2 = "狂怒"
	L_PLANNER_WARRIOR_3 = "防护"
	L_PLANNER_ROGUE_1 = "刺杀"
	L_PLANNER_ROGUE_2 = "战斗"
	L_PLANNER_ROGUE_3 = "敏锐"
	L_PLANNER_MAGE_1 = "奥术"
	L_PLANNER_MAGE_2 = "火焰"
	L_PLANNER_MAGE_3 = "冰霜"
	L_PLANNER_PRIEST_1 = "戒律"
	L_PLANNER_PRIEST_2 = "神圣"
	L_PLANNER_PRIEST_3 = "暗影"
	L_PLANNER_WARLOCK_1 = "痛苦"
	L_PLANNER_WARLOCK_2 = "恶魔学识"
	L_PLANNER_WARLOCK_3 = "毁灭"
	L_PLANNER_HUNTER_1 = "野兽掌握"
	L_PLANNER_HUNTER_2 = "射击"
	L_PLANNER_HUNTER_3 = "生存"
	L_PLANNER_DRUID_1 = "平衡"
	L_PLANNER_DRUID_2 = "野性战斗"
	L_PLANNER_DRUID_3 = "恢复"
	L_PLANNER_SHAMAN_1 = "元素战斗"
	L_PLANNER_SHAMAN_2 = "增强"
	L_PLANNER_SHAMAN_3 = "恢复"
	L_PLANNER_PALADIN_1 = "神圣"
	L_PLANNER_PALADIN_2 = "防护"
	L_PLANNER_PALADIN_3 = "惩戒"
	
	-- BG stats
	L_DATATEXT_BASESASSAULTED = "基地突袭:" 
	L_DATATEXT_BASESDEFENDED = "基地防御:" 
	L_DATATEXT_TOWERSASSAULTED = "哨塔突袭:" 
	L_DATATEXT_TOWERSDEFENDED = "哨塔防御:" 
	L_DATATEXT_FLAGSCAPTURED = "占领旗帜:" 
	L_DATATEXT_FLAGSRETURNED = "交还旗帜:" 
	L_DATATEXT_GRAVEYARDSASSAULTED = "墓地突袭:" 
	L_DATATEXT_GRAVEYARDSDEFENDED = "墓地防守:" 
	L_DATATEXT_DEMOLISHERSDESTROYED = "石毁车摧毁:" 
	L_DATATEXT_GATESDESTROYED = "大门摧毁:"
	L_DATATEXT_CONTROL = " under control:"  -- Needs review
	
	-- Class script
	L_CLASS_HUNTER_UNHAPPY = "你的宠物感到不高兴!"
	L_CLASS_HUNTER_CONTENT = "你的宠物感到满足!"
	L_CLASS_HUNTER_HAPPY = "你的宠物感到高兴!"
	
	-- Info text
	L_INFO_ERRORS = "目前没有错误."
	L_INFO_INVITE = "接受邀请: "
	L_INFO_DUEL = "拒绝决斗请求: "
	L_INFO_DISBAND = "解散团队..."
	L_INFO_ADDON_SETS1 = "键入 /addons <solo/party/raid/pvp/trade/quest>, 载入预设的设定."
	L_INFO_ADDON_SETS2 = "你可以通过编辑`scripts`文件夹的wtf.lua 进行添加,刪除和更改设置."
	L_INFO_SETTINGS_DBM = "键入 /settings dbm, 载入 DBM 的设定."
	L_INFO_SETTINGS_MSBT = "键入 /settings msbt, 载入 MSBT 的设定."
	L_INFO_SETTINGS_SKADA = "键入 /settings skada, 载入 Skada 的设定."
	L_INFO_SETTINGS_RECOUNT = "键入 /settings recount, 载入 Reount 的设定."
	L_INFO_SETTINGS_DXE = "键入 /settings dxe, 载入 DXE 的设定."
	L_INFO_SETTINGS_ALL = "键入 /settings all, 载入所有UI设定."
	
	-- Popups
	L_POPUP_INSTALLUI = "该角色首次使用ShestakUI.你必须重新加载UI来配置."
	L_POPUP_RESETUI = "你确定要重新加载ShestakUI?"
	L_POPUP_RESETSTATS = "Are you sure you want to reset statistics for time spent in game and gold."  -- Needs review
	L_POPUP_SWITCH_RAID = "多个团队样式被加载,请选择一个样式."
	L_POPUP_DISBAND_RAID = "你确定要解散团队?"
	L_POPUP_DISABLEUI = "ShestakUI并不支援此分辨率, 你想要停用ShestakUI吗? (若果您想要尝试其他分辨率, 请按取消)"
	L_POPUP_SETTINGS_ALL = "应用所有的插件设置? (DBM/DXE, Skada/Recount and MSBT)"
	L_POPUP_SETTINGS_DBM = "需要改变DBM描点及风格化元素."
	L_POPUP_SETTINGS_BW = "需要改变BigWigs描点及风格化元素."
	L_POPUP_SETTINGS_CLIQUE = "你的Clique设置没有正确安装,现在应用Clique设置?"  -- Needs review
	
	-- Welcome message
	L_WELCOME_LINE_1 = "欢迎使用ShestakUI "
	L_WELCOME_LINE_2_1 = "输入/cfg进行插件设置,或者访问http://shestak.org"
	L_WELCOME_LINE_2_2 = "得到更多信息."
	
	-- Combat text
	L_COMBATTEXT_KILLING_BLOW = "Killing Blow"  -- Needs review
	L_COMBATTEXT_ALREADY_UNLOCKED = "Combat text already unlocked."  -- Needs review
	L_COMBATTEXT_ALREADY_LOCKED = "Combat text already locked."  -- Needs review
	L_COMBATTEXT_TEST_DISABLED = "Combat text test mode disabled."  -- Needs review
	L_COMBATTEXT_TEST_ENABLED = "Combat text test mode enabled."  -- Needs review
	L_COMBATTEXT_TEST_USE_UNLOCK = "Type /xct unlock to move and resize combat text frames."  -- Needs review
	L_COMBATTEXT_TEST_USE_LOCK = "Type /xct lock to lock combat text frames."  -- Needs review
	L_COMBATTEXT_TEST_USE_TEST = "Type /xct test to toggle combat text testmode."  -- Needs review
	L_COMBATTEXT_POPUP = "To save combat text window positions you need to reload your UI."  -- Needs review
	L_COMBATTEXT_UNSAVED = "Combat text window positions unsaved, don't forget to reload UI."  -- Needs review
	L_COMBATTEXT_UNLOCKED = "Combat text unlocked."  -- Needs review
end