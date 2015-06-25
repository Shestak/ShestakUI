local T, C, L, _ = unpack(select(2, ...))
if C.raidframe.plugins_aura_watch ~= true then return end

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Renew -> http://www.wowhead.com/spell=139
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
T.RaidBuffs = {
	DRUID = {
		{774, "TOPRIGHT", {0.8, 0.4, 0.8}},				-- Rejuvenation
		{8936, "BOTTOMLEFT", {0.2, 0.8, 0.2}},				-- Regrowth
		{33763, "TOPLEFT", {0.4, 0.8, 0.2}},				-- Lifebloom
		{48438, "BOTTOMRIGHT", {0.8, 0.4, 0}},				-- Wild Growth
		{102342, "LEFT", {0.45, 0.3, 0.2}, true},			-- Ironbark
		{155777, "RIGHT", {0.4, 0.9, 0.4}},				-- Rejuvenation (Germination)
	},
	MONK = {
		{119611, "TOPRIGHT", {0.2, 0.7, 0.7}},				-- Renewing Mist
		{132120, "BOTTOMLEFT", {0.4, 0.8, 0.2}},			-- Enveloping Mist
		{124081, "BOTTOMRIGHT", {0.7, 0.4, 0}},				-- Zen Sphere
		{116849, "LEFT", {0.81, 0.85, 0.1}, true},			-- Life Cocoon
	},
	PALADIN = {
		{53563, "TOPRIGHT", {0.7, 0.3, 0.7}},				-- Beacon of Light
		{156910, "TOPRIGHT", {0.7, 0.3, 0.7}},				-- Beacon of Faith
		{20925, "BOTTOMLEFT", {0.9, 0.9, 0.1}},				-- Sacred Shield
		{156322, "TOPLEFT", {0.9, 0.6, 0.4}},				-- Eternal Flame
		{157007, "TOPLEFT", {1, 0.5, 0.2}},				-- Beacon of Insight
		{1022, "BOTTOMRIGHT", {0.2, 0.2, 1}, true},			-- Hand of Protection
		{1044, "BOTTOMRIGHT", {0.89, 0.45, 0}, true},			-- Hand of Freedom
		{1038, "BOTTOMRIGHT", {0.93, 0.75, 0}, true},			-- Hand of Salvation
		{6940, "BOTTOMRIGHT", {0.89, 0.1, 0.1}, true},			-- Hand of Sacrifice
		{114039, "BOTTOMRIGHT", {0.4, 0.6, 0.8}, true},			-- Hand of Purity
	},
	PRIEST = {
		{6788, "TOPRIGHT", {1, 0, 0}, true},				-- Weakened Soul
		{41635, "BOTTOMRIGHT", {0.2, 0.7, 0.2}},			-- Prayer of Mending
		{139, "BOTTOMLEFT", {0.4, 0.7, 0.2}}, 				-- Renew
		{17, "TOPLEFT", {0.81, 0.85, 0.1}, true},			-- Power Word: Shield
		{33206, "LEFT", {0.89, 0.1, 0.1}, true},			-- Pain Suppression
		{47788, "LEFT", {0.86, 0.52, 0}, true},				-- Guardian Spirit
	},
	SHAMAN = {
		{61295, "TOPRIGHT", {0.7, 0.3, 0.7}},				-- Riptide
		{974, "BOTTOMRIGHT", {0.2, 0.7, 0.2}, true},			-- Earth Shield
	},
	HUNTER = {
		{35079, "TOPRIGHT", {0.2, 0.2, 1}},				-- Misdirection
	},
	MAGE = {
		{111264, "TOPRIGHT", {0.2, 0.2, 1}},				-- Ice Ward
	},
	ROGUE = {
		{57933, "TOPRIGHT", {0.89, 0.1, 0.1}},				-- Tricks of the Trade
	},
	WARLOCK = {
		{20707, "TOPRIGHT", {0.7, 0.32, 0.75}},				-- Soulstone
	},
	WARRIOR = {
		{114030, "TOPLEFT", {0.2, 0.2, 1}},				-- Vigilance
		{3411, "TOPRIGHT", {0.89, 0.1, 0.1}},				-- Intervene
	},
	ALL = {
		{23333, "LEFT", {1, 0, 0}, true}, 				-- Warsong flag, Horde
		{23335, "LEFT", {0, 0, 1}, true},				-- Warsong flag, Alliance
		{34976, "LEFT", {1, 0, 0}, true}, 				-- Netherstorm Flag
	},
}

T.RaidBuffsIgnore = {
	[65148] = true,		-- Sacred Shield (Proc)
}

local function SpellName(id)
	local name = GetSpellInfo(id)
	return name
end

