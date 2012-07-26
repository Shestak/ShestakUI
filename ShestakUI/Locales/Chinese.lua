local T, C, L = unpack(select(2, ...))
if T.client ~= "zhCN" then return end

----------------------------------------------------------------------------------------
--	Localization for zhCN client(Thanks to Ianchan, nanjiqq, Mania and tat2dawn for the translation)
----------------------------------------------------------------------------------------
-- Tooltip
L_TOOLTIP_NO_TALENT = "没有天赋"
L_TOOLTIP_LOADING = "读取中..."
L_TOOLTIP_ACH_STATUS = "你的状态:"
L_TOOLTIP_ACH_COMPLETE = "你的状态: 完成 "
L_TOOLTIP_ACH_INCOMPLETE = "你的状态: 未完成"
L_TOOLTIP_SPELL_ID = "法术ID:"
L_TOOLTIP_ITEM_ID = "物品ID:"
L_TOOLTIP_WHO_TARGET = "以其为目标的"
L_TOOLTIP_ITEM_COUNT = "物品数量: "

-- Misc
L_MISC_UNDRESS = "无装备"
L_MISC_DRINKING = " 开始进食."
L_MISC_BUY_STACK = "Alt-右键点击购买一叠"
L_MISC_ONECLICK_BUYOUT = "Shift-左键,不弹出确认框体直接购买"
L_MISC_ONECLICK_BID = "Shift-左鍵,不弹出确认框体直接竞标"

-- Raid Utility
L_RAID_UTIL_DISBAND = "解散团队"

-- Zone name
L_ZONE_WINTERGRASP = "冬握湖"
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
L_ALOAD_DEP = "依赖关系: "

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
L_CHAT_BATTLEGROUND = "战场"
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
L_MAIL_UNIQUE = "中止,在背包或银行发现重复的唯一物品."
L_MAIL_COMPLETE = "完成."
L_MAIL_NEED = "需要一个信箱."
L_MAIL_MESSAGES = "新邮件"

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
L_DATATEXT_CONTROL = " 已经被占领:"

-- Info text
L_INFO_ERRORS = "目前没有错误."
L_INFO_INVITE = "接受邀请: "
L_INFO_DUEL = "拒绝决斗请求: "
L_INFO_DISBAND = "解散团队..."
L_INFO_ADDON_SETS1 = "键入 /addons <solo/party/raid/pvp/trade/quest>, 载入预设的设定."
L_INFO_ADDON_SETS2 = "你可以通过编辑`Config`文件夹的Settings.lua 进行添加,刪除和更改设置."
L_INFO_SETTINGS_DBM = "键入 /settings dbm, 载入 DBM 的设定."
L_INFO_SETTINGS_DXE = "键入 /settings dxe, 载入 DXE 的设定."
L_INFO_SETTINGS_MSBT = "键入 /settings msbt, 载入 MSBT 的设定."
L_INFO_SETTINGS_SKADA = "键入 /settings skada, 载入 Skada 的设定."
L_INFO_SETTINGS_ALL = "键入 /settings all, 载入所有UI设定."
L_INFO_NOT_INSTALLED = " 没有安装."
L_INFO_SKIN_DISABLED1 = "风格化皮肤 "
L_INFO_SKIN_DISABLED2 = " 已禁用."

-- Popups
L_POPUP_INSTALLUI = "该角色首次使用ShestakUI.你必须重新加载UI来配置."
L_POPUP_RESETUI = "你确定要重新加载ShestakUI?"
L_POPUP_RESETSTATS = "你确定要重置本次游戏时间和金币收益统计数据吗?"
L_POPUP_SWITCH_RAID = "多个团队样式被加载,请选择一个样式."
L_POPUP_DISBAND_RAID = "你确定要解散团队?"
L_POPUP_DISABLEUI = "ShestakUI并不支援此分辨率, 你想要停用ShestakUI吗? (若果您想要尝试其他分辨率, 请按取消)"
L_POPUP_SETTINGS_ALL = "应用所有的插件设置? (DBM/DXE, Skada and MSBT)"
L_POPUP_SETTINGS_DBM = "需要改变DBM描点及风格化元素."
L_POPUP_SETTINGS_DXE = "需要改变DXE描点及风格化元素."
L_POPUP_SETTINGS_BW = "需要改变BigWigs描点及风格化元素."

