local T, C, L, _ = unpack(select(2, ...))
if T.client ~= "zhCN" then return end

----------------------------------------------------------------------------------------
--	Localization for zhCN client
--	Translation: Ianchan, Mania, Nanjiqq, Tat2dawn
----------------------------------------------------------------------------------------
-- Announce your Lightwell
L_ANNOUNCE_LA_USE = " 使用我的光束泉. "
L_ANNOUNCE_LA_CHARGE = " 刷新)"
L_ANNOUNCE_LA_USELESS = " 尽量少地使用我的光束泉. "
L_ANNOUNCE_LA_PLACED = "光束泉位置. "
L_ANNOUNCE_LA_CHARGES = " 刷新."

-- Announce flasks and food
L_ANNOUNCE_FF_NOFOOD = "缺少食物Buff: "
L_ANNOUNCE_FF_NOFLASK = "缺少合剂: "
L_ANNOUNCE_FF_ALLBUFFED = "已获得所有增益!"
L_ANNOUNCE_FF_CHECK_BUTTON = "检查食物和合剂"

-- Says thanks for some spells
L_ANNOUNCE_SS_THANKS = "谢谢你的 "
L_ANNOUNCE_SS_RECEIVED = " 收到来自于 "

-- Pull countdown announce
L_ANNOUNCE_PC_GO = "开始!"
L_ANNOUNCE_PC_MSG = "正在拉: %s,倒數 %s.."
L_ANNOUNCE_PC_ABORTED = "取消拉怪!"

-- Announce feasts and portals
L_ANNOUNCE_FP_STAT = "%s 放置了 %s - [%s]."
L_ANNOUNCE_FP_PRE = "%s 放置了 %s"
L_ANNOUNCE_FP_PUT = "%s 放置了 %s"
L_ANNOUNCE_FP_CAST = "%s 开启了 %s"
L_ANNOUNCE_FP_CLICK = "%s 正在开启 %s... 请点击！"
L_ANNOUNCE_FP_USE = "%s 使用了一个 %s."

-- Announce your interrupts
L_ANNOUNCE_INTERRUPTED = "已打断"

-- Tooltip
L_TOOLTIP_NO_TALENT = "没有天赋"
L_TOOLTIP_LOADING = "读取中..."
L_TOOLTIP_ACH_STATUS = "你的状态:"
L_TOOLTIP_ACH_COMPLETE = "你的状态: 完成 "
L_TOOLTIP_ACH_INCOMPLETE = "你的状态: 未完成"
L_TOOLTIP_SPELL_ID = "法术ID:"
L_TOOLTIP_ITEM_ID = "物品ID:"
L_TOOLTIP_WHO_TARGET = "以其为目标的"
L_TOOLTIP_ITEM_COUNT = "物品数量:"
L_TOOLTIP_INSPECT_OPEN = "检查框体已打开"

-- Misc
L_MISC_UNDRESS = "无装备"
L_MISC_DRINKING = " 开始进食."
L_MISC_BUY_STACK = "Alt+右键点击购买一叠"
L_MISC_ONECLICK_BUYOUT = "Shift+右键,不弹出确认框体直接购买"
L_MISC_ONECLICK_BID = "Shift+右鍵,不弹出确认框体直接竞标"
L_MISC_ONECLICK_CANCEL = "Shift+右键,不弹出确认框体直接取消选择的物品"
L_MISC_UI_OUTDATED = "ShestakUI 版本已过期，请至 www.shestak.org 下载最新版"
L_MISC_HEADER_MARK = "鼠标悬停显示团队图标"
L_MISC_BINDER_OPEN = "鼠标绑定"
L_MISC_GROCERY_BUY = "购买"
L_MISC_GROCERY_DESC = "自动购买杂货包"
L_MISC_SCROLL = "附魔卷轴"

-- Raid Utility
L_RAID_UTIL_DISBAND = "解散团队"

-- Zone name
L_ZONE_WINTERGRASP = "冬拥湖"
L_ZONE_TOLBARAD = "托尔巴拉德"
L_ZONE_TOLBARADPEN = "托尔巴拉德半岛"
L_ZONE_ARATHIBASIN = "阿拉希盆地"
L_ZONE_GILNEAS = "吉尔尼斯之战"

