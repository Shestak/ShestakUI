local T, C, L, _ = unpack(select(2, ...))
if T.client ~= "zhCN" then return end

----------------------------------------------------------------------------------------
--	Localization for zhCN client
--	Translation: Ianchan, Mania, Nanjiqq, Tat2dawn
----------------------------------------------------------------------------------------
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
L_ANNOUNCE_PC_MSG = "准备接怪: %s,倒数 %s.."
L_ANNOUNCE_PC_ABORTED = "取消拉怪!"

-- Announce feasts and portals
L_ANNOUNCE_FP_STAT = "%s 放置了 %s - [%s]."
L_ANNOUNCE_FP_PRE = "%s 放置了 %s"
L_ANNOUNCE_FP_PUT = "%s 放置了 %s"
L_ANNOUNCE_FP_CAST = "%s 开启了 %s"
L_ANNOUNCE_FP_CLICK = "%s 正在开启 %s... 请点击!"
L_ANNOUNCE_FP_USE = "%s 使用了 %s."

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
L_TOOLTIP_WHO_TARGET = "关注"
L_TOOLTIP_ITEM_COUNT = "物品数量:"
L_TOOLTIP_INSPECT_OPEN = "检查框体已打开"

-- Misc
L_MISC_UNDRESS = "无装备"
L_MISC_DRINKING = " 进食中..."
L_MISC_BUY_STACK = "Alt+右键点击购买一叠"
L_MISC_ONECLICK_BUYOUT = "Shift+右键,不弹出确认框体直接购买"
L_MISC_ONECLICK_BID = "Shift+右鍵,不弹出确认框体直接竞标"
L_MISC_ONECLICK_CANCEL = "Shift+右键,不弹出确认框体直接取消选择的物品"
L_MISC_UI_OUTDATED = "ShestakUI 版本已过期，请至 www.shestak.org 下载最新版"
L_MISC_HEADER_MARK = "鼠标悬停显示团队图标"
L_MISC_BINDER_OPEN = "鼠标绑定"
L_MISC_SCROLL = "附魔卷轴"

-- Raid Utility
L_RAID_UTIL_DISBAND = "解散团队"

-- Zone name
L_ZONE_ARATHIBASIN = "阿拉希盆地"
L_ZONE_GILNEAS = "吉尔尼斯之战"
L_ZONE_ANCIENTDALARAN = "达拉然巨坑"

-- WatchFrame Wowhead link
L_WATCH_WOWHEAD_LINK = "Wowhead链接"

-- Toggle Menu
L_TOGGLE_ADDON = "插件 "
L_TOGGLE_ADDONS = " 插件系列"
L_TOGGLE_EXPAND = "展开 "
L_TOGGLE_COLLAPSE = "折叠 "
L_TOGGLE_RCLICK = "右键点击以启用/禁用 "
L_TOGGLE_LCLICK = "左键点击以显示/隐藏窗口 "
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
L_MAP_COORDS = "Coordinates" -- Needs review

-- Minimap
L_MINIMAP_CALENDAR = "日历"
L_MINIMAP_HEAL_LAYOUT = "左鍵 - 治疗 布局"
L_MINIMAP_DPS_LAYOUT = "右键 - 攻击 布局"
L_MINIMAP_BLIZZ_LAYOUT = "中键 - 默认布局"

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
L_CHAT_RAID_WARNING = "RE"
L_CHAT_INSTANCE_CHAT = "I"
L_CHAT_INSTANCE_CHAT_LEADER = "IL"
L_CHAT_OFFICER = "O"
L_CHAT_PET_BATTLE = "PB"
L_CHAT_COME_ONLINE = "|cff298F00上线|r."
L_CHAT_GONE_OFFLINE = "|cffff0000下线|r."

-- Errors frame
L_ERRORFRAME_L = "点击查看错误"

-- Bags
L_BAG_SHOW_BAGS = "显示背包"
L_BAG_RIGHT_CLICK_SEARCH = "右键点击搜寻物品"
L_BAG_STACK_MENU = "堆叠"
L_BAG_RIGHT_CLICK_CLOSE = "右键点击打开菜单"

-- Grab mail
L_MAIL_STOPPED = "无法拾取,背包已满."
L_MAIL_UNIQUE = "中止,在背包或银行发现重复的唯一物品."
L_MAIL_COMPLETE = "完成"
L_MAIL_NEED = "需要信箱"
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
L_COOLDOWNS_COMBATRESS = "战复"
L_COOLDOWNS_COMBATRESS_REMAINDER = "战复剩余: "
L_COOLDOWNS_NEXTTIME = "下次: "

-- Autoinvite
L_INVITE_ENABLE = "自动邀请功能启用: "
L_INVITE_DISABLE = "自动邀请功能关闭"