T.RaidDebuffs = {
-----------------------------------------------------------------
-- Draenor
-----------------------------------------------------------------
	-- 60200 Hellfire Citadel
	-- #1 地獄火突襲戰/奇袭地狱火
	[SpellName(186016)] = 4, -- 魔焰彈藥/邪火弹药 拿彈藥的dot
	[SpellName(184379)] = 1, -- 哀嚎之斧/啸风战斧 點名出人群三角站位
	[SpellName(184238)] = 3, -- 畏縮！/颤抖！ 減速
	[SpellName(184243)] = 2, -- 猛擊/猛击 坦克 易傷
	[SpellName(185806)] = 1, -- 傳導震波衝擊/导电冲击脉冲 魔法 擊暈
	[SpellName(180022)] = 1, -- 鑽洞/钻孔 你要被車碾了
	[SpellName(185157)] = 4, -- 燃燒/灼烧 正面錐形aoe dot
	[SpellName(187655)] = 4, -- 腐化虹吸/腐化虹吸 M

	-- #2 鋼鐵劫奪者/钢铁掠夺者
	[SpellName(182074)] = 4, -- 焚燒/献祭 踩到火
	[SpellName(182001)] = 3, -- 不穩定的球體/不稳定的宝珠 8碼分散
	[SpellName(182280)] = 1, -- 砲擊/炮击 離boss越遠傷害越低，p1只點坦，p2點全部
	[SpellName(182003)] = 4, -- 燃料污漬/燃料尾痕 踩到水減速
	[SpellName(179897)] = 4, -- 閃擊/迅猛突袭 被夾住啦
	[SpellName(185242)] = 4, -- 閃擊/迅猛突袭 被夾住啦
	[SpellName(185978)] = 3, -- 火焰彈易傷/易爆火焰炸弹 M 火焰炸彈爆炸易傷

	-- #3 寇姆洛克/考莫克
	[SpellName(181345)] = 2, -- 邪惡碎擊/攫取之手 坦克 被手抓
	[SpellName(181321)] = 2, -- 魔化之觸/邪能之触 坦克 擊飛50%法易傷
	[SpellName(181306)] = 2, -- 炸裂爆發/爆裂冲击 坦克 定身，10秒爆炸，40碼aoe
	[SpellName(187819)] = 3, -- 粉碎/邪污碾压 被手抓
	[SpellName(180270)] = 4, -- 暗影團塊/暗影血球 強化紫色暗影波
	[SpellName(185519)] = 4, -- 熾熱團塊/炽热血球 強化黃色暗影波
	[SpellName(185521)] = 4, -- 邪惡團塊/邪污血球 強化綠色暗影波
	[SpellName(181082)] = 6, -- 暗影池/暗影之池 掉進水池
	[SpellName(186559)] = 6, -- 熾焰火池/火焰之池 掉進水池
	[SpellName(186560)] = 6, -- 邪惡池塘/邪污之池 掉進水池
	[SpellName(181208)] = 5, -- 暗影殘渣/暗影残渣 M 接水dot
	[SpellName(185686)] = 5, -- 熾熱殘渣/爆炸残渣 M 接水dot
	[SpellName(185687)] = 5, -- 腐惡殘渣/邪恶残渣 M 接水dot

	-- #4 地獄火高階議會/地狱火高阶议会
	[SpellName(184449)] = 5, -- 死靈法師印記/死灵印记 魔法
	[SpellName(184450)] = 5, -- 死靈法師印記/死灵印记 魔法
	[SpellName(184676)] = 5, -- 死靈法師印記/死灵印记 魔法
	[SpellName(185065)] = 3, -- 死靈法師印記/死灵印记 魔法
	[SpellName(185066)] = 1, -- 死靈法師印記/死灵印记 魔法
	[SpellName(184360)] = 1, -- 惡魔之怒/堕落狂怒 血沸點名
	[SpellName(184847)] = 2, -- 強酸創傷/酸性创伤 坦克 破甲
	[SpellName(184652)] = 3, -- 收割/暗影收割 踩圈
	-- [SpellName(184357)] = 6, -- 腐壞之血/污血 降低血量上限
	[SpellName(184355)] = 5, -- 血液沸騰/血液沸腾 M 血沸對最遠的5人上流血dot

	-- #5 基爾羅格·亡眼/基尔罗格·死眼
	[SpellName(188929)] = 1, -- 追心飛刀/剖心飞刀 點名飛刀
	[SpellName(180389)] = 3, -- 追心飛刀/剖心飞刀 流血DOT
	[SpellName(182159)] = 4, -- 惡魔腐化/邪能腐蚀 特殊能量
	[SpellName(184396)] = 3, -- 惡魔腐化/邪能腐蚀 疊滿被心控
	[SpellName(180313)] = 4, -- 惡魔附身/恶魔附身 被心控
	[SpellName(180718)] = 3, -- 不朽決心/永痕的决心 玩家 增傷，可疊20層
	[SpellName(181488)] = 6, -- 死亡幻象/死亡幻象
	[SpellName(185563)] = 3, -- 不死救贖/永恒的救赎 玩家debuff 一個光圈，站進去清腐化
	[SpellName(180200)] = 2, -- 撕碎護甲/碎甲 坦克 不該中；身上有主動減傷就不會中(同萊登)
	[SpellName(180575)] = 6, -- 魔化烈焰/邪能烈焰
	[SpellName(183917)] = 5, -- 撕裂嚎叫/撕裂嚎叫 玩家 流血dot
	[SpellName(188852)] = 6, -- 濺血/溅血 踩水
	[SpellName(184067)] = 6, -- 魔化之沼/邪能腐液  踩水

	-- #6 血魔/血魔
	[SpellName(180093)] = 4, -- 靈魂箭雨/灵魂箭雨 緩速
	[SpellName(179864)] = 1, -- 死亡之影/死亡之影 點名進場
	[SpellName(179867)] = 6, -- 血魔的腐化/血魔的腐化 進過場，不能再次進場
	[SpellName(181295)] = 3, -- 消化/消化 內場，debuff結束秒殺，剩3秒出場
	[SpellName(180148)] = 1, -- 嗜命/生命渴望 玩家 傀儡(小怪)盯人，追上10碼爆炸
	[SpellName(179977)] = 1, -- 末日之觸/毁灭之触 去角落放圈
	[SpellName(179995)] = 6, -- 末日之井/末日井 踩到圈
	[SpellName(185190)] = 6, -- 魔化烈焰/邪能烈焰 大怪buff
	[SpellName(185189)] = 4, -- 魔化之怒/邪能之怒 大怪dot
	[SpellName(179908)] = 3, -- 命運共享/命运相连 找被定身的集合消連線，能動
	[SpellName(179909)] = 3, -- 命運共享/命运相连 找被定身的集合消連線，定身
	[SpellName(186770)] = 6, -- 碰到血魔的洗澡水

	-- #7 暗影領主伊斯卡/暗影领主伊斯卡
	[SpellName(185239)] = 5, -- 安祖烈光/安苏之光 拿球疊dot
	[SpellName(182325)] = 3, -- dot，hp90%以上消失或拿球消
	[SpellName(182600)] = 6, -- 魔化火焰/邪能焚化 踩火
	[SpellName(181957)] = 5, -- 吹下去，拿球消
	[SpellName(182200)] = 1, -- 魔化戰輪/邪能飞轮 出人群
	[SpellName(182178)] = 1, -- 魔化戰輪/邪能飞轮 出人群
	[SpellName(179219)] = 6, -- 幻魅魔化炸彈/幻影邪能炸弹 魔法 別驅
	[SpellName(181753)] = 3, -- 魔化炸彈/邪能炸弹 魔法 拿球驅散
	[SpellName(181824)] = 2, -- 幻魅腐化/幻影腐蚀 坦克 10秒後爆炸，拿球清
	[SpellName(187344)] = 3, -- 幻魅火葬/幻影焚化 近戰 幻魅腐化給附近的人的易傷
	[SpellName(185456)] = 3, -- 絕望之鍊/绝望之链 M 配對(無誤)
	[SpellName(185510)] = 3, -- 黑暗束縛/暗影之缚 M 把鍊子綁在一起，沒有鍊子的人靠近會引爆

	-- #8永恆者索奎薩爾/永恒者索克雷萨
	[SpellName(182038)] = 2, -- 粉碎防禦/粉碎防御 迴盪之擊易傷，分攤，坦克2次換
	[SpellName(189627)] = 1, -- 烈性魔珠/易爆的邪能宝珠 點名球追人，追到爆炸
	[SpellName(182218)] = 4, -- 魔炎殘渣/邪炽冲锋 衝鋒留下綠火，75%減速
	[SpellName(180415)] = 4, -- 魔化牢籠/邪能牢笼 水晶暈人
	[SpellName(189540)] = 5, -- 極限威能/压倒能量 傀儡隨便電人，6秒dot
	[SpellName(184124)] = 1, -- 曼那瑞之賜/堕落者之赐 綠圈aoe，別靠近別人
	[SpellName(182769)] = 2, -- 恐怖凝視/魅影重重 p2被小怪追
	[SpellName(184239)] = 3, -- 暗言術：痛苦/暗言术：恶 魔法 喚影師施放，驅散
	[SpellName(182900)] = 4, -- 惡性糾纏/恶毒鬼魅 小怪恐懼
	[SpellName(188666)] = 2, -- 永世饑渴/无尽饥渴 M 玩家 潛獵者追人，正面秒殺
	[SpellName(190776)] = 4, -- 索奎薩爾的應變之計/索克雷萨之咒 M 潛獵者傀儡易傷

	-- #9 女暴君維哈里/暴君维哈里
	[SpellName(180000)] = 2, -- 凋零徽印/凋零契印 坦克	2-4層換坦
	-- [SpellName(179987)] = 6, -- 蔑視光環/蔑视光环
	-- [SpellName(181683)] = 6, -- 壓迫光環/抑制光环
	-- [SpellName(179993)] = 6, -- 惡意光環/怨恨光环
	[SpellName(180526)] = 1, -- 腐化洗禮/腐蚀序列 P2 aoe標記，被標記的人會5碼aoe
	[SpellName(180166)] = 3, -- 魔法 吸收治療量，驅散跳到別人身上
	[SpellName(180164)] = 3, -- 魔法 吸收治療量，驅散跳到別人身上
	[SpellName(182459)] = 6, -- 定罪赦令/谴责法令 分攤
	[SpellName(180604)] = 4, -- 剝奪之地/亵渎之地 P3地板紫圈

	-- #10 惡魔領主札昆/邪能领主扎昆
	[SpellName(189260)] = 3, -- 裂魂/破碎之魂 進場的暗影易傷
	[SpellName(179407)] = 4, -- 虛體/魂不附体 進場debuff
	[SpellName(182008)] = 4, -- 潛在能量/潜伏能量 撞到波爆炸
	[SpellName(189032)] = 4, -- 被污染/玷污 吸收盾，分別是綠/黃/紅燈，刷滿6碼爆炸
	[SpellName(189031)] = 3, -- 被污染/玷污 吸收盾，分別是綠/黃/紅燈，刷滿6碼爆炸
	[SpellName(189030)] = 2, -- 被污染/玷污 吸收盾，分別是綠/黃/紅燈，刷滿6碼爆炸
	[SpellName(179428)] = 3, -- 轟隆裂隙/轰鸣的裂隙 站在漩渦上，一個漩渦只要一個人踩
	[SpellName(181508)] = 1, -- 毀滅種子/毁灭之种 出人群
	[SpellName(181515)] = 1, -- 毀滅種子/毁灭之种 出人群
	[SpellName(181653)] = 4, -- 惡魔水晶/邪能水晶
	[SpellName(188998)] = 6, -- 耗竭靈魂/枯竭灵魂 M 不能再次進場

	-- #11 祖霍拉克/祖霍拉克
	[SpellName(186134)] = 3, -- 魔化之觸/邪蚀 受到火焰傷害的標記，持續15秒，碰到暗影傷害會爆炸
	[SpellName(186135)] = 3, -- 魔化之觸/邪蚀 受到火焰傷害的標記，持續15秒，碰到暗影傷害會爆炸
	[SpellName(185656)] = 3, -- 影魔殲滅/邪影屠戮
	[SpellName(186073)] = 6, -- 魔化焦灼/邪能炙烤 踩到綠火
	[SpellName(186063)] = 6, -- 破滅虛空/虚空消耗 踩到紫水
	[SpellName(186407)] = 2, -- 惡魔奔騰/魔能喷涌 點名，5秒後腳下出綠火
	[SpellName(186333)] = 2, -- 虛無怒濤/灵能涌动 點名，5秒後腳下出紫水
	[SpellName(186448)] = 6, -- 魔炎亂舞/邪焰乱舞
	[SpellName(186453)] = 6, -- 魔炎亂舞/邪焰乱舞
	[SpellName(186785)] = 6, -- 枯萎凝視/凋零凝视
	[SpellName(186783)] = 6, -- 枯萎凝視/凋零凝视
	[SpellName(188208)] = 5, -- 著火/点燃 小鬼火球砸中的dot
	-- [SpellName(186547)] = 6, -- 黑洞/黑洞 全團aoe直到踩掉為止
	[SpellName(186500)] = 4, -- 魔化鎖鍊/邪能锁链 跑遠拉斷

	-- #12 瑪諾洛斯/玛诺洛斯
	[SpellName(181275)] = 4, -- 軍團的詛咒/军团诅咒 詛咒 驅散召喚領主
	[SpellName(181099)] = 1, -- 毀滅印記/末日印记 玩家 受到傷害移除並爆炸，20碼AOE
	[SpellName(181119)] = 2, -- 末日尖刺/末日之刺 坦克 層數越高，結束時的傷害越高
	[SpellName(189717)] = 2, -- 末日尖刺/末日之刺 坦克層數越高，結束時的傷害越高
	[SpellName(182171)] = 6, -- 瑪諾洛斯之血/玛洛诺斯之血 踩到P1綠水
	[SpellName(184252)] = 2, -- 刺傷/穿刺之伤 坦克 (p2p3/p4)不該中；旋刃戳刺時身上有主動減傷就不會中(同萊登)
	[SpellName(191231)] = 2, -- 刺傷/穿刺之伤 坦克 (p2p3/p4)不該中；旋刃戳刺時身上有主動減傷就不會中(同萊登)
	[SpellName(181359)] = 2, -- 巨力衝擊/巨力冲击 坦克 擊飛
	[SpellName(181597)] = 4, -- 瑪諾洛斯的凝視/玛诺洛斯凝视 恐懼，分攤傷害
	[SpellName(181841)] = 4, -- 暗影之力/暗影之力 推人(小心加速)
	[SpellName(182006)] = 4, -- 瑪諾洛斯的強力凝視/强化玛诺洛斯凝视 恐懼，分攤傷害產生白水
	[SpellName(182088)] = 4, -- 強化暗影之力/强化暗影之力 p4推人
	[SpellName(182031)] = 6, -- 凝視之影/凝视暗影 踩到白色
	[SpellName(190482)] = 3, -- 擁抱暗影/束缚暗影 M

	-- #13 阿克蒙德/阿克蒙德
	[SpellName(183634)] = 4, -- 影魔衝擊/暗影冲击 擊飛，分攤落地傷害
	[SpellName(187742)] = 2, -- 暗影爆破/暗影冲击 玩家/坦克	大怪易傷，坦克2層換
	[SpellName(183864)] = 2, -- 暗影爆破/暗影冲击 玩家/坦克	大怪易傷，坦克2層換
	[SpellName(183828)] = 5, -- 死亡烙印/死亡烙印 坦克 dot 大怪死才消失
	[SpellName(183586)] = 5, -- 毀滅之火/魔火 踩火dot
	[SpellName(182879)] = 2, -- 毀滅之火鎖定/魔火锁定 追人
	[SpellName(183963)] = 3, -- 那魯之光/纳鲁之光 伊芮爾的小球，免疫暗影傷害
	[SpellName(185014)] = 4, -- 聚集混沌/聚焦混乱 即將被傳遞塑形混沌
	[SpellName(186123)] = 3, -- 塑型混沌/精炼混乱 正面直線aoe，傳遞給箭頭指向的人
	[SpellName(184964)] = 4, -- 束縛折磨/枷锁酷刑 遠離靈魂30碼消除
	[SpellName(186952)] = 2, -- 虛空放逐/虚空放逐 坦克 進場
	[SpellName(186961)] = 2, -- 虛空放逐/虚空放逐 坦克 進場
	[SpellName(187047)] = 4, -- 吞噬生命/吞噬声明 內場，降低受到的治療量
	[SpellName(189891)] = 6, -- 虛空裂隙/虚空撕裂 傳送門在外場變成的水池
	[SpellName(190049)] = 3, -- 虛空腐化/虚空腐化 內場易傷
	[SpellName(188796)] = 6, -- 惡魔腐化/邪能腐蚀 場邊綠水

	-- 黑石铸造厂 
	--格鲁尔 
	[SpellName(155080)] = 4, -- 煉獄切割 分担组DOT 
	[SpellName(155078)] = 3, -- 压迫打击 普攻坦克易伤 
	[SpellName(162322)] = 5, -- 炼狱打击 吃刀坦克易伤 
	[SpellName(155506)] = 2, -- 石化 

	--奥尔高格 
	[SpellName(156203)] = 5, -- 呕吐黑石 远程躲 
	[SpellName(156374)] = 5, -- 爆炸裂片 近战躲 
	[SpellName(156297)] = 3, -- 酸液洪流 副坦克易伤 
	[SpellName(173471)] = 4, -- 酸液巨口 主坦克DOT 
	[SpellName(155900)] = 2, -- 翻滚之怒 击倒 

	--爆裂熔炉 
	[SpellName(156932)] = 5, -- 崩裂 
	[SpellName(178279)] = 4, -- 炸弹 
	[SpellName(155192)] = 4, -- 炸弹 
	[SpellName(176121)] = 6, -- 不稳定的火焰 点名八码爆炸 
	[SpellName(155196)] = 2, -- 锁定 
	[SpellName(155743)] = 5, -- 熔渣池 
	[SpellName(155240)] = 3, -- 淬火 坦克易伤 
	[SpellName(155242)] = 3, -- 高热 三层换坦 
	[SpellName(155225)] = 5, -- 熔化 点名 
	[SpellName(155223)] = 5, -- 熔化 

	--汉斯加尔与弗兰佐克 
	[SpellName(157139)] = 3, -- 折脊碎椎 跳跃易伤 
	[SpellName(160838)] = 2, -- 干扰怒吼 
	[SpellName(160845)] = 2, -- 干扰怒吼 
	[SpellName(160847)] = 2, -- 干扰怒吼 
	[SpellName(160848)] = 2, -- 干扰怒吼 
	[SpellName(155818)] = 4, -- 灼热燃烧 场地边缘的火 

	--缚火者卡格拉兹 
	[SpellName(154952)] = 3, -- 锁定 
	[SpellName(155074)] = 1, -- 焦灼吐息 坦克易伤 
	[SpellName(155049)] = 2, -- 火焰链接 
	[SpellName(154932)] = 4, -- 熔岩激流 点名分摊 
	[SpellName(155277)] = 5, -- 炽热光辉 点名AOE 
	[SpellName(155314)] = 1, -- 岩浆猛击 冲锋火线 
	[SpellName(163284)] = 2, -- 升腾烈焰 坦克DOT 

	--克罗莫格 
	[SpellName(156766)] = 1, -- 扭曲护甲 坦克易伤 
	[SpellName(157059)] = 2, -- 纠缠之地符文 
	[SpellName(161839)] = 3, -- 破碎大地符文 
	[SpellName(161923)] = 3, -- 破碎大地符文 

	--兽王达玛克
	[SpellName(154960)] = 4, -- 长矛钉刺 
	[SpellName(155061)] = 1, -- 狂乱撕扯 狼阶段流血 
	[SpellName(162283)] = 1, -- 狂乱撕扯 BOSS继承的流血 
	[SpellName(154989)] = 3, -- 炼狱吐息 
	[SpellName(154981)] = 5, -- 爆燃 秒驱 
	[SpellName(155030)] = 2, -- 炽燃利齿 龙阶段坦克易伤 
	[SpellName(155236)] = 2, -- 碾碎护甲 象阶段坦克易伤 
	[SpellName(155499)] = 3, -- 高热弹片 
	[SpellName(155657)] = 4, -- 烈焰灌注 
	[SpellName(159044)] = 1, -- 强震 
	[SpellName(162277)] = 1, -- 强震 

	--主管索戈尔 
	[SpellName(155921)] = 2, -- 点燃 坦克易伤 
	[SpellName(165195)] = 4, -- 实验型脉冲手雷 
	[SpellName(156310)] = 3, -- 熔岩震击 
	[SpellName(159481)] = 3, -- 延时攻城炸弹 
	[SpellName(164380)] = 2, -- 燃烧 
	[SpellName(164280)] = 2, -- 热能冲击 

	--钢铁女武神 
	[SpellName(156631)] = 2, -- 急速射击 
	[SpellName(164271)] = 3, -- 穿透射击 
	[SpellName(158601)] = 1, -- 主炮轰击 
	[SpellName(156214)] = 4, -- 震颤暗影 
	[SpellName(158315)] = 2, -- 暗影猎杀 
	[SpellName(159724)] = 3, -- 鲜血仪式 
	[SpellName(158010)] = 2, -- 浸血觅心者 
	[SpellName(158692)] = 1, -- 致命投掷 
	[SpellName(158702)] = 2, -- 锁定 
	[SpellName(158683)] = 3, -- 堕落之血 

	--黑手 
	[SpellName(156096)] = 5, -- 死亡标记 
   	
--悬槌堡 
	-- 1 卡加斯 
	[SpellName(158986)] = 2, -- 冲锋 
	[SpellName(159178)] = 5, -- 迸裂创伤         
	[SpellName(162497)] = 3, -- 搜寻猎物       
	[SpellName(163130)] = 3, -- 着火 

	-- 2 屠夫 
	[SpellName(156151)] = 3, -- 捶肉槌 
	[SpellName(156147)] = 5, -- 切肉刀           
	[SpellName(156152)] = 3, -- 龟裂创伤         
	[SpellName(163046)] = 4, -- 白鬼硫酸 

	-- 3 泰克图斯 
	[SpellName(162346)] = 4,  -- 晶化弹幕  点名 
	[SpellName(162370)] = 3, -- 晶化弹幕   踩到 

	-- 4  布兰肯斯波 
	[SpellName(163242)] = 5, -- 感染孢子 
	[SpellName(159426)] = 5, -- 回春孢子 
	[SpellName(163241)] = 4, -- 溃烂 
	[SpellName(159220)] = 2,  -- 死疽吐息   
	[SpellName(160179)] = 2,  -- 蚀脑真菌 
	[SpellName(165223)] = 6, -- 爆裂灌注 
	[SpellName(163666)] = 3, -- 脉冲高热 

	-- 5  独眼魔双子 
	[SpellName(155569)] = 3, -- 受伤 
	[SpellName(158241)] = 4, -- 烈焰   
	[SpellName(163372)] = 4, -- 奥能动荡 
	[SpellName(167200)] = 3, -- 奥术致伤 
	[SpellName(163297)] = 3, -- 扭曲奥能 

	-- 6 克拉戈 
	[SpellName(172813)] = 5, -- 魔能散射：冰霜 
	[SpellName(162185)] = 5, -- 魔能散射：火焰 
	[SpellName(162184)] = 3, -- 魔能散射：暗影 
	[SpellName(162186)] = 2, -- 魔能散射：奥术 
	[SpellName(161345)] = 2, -- 压制力场 
	[SpellName(161242)] = 3, -- 废灵标记 
	[SpellName(172886)] = 4, -- 废灵璧垒 
	[SpellName(172895)] = 4, -- 魔能散射：邪能  点名 
	[SpellName(172917)] = 4, -- 魔能散射：邪能  踩到 
	[SpellName(163472)] = 2, -- 统御之力 

	-- 7 元首 
	[SpellName(157763)] = 3,  -- 锁定         
	[SpellName(159515)] = 4, -- 狂莽突击         
	[SpellName(156225)] = 4, -- 烙印       
	[SpellName(164004)] = 4, -- 烙印：偏移         
	[SpellName(164006)] = 4, -- 烙印：强固         
	[SpellName(164005)] = 4, -- 烙印：复制         
	[SpellName(158605)] = 2, -- 混沌标记         
	[SpellName(164176)] = 2, -- 混沌标记：偏移           
	[SpellName(164178)] = 2, -- 混沌标记：强固         
	[SpellName(164191)] = 2, -- 混沌标记：复制 

-----------------------------------------------------------------
-- Pandaria
-----------------------------------------------------------------
-- Siege of Orgrimmar
	-- Immerseus
	[SpellName(143436)] = 3,	-- Corrosive Blast (Tank switch)
	-- The Fallen Protectors
	[SpellName(143434)] = 4,	-- Shadow Word: Bane (Dispel)
	[SpellName(143198)] = 3,	-- Garrote (DoT)
	[SpellName(143842)] = 5,	-- Mark of Anguish
	[SpellName(147383)] = 3,	-- Debilitation
	-- Norushen
	[SpellName(146124)] = 4,	-- Self Doubt (Tank switch)
	[SpellName(144514)] = 3,	-- Lingering Corruption (Dispel)
	-- Sha of Pride
	[SpellName(144358)] = 4,	-- Wounded Pride (Tank switch)
	[SpellName(144351)] = 3,	-- Mark of Arrogance (Dispel)
	[SpellName(146594)] = 3,	-- Gift of the Titans
	[SpellName(147207)] = 3,	-- Weakened Resolve (Heroic)
	-- Galakras
	[SpellName(147029)] = 3,	-- Flames of Galakrond (DoT)
	[SpellName(146902)] = 3,	-- Poison-Tipped Blades (Poison stacks)
	-- Iron Juggernaut
	[SpellName(144467)] = 4,	-- Ignite Armor (Tank stacks)
	[SpellName(144459)] = 3,	-- Laser Burn (DoT)
	-- Kor'kron Dark Shaman
	[SpellName(144215)] = 3,	-- Froststorm Strike (Tank stacks)
	[SpellName(144089)] = 3,	-- Toxic Mist (DoT)
	[SpellName(144330)] = 3,	-- Iron Prison (Heroic)
	-- General Nazgrim
	[SpellName(143494)] = 3,	-- Sundering Blow (Tank stacks)
	[SpellName(143638)] = 3,	-- Bonecracker (DoT)
	[SpellName(143431)] = 3,	-- Magistrike (Dispel)
	[SpellName(143480)] = 3,	-- Assassin's Mark (Fixate)
	-- Malkorok
	[SpellName(142990)] = 4,	-- Fatal Strike (Tank stacks)
	[SpellName(142864)] = 3,	-- Ancient Barrier
	[SpellName(142865)] = 3,	-- Strong Ancient Barrier
	[SpellName(142913)] = 4,	-- Displaced Energy (Dispel)
	-- Spoils of Pandaria
	[SpellName(145218)] = 3,	-- Harden Flesh (Dispel)
	[SpellName(146235)] = 3,	-- Breath of Fire (Dispel)
	-- Thok the Bloodthirsty
	[SpellName(143766)] = 3,	-- Panic (Tank stacks)
	[SpellName(143780)] = 3,	-- Acid Breath (Tank stacks)
	[SpellName(143773)] = 3,	-- Freezing Breath (Tank Stacks)
	[SpellName(143800)] = 3,	-- Icy Blood (Random Stacks)
	[SpellName(143767)] = 3,	-- Scorching Breath (Tank Stacks)
	[SpellName(143791)] = 3,	-- Corrosive Blood (Dispel)
	-- Siegecrafter Blackfuse
	[SpellName(143385)] = 3,	-- Electrostatic Charge (Tank stacks)
	[SpellName(144236)] = 3,	-- Pattern Recognition
	-- Paragons of the Klaxxi
	[SpellName(143974)] = 4,	-- Shield Bash (Tank stun)
	[SpellName(142315)] = 4,	-- Caustic Blood (Tank stacks)
	[SpellName(143701)] = 3,	-- Whirling (DoT)
	[SpellName(142948)] = 3,	-- Aim
	-- Garrosh Hellscream
	[SpellName(145183)] = 3,	-- Gripping Despair (Tank stacks)
	[SpellName(145195)] = 3,	-- Empowered Gripping Despair (Tank stacks)
	[SpellName(145065)] = 3,	-- Touch of Y'Shaarj
	[SpellName(145171)] = 3,	-- Empowered Touch of Y'Shaarj
-- Throne of Thunder
	-- Jin'rokh the Breaker
	[SpellName(137162)] = 4,	-- Static Burst (Tank switch)
	[SpellName(138349)] = 3,	-- Static Wound (Tank stacks)
	[SpellName(137371)] = 4,	-- Thundering Throw (Tank stun)
	[SpellName(138732)] = 3,	-- Ionization (Heroic - Dispel)
	[SpellName(137422)] = 3,	-- Focused Lightning (Fixated - Kiting)
	-- Horridon
	[SpellName(136767)] = 3,	-- Triple Puncture (Tank stacks)
	[SpellName(136708)] = 4,	-- Stone Gaze (Stun - Dispel)
	[SpellName(136654)] = 3,	-- Rending Charge (DoT)
	[SpellName(136719)] = 3,	-- Blazing Sunlight (Dispel)
	[SpellName(136587)] = 3,	-- Venom Bolt Volley (Dispel)
	[SpellName(136710)] = 3,	-- Deadly Plague (Dispel)
	[SpellName(136512)] = 3,	-- Hex of Confusion (Dispel)
	-- Council of Elders
	[SpellName(136903)] = 3,	-- Frigid Assault (Tank stacks)
	[SpellName(136922)] = 3,	-- Frostbite (DoT)
	[SpellName(136992)] = 3,	-- Biting Cold (DoT)
	[SpellName(136857)] = 4,	-- Entrapped (Dispel)
	[SpellName(137359)] = 3,	-- Marked Soul (Fixated - Kiting)
	[SpellName(137641)] = 3,	-- Soul Fragment (Heroic)
	-- Tortos
	[SpellName(136753)] = 3,	-- Slashing Talons (Tank DoT)
	[SpellName(137633)] = 3,	-- Crystal Shell (Heroic)
	[SpellName(140701)] = 4,	-- Crystal Shell: Full Capacity! (Heroic)
	-- Megaera
	[SpellName(137731)] = 3,	-- Ignite Flesh (Tank stacks)
	[SpellName(139843)] = 3,	-- Arctic Freeze (Tank stacks)
	[SpellName(139840)] = 3,	-- Rot Armor (Tank stacks)
	[SpellName(134391)] = 4,	-- Cinder (DoT - Dispell)
	[SpellName(139857)] = 4,	-- Torrent of Ice (Fixated - Kiting)
	[SpellName(140179)] = 4,	-- Suppression (Heroic - Dispell)
	-- Ji-Kun
	[SpellName(134366)] = 4,	-- Talon Rake (Tank stacks)
	[SpellName(140092)] = 3,	-- Infected Talons (Tank DoT)
	[SpellName(134256)] = 3,	-- Slimed (DoT)
	-- Durumu the Forgotten
	[SpellName(133768)] = 4,	-- Arterial Cut (Tank DoT)
	[SpellName(133767)] = 3,	-- Serious Wound (Tank stacks)
	[SpellName(133798)] = 3,	-- Life Drain (Stun)
	[SpellName(133597)] = 3,	-- Dark Parasite (Heroic - Dispel)
	-- Primordius
	[SpellName(136050)] = 3,	-- Malformed Blood (Tank stacks)
	[SpellName(136228)] = 4,	-- Volatile Pathogen (DoT)
	-- Dark Animus
	[SpellName(138569)] = 4,	-- Explosive Slam (Tank stacks)
	[SpellName(138609)] = 4,	-- Matter Swap (Dispel)
	[SpellName(138659)] = 3,	-- Touch of the Animus (DoT)
	-- Iron Qon
	[SpellName(134691)] = 3,	-- Impale (Tank stacks)
	[SpellName(136192)] = 4,	-- Lightning Storm (Stun)
	[SpellName(136193)] = 3,	-- Arcing Lightning
	-- Twin Consorts
	[SpellName(137408)] = 3,	-- Fan of Flames (Tank stacks)
	[SpellName(136722)] = 3,	-- Slumber Spores (Dispel)
	[SpellName(137341)] = 3,	-- Beast of Nightmares (Fixate)
	[SpellName(137360)] = 3,	-- Corrupted Healing (Healer stacks)
	-- Lei Shen
	[SpellName(135000)] = 3,	-- Decapitate (Tank only)
	[SpellName(136478)] = 3,	-- Fusion Slash (Tank only)
	[SpellName(136914)] = 3,	-- Electrical Shock (Tank staks)
	[SpellName(135695)] = 3,	-- Static Shock (Damage Split)
	[SpellName(136295)] = 3,	-- Overcharged
	[SpellName(139011)] = 3,	-- Helm of Command (Heroic)
	-- Ra-den
	[SpellName(138297)] = 3,	-- Unstable Vita
	[SpellName(138329)] = 3,	-- Unleashed Anima
	[SpellName(138372)] = 4,	-- Vita Sensitivity
-- Terrace of Endless Spring
	-- Protectors of the Endless
	[SpellName(117519)] = 3,	-- Touch of Sha
	[SpellName(117436)] = 4,	-- Lightning Prison
	-- Tsulong
	[SpellName(122752)] = 3,	-- Shadow Breath
	[SpellName(123011)] = 3,	-- Terrorize
	[SpellName(122777)] = 3,	-- Nightmares
	[SpellName(123036)] = 3,	-- Fright
	-- Lei Shi
	[SpellName(123121)] = 3,	-- Spray
	[SpellName(123705)] = 3,	-- Scary Fog
	-- Sha of Fear
	[SpellName(119086)] = 3,	-- Penetrating Bolt
	[SpellName(120669)] = 3,	-- Naked and Afraid
	[SpellName(120629)] = 3,	-- Huddle in Terror
-- Heart of Fear
	-- Imperial Vizier Zor'lok
	[SpellName(122761)] = 3,	-- Exhale
	[SpellName(122740)] = 3,	-- Convert
	-- Blade Lord Ta'yak
	[SpellName(123180)] = 3,	-- Wind Step
	[SpellName(123474)] = 3,	-- Overwhelming Assault
	-- Garalon
	[SpellName(122835)] = 3,	-- Pheromones
	[SpellName(123081)] = 4,	-- Pungency
	-- Wind Lord Mel'jarak
	[SpellName(129078)] = 4,	-- Amber Prison
	[SpellName(122055)] = 3,	-- Residue
	[SpellName(122064)] = 3,	-- Corrosive Resin
	[SpellName(123963)] = 4,	-- Kor'thik Strike
	-- Amber-Shaper Un'sok
	[SpellName(121949)] = 3,	-- Parasitic Growth
	[SpellName(122370)] = 3,	-- Reshape Life
	-- Grand Empress Shek'zeer
	[SpellName(123707)] = 3,	-- Eyes of the Empress
	[SpellName(123713)] = 3,	-- Servant of the Empress
	[SpellName(123788)] = 3,	-- Cry of Terror
	[SpellName(124849)] = 3,	-- Consuming Terror
	[SpellName(124863)] = 3,	-- Visions of Demise
-- Mogu'shan Vaults
	-- The Stone Guard
	[SpellName(125206)] = 3,	-- Rend Flesh
	[SpellName(130395)] = 3,	-- Jasper Chains
	[SpellName(116281)] = 3,	-- Cobalt Mine Blast
	-- Feng the Accursed
	[SpellName(131788)] = 3,	-- Lightning Lash
	[SpellName(116942)] = 3,	-- Flaming Spear
	[SpellName(131790)] = 3,	-- Arcane Shock
	[SpellName(131792)] = 3,	-- Shadowburn
	[SpellName(116374)] = 4,	-- Lightning Charge
	[SpellName(116784)] = 3,	-- Wildfire Spark
	[SpellName(116417)] = 3,	-- Arcane Resonance
	-- Gara'jal the Spiritbinder
	[SpellName(122151)] = 4,	-- Voodoo Doll
	[SpellName(116161)] = 3,	-- Crossed Over
	[SpellName(117723)] = 3,	-- Frail Soul
	-- The Spirit Kings
	[SpellName(117708)] = 3,	-- Maddening Shout
	[SpellName(118303)] = 3,	-- Fixate
	[SpellName(118048)] = 3,	-- Pillaged
	[SpellName(118135)] = 3,	-- Pinned Down
	[SpellName(118163)] = 3,	-- Robbed Blind
	-- Elegon
	[SpellName(117878)] = 3,	-- Overcharged
	[SpellName(117949)] = 3,	-- Closed Circuit
	[SpellName(132222)] = 3,	-- Destabilizing Energies
	-- Will of the Emperor
	[SpellName(116835)] = 3,	-- Devastating Arc
	[SpellName(116778)] = 3,	-- Focused Defense
	[SpellName(116525)] = 3,	-- Focused Assault
-- Sha of Anger
	[SpellName(119626)] = 3,	-- Aggressive Behavior
-- Other
	[SpellName(87023)] = 4,		-- Cauterize
	[SpellName(94794)] = 4,		-- Rocket Fuel Leak
	[SpellName(116888)] = 4,	-- Shroud of Purgatory
	[SpellName(121175)] = 2,	-- Orb of Power
-----------------------------------------------------------------
-- PvP
-----------------------------------------------------------------
	-- Death Knight
	--[[[SpellName(115001)] = 3,	-- Remorseless Winter
	[SpellName(108194)] = 3,	-- Asphyxiate
	[SpellName(91797)] = 3,		-- Monstrous Blow (Mutated Ghoul)
	[SpellName(91800)] = 3,		-- Gnaw (Ghoul)
	[SpellName(47476)] = 3,		-- Strangulate
	-- Druid
	[SpellName(33786)] = 3,		-- Cyclone
	[SpellName(339)] = 2,		-- Entangling Roots
	[SpellName(78675)] = 3,		-- Solar Beam
	-- Hunter
	[SpellName(3355)] = 3,		-- Freezing Trap
	[SpellName(19386)] = 3,		-- Wyvern Sting
	[SpellName(117526)] = 3,	-- Binding Shot
	[SpellName(24394)] = 3,		-- Intimidation
	-- Mage
	[SpellName(61305)] = 3,		-- Polymorph
	[SpellName(82691)] = 3,		-- Ring of Frost
	[SpellName(44572)] = 3,		-- Deep Freeze
	[SpellName(31661)] = 3,		-- Dragon's Breath
	[SpellName(102051)] = 3,	-- Frostjaw
	[SpellName(122)] = 2,		-- Frost Nova
	[SpellName(111340)] = 2,	-- Ice Ward
	-- Monk
	[SpellName(115078)] = 3,	-- Paralysis
	[SpellName(119381)] = 3,	-- Leg Sweep
	-- Paladin
	[SpellName(20066)] = 3,		-- Repentance
	[SpellName(853)] = 3,		-- Hammer of Justice
	[SpellName(105593)] = 3,	-- Fist of Justice
	[SpellName(105421)] = 3,	-- Blinding Light
	-- Priest
	[SpellName(605)] = 3,		-- Dominate Mind
	[SpellName(8122)] = 3,		-- Psychic Scream
	[SpellName(64044)] = 3,		-- Psychic Horror
	[SpellName(15487)] = 3,		-- Silence
	-- Rogue
	[SpellName(6770)] = 3,		-- Sap
	[SpellName(2094)] = 3,		-- Blind
	[SpellName(1776)] = 3,		-- Gouge
	-- Shaman
	[SpellName(51514)] = 3,		-- Hex
	[SpellName(118905)] = 3,	-- Static Charge
	[SpellName(63685)] = 2,		-- Frozen Power
	-- Warlock
	[SpellName(118699)] = 3,	-- Fear
	[SpellName(6789)] = 3,		-- Mortal Coil
	[SpellName(5484)] = 3,		-- Howl of Terror
	[SpellName(6358)] = 3,		-- Seduction (Succubus)
	[SpellName(115268)] = 3,	-- Mesmerize (Shivarra)
	[SpellName(30283)] = 3,		-- Shadowfury
	-- Warrior
	[SpellName(46968)] = 3,		-- Shockwave
	[SpellName(132169)] = 3,	-- Storm Bolt
	[SpellName(5246)] = 3,		-- Intimidating Shout]]
}

T.RaidDebuffsReverse = {
	--[spellID] = true,			-- Spell name
}

T.RaidDebuffsIgnore = {
	[142862] = true,			-- Ancient Barrier
	[138309] = true,			-- Slimed
}