-- WatchFrame Wowhead link
L_WATCH_WOWHEAD_LINK = "Wowhead链接"

-- Toggle Menu
L_TOGGLE_ADDON = "插件 "
L_TOGGLE_ADDONS = " 插件系列"
L_TOGGLE_EXPAND = "展开 "
L_TOGGLE_COLLAPSE = "折叠 "
L_TOGGLE_RCLICK = "右键点击以启用或禁用 "
L_TOGGLE_LCLICK = "左键点击来显示/隐藏窗口 "
L_TOGGLE_RELOAD = " (需要重载插件)"
L_TOGGLE_NOT_FOUND = " 未创建."

-- UnitFrame
L_UF_GHOST = "灵魂"
L_UF_DEAD = "死亡"
L_UF_OFFLINE = "离线"
L_UF_MANA = "低法力值"

-- Map
L_MAP_CURSOR = "指针: "
L_MAP_BOUNDS = "超出范围!"
L_MAP_FOG = "地图全亮"

-- Minimap
L_MINIMAP_CALENDAR = "日历"
L_MINIMAP_HEAL_LAYOUT = "左鍵单击 - 治疗模式团队框架"
L_MINIMAP_DPS_LAYOUT = "右键单击 - 输出模式团队框架"
L_MINIMAP_BLIZZ_LAYOUT = "鼠标中键 - 默认暴雪模式团队框架"

-- Chat
L_CHAT_WHISPER = "From"
L_CHAT_BN_WHISPER = "From"
L_CHAT_AFK = "[AFK]"
L_CHAT_DND = "[DND]"
L_CHAT_GM = "[GM]"
L_CHAT_GUILD = "公会"
L_CHAT_PARTY = "小队"
L_CHAT_PARTY_LEADER = "队长"
L_CHAT_RAID = "团队"
L_CHAT_RAID_LEADER = "团长"
L_CHAT_RAID_WARNING = "团队警告"
L_CHAT_INSTANCE_CHAT = "副本"
L_CHAT_INSTANCE_CHAT_LEADER = "副本领袖"
L_CHAT_OFFICER = "官员"
L_CHAT_PET_BATTLE = "宠物对战"
L_CHAT_COME_ONLINE = "|cff298F00上线了|r。"
L_CHAT_GONE_OFFLINE = "|cffff0000下线了|r。"

-- Errors frame
L_ERRORFRAME_L = "点击查看错误."

-- Bags
L_BAG_SHOW_BAGS = "显示背包"
L_BAG_RIGHT_CLICK_SEARCH = "点击右键以搜寻物品"

-- Grab mail
L_MAIL_STOPPED = "无法拾取, 背包已满."
L_MAIL_UNIQUE = "中止,在背包或银行发现重复的唯一物品."
L_MAIL_COMPLETE = "完成."
L_MAIL_NEED = "需要一个信箱."
L_MAIL_MESSAGES = "新邮件"

-- Loot
L_LOOT_RANDOM = "随机拾取"
L_LOOT_SELF = "自由拾取"
L_LOOT_FISH = "钓鱼拾取"
L_LOOT_ANNOUNCE = "向频道通告"
L_LOOT_TO_RAID = "  团队"
L_LOOT_TO_PARTY = "  队伍"
L_LOOT_TO_GUILD = "  公会"
L_LOOT_TO_SAY = "  说"

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
L_PLANNER_DRUID_4 = "恢复"
L_PLANNER_MONK_2 = "织雾"
L_PLANNER_PALADIN_1 = "神圣"
L_PLANNER_PRIEST_1 = "戒律"

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
L_DATATEXT_ORB_POSSESSIONS = "已占领的Orb:"
L_DATATEXT_VICTORY_POINTS = "胜利点数："
L_DATATEXT_CARTS_CONTROLLED = "车辆控制："