-- Bind key
L_BIND_SAVED = "快捷键设置已保存."
L_BIND_DISCARD = "新的快捷键设置已撤消."
L_BIND_INSTRUCT = "将鼠标悬停至任意动作条进行绑定.按Esc或者右键点击以清除当前动作条的按键绑定."
L_BIND_CLEARED = "已清除所有快捷键设置."
L_BIND_BINDING = "绑定"
L_BIND_KEY = "按键"
L_BIND_NO_SET = "没有绑定快捷键"

-- Info text
L_INFO_ERRORS = "目前没有错误."
L_INFO_INVITE = "接受邀请 "
L_INFO_DUEL = "拒绝决斗 "
L_INFO_PET_DUEL = "拒绝宠物对战 "
L_INFO_DISBAND = "解散团队..."
L_INFO_SETTINGS_DBM = "键入 /settings dbm, 载入 DBM 设定."
L_INFO_SETTINGS_BIGWIGS = "键入 /settings bw, 载入 BigWigs 设定."
L_INFO_SETTINGS_MSBT = "键入 /settings msbt, 载入 MSBT 设定."
L_INFO_SETTINGS_SKADA = "键入 /settings skada, 载入 Skada 设定."
L_INFO_SETTINGS_ALL = "键入 /settings all, 载入所有UI设定."
L_INFO_NOT_INSTALLED = " 没有安装."
L_INFO_SKIN_DISABLED1 = "介面样式启用 "
L_INFO_SKIN_DISABLED2 = " 已禁用."

-- Popups
L_POPUP_INSTALLUI = "该角色首次使用ShestakUI.你必须重新加载UI来配置."
L_POPUP_RESETUI = "你确定要重新加载ShestakUI?"
L_POPUP_RESETSTATS = "你确定要重置本次游戏时间和金币收益统计数据?"
L_POPUP_SWITCH_RAID = "选择团队布局."
L_POPUP_DISBAND_RAID = "你确定要解散团队?"
L_POPUP_DISABLEUI = "ShestakUI不支持此分辨率, 是否停用ShestakUI? (若调整其他分辨率,请按取消)"
L_POPUP_SETTINGS_ALL = "套用所有插件设置? (DBM/BigWigs/Skada/MSBT)"
L_POPUP_SETTINGS_DBM = "需要改变DBM锚点及样式元素."
L_POPUP_SETTINGS_BW = "需要改变BigWigs锚点及样式元素."
L_POPUP_ARMORY = "英雄榜"

-- Welcome message
L_WELCOME_LINE_1 = "欢迎使用ShestakUI "
L_WELCOME_LINE_2_1 = "输入/cfg进行插件设置,或者访问http://shestak.org"
L_WELCOME_LINE_2_2 = "获取更多信息."