-- Welcome message
L_WELCOME_LINE_1 = "欢迎使用ShestakUI "
L_WELCOME_LINE_2_1 = "输入/cfg进行插件设置,或者访问http://shestak.org"
L_WELCOME_LINE_2_2 = "得到更多信息."
L_WELCOME_LINE_3 = "注： 此版本的ShestakUI由shestak.org奥兹编辑。"

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
L_STATS_ALT = "ALT键"
L_STATS_AUTO_REPAIR = "自动修装"
L_STATS_GUILD_REPAIR = "公会银行修理"
L_STATS_AUTO_SELL = "自动出售灰色物品"
L_STATS_BANDWIDTH = "宽带占用:"
L_STATS_DOWNLOAD = "下载:"
L_STATS_CLEARED_JUNK = "清除自动出售例外名单列表"
L_STATS_CLEAR_EXCEPTIONS = "清除例外名单列表"
L_STATS_WORLD_MAP = "点击开启世界地图"
L_STATS_CURRENT_XP = "目前/升级所需经验值"
L_STATS_MEMORY_USAGE = "内建插件资源耗用:"
L_STATS_GARBAGE_COLLECTED = "垃圾资源清除"
L_STATS_CHANGE_SORTING = "(公会)右键更改排列方式,SHIFT+右键反转排列方式"
L_STATS_HIDDEN = "隐藏"
L_STATS_VIEW_NOTES = "按住ALT键检视公会成员会阶.注记.干部注记"
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
L_STATS_TALENTS = "人才"
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
L_STATS_INSERTS_COORDS = "SHIFT+点击地名或座标可在对话视窗发布你所在座标"
L_STATS_EQUIPMENT_CHANGER = "左键或中键开启装备管理员"
L_STATS_SORTING_BY = "依...排列"
L_STATS_TIPS = "提示:"
L_STATS_TOTAL = "总计"
L_STATS_TOTAL_MEMORY_USAGE = "全部资源耗用:"
L_STATS_NOT_TO_SELL = "输入/junk设定自动出售例外名单"
L_STATS_WATCH_CURRENCY = "在货币面板选定的项目将在鼠标提示中显示."
L_STATS_WATCH_FACTIONS = "从角色人物介面观看资讯"
L_STATS_TOOLTIP_TIME_PLAYED = "达到最高等级后,提示将显示角色上线时间纪录"
L_STATS_TOOLTIP_EXPERIENCE = "未达最高等级时,提示将显示经验值讯息"

-- Slash commands
L_SLASHCMD_HELP = {
	"Available slash commands:",
	"/rl - 重载界面.",
	"/rc - 就位确认.",
	"/gm - 打开GM面板.",
	"/dis ADDON_NAME - 禁用 插件名.",
	"/en ADDON_NAME - 启用 插件名.",
	"/rd - 解散队伍.",
	"/toraid - 转换队伍/团队.",
	"/teleport - 传送随机副本.",
	"/luaerror - 打开/关闭 lua报错弹出窗口.",
	"/spec - 切换天赋.",
	"/clfix - 战斗记录框体修复.",
	"/heal - 载入治疗模式界面.",
	"/dps - 载入伤害输出模式界面.",
	"/frame - 在聊天窗口输出当前鼠标下的框体的名字.",
	"/addons solo|party|raid|pvp|trade - 载入插件给 单独|队伍|团队|玩家对玩家|交易.",
	"/farmmode - 打开小地图的采集模式(小地图框体放大).",
	"/moveui - 解锁/锁定 界面中所有可以移动的框体.",
	"/resetui - 恢复界面到原始设定值.",
	"/resetuf - 恢复头像框体到原始设定值.",
	"/resetconfig - 恢复界面设置到原始设定值.",
	"/resetstats - 恢复人物属性面板设置到原始设定值.",
	"/settings ADDON_NAME - 设置 插件名.",
	"/ls - 载入设置.",
	"/bags - 背包选项.",
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

-- edit by Oz of shestak. org --