-- Info text
L_INFO_ERRORS = "目前没有错误."
L_INFO_INVITE = "接受邀请 "
L_INFO_DUEL = "拒绝决斗请求 "
L_INFO_PET_DUEL = "拒绝宠物对战请求 "
L_INFO_DISBAND = "解散团队..."
L_INFO_SETTINGS_DBM = "键入 /settings dbm, 载入 DBM 的设定."
L_INFO_SETTINGS_DXE = "键入 /settings dxe, 载入 DXE 的设定."
L_INFO_SETTINGS_MSBT = "键入 /settings msbt, 载入 MSBT 的设定."
L_INFO_SETTINGS_SKADA = "键入 /settings skada, 载入 Skada 的设定."
L_INFO_SETTINGS_ALL = "键入 /settings all, 载入所有UI设定."
L_INFO_NOT_INSTALLED = " 没有安装."
L_INFO_SKIN_DISABLED1 = "介面样式启用 "
L_INFO_SKIN_DISABLED2 = " 已禁用."

-- Popups
L_POPUP_INSTALLUI = "该角色首次使用ShestakUI.你必须重新加载UI来配置."
L_POPUP_RESETUI = "你确定要重新加载ShestakUI?"
L_POPUP_RESETSTATS = "你确定要重置本次游戏时间和金币收益统计数据吗?"
L_POPUP_SWITCH_RAID = "Select Raid layout."
L_POPUP_DISBAND_RAID = "你确定要解散团队?"
L_POPUP_DISABLEUI = "ShestakUI并不支援此分辨率, 你想要停用ShestakUI吗? (若果您想要尝试其他分辨率, 请按取消)"
L_POPUP_SETTINGS_ALL = "应用所有的插件设置? (DBM/DXE, Skada and MSBT)"
L_POPUP_SETTINGS_DBM = "需要改变DBM描点及风格化元素."
L_POPUP_SETTINGS_DXE = "需要改变DXE描点及风格化元素."
L_POPUP_SETTINGS_BW = "需要改变BigWigs描点及风格化元素."
L_POPUP_ARMORY = "英雄榜"
L_POPUP_CURRENCY_CAP = "你拥有的最高级货币为"

-- Welcome message
L_WELCOME_LINE_1 = "欢迎使用ShestakUI "
L_WELCOME_LINE_2_1 = "输入/cfg进行插件设置,或者访问http://shestak.org"
L_WELCOME_LINE_2_2 = "得到更多信息."

-- Combat text
L_COMBATTEXT_KILLING_BLOW = "最后一击"
L_COMBATTEXT_ALREADY_UNLOCKED = "战斗信息已经解锁."
L_COMBATTEXT_ALREADY_LOCKED = "战斗信息已经锁定."
L_COMBATTEXT_TEST_DISABLED = "战斗信息测试模式已禁用."
L_COMBATTEXT_TEST_ENABLED = "战斗信息测试模式已启用."
L_COMBATTEXT_TEST_USE_UNLOCK = "输入 /xct unlock 来移动或调整战斗信息框架大小."
L_COMBATTEXT_TEST_USE_LOCK = "输入 /xct lock 来锁定战斗信息框架."
L_COMBATTEXT_TEST_USE_TEST = "输入 /xct test 来启用或禁用战斗信息测试模式."
L_COMBATTEXT_POPUP = "要保存战斗信息窗口的位置你需要重新载入插件."
L_COMBATTEXT_UNSAVED = "战斗信息窗口位置尚未保存,不要忘记重新载入插件."
L_COMBATTEXT_UNLOCKED = "战斗信息已解锁."