-- Combat text
L_COMBATTEXT_KILLING_BLOW = "最后一击"
L_COMBATTEXT_ALREADY_UNLOCKED = "战斗信息已解锁."
L_COMBATTEXT_ALREADY_LOCKED = "战斗信息已锁定."
L_COMBATTEXT_TEST_DISABLED = "战斗信息测试模式已禁用."
L_COMBATTEXT_TEST_ENABLED = "战斗信息测试模式已启用."
L_COMBATTEXT_TEST_USE_UNLOCK = "输入 /xct unlock 移动/调整战斗信息框架大小."
L_COMBATTEXT_TEST_USE_LOCK = "输入 /xct lock 锁定战斗信息框架."
L_COMBATTEXT_TEST_USE_TEST = "输入 /xct test 启用/禁用战斗信息测试模式."
L_COMBATTEXT_TEST_USE_RESET = "Type /xct reset 恢复默认位置."
L_COMBATTEXT_POPUP = "保存战斗信息窗口的位置须重载插件."
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
L_STATS_CURRENCY_RAID = "副本徽记"
L_STATS_WORLD_MAP = "点击开启世界地图"
L_STATS_CURRENT_XP = "当前/升级所需经验值"
L_STATS_MEMORY_USAGE = "插件内存占用:"
L_STATS_GARBAGE_COLLECTED = "整理内存"
L_STATS_CHANGE_SORTING = "[公会]右键更改排列方式,Shift+右键反向排列"
L_STATS_HIDDEN = "隐藏"
L_STATS_VIEW_NOTES = "按住Alt键检视公会成员会阶/注记/干部注记"
L_STATS_HR = "小时"
L_STATS_INF = "无限"
L_STATS_ALREADY_EXCEPTIONS = "物品已在例外名单列表"
L_STATS_ITEMLINK = "物品链接"
L_STATS_JUNK_EXCEPTIONS = "自动出售例外名单"
L_STATS_JUNK_LIST = "自动出售列表"
L_STATS_JUNK_PROFIT = "自动出售所得金额"
L_STATS_KILLS = "击杀"
L_STATS_OPEN_CALENDAR = "左键开启日历"
L_STATS_OPEN_CHARACTER = "左键开启角色面板"
L_STATS_OPEN_CURRENCY = "左键单击开启货币面板."
L_STATS_OPEN_TALENT = "Left-Click toggles your talent specialization." -- Need review
L_STATS_XP_RATE = "当前等级经验百分值"
L_STATS_IGNORED_ITEMS = "列出目前忽略物品"
L_STATS_TOGGLE_TIME = "本地/服务器及24小时制可显示于时间管理器"
L_STATS_LOCATION = "位置/座标"
L_STATS_MEMORY = "内存"
L_STATS_ON = "启用"
L_STATS_OTHER_OPTIONS = "其它选项可能配置在%s"
L_STATS_PLAYED_LEVEL = "当前等级总上线时间"
L_STATS_PLAYED_SESSION = "此次在线时长"
L_STATS_PLAYED_TOTAL = "总在线时长"
L_STATS_QUEST = "任务"
L_STATS_QUESTS_TO = "任务/杀怪得到经验值 %s"
L_STATS_REMAINING_XP = "升级尚需经验值"
L_STATS_REMOVED_JUNK = "移除自动出售例外名单"
L_STATS_RESTED_XP = "休息奖励经验值"
L_STATS_RC_COLLECTS_GARBAGE = "右键点击整理内存"
L_STATS_RC_TIME_MANAGER = "右键开启计时器"
L_STATS_RC_EXPERIENCE = "右键切换经验值/在线时间/角色信息显示"
L_STATS_RC_AUTO_REPAIRING = "右键显示自动修装"
L_STATS_RC_AUTO_SELLING = "右键开启自动出售"
L_STATS_RC_TALENT = "Right-Click toggles your loot specialization." -- Need review
L_STATS_SERVER_GOLD = "帐号总现金"
L_STATS_SESSION_GAIN = "此次在线时段获得/损失金额"
L_STATS_SESSION_XP = "此次上线时段所得经验值"
L_STATS_INSERTS_COORDS = "Shift+点击地名/座标可在聊天框通告你所在座标"
L_STATS_EQUIPMENT_CHANGER = "左键/中键开启装备管理员"
L_STATS_SORTING_BY = "排列方式:"
L_STATS_TIPS = "提示:"
L_STATS_TOTAL_MEMORY_USAGE = "总内存:"
L_STATS_TOTAL_CPU_USAGE = "Total CPU Usage:" -- Need review
L_STATS_NOT_TO_SELL = "输入/junk设定自动出售例外名单"
L_STATS_WATCH_CURRENCY = "在货币面板选定的项目将在鼠标提示中显示."
L_STATS_WATCH_FACTIONS = "从角色面板查看"
L_STATS_TOOLTIP_TIME_PLAYED = "达到最高等级后,提示将显示角色上线时间纪录"
L_STATS_TOOLTIP_EXPERIENCE = "未达最高等级时,提示将显示经验值信息"
L_STATS_SEALS = "本周已领徽记"
L_STATS_SPEC = "专精" -- Need review

-- Slash commands
L_SLASHCMD_HELP = {
	"命令列表:",
	"/rl - 重载界面",
	"/rc - 就位确认",
	"/gm - 打开GM面板.",
	"/dis ADDON_NAME - 禁用指定插件",
	"/en ADDON_NAME - 启用指定插件",
	"/rd - 解散队伍.",
	"/toraid - 转换队伍/团队",
	"/teleport - 传送随机副本",
	"/spec - 切换天赋",
	"/heal - 载入HPS布局",
	"/dps - 载入DPS布局",
	"/frame - 在聊天窗口输出鼠标指向的框体的名字",
	"/farmmode - 开启/关闭小地图采集模式",
	"/moveui - 解锁/锁定 界面中所有可以移动的框体",
	"/resetui - 重置UI界面",
	"/resetuf - 重置头像框架",
	"/resetconfig - 重置配置文件",
	"/resetstats - 重置角色属性面板",
	"/settings ADDON_NAME - 设置指定插件",
	"/ls - 载入设置",
	"/xct - 战斗信息选项",
	"/raidcd - 团队技能冷却监视",
	"/enemycd - 敌对技能冷却监视",
	"/pulsecd - 技能冷却提醒",
	"/threat - 仇恨条",
	"/tt - 密语当前目标",
	"/ainv - 开启/关闭 自动接受公会/好友组队邀请",
	"/testuf - 头像框架测试模式",
	"/cfg - 开启shestakui设置界面",
}