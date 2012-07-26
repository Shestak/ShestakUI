local T, C, L = unpack(ShestakUI)
if T.client ~= "zhCN" then return end

----------------------------------------------------------------------------------------
--	Localization for zhCN client(Thanks to tat2dawn for the translation)
----------------------------------------------------------------------------------------
-- Key binding Header Name
L_EXTRA_HEADER_EXTRABAR = "Extra Bar" -- Needs review
L_EXTRA_HEADER_MARK = "Mouseover Raid Icons" -- Needs review

-- Announce fps
L_EXTRA_ANNOUNCE_FPS = "我目前的 FPS 是 "

-- Click2Cast
L_EXTRA_BINDER_FRAMES = "点击施法框体"
L_EXTRA_BINDER_OPEN = "打开点击施法绑定页面"
L_EXTRA_BINDER_CLOSE = "关闭点击施法绑定页面"

-- BG announce
L_EXTRA_ANNOUNCE_BG_LIGHT = "敌方小型攻击部队来到 "
L_EXTRA_ANNOUNCE_BG_MEDIUM = "敌方中型攻击部队来到 "
L_EXTRA_ANNOUNCE_BG_HEAVY = "敌方大部队来到 "
L_EXTRA_ANNOUNCE_BG_CLEAR = " 这边已经清掉所有敌人"
L_EXTRA_ANNOUNCE_BG_FOCUS = "集火目标 "
L_EXTRA_ANNOUNCE_BG_STEALTH = "敌方潜行在我们旁边"

-- EnchantScroll
L_EXTRA_SCROLL = "附魔卷轴"

-- Announce your Lightwell
L_EXTRA_ANNOUNCE_LA_USE = " 使用我的光束泉. "
L_EXTRA_ANNOUNCE_LA_CHARGE = " 刷新)"
L_EXTRA_ANNOUNCE_LA_USELESS = "尽量少地使用我的光束泉. "
L_EXTRA_ANNOUNCE_LA_STOP = "你不应该使用光束泉."
L_EXTRA_ANNOUNCE_LA_PLACED = "光束泉位置. "
L_EXTRA_ANNOUNCE_LA_CHARGES = "刷新."

-- Announce flasks and food
L_EXTRA_ANNOUNCE_FF_NOFOOD = "No Food: " -- Needs review
L_EXTRA_ANNOUNCE_FF_NOFLASK = "No Flask: " -- Needs review
L_EXTRA_ANNOUNCE_FF_ALLBUFFED = "All Buffed!" -- Needs review
L_EXTRA_ANNOUNCE_FF_CHECK_BUTTON = "Check food and flask" -- Needs review

-- Says thanks for some spells
L_EXTRA_ANNOUNCE_SS_THANKS = "Thanks for " -- Needs review
L_EXTRA_ANNOUNCE_SS_RECEIVED = " received from " -- Needs review

-- Taunt announce
L_EXTRA_TAUNT_UNKNOWN = "未知命令:"
L_EXTRA_TAUNT_ADD = "添加坦克 "
L_EXTRA_TAUNT_DEL = "移除坦克 "
L_EXTRA_TAUNT_DEL_ALL = "移除所有坦克"
L_EXTRA_TAUNT_TANK_LIST = "坦克列表"
L_EXTRA_TAUNT_AURA = "检查光环"
L_EXTRA_TAUNT_AURA_CHECK = "光环检查完毕."
L_EXTRA_TAUNT_ALREADY_LIST = " 已经在列表中."
L_EXTRA_TAUNT_ADDED_TANK = "已添加坦克 "
L_EXTRA_TAUNT_REMOVED_TANK = "已移除坦克 "
L_EXTRA_TAUNT_TARGET_FIRST = "请先选择一位队友为目标."
L_EXTRA_TAUNT_ALL_REMOVED = "已移除所有自定义添加的坦克."

-- ExploreMap
L_EXTRA_EXPLORED = "Explored: " -- Needs review
L_EXTRA_ZONEACHID = {
	-- http://www.wowhead.com/achievement=*
	-- e(X)plore achievement id, (Q)uest achievement id
	["东部王国"]							= {X =   42, A =    0, H =    0},
	["卡利姆多"]							= {X =   43, A =    0, H =    0},
	["外域"]								= {X =   44, A =    0, H =    0},
	["诺森德"]							= {X =   45, A =    0, H =    0},
	["世界地图"]							= {X =  nil, A =    0, H =    0},
	-- Eastern Kingdoms
	["阿拉希高地"]						= {X =  761, A = 4896, H = 4896},
	["荒芜之地"]							= {X =  765, A = 4900, H = 4900},
	["诅咒之地"]							= {X =  766, A = 4909, H = 4909},
	["燃烧平原"]							= {X =  775, A = 4901, H = 4901},
	["逆风小径"]							= {X =  777, A =    0, H =    0},
	["丹莫罗"]							= {X =  627, A =    0, H =    0},
	["暮色森林"]							= {X =  778, A = 4907, H =    0},
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
	["湿地"]								= {X =  841, A = 4898, H =    0},
	-- Kalimdor
	["灰谷"]								= {X =  845, A = 4925, H = 4976},
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
	["冰冠冰川"]							= {X = 1270, A =   40, H =   40},
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
	-- Boolean Explores
	["奎尔丹纳斯岛"]						= {X =  868, A =    0, H =    0},
	["安其拉：堕落王国"]					= {X =    0, A =    0, H =    0},
	["冬拥湖"]							= {X =    0, A =    0, H =    0},
}