-- LiteStats
L_STATS_ACC_PLAYED = "帐号启用总时间"
L_STATS_ADDED_JUNK = "增加自动出售例外名单"
L_STATS_REMOVE_EXCEPTION = "新增/移除例外名单"
L_STATS_AUTO_REPAIR = "自动修装"
L_STATS_GUILD_REPAIR = "公会银行修理"
L_STATS_AUTO_SELL = "自动出售灰色物品"
L_STATS_BANDWIDTH = "宽带占用:"
L_STATS_DOWNLOAD = "下载:"
L_STATS_CLEARED_JUNK = "清除自动出售例外名单列表"
L_STATS_CLEAR_EXCEPTIONS = "清除例外名单列表"
L_STATS_WORLD_MAP = "点击开启世界地图"
L_STATS_CURRENT_XP = "目前/升级所需经验值"
L_STATS_MEMORY_USAGE = "暴雪插件内存占用量:"
L_STATS_GARBAGE_COLLECTED = "垃圾资源清除"
L_STATS_CHANGE_SORTING = "[公会]右键更改排列方式,Shift+右键反转排列方式"
L_STATS_HIDDEN = "隐藏"
L_STATS_VIEW_NOTES = "按住Alt键检视公会成员会阶.注记.干部注记"
L_STATS_HR = "小时"
L_STATS_INF = "无限"
L_STATS_ALREADY_EXCEPTIONS = "物品已在例外名单列表"
L_STATS_NOT_JUNK = "非自动出售物品"
L_STATS_ITEMLINK = "物品链结"
L_STATS_JUNK_EXCEPTIONS = "自动出售例外名单"
L_STATS_JUNK_LIST = "自动出售列表"
L_STATS_JUNK_PROFIT = "自动出售所得金额"
L_STATS_KILLS = "击杀"
L_STATS_OPEN_CALENDAR = "左键开启行事历"
L_STATS_OPEN_CHARACTER = "左键开启人物栏"
L_STATS_OPEN_CURRENCY = "左键单击打开货币面板."
L_STATS_OPEN_TALENT = "左键开启天赋视窗"
L_STATS_XP_RATE = "当前等级经验值百分比"
L_STATS_IGNORED_ITEMS = "列出目前忽略物品"
L_STATS_TOGGLE_TIME = "当地/服务器及24小时制可显示于时间管理器"
L_STATS_LOCATION = "位置/座标"
L_STATS_MEMORY = "内存"
L_STATS_ON = "启用"
L_STATS_OTHER_OPTIONS = "其它选项可能配置在%s"
L_STATS_PLAYED_LEVEL = "当前等级总上线时间"
L_STATS_PLAYED_SESSION = "此次上线时段耗费时间"
L_STATS_PLAYED_TOTAL = "总上线时间"
L_STATS_QUEST = "任务"
L_STATS_QUESTS_TO = "任务/杀怪得到经验值%s"
L_STATS_REMAINING_XP = "升级尚需经验值"
L_STATS_REMOVED_JUNK = "移除自动出售例外名单"
L_STATS_RESTED_XP = "休息奖励经验值"
L_STATS_RC_COLLECTS_GARBAGE = "右键点击清除插件垃圾资源"
L_STATS_RC_TIME_MANAGER = "右键开启时间管理器"
L_STATS_RC_EXPERIENCE = "右键切换显示经验值.上线时间.角色资讯"
L_STATS_RC_AUTO_REPAIRING = "右键显示自动修装"
L_STATS_RC_AUTO_SELLING = "右键开启自动出售"
L_STATS_RC_TALENT = "右键切换天赋"
L_STATS_SERVER_GOLD = "帐号总现金"
L_STATS_SESSION_GAIN = "此次上线时段所得/损失现金"
L_STATS_SESSION_XP = "此次上线时段所得经验值"
L_STATS_INSERTS_COORDS = "Shift+点击地名或座标可在对话视窗发布你所在座标"
L_STATS_EQUIPMENT_CHANGER = "左键或中键开启装备管理员"
L_STATS_SORTING_BY = "依...排列"
L_STATS_TIPS = "提示:"
L_STATS_TOTAL_MEMORY_USAGE = "全部资源耗用:"
L_STATS_NOT_TO_SELL = "输入/junk设定自动出售例外名单"
L_STATS_WATCH_CURRENCY = "在货币面板选定的项目将在鼠标提示中显示."
L_STATS_WATCH_FACTIONS = "从角色人物介面观看资讯"
L_STATS_TOOLTIP_TIME_PLAYED = "达到最高等级后,提示将显示角色上线时间纪录"
L_STATS_TOOLTIP_EXPERIENCE = "未达最高等级时,提示将显示经验值讯息"

