----------------------------------------------------------------------------------------
--	Localization for zhCN client(Thanks to Mania for the translation)
----------------------------------------------------------------------------------------
if GetLocale() == "zhCN" then
	L_GUI_BUTTON_RESET = "重载插件"
	-- General options
	L_GUI_GENERAL_UIICON = "小地图插件图标"
	L_GUI_GENERAL_AUTOSCALE = "自动UI缩放"
	L_GUI_GENERAL_MULTISAMPLE = "多重采样保护(保证1像素边框)"
	L_GUI_GENERAL_UISCALE = "UI缩放(当自动缩放关闭时)"
	L_GUI_GENERAL_WELCOME_MESSAGE = "显示欢迎信息"

	-- Miscellaneous options
	L_GUI_MISC_AUTOQUEST = "自动接受任务"
	L_GUI_MISC_AUTODUEL = "自动取消决斗"
	L_GUI_MISC_AUTOACCEPT = "自动接受组队邀请"
	L_GUI_MISC_AUTORESSURECT = "在战场中自动释放灵魂"
	L_GUI_MISC_MARKING = "点击shift显示团队标记图示菜单"
	L_GUI_MISC_INVKEYWORD = "自动邀请关键字(/ainv)"
	L_GUI_MISC_SPIN_CAMERA = "afk时旋转镜头"
	L_GUI_MISC_MOVE_WATCH_FRAME = "Quest Watch frame movable" -- Needs review
	L_GUI_MISC_VEHICLE_MOUSEOVER = "Vehicle frame on mouseover" -- Needs review
	L_GUI_MISC_QUEST_AUTOBUTTON = "Quest/item auto button" -- Needs review
	L_GUI_MISC_RAID_TOOLS = "Raid tools" -- Needs review
	
	-- Skins options
	L_GUI_SKINS = "Stylization" -- Needs review
	L_GUI_SKINS_DBM = "Enable styling DBM" -- Needs review
	L_GUI_SKINS_PP = "Enable styling PallyPower" -- Needs review
	
	-- Combat text options
	L_GUI_COMBATTEXT = "战斗文本设置-（需/RL）"
	L_GUI_COMBATTEXT_FONT_SIZE = "字体大小设置"
	L_GUI_COMBATTEXT_BLIZZ_HEAD_NUMBERS = "使用暴雪默认伤害/治疗字体"
	L_GUI_COMBATTEXT_DAMAGE_STYLE = "更改默认的头像上的伤害/治疗字体"
	L_GUI_COMBATTEXT_DAMAGE = "独立显示输出伤害"
	L_GUI_COMBATTEXT_HEALING = "独立显示输出治疗"
	L_GUI_COMBATTEXT_HOTS = "Show periodic healing effects in healing frame" -- Needs review
	L_GUI_COMBATTEXT_PET_DAMAGE = "Show your pet damage" -- Needs review
	L_GUI_COMBATTEXT_DOT_DAMAGE = "Show damage from your dots" -- Needs review
	L_GUI_COMBATTEXT_DAMAGE_COLOR = "伤害字体着色"
	L_GUI_COMBATTEXT_CRIT_PREFIX = "暴击伤害字体符号修饰（左）"
	L_GUI_COMBATTEXT_CRIT_POSTFIX = "暴击伤害字体符号修饰（右）"
	L_GUI_COMBATTEXT_ICONS = "显示伤害输出图标"
	L_GUI_COMBATTEXT_ICON_SIZE = "伤害输出图标/字体尺寸设置"
	L_GUI_COMBATTEXT_TRESHOLD = "最小化显示伤害框体（建议1000）"
	L_GUI_COMBATTEXT_HEAL_TRESHOLD = "最小化显示治疗框体（建议1000）"
	L_GUI_COMBATTEXT_SCROLLABLE = "允许鼠标调整滚动框"
	L_GUI_COMBATTEXT_MAX_LINES = "滚动框大小调整"
	L_GUI_COMBATTEXT_TIME_VISIBLE = "信息保留时间（建议3）"
	L_GUI_COMBATTEXT_STOP_VE_SPAM = "自动过滤暗牧形态下的垃圾信息"
	L_GUI_COMBATTEXT_DK_RUNES = "显示死亡骑士符文恢复"
	L_GUI_COMBATTEXT_KILLINGBLOW = "Tells you about your killingblows" -- Needs review
	L_GUI_COMBATTEXT_MERGE_AOE_SPAM = "Merges multiple aoe damage spam into single message" -- Needs review
	L_GUI_COMBATTEXT_MERGE_AOE_SPAM_TIME = "Time in seconds aoe spell will be merged into single message" -- Needs review
	
	-- Buffs reminder options
	L_GUI_REMINDER = "Buffs提示"
	L_GUI_REMINDER_SOLO_ENABLE = "显示自身缺少buffs"
	L_GUI_REMINDER_SOLO_SOUND = "开启自身缺少buffs声音提示"
	L_GUI_REMINDER_SOLO_SIZE = "自身buff图示大小"
	L_GUI_REMINDER_RAID_ENABLE = "显示缺少的团队buffs"
	L_GUI_REMINDER_RAID_ALWAYS = "总是显示buffs提示"
	L_GUI_REMINDER_RAID_SIZE = "团队buffs图示大小"
	L_GUI_REMINDER_RAID_ALPHA = "当buffs存在时透明显示图示" -- Needs review

	-- Raid/Enemy cooldown options
	L_GUI_COOLDOWN = "团队/敌对技能冷却"
	L_GUI_COOLDOWN_RAID_ENABLE = "开启团队技能冷却"
	L_GUI_COOLDOWN_RAID_FONT = "团队技能冷却文字大小"
	L_GUI_COOLDOWN_RAID_HEIGHT = "团队技能冷却栏高度"
	L_GUI_COOLDOWN_RAID_WIDTH = "团队技能冷却栏宽度"
	L_GUI_COOLDOWN_RAID_SORT = "团队技能冷却栏向上延伸"
	L_GUI_COOLDOWN_RAID_ICONS = "团队技能冷却栏图示"
	L_GUI_COOLDOWN_RAID_IN_RAID = "在团队中显示团队技能冷却"
	L_GUI_COOLDOWN_RAID_IN_PARTY = "在队伍中显示团队技能冷却"
	L_GUI_COOLDOWN_RAID_IN_ARENA = "在竞技场中显示团队技能冷却"
	L_GUI_COOLDOWN_ENEMY = "敌对技能冷却"
	L_GUI_COOLDOWN_ENEMY_SIZE = "敌对技能冷却图示大小"
	L_GUI_COOLDOWN_ENEMY_EVERYWHERE = "在任何时候显示敌对技能冷却"
	L_GUI_COOLDOWN_ENEMY_IN_BG = "在战场中显示敌对技能冷却"
	L_GUI_COOLDOWN_ENEMY_IN_ARENA = "在竞技场中显示敌对技能冷却"
	
	-- Threat options
	L_GUI_THREAT = "Threat bars" -- Needs review
	L_GUI_THREAT_ENABLE = "Enable threat bars" -- Needs review
	L_GUI_THREAT_FONT_SIZE = "Threat bars font size" -- Needs review
	L_GUI_THREAT_HEIGHT = "Threat bars height" -- Needs review
	L_GUI_THREAT_WIDTH = "Threat bars width" -- Needs review
	L_GUI_THREAT_ROWS = "Number of threat bars" -- Needs review
	L_GUI_THREAT_TEST_MODE = "Enable test mode for threat bars" -- Needs review

	-- Tooltip options
	L_GUI_TOOLTIP = "提示资讯"
	L_GUI_TOOLTIP_ENABLE = "Enable tooltip" -- Needs review
	L_GUI_TOOLTIP_SHIFT = "按下shift时显示提示资讯"
	L_GUI_TOOLTIP_CURSOR = "提示资讯跟随鼠标"
	L_GUI_TOOLTIP_ICON = "在提示资讯中显示物品图示"
	L_GUI_TOOLTIP_HEALTH = "显示百分比生命值"
	L_GUI_TOOLTIP_HIDE = "隐藏动作条的提示提示资讯."
	L_GUI_TOOLTIP_TALENTS = "在提示资讯中显示天赋"
	L_GUI_TOOLTIP_ACHIEVEMENTS = "在提示资讯中显示成就比较"
	L_GUI_TOOLTIP_TARGET = "在提示资讯中显示目标的目标"
	L_GUI_TOOLTIP_TITLE = "在提示资讯中显示目标称号"
	L_GUI_TOOLTIP_RANK = "在提示资讯中显示公会会阶"
	L_GUI_TOOLTIP_ARENA_EXPERIENCE = "在提示资讯中显示竞技场等级"
	L_GUI_TOOLTIP_SPELL_ID = "Spell ID" -- Needs review

	-- Chat options
	L_GUI_CHAT_ENABLE = "Enable chat" -- Needs review
	L_GUI_CHAT_BACKGROUND = "Enable chat background" -- Needs review
	L_GUI_CHAT_BACKGROUND_ALPHA = "Alpha of chat background" -- Needs review
	L_GUI_CHAT_FONT_SIZE = "聊天框字体大小"
	L_GUI_CHAT_FONT_STYLE = "字体样式"
	L_GUI_CHAT_TAB_FONT_SIZE = "标签文字大小"
	L_GUI_CHAT_TAB_FONT_STYLE = "标签文字样式"
	L_GUI_CHAT_SPAM = "移除垃圾消息(*玩家1* 战胜*玩家2*)"
	L_GUI_CHAT_WIDTH = "框体宽度"
	L_GUI_CHAT_HEIGHT = "框体高度"
	L_GUI_CHAT_BAR = "显示频道快捷图示栏"
	L_GUI_CHAT_TIMESTAMP = "时间标签颜色"
	L_GUI_CHAT_WHISP = "接受密语时声音提示"
	L_GUI_CHAT_SKIN_BUBBLE = "Skin Blizzard chat bubbles"  -- Needs review

	-- Bag options
	L_GUI_BAGS = "背包"
	L_GUI_BAGS_ENABLE = "Enable bags"  -- Needs review
	L_GUI_BAGS_BUTTON_SIZE = "Buttons size"  -- Needs review
	L_GUI_BAGS_BUTTON_SPACE = "Buttons space"  -- Needs review
	L_GUI_BAGS_BANK = "银行背包每行数目"
	L_GUI_BAGS_BAG = "背包每行数目"

	-- Minimap options
	L_GUI_MINIMAP_ENABLE = "Enable minimap"  -- Needs review
	L_GUI_MINIMAP_ICON = "追踪类型图示"
	L_GUI_MINIMAP_SIZE = "小地图大小"
	L_GUI_MINIMAP_HIDE_COMBAT = "战斗中隐藏小地图"

	-- Map options
	L_GUI_MAP_ENABLE = "Enable world map"  -- Needs review
	L_GUI_MAP_SCALE = "世界地图缩放"
	L_GUI_MAP_BG_STYLIZATION = "战场地图风格"

	-- Loot options
	L_GUI_LOOT_ENABLE = "Enable loot frame"  -- Needs review
	L_GUI_LOOT_ROLL_ENABLE = "Enable group loot frame"  -- Needs review
	L_GUI_LOOT_FONT_SIZE = "拾取框体字体大小"
	L_GUI_LOOT_ICON_SIZE = "拾取框体图示大小"
	L_GUI_LOOT_WIDTH = "拾取框体宽度"
	L_GUI_LOOT_AUTOGREED = "满级后自动贪婪绿色物品"
	L_GUI_LOOT_AUTODE = "自动选择分解选项"

	-- Nameplate options
	UNIT_NAMEPLATES = "单位名条"
	L_GUI_NAMEPLATE_ENABLE = "Enable nameplates"  -- Needs review
	L_GUI_NAMEPLATE_COMBAT = "在战斗中自动显示单位名条"
	L_GUI_NAMEPLATE_HEALTH = "显示百分比生命值"
	L_GUI_NAMEPLATE_CASTBAR = "显示施法条"
	L_GUI_NAMEPLATE_FONT_SIZE = "单位名条字体大小"
	L_GUI_NAMEPLATE_HEIGHT = "单位名条高度"
	L_GUI_NAMEPLATE_WIDTH = "单位名条宽度"
	L_GUI_NAMEPLATE_CASTBAR_NAME = "显示施法名称"
	L_GUI_NAMEPLATE_THREAT = "显示仇恨情况"
	L_GUI_NAMEPLATE_CLASS_ICON = "在PVP情况下显示职业图示"
	L_GUI_NAMEPLATE_NAME_ABBREV = "Display the abbreviated names"  -- Needs review
	L_GUI_NAMEPLATE_OVERLAP = "Allow nameplates to overlap"  -- Needs review

	-- ActionBar options
	L_GUI_ACTIONBAR_ENABLE = "Enable action bars"  -- Needs review
	L_GUI_ACTIONBAR_HOTKEY = "显示快捷键文字"
	L_GUI_ACTIONBAR_GRID = "显示空的动作条按钮"
	L_GUI_ACTIONBAR_BUTTON_SIZE = "按钮大小"
	L_GUI_ACTIONBAR_BUTTON_SPACE = "Buttons space"  -- Needs review
	L_GUI_ACTIONBAR_BOTTOMBARS = "Number of action bars on the bottom (1, 2 or 3)"  -- Needs review
	L_GUI_ACTIONBAR_RIGHTBARS = "Number of action bars on right (0, 1, 2 or 3)"  -- Needs review
	L_GUI_ACTIONBAR_RIGHTBARS_MOUSEOVER = "鼠标划过时显示右侧动作条"
	L_GUI_ACTIONBAR_PETBAR_MOUSEOVER = "鼠标划过时显示宠物动作条"
	L_GUI_ACTIONBAR_PETBAR_HIDE = "隐藏宠物动作条"
	L_GUI_ACTIONBAR_PETBAR_HORIZONTAL = "打开横向宠物动作条"
	L_GUI_ACTIONBAR_SHAPESHIFT_MOUSEOVER = "鼠标划过时显示变身/姿态/图腾快捷列"
	L_GUI_ACTIONBAR_SHAPESHIFT_HIDE = "隐藏变身/姿态/图腾动作条"
	L_GUI_ACTIONBAR_SHAPESHIFT_HORIZONTAL = "Enable horizontal stance bar"  -- Needs review

	-- Auras/Buffs/Debuffs
	L_GUI_AURA_FONT_SIZE = "Auras font size"  -- Needs review
	L_GUI_AURA_PLAYER_BUFF_SIZE = "Player buffs size"  -- Needs review
	L_GUI_AURA_SHOW_SPIRAL = "在图示上显示漩涡冷却样式"
	L_GUI_AURA_SHOW_TIMER = "在图示上显示层数堆叠"
	L_GUI_AURA_PLAYER_AURAS = "在玩家框体显示法术效果"
	L_GUI_AURA_TARGET_AURAS = "在目标框体显示法术效果"
	L_GUI_AURA_FOCUS_DEBUFFS = "在焦点目标框体显示DeBuffs"
	L_GUI_AURA_FOT_DEBUFFS = "DeBuffs on focus target frame"  -- Needs review
	L_GUI_AURA_PET_DEBUFFS = "在宠物框体显示DeBuffs"
	L_GUI_AURA_TOT_DEBUFFS = "在目标的目标框体显示DeBuffs"
	L_GUI_AURA_PLAYER_AURA_ONLY = "在目标框体只显示自己的DeBuffs"
	L_GUI_AURA_DEBUFF_COLOR_TYPE = "DeBuffs着色依照法术类型"
	
	-- Unit frame options
	L_GUI_UF_ENABLE = "Enable unit frames"  -- Needs review
	L_GUI_UF_FONT_SIZE = "字体大小"
	L_GUI_UF_AGGRO_BORDER = "仇恨边框"
	L_GUI_UF_OWN_COLOR = "在预测治疗中显示你的治疗量"
	L_GUI_UF_ENEMY_HEALTH_COLOR = "敌对目标生命条以红色着色"
	L_GUI_UF_TOTAL_VALUE = "在玩家与目标框体显示详细的文字变化"
	L_GUI_UF_DEFICIT_HEALTH = "团队生命值亏减模式"
	L_GUI_UF_COLOR_VALUE = "生命值与魔法值以职业颜色着色"
	L_GUI_UF_UNIT_CASTBAR = "显示施法条"
	L_GUI_UF_CASTBAR_ICON = "显示施法条图标"
	L_GUI_UF_CASTBAR_LATENCY = "施法条延迟"
	L_GUI_UF_SHOW_BOSS = "显示boss框体"
	L_GUI_UF_SHOW_ARENA = "显示竞技场框体"
	L_GUI_UF_ARENA_RIGHT = "在右侧显示竞技场框体"
	L_GUI_UF_SHOW_RAID = "显示团队框体"
	L_GUI_UF_VERTICAL_HEALTH = "垂直显示团队框体生命值"
	L_GUI_UF_ALPHA_HEALTH = "100%生命值时透明显示生命栏"
	L_GUI_UF_SHOW_RANGE = "在团队框体中距离透明度变化"
	L_GUI_UF_RANGE_ALPHA = "淡化超出距离的单位框体"
	L_GUI_UF_SOLO_MODE = "总是显示玩家框体"
	L_GUI_UF_PLAYER_PARTY = "在小队中显示玩家框体"
	L_GUI_UF_SHOW_TANK = "显示团队主坦克框体"
	L_GUI_UF_RAID_GROUP = "显示小队数目(ShestakUI_Heal风格)"
	L_GUI_UF_RAID_VERTICAL_GROUP = "Vertical raid groups(Only for ShestakUI_Heal)"  -- Needs review
	L_GUI_UF_ICONS_PVP = "鼠标划过玩家/目标时显示PVP状态文字" -- Needs review
	L_GUI_UF_ICONS_LEADER = "显示团队队长标识/助手标识/分配者标识"
	L_GUI_UF_ICONS_COMBAT = "显示战斗标识"
	L_GUI_UF_ICONS_RESTING = "显示休息标识"
	L_GUI_UF_ICONS_LFD_ROLE = "显示队长标识"
	L_GUI_UF_ICONS_RAID_MARK = "显示团队标记"
	L_GUI_UF_ICONS_COMBO_POINT = "潜行者|德鲁伊连击点图示"
	L_GUI_UF_ICONS_READY_CHECK = "确认就绪情况图示"
	L_GUI_UF_PORTRAIT_ENABLE = "开启玩家/目标头像"
	L_GUI_UF_PORTRAIT_CLASSCOLOR_BORDER = "开启职业颜色边框"
	L_GUI_UF_PORTRAIT_HEIGHT = "头像高度"
	L_GUI_UF_PORTRAIT_WIDTH = "头像宽度"
	L_GUI_UF_PLUGINS_GCD = "公共CD计时"
	L_GUI_UF_PLUGINS_SWING = "普通攻击计时条"
	L_GUI_UF_PLUGINS_ECLIPSE_BAR = "Enable eclipse bar" -- Needs review
	L_GUI_UF_PLUGINS_HOLY_BAR = "Enable holy power bar" -- Needs review
	L_GUI_UF_PLUGINS_SHARD_BAR = "Enable shards bar" -- Needs review
	L_GUI_UF_PLUGINS_RUNE_BAR = "符文条"
	L_GUI_UF_PLUGINS_TOTEM_BAR = "图腾栏"
	L_GUI_UF_PLUGINS_TOTEM_BAR_NAME = "图腾名字"
	L_GUI_UF_PLUGINS_REPUTATION_BAR = "声望条"
	L_GUI_UF_PLUGINS_EXPERIENCE_BAR = "经验条"
	L_GUI_UF_PLUGINS_SMOOTH_BAR = "平滑条" -- Needs review
	L_GUI_UF_PLUGINS_TALENTS = "Show enemy talent spec" -- Needs review
	L_GUI_UF_PLUGINS_COMBAT_FEEDBACK = "显示玩家/目标的文字战斗信息" -- Needs review
	L_GUI_UF_PLUGINS_DEBUFFHIGHLIGHT_ICON = "Debuff与图示高亮"
	L_GUI_UF_PLUGINS_AURA_WATCH = "团队法术监视" -- Needs review
	L_GUI_UF_PLUGINS_HEALCOMM = "即将受到的治疗条"

	-- Panel options
	L_GUI_TOP_PANEL = "顶部面板"
	L_GUI_TOP_PANEL_ENABLE = "Enable top panel"	-- Needs review
	L_GUI_TOP_PANEL_MOUSE = "鼠标划过时显示顶部面板"
	L_GUI_TOP_PANEL_WIDTH = "面板宽度"
	L_GUI_TOP_PANEL_HEIGHT = "面板高度"
	
	-- Stats options
	L_GUI_STATS = "Stats"  -- Needs review
	L_GUI_STATS_FONT_SIZE = "面板字体大小"  -- Needs review
	L_GUI_STATS_BG = "战场分数"  -- Needs review
	L_GUI_STATS_CLOCK = "Clock"  -- Needs review
	L_GUI_STATS_LATENCY = "Latency"  -- Needs review
	L_GUI_STATS_MEMORY = "Memory"  -- Needs review
	L_GUI_STATS_FPS = "FPS"  -- Needs review
	L_GUI_STATS_EXPERIENCE = "Experience"  -- Needs review
	L_GUI_STATS_COORDS = "Coords"  -- Needs review
	L_GUI_STATS_LOCATION = "Location"  -- Needs review
	L_GUI_STATS_GUILD_REPAIR = "Repair from guild bank" -- Needs review

	-- Error options
	L_GUI_ERROR = "错误收集"
	L_GUI_ERROR_HIDE = "隐藏错误提示"
	L_GUI_ERROR_BLACK = "隐藏黑名单错误" -- Needs review
	L_GUI_ERROR_WHITE = "显示白名单错误" -- Needs review
	L_GUI_ERROR_HIDE_COMBAT = "在战斗中隐藏错误提示"
end