-- Slash commands
L_SLASHCMD_HELP = {
	"Available slash commands:", -- Needs review
	"/rl - 重载界面.",
	"/rc - 就位确认.",
	"/gm - 打开GM面板.",
	"/dis ADDON_NAME - 禁用 插件名.",
	"/en ADDON_NAME - 启用 插件名.",
	"/rd - 解散队伍.",
	"/toraid - 转换队伍/团队.",
	"/teleport - 传送随机副本.",
	"/spec - 切换天赋.",
	"/heal - 载入治疗模式界面.",
	"/dps - 载入伤害输出模式界面.",
	"/frame - 在聊天窗口输出当前鼠标下的框体的名字.",
	"/farmmode - 打开小地图的采集模式(小地图框体放大).",
	"/moveui - 解锁/锁定 界面中所有可以移动的框体.",
	"/resetui - 恢复界面到原始设定值.",
	"/resetuf - 恢复头像框体到原始设定值.",
	"/resetconfig - 恢复界面设置到原始设定值.",
	"/resetstats - 恢复人物属性面板设置到原始设定值.",
	"/settings ADDON_NAME - 设置 插件名.",
	"/ls - 载入设置.",
	"/xct - 战斗文字选项.",
	"/raidcd - 团队技能冷却监视条.",
	"/enemycd - 敌对技能冷却监视.",
	"/pulsecd - 自身技能冷却监视+警告提醒.",
	"/threat - 仇恨条.",
	"/tt - 密语当前目标.",
	"/ainv - 自动接受 公会+好友 组队邀请.",
	"/testuf - 测试头像面板.",
	"/cfg - 打开shestakui设置界面.",
}

-- ExploreMap
L_EXTRA_EXPLORED = "探索: "
L_EXTRA_ZONEACHID = {
	-- http://www.wowhead.com/achievement=*
	-- e(X)plore achievement id, (Q)uest achievement id
	["东部王国"]							= {X =   42, A =    0, H =    0},
	["卡利姆多"]							= {X =   43, A =    0, H =    0},
	["外域"]							= {X =   44, A =    0, H =    0},
	["诺森德"]							= {X =   45, A =    0, H =    0},
	["世界地图"]							= {X =  nil, A =    0, H =    0},
	["潘达利亚"]							= {X = 6974, A =    0, H =    0},
	-- Eastern Kingdoms
	["阿拉希高地"]						= {X =  761, A = 4896, H = 4896},
	["荒芜之地"]							= {X =  765, A = 4900, H = 4900},
	["诅咒之地"]							= {X =  766, A = 4909, H = 4909},
	["燃烧平原"]							= {X =  775, A = 4901, H = 4901},
	["逆风小径"]							= {X =  777, A =    0, H =    0},
	["丹莫罗"]							= {X =  627, A =    0, H =    0},
	["暮色森林"]							= {X =  778, A = 4903, H =    0},
	["东瘟疫之地"]						= {X =  771, A = 4892, H = 4892},
	["艾尔文森林"]						= {X =  776, A =    0, H =    0},
	["永歌森林"]							= {X =  859, A =    0, H =    0},
	["幽魂之地"]							= {X =  858, A =    0, H = 4908},
	["希尔斯布莱德丘陵"]					= {X =  772, A =    0, H = 4895},
	["洛克莫丹"]							= {X =  779, A = 4899, H =    0},
	["北荆棘谷"]							= {X =  781, A = 4906, H = 4906},
	["赤脊山"]							= {X =  780, A = 4902, H =    0},
	["灼热峡谷"]							= {X =  774, A = 4910, H = 4910},
	["银松森林"]							= {X =  769, A =    0, H = 4894},
	["悲伤沼泽"]							= {X =  782, A = 4904, H = 4904},
	["荆棘谷海角"]						= {X = 4995, A = 4905, H = 4905},
	["辛特兰"]							= {X =  773, A = 4897, H = 4897},
	["提瑞斯法林地"]						= {X =  768, A =    0, H =    0},
	["西瘟疫之地"]						= {X =  770, A = 4893, H = 4893},
	["西部荒野"]							= {X =  802, A = 4903, H =    0},
	["湿地"]							= {X =  841, A = 4899, H =    0},
	-- Kalimdor
	["灰谷"]							= {X =  845, A = 4925, H = 4976},
	["艾萨拉"]							= {X =  852, A =    0, H = 4927},
	["秘蓝岛"]							= {X =  860, A =    0, H =    0},
	["秘血岛"]							= {X =  861, A = 4926, H = 4926},
	["黑海岸"]							= {X =  844, A = 4928, H = 4928},
	["凄凉之地"]							= {X =  848, A = 4930, H = 4930},
	["杜隆塔尔"]							= {X =  728, A =    0, H =    0},
	["尘泥沼泽"]							= {X =  850, A = 4929, H = 4978},
	["费伍德森林"]						= {X =  853, A = 4931, H = 4931},
	["菲拉斯"]							= {X =  849, A = 4932, H = 4979},
	["月光林地"]							= {X =  855, A =    0, H =    0},
	["莫高雷"]							= {X =  736, A =    0, H =    0},
	["北贫瘠之地"]						= {X =  750, A =    0, H = 4933},
	["希利苏斯"]							= {X =  856, A = 4934, H = 4934},
	["南贫瘠之地"]						= {X = 4996, A = 4937, H = 4981},
	["石爪山脉"]							= {X =  847, A = 4936, H = 4980},
	["塔纳利斯"]							= {X =  851, A = 4935, H = 4935},
	["泰达希尔"]							= {X =  842, A =    0, H =    0},
	["千针石林"]							= {X =  846, A = 4938, H = 4938},
	["安戈洛环形山"]						= {X =  854, A = 4939, H = 4939},
	["冬泉谷"]							= {X =  857, A = 4940, H = 4940},
	-- Outland
	["刀锋山"]							= {X =  865, A = 1193, H = 1193},
	["地狱火半岛"]						= {X =  862, A = 1189, H = 1271},
	["纳格兰"]							= {X =  866, A = 1192, H = 1273},
	["虚空风暴"]							= {X =  843, A = 1194, H = 1194},
	["影月谷"]							= {X =  864, A = 1195, H = 1195},
	["泰罗卡森林"]						= {X =  867, A = 1191, H = 1272},
	["赞加沼泽"]							= {X =  863, A = 1190, H = 1190},
	-- Northrend
	["北风苔原"]							= {X = 1264, A =   33, H = 1358},
	["晶歌森林"]							= {X = 1457, A =    0, H =    0},
	["龙骨荒野"]							= {X = 1265, A =   35, H = 1356},
	["灰熊丘陵"]							= {X = 1266, A =   37, H = 1357},
	["嚎风峡湾"]							= {X = 1263, A =   34, H = 1356},
	["冰冠冰川"]					 		= {X = 1270, A =   40, H =   40},
	["索拉查盆地"]						= {X = 1268, A =   39, H =   39},
	["风暴峭壁"]							= {X = 1269, A =   38, H =   38},
	["祖达克"]							= {X = 1267, A =   36, H =   36},
	-- Cataclysm
	["深岩之洲"]							= {X = 4864, A = 4871, H = 4871},
	["海加尔"]							= {X = 4863, A = 4870, H = 4870},
	["暮光高地"]							= {X = 4866, A = 4873, H = 5501},
	["奥丹姆"]							= {X = 4865, A = 4872, H = 4872},
	["瓦丝琪尔"]							= {X = 4825, A = 4869, H = 4982},
	["托尔巴拉德"]						= {X =    0, A = 4874, H = 4874},
	["托尔巴拉德半岛"]					= {X =    0, A = 4874, H = 4874},
	-- Pandaria
	["翡翠林"]							= {X = 6351, A = 6300, H = 6534},
	["四风谷"]							= {X = 6969, A = 6301, H = 6301},
	["昆莱山"]							= {X = 6976, A = 6537, H = 6538},
	["螳螂高原"]							= {X = 6977, A = 6539, H = 6539},
	["恐惧废土"]							= {X = 6978, A = 6540, H = 6540},
	["锦绣谷"]							= {X = 6979, A =    0, H =    0},
	-- Boolean Explores
	["奎尔丹纳斯岛"]						= {X =  868, A =    0, H =    0},
	["安其拉：堕落王国"]					= {X =    0, A =    0, H =    0},
	["冬拥湖"]							= {X =    0, A =    0, H =    0},
}
