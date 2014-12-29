local T, C, L, _ = unpack(ShestakUI)
if C.unitframe.enable ~= true then return end

C["filger_spells"] = {
	["DEATHKNIGHT"] = {
		{
			Name = "P_BUFF",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C["filger_position"].player_buff)},


		},
		{
			Name = "P_PROC",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C["filger_position"].player_proc)},

				--血魄護盾
                { spellID = 77535, unitID = "player", caster = "player", filter = "BUFF" },
                --血魄轉化
                { spellID = 45529, unitID = "player", caster = "player", filter = "BUFF" },
                --血族之裔
                { spellID = 55233, unitID = "player", caster = "player", filter = "BUFF" },
                --穢邪力量
                { spellID = 53365, unitID = "player", caster = "player", filter = "BUFF" },
                --穢邪之力
                { spellID = 67117, unitID = "player", caster = "player", filter = "BUFF" },
                --符文武器幻舞
                { spellID = 81256, unitID = "player", caster = "player", filter = "BUFF" },
                --冰錮堅韌
                { spellID = 48792, unitID = "player", caster = "player", filter = "BUFF" },
                --反魔法護罩
                { spellID = 48707, unitID = "player", caster = "player", filter = "BUFF" },
                --殺戮酷刑
                { spellID = 51124, unitID = "player", caster = "player", filter = "BUFF" },
                --冰封之霧
                { spellID = 59052, unitID = "player", caster = "player", filter = "BUFF" },
                --骸骨之盾
                { spellID = 49222, unitID = "player", caster = "player", filter = "BUFF" },
                --冰霜之柱
                { spellID = 51271, unitID = "player", caster = "player", filter = "BUFF" },
                --血魄充能
                { spellID = 114851, unitID = "player", caster = "player", filter = "BUFF" },
                --黑暗救贖
                { spellID = 101568, unitID = "player", caster = "player", filter = "BUFF" },
                --寶寶能量
                { spellID = 91342, unitID = "pet", caster = "player", filter = "BUFF" },
                --黑暗變身
                { spellID = 63560, unitID = "pet", caster = "player", filter = "BUFF" },
                --鮮血氣息
                { spellID = 50421, unitID = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "T_BUFF",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C["filger_position"].target_buff)},


		},
		{
			Name = "T_PROC",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C["filger_position"].target_proc)},

				--絞殺
                { spellID = 47476, unitID = "target", caster = "player", filter = "DEBUFF" },
                --血魄瘟疫
                { spellID = 55078, unitID = "target", caster = "player", filter = "DEBUFF" },
                --冰霜熱疫
                { spellID = 55095, unitID = "target", caster = "player", filter = "DEBUFF" },
                --召喚石像鬼
                { spellID = 49206, unitID = "target", caster = "player", filter = "DEBUFF" },
                --死亡凋零
                { spellID = 43265, unitID = "target", caster = "player", filter = "DEBUFF" },
                --靈魂收割者
                { spellID = 130736, unitID = "target", caster = "player", filter = "DEBUFF" },
                { spellID = 114866, unitID = "target", caster = "player", filter = "DEBUFF" },
		},
		{
			Name = "T_DE/BUFF_BAR",
			Direction = "UP",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 186,
			Position = {unpack(C["filger_position"].target_bar)},

			-- Blood Plague
			{spellID = 55078, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Frost Fever
			{spellID = 55095, unitID = "target", caster = "player", filter = "DEBUFF"},
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 30,
			Position = {unpack(C["filger_position"].cooldown)},

				-- 物品
                -- 手套
                {slotID = 10, filter = "CD" },
                -- 腰带
                {slotID = 6, filter = "CD" },
                -- 披风
                {slotID = 15, filter = "CD" },
                -- 饰品
                {slotID = 13, filter = "CD" },
                {slotID = 14, filter = "CD" },
		},
	},
	["DRUID"] = {
		{
			Name = "P_BUFF",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C["filger_position"].player_buff)},

			--生命之花
            { spellID = 33763, unitID = "player", caster = "player", filter = "BUFF" },
            --回春術
            { spellID = 774, unitID = "player", caster = "player", filter = "BUFF" },
            --癒合
            { spellID = 8936, unitID = "player", caster = "player", filter = "BUFF" },
            --共生
            { spellID = 100977, unitID = "player", caster = "player", filter = "BUFF" },
            --回春術(萌芽)
            { spellID = 155777, unitID = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "P_PROC",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C["filger_position"].player_proc)},

				--日之巅
                { spellID = 171744, unitID = "player", caster = "player", filter = "BUFF" },
                --月之巅
                { spellID = 171743, unitID = "player", caster = "player", filter = "BUFF" },
                --月光增效
                { spellID = 164547, unitID = "player", caster = "player", filter = "BUFF" },
                --日光增效
                { spellID = 164545, unitID = "player", caster = "player", filter = "BUFF" },
                --流星
                { spellID = 93400, unitID = "player", caster = "player", filter = "BUFF" },
                --兇蠻咆哮
                { spellID = 52610, unitID = "player", caster = "player", filter = "BUFF" },
                --求生本能
                { spellID = 61336, unitID = "player", caster = "player", filter = "BUFF" },
                --節能施法
                { spellID = 16870, unitID = "player", caster = "player", filter = "BUFF" },
                --樹皮術
                { spellID = 22812, unitID = "player", caster = "player", filter = "BUFF" },
                --狂暴
                { spellID = 106951, unitID = "player", caster = "player", filter = "BUFF" },
                --狂暴恢復
                { spellID = 22842, unitID = "player", caster = "player", filter = "BUFF" },
                --猛獸迅捷
                { spellID = 69369, unitID = "player", caster = "player", filter = "BUFF" },
                --自然戒備
                { spellID = 124974, unitID = "player", caster = "player", filter = "BUFF" },
                --森林之魂
                { spellID = 114108, unitID = "player", caster = "player", filter = "BUFF" },
                --星殞術
                { spellID = 48505, unitID = "player", caster = "player", filter = "BUFF" },
                --星穹大連線
                { spellID = 112071, unitID = "player", caster = "player", filter = "BUFF" },
                --化身:艾露恩之眷
                { spellID = 117679, unitID = "player", caster = "player", filter = "BUFF" },
                --野性之心
                { spellID = 108294, unitID = "player", caster = "player", filter = "BUFF" },
                --化身:丛林之王
                { spellID = 102543, unitID = "player", caster = "player", filter = "BUFF" },
                --猛虎之怒
                { spellID = 5217, unitID = "player", caster = "player", filter = "BUFF" },
                --野蛮咆哮雕文
                { spellID = 174544, unitID = "player", caster = "player", filter = "BUFF" },
                --血腥爪击
                { spellID = 145152, unitID = "player", caster = "player", filter = "BUFF" },
                --粉碎
                { spellID = 158792, unitID = "player", caster = "player", filter = "BUFF" },
                --鬃毛倒竖
                { spellID = 155835, unitID = "player", caster = "player", filter = "BUFF" },
                --塞纳里奥结界
                { spellID = 102351, unitID = "player", caster = "player", filter = "BUFF" },
                --塞纳里奥结界:触发
                { spellID = 102352, unitID = "player", caster = "player", filter = "BUFF" },
                --狂暴:熊形态
                { spellID = 50334, unitID = "player", caster = "player", filter = "BUFF" },
                --化身:乌索克之子
                { spellID = 102558, unitID = "player", caster = "player", filter = "BUFF" },
                --巨熊之力
                { spellID = 159233, unitID = "player", caster = "player", filter = "BUFF" },
                --尖牙与利爪
                { spellID = 135286, unitID = "player", caster = "player", filter = "BUFF" },
                --野蛮防御
                { spellID = 132402, unitID = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "T_BUFF",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C["filger_position"].target_buff)},

				--生命之花
                { spellID = 33763, unitID = "target", caster = "player", filter = "BUFF" },
                --回春術
                { spellID = 774, unitID = "target", caster = "player", filter = "BUFF" },
                --癒合
                { spellID = 8936, unitID = "target", caster = "player", filter = "BUFF" },
                --精靈群襲
                { spellID = 102355, unitID = "target", caster = "all", filter = "DEBUFF" },
                --回春術(萌芽)
                { spellID = 155777, unitID = "target", caster = "player", filter = "BUFF" },
		},
		{
			Name = "T_PROC",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C["filger_position"].target_proc)},

				--糾纏根鬚
                { spellID = 339, unitID = "target", caster = "all", filter = "DEBUFF" },
                --颶風術
                { spellID = 33786, unitID = "target", caster = "all", filter = "DEBUFF" },
                --月火術
                { spellID = 164812, unitID = "target", caster = "player", filter = "DEBUFF" },
                --日炎術
                { spellID = 164815, unitID = "target", caster = "player", filter = "DEBUFF" },
                --掃擊
                { spellID = 1822, unitID = "target", caster = "player", filter = "DEBUFF" },
                --撕扯
                { spellID = 1079, unitID = "target", caster = "player", filter = "DEBUFF" },
                --割裂
                { spellID = 33745, unitID = "target", caster = "player", filter = "DEBUFF" },
                --痛擊
                { spellID = 106830, unitID = "target", caster = "player", filter = "DEBUFF" },
                --傷殘術
                { spellID = 22570, unitID = "target", caster = "player", filter = "DEBUFF" },
                --斜掠
                { spellID = 155722, unitID = "target", caster = "player", filter = "DEBUFF" },
                --痛击
                { spellID = 77758, unitID = "target", caster = "player", filter = "DEBUFF" },
		},
		{
			Name = "T_DE/BUFF_BAR",
			Direction = "UP",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 186,
			Position = {unpack(C["filger_position"].target_bar)},

			-- Lifebloom
			{spellID = 33763, unitID = "target", caster = "player", filter = "BUFF"},
			-- Rejuvenation
			{spellID = 774, unitID = "target", caster = "player", filter = "BUFF"},
			-- Regrowth
			{spellID = 8936, unitID = "target", caster = "player", filter = "BUFF"},
			-- Wild Growth
			{spellID = 48438, unitID = "target", caster = "player", filter = "BUFF"},
			-- Cenarion Ward
			{spellID = 102351, unitID = "target", caster = "player", filter = "BUFF"},
		},
		{
			Name = "PVE/PVP_CC",
			Direction = "DOWN",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 189,
			Position = {unpack(C["filger_position"].pve_cc)},

			-- Cyclone
			{spellID = 33786, unitID = "focus", caster = "all", filter = "DEBUFF"},
			-- Entangling Roots
			{spellID = 339, unitID = "focus", caster = "all", filter = "DEBUFF"},
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 30,
			Position = {unpack(C["filger_position"].cooldown)},

				--狂暴
                { spellID = 50334, filter = "CD" },
                --狂暴恢復
                { spellID = 22842, filter = "CD" },
                --複生
                { spellID = 20484, filter = "CD" },
                --樹皮術
                { spellID = 22812, filter = "CD" },
                --寧靜
                { spellID = 740, filter = "CD" },
                --自然戒備
                { spellID = 124974, filter = "CD" },
                --星穹大連線
                { spellID = 112071, filter = "CD" },
                --野性位移
                { spellID = 102280, filter = "CD" },
                --化身:艾露恩之眷
                { spellID = 102560, filter = "CD" },
                --狂奔怒吼
                { spellID = 106898, filter = "CD" },
                --急奔
                { spellID = 1850, filter = "CD" },
                --日光术
                { spellID = 78675, filter = "CD" },
                --猛虎之怒
                { spellID = 5217, filter = "CD" },
                --影遁
                { spellID = 58984, filter = "CD" },

                -- 物品
                -- 手套
                {slotID = 10, filter = "CD" },
                -- 腰带
                {slotID = 6, filter = "CD" },
                -- 披风
                {slotID = 15, filter = "CD" },
                -- 饰品
                {slotID = 13, filter = "CD" },
                {slotID = 14, filter = "CD" },
		},
	},
	["HUNTER"] = {
		{
			Name = "P_BUFF",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C["filger_position"].player_buff)},

				--狙击训练
                { spellID = 168811, unitID = "player", caster = "player", filter = "BUFF" },
				--狙击训练；最近移动
                { spellID = 168809, unitID = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "P_PROC",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C["filger_position"].player_proc)},

				--誤導
                { spellID = 34477, unitID = "player", caster = "player", filter = "BUFF" },
                { spellID = 35079, unitID = "player", caster = "player", filter = "BUFF" },
                --快速射擊
                { spellID = 6150, unitID = "player", caster = "player", filter = "BUFF" },
                --戰術大師
                { spellID = 34837, unitID = "player", caster = "player", filter = "BUFF" },
                --急速射擊
                { spellID = 3045, unitID = "player", caster = "player", filter = "BUFF" },
                --治療寵物
                { spellID = 136, unitID = "pet", caster = "player", filter = "BUFF" },
                --連環火網
                { spellID = 82921, unitID = "player", caster = "player", filter = "BUFF" },
                --狂亂效果
                { spellID = 19615, unitID = "pet", caster = "pet", filter = "BUFF" },
                --獵殺快感
                { spellID = 34720, unitID = "player", caster = "player", filter = "BUFF" },
                --4T13
                { spellID = 105919, unitID = "player", caster = "player", filter = "BUFF" },
                --稳固集中
                { spellID = 177668, unitID = "player", caster = "player", filter = "BUFF" },
                --擊殺命令
                { spellID = 34026, filter = "CD" },
                --爆裂射擊
                { spellID = 53301, filter = "CD" },
		},
		{
			Name = "T_BUFF",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C["filger_position"].target_buff)},

				--獵人印記
                { spellID = 1130, unitID = "target", caster = "all", filter = "DEBUFF" },
		},
		{
			Name = "T_PROC",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C["filger_position"].target_proc)},

				--翼龍釘刺
                { spellID = 19386, unitID = "target", caster = "all", filter = "DEBUFF" },
                --毒蛇釘刺
                { spellID = 118253, unitID = "target", caster = "player", filter = "DEBUFF" },
                --黑蝕箭
                { spellID = 3674, unitID = "target", caster = "player", filter = "DEBUFF" },
                --爆裂射擊
                { spellID = 53301, unitID = "target", caster = "player", filter = "DEBUFF" },
                --黑鸦
                { spellID = 131894, unitID = "target", caster = "player", filter = "DEBUFF" },
		},
		{
			Name = "PVE/PVP_CC",
			Direction = "DOWN",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 189,
			Position = {unpack(C["filger_position"].pve_cc)},

			-- Wyvern Sting
			{spellID = 19386, unitID = "focus", caster = "player", filter = "DEBUFF"},
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 30,
			Position = {unpack(C["filger_position"].cooldown)},

				--急速射擊
                { spellID = 3045, filter = "CD" },
                --奧術之流
                { spellID = 25046, filter = "CD" },
                --誤導
                { spellID = 34477, filter = "CD" },
                --偽裝
                { spellID = 51753, filter = "CD" },
                --爆炸陷阱
                { spellID = 13813, filter = "CD" },
                --冰凍陷阱
                { spellID = 1499, filter = "CD" },
                --毒蛇陷阱
                { spellID = 34600, filter = "CD" },
                --翼龍釘刺
                { spellID = 19386, filter = "CD" },
                --主人的召喚
                { spellID = 53271, filter = "CD" },
                --假死
                { spellID = 5384, filter = "CD" },
                --兇暴野獸
                { spellID = 120679, filter = "CD" },
                --黑鴉獵殺
                { spellID = 131894, filter = "CD" },
                --山貓衝刺
                { spellID = 120697, filter = "CD" },

                -- 物品
                -- 手套
                {slotID = 10, filter = "CD" },
                -- 腰带
                {slotID = 6, filter = "CD" },
                -- 披风
                {slotID = 15, filter = "CD" },
                -- 饰品
                {slotID = 13, filter = "CD" },
                {slotID = 14, filter = "CD" },
		},
	},
	["MAGE"] = {
		{
			Name = "P_BUFF",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C["filger_position"].player_buff)},

			
		},
		{
			Name = "P_PROC",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C["filger_position"].player_proc)},

				--冰霜之指
                { spellID = 44544, unitID = "player", caster = "player", filter = "BUFF" },
                --焦炎之痕
                { spellID = 48108, unitID = "player", caster = "player", filter = "BUFF" },
                --飛彈彈幕
                { spellID = 79683, unitID = "player", caster = "player", filter = "BUFF" },
                --秘法強化
                { spellID = 12042, unitID = "player", caster = "player", filter = "BUFF" },
                --秘法衝擊
                { spellID = 36032, unitID = "player", caster = "player", filter = "DEBUFF" },
                --寒冰護體
                { spellID = 11426, unitID = "player", caster = "player", filter = "BUFF" },
                --腦部凍結
                { spellID = 57761, unitID = "player", caster = "player", filter = "BUFF" },
                --升溫
                { spellID = 48107, unitID = "player", caster = "player", filter = "BUFF" },
                --咒法結界
                { spellID = 1463, unitID = "player", caster = "player", filter = "BUFF" },
                --力之符文
                { spellID = 116014, unitID = "player", caster = "player", filter = "BUFF" },
                --咒法轉移
                { spellID = 116267, unitID = "player", caster = "player", filter = "BUFF" },
                --冰寒脈動
                { spellID = 12472, unitID = "player", caster = "player", filter = "BUFF" },
                --氣定神閒
                { spellID = 12043, unitID = "player", caster = "player", filter = "BUFF" },
                --時光倒轉
                { spellID = 110909, unitID = "player", caster = "player", filter = "BUFF" },
                --時光護盾
                { spellID = 115610, unitID = "player", caster = "player", filter = "BUFF" },
                --燒灼
                { spellID = 87023, unitID = "player", caster = "player", filter = "DEBUFF" },
                --強效隱形
                { spellID = 113862, unitID = "player", caster = "player", filter = "BUFF" },
                --冰霜炸彈
                { spellID = 112948, filter = "CD" },
		},
		{
			Name = "T_BUFF",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C["filger_position"].target_buff)},


		},
		{
			Name = "T_PROC",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C["filger_position"].target_proc)},

			--變形術
			{ spellID = 118, unitID = "target", caster = "all", filter = "DEBUFF" },
			--龍之吐息
			{ spellID = 31661, unitID = "target", caster = "all", filter = "DEBUFF" },
			--減速術
			{ spellID = 31589, unitID = "target", caster = "player", filter = "DEBUFF" },
			--燃火
			{ spellID = 83853, unitID = "target", caster = "player", filter = "DEBUFF" },
			--點燃
			{ spellID = 12654, unitID = "target", caster = "player", filter = "DEBUFF" },
			--活體爆彈
			{ spellID = 44457, unitID = "target", caster = "player", filter = "DEBUFF" },
			--炎爆術
			{ spellID = 11366, unitID = "target", caster = "player", filter = "DEBUFF" },
			--極度冰凍
			{ spellID = 44572, unitID = "target", caster = "all", filter = "DEBUFF" },
			--冰霜爆彈
			{ spellID = 112948, unitID = "target", caster = "player", filter = "DEBUFF" },
			--虛空暴雨
			{ spellID = 114923, unitID = "target", caster = "player", filter = "DEBUFF" },
		},
		{
			Name = "PVE/PVP_CC",
			Direction = "DOWN",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 189,
			Position = {unpack(C["filger_position"].pve_cc)},

			-- Polymorph
			{spellID = 118, unitID = "focus", caster = "all", filter = "DEBUFF"},
			--活體爆彈
            { spellID = 44457, unitID = "focus", caster = "player", filter = "DEBUFF" },
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 30,
			Position = {unpack(C["filger_position"].cooldown)},

			--镜像术
			{ spellID = 55342, filter = "CD" },
			--隐形术
			{ spellID = 66, filter = "CD" },
			--燃火
			{ spellID = 11129, filter = "CD" },
			--唤醒
			{ spellID = 12051, filter = "CD" },
			--秘法強化
			{ spellID = 12042, filter = "CD" },
			--急速冷卻
			{ spellID = 11958, filter = "CD" },
			--極度冰凍
			{ spellID = 44572, filter = "CD" },
			--冰寒脈動
			{ spellID = 12472, filter = "CD" },
			--寒冰屏障
			{ spellID = 45438, filter = "CD" },
			--冰霜之球
			{ spellID = 84714, filter = "CD" },

			-- 物品
			-- 手套
			{slotID = 10, filter = "CD" },
			-- 腰带
			{slotID = 6, filter = "CD" },
			-- 披风
			{slotID = 15, filter = "CD" },
			-- 饰品
			{slotID = 13, filter = "CD" },
			{slotID = 14, filter = "CD" },
		},
	},
	["MONK"] = {
		{
			Name = "P_BUFF",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C["filger_position"].player_buff)},

			--飄渺絕釀
			{ spellID = 128939, unitID = "player", caster = "player", filter = "BUFF" },
			--虎眼絕釀
			{ spellID = 125195, unitID = "player", caster = "player", filter = "BUFF" },
			--回生迷霧
			{ spellID = 119611, unitID = "player", caster = "player", filter = "BUFF" },
			--迷霧繚繞
			{ spellID = 132120, unitID = "player", caster = "player", filter = "BUFF" },
			--舒和之霧
			{ spellID = 115175, unitID = "player", caster = "player", filter = "BUFF" },
			--酒仙小緩勁
			{ spellID = 124275, unitID = "player", caster = "all", filter = "DEBUFF" },
			--酒仙中緩勁
			{ spellID = 124274, unitID = "player", caster = "all", filter = "DEBUFF" },
			--酒仙大緩勁
			{ spellID = 124273, unitID = "player", caster = "all", filter = "DEBUFF" },
			--法力茶
			{ spellID = 115867, unitID = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "P_PROC",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C["filger_position"].player_proc)},

			--虎掌
			{ spellID = 125359, unitID = "player", caster = "player", filter = "BUFF" },
			--禪心玉
			{ spellID = 124081, unitID = "player", caster = "player", filter = "BUFF" },
			--石形絕釀
			{ spellID = 120954, unitID = "player", caster = "player", filter = "BUFF" },
			--醉拳
			{ spellID = 115307, unitID = "player", caster = "player", filter = "BUFF" },
			--護身氣勁
			{ spellID = 115295, unitID = "player", caster = "player", filter = "BUFF" },
			--飄渺絕釀
			{ spellID = 115308, unitID = "player", caster = "player", filter = "BUFF" },
			--虎眼絕釀
			{ spellID = 116740, unitID = "player", caster = "player", filter = "BUFF" },
			--乾坤挪移
			{ spellID = 125174, unitID = "player", caster = "player", filter = "BUFF" },
			--蛟龍之誠
			{ spellID = 127722, unitID = "player", caster = "player", filter = "BUFF" },
			--精活迷霧
			{ spellID = 118674, unitID = "player", caster = "player", filter = "BUFF" },
			--連段破:滅寂腿
			{ spellID = 116768, unitID = "player", caster = "player", filter = "BUFF" },
			--連段破:虎掌
			{ spellID = 118864, unitID = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "T_BUFF",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C["filger_position"].target_buff)},

			--回生迷霧
			{ spellID = 119611, unitID = "target", caster = "player", filter = "BUFF" },
			--迷霧繚繞
			{ spellID = 132120, unitID = "target", caster = "player", filter = "BUFF" },
			--舒和之霧
			{ spellID = 115175, unitID = "target", caster = "player", filter = "BUFF" },
		},
		{
			Name = "T_PROC",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C["filger_position"].target_proc)},

			--掃葉腿
			{ spellID = 119381, unitID = "target", caster = "player", filter = "DEBUFF" },
			--微醺醉氣
			{ spellID = 116330, unitID = "target", caster = "player", filter = "DEBUFF" },
			--旭日东升踢
			{ spellID = 130320, unitID = "target", caster = "player", filter = "DEBUFF" },
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 30,
			Position = {unpack(C["filger_position"].cooldown)},

			--冥思禪功
			{ spellID = 115176, filter = "CD" },
			--乾坤挪移
			{ spellID = 122470, filter = "CD" },
			--召喚白虎雪怒
			{ spellID = 123904, filter = "CD" },
			--凝神絕釀
			{ spellID = 115288, filter = "CD" },
			--石形絕釀
			{ spellID = 115203, filter = "CD" },
			--召喚玄牛雕像
			{ spellID = 115315, filter = "CD" },
			--氣繭護體
			{ spellID = 116849, filter = "CD" },
			--五氣歸元
			{ spellID = 115310, filter = "CD" },

			-- 物品
			-- 手套
			{slotID = 10, filter = "CD" },
			-- 腰带
			{slotID = 6, filter = "CD" },
			-- 披风
			{slotID = 15, filter = "CD" },
			-- 饰品
			{slotID = 13, filter = "CD" },
			{slotID = 14, filter = "CD" },
		},
	},
	["PALADIN"] = {
		{
			Name = "P_BUFF",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C["filger_position"].player_buff)},

			--聖光信標
			{ spellID = 53563, unitID = "player", caster = "player", filter = "BUFF" },
			--永恆之火
			{ spellID = 114163, unitID = "player", caster = "player", filter = "BUFF" },
			--無私治療者
			{ spellID = 114250, unitID = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "P_PROC",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C["filger_position"].player_proc)},

			--神聖之盾
			{ spellID = 20925, unitID = "player", caster = "player", filter = "BUFF" },
			--神圣意志
			{ spellID = 90174, unitID = "player", caster = "player", filter = "BUFF" },
			--破晓
			{ spellID = 88819, unitID = "player", caster = "player", filter = "BUFF" },
			--神恩術
			{ spellID = 31842, unitID = "player", caster = "player", filter = "BUFF" },
			--神圣复仇者
			{ spellID = 105809, unitID = "player", caster = "player", filter = "BUFF" },
			--破曉之光
			{ spellID = 88819, unitID = "player", caster = "player", filter = "BUFF" },
			--聖光灌注
			{ spellID = 54149, unitID = "player", caster = "player", filter = "BUFF" },
			--聖佑術
			{ spellID = 498, unitID = "player", caster = "player", filter = "BUFF" },
			--戰爭藝術
			{ spellID = 59578, unitID = "player", caster = "player", filter = "BUFF" },
			--復仇之怒
			{ spellID = 31884, unitID = "player", caster = "player", filter = "BUFF" },
			--精通光環
			{ spellID = 31821, unitID = "player", caster = "player", filter = "BUFF" },
			--圣盾術
			{ spellID = 642, unitID = "player", caster = "player", filter = "BUFF" },
			--忠誠防衛者
			{ spellID = 31850, unitID = "player", caster = "player", filter = "BUFF" },
			--光速
			{ spellID = 85499, unitID = "player", caster = "player", filter = "BUFF" },
			--公正之盾
			{ spellID = 132403, unitID = "player", caster = "player", filter = "BUFF" },
			--榮耀壁壘
			{ spellID = 114637, unitID = "player", caster = "player", filter = "BUFF" },
			--大十字軍
			{ spellID = 85416, unitID = "player", caster = "player", filter = "BUFF" },
			--遠古諸王之光
			{ spellID = 86678, unitID = "player", caster = "all", filter = "BUFF" },
			--道高一丈
			{ spellID = 87173, unitID = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "T_BUFF",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C["filger_position"].target_buff)},

			--聖光信標
			{ spellID = 53563, unitID = "target", caster = "player", filter = "BUFF" },
			--纯净之手
			{ spellID = 114039, unitID = "target", caster = "player", filter = "BUFF" },
			--永恒之火
			{ spellID = 114163, unitID = "target", caster = "player", filter = "BUFF" },
			--处决审判
			{ spellID = 114157, unitID = "target", caster = "player", filter = "BUFF" },
			--圣洁护盾
			{ spellID = 20925, unitID = "target", caster = "player", filter = "BUFF" },
			--譴責
			{ spellID = 31803, unitID = "target", caster = "player", filter = "DEBUFF" },
		},
		{
			Name = "T_PROC",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C["filger_position"].target_proc)},

			--制裁之錘
			{ spellID = 853, unitID = "target", caster = "all", filter = "DEBUFF" },
			--制裁之拳
			{ spellID = 105593, unitID = "target", caster = "all", filter = "DEBUFF" },
			--自律
			{ spellID = 25771, unitID = "target", caster = "all", filter = "DEBUFF" },
			--罪之重擔
			{ spellID = 110300, unitID = "target", caster = "player", filter = "DEBUFF" },
			--公正聖印
			{ spellID = 20170, unitID = "target", caster = "player", filter = "DEBUFF" },
			--問罪
			{ spellID = 2812, unitID = "target", caster = "player", filter = "DEBUFF" },
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 30,
			Position = {unpack(C["filger_position"].cooldown)},

			--精通光環
			{ spellID = 31821, filter = "CD" },
			--聖佑術
			{ spellID = 498, filter = "CD" },

			-- 物品
			-- 手套
			{slotID = 10, filter = "CD" },
			-- 腰带
			{slotID = 6, filter = "CD" },
			-- 披风
			{slotID = 15, filter = "CD" },
			-- 饰品
			{slotID = 13, filter = "CD" },
			{slotID = 14, filter = "CD" },
		},
	},
	["PRIEST"] = {
		{
			Name = "P_BUFF",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C["filger_position"].player_buff)},

			--真言術：盾
			{ spellID = 17, unitID = "player", caster = "all", filter = "BUFF" },
			--虚弱靈魂
			{ spellID = 6788, unitID = "player", caster = "all", filter = "DEBUFF" },
			--恢复
			{ spellID = 139, unitID = "player", caster = "player", filter = "BUFF" },
			--漸隱術
			{ spellID = 586, unitID = "player", caster = "player", filter = "BUFF" },
			--防護恐懼結界
			{ spellID = 6346, unitID = "player", caster = "all", filter = "BUFF" },
			--預支時間
			{ spellID = 59889, unitID = "player", caster = "player", filter = "BUFF" },
			--精神鞭笞雕文
			{ spellID = 120587, unitID = "player", caster = "player", filter = "BUFF" },
			--身心合一
			{ spellID = 65081, unitID = "player", caster = "all", filter = "BUFF" },
			--天使之羽
			{ spellID = 121557, unitID = "player", caster = "all", filter = "BUFF" },
			--幻影術
			{ spellID = 114239, unitID = "player", caster = "player", filter = "BUFF" },
			--愈合之语
			{ spellID = 155362, unitID = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "P_PROC",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C["filger_position"].player_proc)},

			--機緣回復
			{ spellID = 63735, unitID = "player", caster = "player", filter = "BUFF" },
			--佈道
			{ spellID = 81661, unitID = "player", caster = "player", filter = "BUFF" },
			--大天使
			{ spellID = 81700, unitID = "player", caster = "player", filter = "BUFF" },
			--影散
			{ spellID = 47585, unitID = "player", caster = "player", filter = "BUFF" },
			--心靈鑚刺雕文
			{ spellID = 81292, unitID = "player", caster = "player", filter = "BUFF" },
			--暗影强化(4T16)
			{ spellID = 145180, unitID = "player", caster = "player", filter = "BUFF" },
			--鬼魅幻影
			{ spellID = 119032, unitID = "player", caster = "player", filter = "BUFF" },
			--天使之壁
			{ spellID = 114214, unitID = "player", caster = "player", filter = "BUFF" },
			--光之澎湃
			{ spellID = 114255, unitID = "player", caster = "player", filter = "BUFF" },
			--黑暗奔騰
			{ spellID = 87160, unitID = "player", caster = "player", filter = "BUFF" },
			--命運無常
			{ spellID = 123254, unitID = "player", caster = "player", filter = "BUFF" },
			--注入能量
			{ spellID = 10060, unitID = "player", caster = "player", filter = "BUFF" },
			--神聖洞察
			{ spellID = 123267, unitID = "player", caster = "player", filter = "BUFF" },
			--幽暗洞察
			{ spellID = 124430, unitID = "player", caster = "player", filter = "BUFF" },
			--精神護罩
			{ spellID = 109964, unitID = "player", caster = "player", filter = "BUFF" },
			--暗言术：乱
			{ spellID = 132573, unitID = "player", caster = "player", filter = "BUFF" },
			--愈合之语(十层)
			{ spellID = 155363, unitID = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "T_BUFF",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C["filger_position"].target_buff)},

			--真言术：盾
			{ spellID = 17, unitID = "target", caster = "all", filter = "BUFF" },
			--虚弱灵魂
			{ spellID = 6788, unitID = "target", caster = "all", filter = "DEBUFF" },
			--恢复
			{ spellID = 139, unitID = "target", caster = "player", filter = "BUFF" },
			--防護恐懼結界
			{ spellID = 6346, unitID = "target", caster = "all", filter = "BUFF" },
		},
		{
			Name = "T_PROC",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C["filger_position"].target_proc)},

			--束縛不死生物
			{ spellID = 9484, unitID = "target", caster = "all", filter = "DEBUFF" },
			--心靈尖嘯
			{ spellID = 8122, unitID = "target", caster = "all", filter = "DEBUFF" },
			--虛無觸鬚
			{ spellID = 114404, unitID = "target", caster = "all", filter = "DEBUFF" },
			--支配心智
			{ spellID = 605, unitID = "target", caster = "all", filter = "DEBUFF" },
			--暗言術:痛
			{ spellID = 589, unitID = "target", caster = "player", filter = "DEBUFF" },
			--吸血之觸
			{ spellID = 34914, unitID = "target", caster = "player", filter = "DEBUFF" },
			--噬靈瘟疫
			{ spellID = 158831, unitID = "target", caster = "player", filter = "DEBUFF" },
			--心靈恐慌
			{ spellID = 64044, unitID = "target", caster = "all", filter = "DEBUFF" },
			--沉默
			{ spellID = 15487, unitID = "target", caster = "all", filter = "DEBUFF" },
			--守護聖靈
			{ spellID = 47788, unitID = "target", caster = "all", filter = "BUFF" },
			--痛苦鎮壓
			{ spellID = 33206, unitID = "target", caster = "all", filter = "BUFF" },
			--意志洞悉
			{ spellID = 152118, unitID = "target", caster = "all", filter = "BUFF" },
			--虚空熵能
			{ spellID = 155361, unitID = "target", caster = "player", filter = "DEBUFF" },
		},		
		{
			Name = "T_DE/BUFF_BAR",
			Direction = "UP",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 186,
			Position = {unpack(C["filger_position"].target_bar)},

			-- Renew
			{spellID = 139, unitID = "target", caster = "player", filter = "BUFF"},
			-- Prayer of Mending
			{spellID = 41635, unitID = "target", caster = "player", filter = "BUFF"},
			-- Guardian Spirit
			{spellID = 47788, unitID = "target", caster = "player", filter = "BUFF"},
			-- Pain Suppression
			{spellID = 33206, unitID = "target", caster = "player", filter = "BUFF"},
			-- Shadow Word: Pain
			{spellID = 589, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Vampiric Touch
			{spellID = 34914, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Devouring Plague
			{spellID = 2944, unitID = "target", caster = "player", filter = "DEBUFF"},
		},
		{
			Name = "PVE/PVP_CC",
			Direction = "DOWN",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 189,
			Position = {unpack(C["filger_position"].pve_cc)},

			-- Shackle Undead
			{spellID = 9484, unitID = "focus", caster = "player", filter = "DEBUFF"},
			-- Psychic Scream
			{spellID = 8122, unitID = "focus", caster = "player", filter = "DEBUFF"},
			--虛無觸鬚
            { spellID = 114404, unitID = "focus", caster = "all", filter = "DEBUFF" },
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 30,
			Position = {unpack(C["filger_position"].cooldown)},

			--光束泉
			{ spellID = 126135, filter = "CD" },
			--神聖禮頌
			{ spellID = 64843, filter = "CD" },
			--守護聖靈
			{ spellID = 47788, filter = "CD" },
			--真言術:壁
			{ spellID = 62618, filter = "CD" },
			--痛苦鎮壓
			{ spellID = 33206, filter = "CD" },
			--影散
			{ spellID = 47585, filter = "CD" },
			--吸血鬼的擁抱
			{ spellID = 15286, filter = "CD" },
			--暗影魔
			{ spellID = 34433, filter = "CD" },
			--注入能量
			{ spellID = 10060, filter = "CD" },
			--絕望禱言
			{ spellID = 19236, filter = "CD" },

			-- 物品
			-- 手套
			{slotID = 10, filter = "CD" },
			-- 腰带
			{slotID = 6, filter = "CD" },
			-- 披风
			{slotID = 15, filter = "CD" },
			-- 饰品
			{slotID = 13, filter = "CD" },
			{slotID = 14, filter = "CD" },
		},
	},
	["ROGUE"] = {
		{
			Name = "P_BUFF",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C["filger_position"].player_buff)},

			--淺察
			{ spellID = 84745, unitID = "player", caster = "player", filter = "BUFF" },
			--中度洞察
			{ spellID = 84746, unitID = "player", caster = "player", filter = "BUFF" },
			--深度洞察
			{ spellID = 84747, unitID = "player", caster = "player", filter = "BUFF" },
			--手裏劍
			{ spellID = 137586, unitID = "player", caster = "player", filter = "BUFF" },
			--無聲之刃
			{ spellID = 145193, unitID = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "P_PROC",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C["filger_position"].player_proc)},

			--疾跑
			{ spellID = 2983, unitID = "player", caster = "player", filter = "BUFF" },
			--暗影披風
			{ spellID = 31224, unitID = "player", caster = "player", filter = "BUFF" },
			--能量刺激
			{ spellID = 13750, unitID = "player", caster = "player", filter = "BUFF" },
			--閃避
			{ spellID = 5277, unitID = "player", caster = "player", filter = "BUFF" },
			--戰鬥就緒
			{ spellID = 74001, unitID = "player", caster = "player", filter = "BUFF" },
			--毒化
			{ spellID = 32645, unitID = "player", caster = "player", filter = "BUFF" },
			--極限殺戮
			{ spellID = 58426, unitID = "player", caster = "player", filter = "BUFF" },
			--切割
			{ spellID = 5171, unitID = "player", caster = "player", filter = "BUFF" },
			--偷天換日
			{ spellID = 57934, unitID = "player", caster = "player", filter = "BUFF" },
			--偷天換日(傷害之後)
			{ spellID = 59628, unitID = "player", caster = "player", filter = "BUFF" },
			--养精蓄锐
			{ spellID = 73651, unitID = "player", caster = "player", filter = "BUFF" },
			--剑刃乱舞
			{ spellID = 13877, unitID = "player", caster = "player", filter = "BUFF" },
			--佯攻
			{ spellID = 1966, unitID = "player", caster = "player", filter = "BUFF" },
			--暗影之舞
			{ spellID = 51713, unitID = "player", caster = "player", filter = "BUFF" },
			--敏銳大師
			{ spellID = 31665, unitID = "player", caster = "player", filter = "BUFF" },
			--毀滅者之怒
			{ spellID = 109949, unitID = "player", caster = "player", filter = "BUFF" },
			--洞悉要害
			{ spellID = 121153, unitID = "player", caster = "player", filter = "BUFF" },
			--狂舞殘殺
			{ spellID = 51690, unitID = "player", caster = "player", filter = "BUFF" },
			--毒藥師
			{ spellID = 145249, unitID = "player", caster = "player", filter = "BUFF" },
			--欺敵
			{ spellID = 115192, unitID = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "T_BUFF",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C["filger_position"].target_buff)},

			--致命毒藥
			{ spellID = 2818, unitID = "target", caster = "player", filter = "DEBUFF" },
			--致殘毒藥
			{ spellID = 3409, unitID = "target", caster = "player", filter = "DEBUFF" },
			--吸血毒藥
			{ spellID = 112961, unitID = "target", caster = "player", filter = "DEBUFF" },
			--致傷毒藥
			{ spellID = 8680, unitID = "target", caster = "player", filter = "DEBUFF" },
		},
		{
			Name = "T_PROC",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C["filger_position"].target_proc)},

			--偷襲
			{ spellID = 1833, unitID = "target", caster = "all", filter = "DEBUFF" },
			--腎擊
			{ spellID = 408, unitID = "target", caster = "all", filter = "DEBUFF" },
			--致盲
			{ spellID = 2094, unitID = "target", caster = "all", filter = "DEBUFF" },
			--悶棍
			{ spellID = 6770, unitID = "target", caster = "all", filter = "DEBUFF" },
			--割裂
			{ spellID = 1943, unitID = "target", caster = "player", filter = "DEBUFF" },
			--絞喉
			{ spellID = 703, unitID = "target", caster = "player", filter = "DEBUFF" },
			--絞喉沉默
			{ spellID = 1330, unitID = "target", caster = "player", filter = "DEBUFF" },
			--鑿擊
			{ spellID = 1776, unitID = "target", caster = "player", filter = "DEBUFF" },
			--出血
			{ spellID = 89775, unitID = "target", caster = "player", filter = "DEBUFF" },
			--赤紅風暴
			{ spellID = 122233, unitID = "target", caster = "player", filter = "DEBUFF" },
			--揭底之擊
			{ spellID = 84617, unitID = "target", caster = "player", filter = "DEBUFF" },
			--宿怨
			{ spellID = 79140, unitID = "target", caster = "player", filter = "DEBUFF" },
			--出血
			{ spellID = 16511, unitID = "target", caster = "player", filter = "DEBUFF" },
			--找尋弱點
			{ spellID = 91021, unitID = "target", caster = "player", filter = "DEBUFF" },
			--制裁之錘
			{ spellID = 853, unitID = "target", caster = "all", filter = "DEBUFF" },
			--制裁之拳
			{ spellID = 105593, unitID = "target", caster = "all", filter = "DEBUFF" },
			--暗影反射
			{ spellID = 156745, unitID = "target", caster = "player", filter = "DEBUFF" },
		},
		{
			Name = "PVE/PVP_CC",
			Direction = "DOWN",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 189,
			Position = {unpack(C["filger_position"].pve_cc)},

			-- Blind
			{spellID = 2094, unitID = "focus", caster = "player", filter = "DEBUFF"},
			-- Sap
			{spellID = 6770, unitID = "focus", caster = "player", filter = "DEBUFF"},
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 30,
			Position = {unpack(C["filger_position"].cooldown)},

			--死亡標記
			{ spellID = 137619, filter = "CD" },
			--暗影步
			{ spellID = 36554, filter = "CD" },
			--预备
			{ spellID = 14185, filter = "CD" },
			--疾跑
			{ spellID = 2983, filter = "CD" },
			--斗篷
			{ spellID = 31224, filter = "CD" },
			--闪避
			{ spellID = 5277, filter = "CD" },
			--影舞
			{ spellID = 51713, filter = "CD" },
			--預謀
			{ spellID = 14183, filter = "CD" },
			--致盲
			{ spellID = 2094, filter = "CD" },
			--偷天換日
			{ spellID = 57934, filter = "CD" },
			--战斗就绪
			{ spellID = 74001, filter = "CD" },
			--烟雾弹
			{ spellID = 76577, filter = "CD" },
			--消失
			{ spellID = 1856, filter = "CD" },
			--宿怨
			{ spellID = 79140, filter = "CD" },
			--狂舞杀戮
			{ spellID = 51690, filter = "CD" },
			--能量刺激
			{ spellID = 13750, filter = "CD" },
			--奧術之流
			{ spellID = 25046, filter = "CD" },

			-- 物品
			-- 手套
			{slotID = 10, filter = "CD" },
			-- 腰带
			{slotID = 6, filter = "CD" },
			-- 披风
			{slotID = 15, filter = "CD" },
			-- 饰品
			{slotID = 13, filter = "CD" },
			{slotID = 14, filter = "CD" },
		},
	},
	["SHAMAN"] = {
		{
			Name = "P_BUFF",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C["filger_position"].player_buff)},

			--Earth Shield / Erdschild
			{ spellID = 974, unitID = "player", caster = "player", filter = "BUFF" },
			--Lightning Shield / Blitzschlagschild
			{ spellID = 324, unitID = "player", caster = "player", filter = "BUFF" },
			--Water Shield / Wasserschild
			{ spellID = 52127, unitID = "player", caster = "player", filter = "BUFF" },
			--治疗之雨
			{ spellID = 73920, unitID = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "P_PROC",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C["filger_position"].player_proc)},

			--Maelstorm Weapon / Waffe des Mahlstroms
			{ spellID = 53817, unitID = "player", caster = "player", filter = "BUFF" },
			--Shamanistic Rage / Schamanistische Wut
			{ spellID = 30823, unitID = "player", caster = "player", filter = "BUFF" },
			--靈行者之賜
			{ spellID = 79206, unitID = "player", caster = "player", filter = "BUFF" },
			--釋放生命武器
			{ spellID = 73685, unitID = "player", caster = "player", filter = "BUFF" },
			--治療之潮
			{ spellID = 53390, unitID = "player", caster = "player", filter = "BUFF" },
			--卓越術
			{ spellID = 114052, unitID = "player", caster = "player", filter = "BUFF" },
			--星界轉移
			{ spellID = 108271, unitID = "player", caster = "player", filter = "BUFF" },
			--升腾
			{ spellID = 114050, unitID = "player", caster = "player", filter = "BUFF" },
			--元素回响
			{ spellID = 159105, unitID = "player", caster = "player", filter = "BUFF" },
			--元素回响
			{ spellID = 159101, unitID = "player", caster = "player", filter = "BUFF" },
			--先祖指引
			{ spellID = 108281, unitID = "player", caster = "player", filter = "BUFF" },
			--元素掌握
			{ spellID = 16166, unitID = "player", caster = "player", filter = "BUFF" },
			--元素融合
			{ spellID = 157174, unitID = "player", caster = "player", filter = "BUFF" },
			--火焰释放
			{ spellID = 165462, unitID = "player", caster = "player", filter = "BUFF" },
			--Riptide / Springflut
			{ spellID = 61295, unitID = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "T_BUFF",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C["filger_position"].target_buff)},

			--Earth Shield / Erdschild
			{ spellID = 974, unitID = "target", caster = "player", filter = "BUFF" },
			--冰凍之力
			{ spellID = 63685, unitID = "target", caster = "player", filter = "DEBUFF" },
			--狂怒釋放
			{ spellID = 118473, unitID = "target", caster = "player", filter = "BUFF" },
		},
		{
			Name = "T_PROC",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C["filger_position"].target_proc)},

			--Hex / Verhexen
			{ spellID = 51514, unitID = "target", caster = "all", filter = "DEBUFF" },
			--Storm Strike / Sturmschlag
			{ spellID = 17364, unitID = "target", caster = "player", filter = "DEBUFF" },
			--Frost Shock / Frostschock
			{ spellID = 8056, unitID = "target", caster = "player", filter = "DEBUFF" },
			--Flame Shock / Flammenschock
			{ spellID = 8050, unitID = "target", caster = "player", filter = "DEBUFF" },
			--Riptide / Springflut
			{ spellID = 61295, unitID = "target", caster = "player", filter = "BUFF" },
			--地震术
			{ spellID = 61882, unitID = "target", caster = "player", filter = "DEBUFF" },
		},
		{
			Name = "T_DE/BUFF_BAR",
			Direction = "UP",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 186,
			Position = {unpack(C["filger_position"].target_bar)},

			-- Earth Shield
			{spellID = 974, unitID = "target", caster = "player", filter = "BUFF"},
			-- Riptide
			{spellID = 61295, unitID = "target", caster = "player", filter = "BUFF"},
		},
		{
			Name = "PVE/PVP_CC",
			Direction = "DOWN",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 189,
			Position = {unpack(C["filger_position"].pve_cc)},

			-- Hex
			{spellID = 51514, unitID = "focus", caster = "player", filter = "DEBUFF"},
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 30,
			Position = {unpack(C["filger_position"].cooldown)},

			--火元素圖騰
			{ spellID = 2894, filter = "CD" },
			--土元素圖騰
			{ spellID = 2062, filter = "CD" },

			-- 物品
			-- 手套
			{slotID = 10, filter = "CD" },
			-- 腰带
			{slotID = 6, filter = "CD" },
			-- 披风
			{slotID = 15, filter = "CD" },
			-- 饰品
			{slotID = 13, filter = "CD" },
			{slotID = 14, filter = "CD" },
		},
	},
	["WARLOCK"] = {
		{
			Name = "P_BUFF",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C["filger_position"].player_buff)},

			--黑暗再生
			{ spellID = 108359, unitID = "player", caster = "player", filter = "BUFF" },
			--灵魂榨取
			{ spellID = 108366, unitID = "player", caster = "player", filter = "BUFF" },
			--牺牲契约
			{ spellID = 108416, unitID = "player", caster = "player", filter = "BUFF" },
			--黑暗交易
			{ spellID = 110913, unitID = "player", caster = "player", filter = "BUFF" },
			--猩红恐惧
			{ spellID = 111397, unitID = "player", caster = "player", filter = "BUFF" },
			--爆燃冲刺
			{ spellID = 111400, unitID = "player", caster = "player", filter = "BUFF" },
			--魔性征召
			{ spellID = 114925, unitID = "player", caster = "player", filter = "BUFF" },
			--魔典：恶魔牺牲
			{ spellID = 108503, unitID = "player", caster = "player", filter = "BUFF" },
			--恶魔法阵：召唤
			{ spellID = 48018, unitID = "player", caster = "player", filter = "BUFF" },
			--灵魂石保存
			{ spellID = 20707, unitID = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "P_PROC",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C["filger_position"].player_proc)},

			--灵魂燃烧
			{ spellID = 74434, unitID = "player", caster = "player", filter = "BUFF" },
			--灵魂交换
			{ spellID = 86211, unitID = "player", caster = "player", filter = "BUFF" },
			--黑暗灵魂：哀难
			{ spellID = 113860, unitID = "player", caster = "player", filter = "BUFF" },
			--熔火之心
			{ spellID = 122355, unitID = "player", caster = "player", filter = "BUFF" },
			--恶魔协同
			{ spellID = 171982, unitID = "player", caster = "all", filter = "BUFF" },
			--炽燃之怒(2T16)
			{ spellID = 145085, unitID = "player", caster = "player", filter = "BUFF" },
			--黑暗灵魂：学识
			{ spellID = 113861, unitID = "player", caster = "player", filter = "BUFF" },
			--爆燃
			{ spellID = 117828, unitID = "player", caster = "player", filter = "BUFF" },
			--火焰之雨
			{ spellID = 104232, unitID = "player", caster = "player", filter = "BUFF" },
			--硫磺烈火
			{ spellID = 108683, unitID = "player", caster = "player", filter = "BUFF" },
			--浩劫
			{ spellID = 80240, unitID = "player", caster = "player", filter = "BUFF" },
			--黑暗灵魂：易爆
			{ spellID = 113858, unitID = "player", caster = "player", filter = "BUFF" },
			--基尔加丹的狡诈
			{ spellID = 137587, unitID = "player", caster = "player", filter = "BUFF" },
			--玛诺洛斯的狂怒
			{ spellID = 108508, unitID = "player", caster = "player", filter = "BUFF" },
			--不灭决心
			{ spellID = 104773, unitID = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "T_BUFF",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C["filger_position"].target_buff)},

			
		},
		{
			Name = "T_PROC",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C["filger_position"].target_proc)},

			--恐懼術
			{ spellID = 118699, unitID = "target", caster = "player", filter = "DEBUFF" },
			--放逐術
			{ spellID = 710, unitID = "target", caster = "player", filter = "DEBUFF" },
			--腐蝕術
			{ spellID = 146739, unitID = "target", caster = "player", filter = "DEBUFF" },
			--痛苦災厄
			{ spellID = 980, unitID = "target", caster = "player", filter = "DEBUFF" },
			--痛苦動盪
			{ spellID = 30108, unitID = "target", caster = "player", filter = "DEBUFF" },
			--蝕魂術
			{ spellID = 48181, unitID = "target", caster = "player", filter = "DEBUFF" },
			--腐蝕種子
			{ spellID = 27243, unitID = "target", caster = "player", filter = "DEBUFF" },
			--古尔丹之手
			{ spellID = 47960, unitID = "target", caster = "player", filter = "DEBUFF" },
			--末日降临
			{ spellID = 603, unitID = "target", caster = "player", filter = "DEBUFF" },
			--獻祭
			{ spellID = 157736, unitID = "target", caster = "player", filter = "DEBUFF" },
			--浩劫
			{ spellID = 80240, unitID = "target", caster = "player", filter = "DEBUFF" },
			--恐懼嚎叫
			{ spellID = 5484, unitID = "target", caster = "player", filter = "DEBUFF" },
			--死亡纏繞
			{ spellID = 6789, unitID = "target", caster = "player", filter = "DEBUFF" },
			--暗影之怒
			{ spellID = 30283, unitID = "target", caster = "player", filter = "DEBUFF" },
			--奴役惡魔
			{ spellID = 1098, unitID = "pet", caster = "player", filter = "DEBUFF" },
		},
		{
			Name = "T_DE/BUFF_BAR",
			Direction = "UP",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 186,
			Position = {unpack(C["filger_position"].target_bar)},

			-- Doom
			{spellID = 603, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Agony
			{spellID = 980, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Corruption
			{spellID = 146739, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Seed of Corruption
			{spellID = 27243, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Immolate
			{spellID = 348, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Unstable Affliction
			{spellID = 30108, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Haunt
			{spellID = 48181, unitID = "target", caster = "player", filter = "DEBUFF"},
		},
		{
			Name = "PVE/PVP_CC",
			Direction = "DOWN",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 189,
			Position = {unpack(C["filger_position"].pve_cc)},

			-- Fear
			{spellID = 118699, unitID = "focus", caster = "player", filter = "DEBUFF"},
			-- Banish
			{spellID = 710, unitID = "focus", caster = "player", filter = "DEBUFF"},
			--恐懼嚎叫
            { spellID = 5484, unitID = "focus", caster = "all", filter = "DEBUFF" },
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 30,
			Position = {unpack(C["filger_position"].cooldown)},

			-- 物品
			-- 手套
			{slotID = 10, filter = "CD" },
			-- 腰带
			{slotID = 6, filter = "CD" },
			-- 披风
			{slotID = 15, filter = "CD" },
			-- 饰品
			{slotID = 13, filter = "CD" },
			{slotID = 14, filter = "CD" },
		},
	},
	["WARRIOR"] = {
		{
			Name = "P_BUFF",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C["filger_position"].player_buff)},

			--勝利
			{ spellID = 32216, unitID = "player", caster = "player", filter = "BUFF" },
			--嗜血
			{ spellID = 23881, filter = "CD" },
			--巨人打击
			{ spellID = 86346, filter = "CD" },
	},
		{
			Name = "P_PROC",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C["filger_position"].player_proc)},

			--驟亡
			{ spellID = 52437, unitID = "player", caster = "player", filter = "BUFF" },
			--狂暴之怒
			{ spellID = 18499, unitID = "player", caster = "player", filter = "BUFF" },
			--魯莽
			{ spellID = 1719, unitID = "player", caster = "player", filter = "BUFF" },
			--熱血沸騰
			{ spellID = 46916, unitID = "player", caster = "player", filter = "BUFF" },
			--劍盾合璧
			{ spellID = 50227, unitID = "player", caster = "player", filter = "BUFF" },
			--蓄血
			{ spellID = 64568, unitID = "player", caster = "player", filter = "BUFF" },
			--法術反射
			{ spellID = 23920, unitID = "player", caster = "player", filter = "BUFF" },
			--勝利衝擊
			{ spellID = 34428, unitID = "player", caster = "player", filter = "BUFF" },
			--盾牌格擋
			{ spellID = 132404, unitID = "player", caster = "player", filter = "BUFF" },
			--盾墻
			{ spellID = 871, unitID = "player", caster = "player", filter = "BUFF" },
			--狂怒恢復
			{ spellID = 55694, unitID = "player", caster = "player", filter = "BUFF" },
			--橫掃攻擊
			{ spellID = 12328, unitID = "player", caster = "player", filter = "BUFF" },
			--绞肉机
			{ spellID = 85739, unitID = "player", caster = "player", filter = "BUFF" },
			--狂怒之擊!
			{ spellID = 131116, unitID = "player", caster = "player", filter = "BUFF" },
			--浴血
			{ spellID = 12292, unitID = "player", caster = "player", filter = "BUFF" },
			--怒击！
			{ spellID = 131116, unitID = "player", caster = "player", filter = "BUFF" },
			--剑刃风暴
			{ spellID = 46924, unitID = "player", caster = "player", filter = "BUFF" },
			--激怒
			{ spellID = 12880, unitID = "player", caster = "player", filter = "BUFF" },
			--死亡裁决
			{ spellID = 144442, unitID = "player", caster = "player", filter = "BUFF" },
			--盾牌屏障
			{ spellID = 112048, unitID = "player", caster = "player", filter = "BUFF" },
			--最后通牒
			{ spellID = 122510, unitID = "player", caster = "player", filter = "BUFF" },
			--剑在人在
			{ spellID = 118038, unitID = "player", caster = "player", filter = "BUFF" },
			--盾牌冲锋
			{ spellID = 156321, unitID = "player", caster = "player", filter = "BUFF" },
			--盾牌冲锋
			{ spellID = 169667, unitID = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "T_BUFF",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C["filger_position"].target_buff)},


		},
		{
			Name = "T_PROC",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C["filger_position"].target_proc)},

			--撕裂
			{ spellID = 772, unitID = "target", caster = "player", filter = "DEBUFF" },
			--震盪波
			{ spellID = 46968, unitID = "target", caster = "all", filter = "DEBUFF" },
			--斷筋
			{ spellID = 1715, unitID = "target", caster = "all", filter = "DEBUFF" },
			--挫志怒吼
			{ spellID = 1160, unitID = "target", caster = "player", filter = "DEBUFF" },
			--破膽怒吼
			{ spellID = 5246, unitID = "target", caster = "player", filter = "DEBUFF" },
			--巨人打击
			{ spellID = 167105, unitID = "target", caster = "player", filter = "DEBUFF" },
			--感染之傷(德魯伊)
			{ spellID = 48484, unitID = "target", caster = "all", filter = "DEBUFF" },
			--挫志咆哮(德魯伊)
			{ spellID = 99, unitID = "target", caster = "all", filter = "DEBUFF" },
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 30,
			Position = {unpack(C["filger_position"].cooldown)},

			--鲁莽
			{ spellID = 1719, filter = "CD" },
			--浴血奋战
			{ spellID = 12292, filter = "CD" },
			--盾墙
			{ spellID = 871, filter = "CD" },
			--集结呐喊
			{ spellID = 97462, filter = "CD" },
			--破胆怒吼
			{ spellID = 5246, filter = "CD" },
			--天神下凡
			{ spellID = 107574, filter = "CD" },

			-- 物品
			-- 手套
			{ slotID = 10, filter = "CD" },
			-- 腰带
			{ slotID = 6, filter = "CD" },
			-- 披风
			{ slotID = 15, filter = "CD" },
			-- 饰品
			{ slotID = 13, filter = "CD" },
			{ slotID = 14, filter = "CD" },
		},
	},
	["ALL"] = {
		{
			Name = "P_SPECIAL",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 45,
			Position = {unpack(C["filger_position"].player_special)},

			--飾品
                -- PvP 飾品 (生命上限)
                { spellID = 126697, unitID = "player", caster = "all", filter = "BUFF" },
                -- PvP 飾品 (全能)
                { spellID = 170397, unitID = "player", caster = "all", filter = "BUFF" },

                -- 暗月卡牌
                -- 玉珑圣物 (智力, 触发)
                { spellID = 128985, unitID = "player", caster = "all", filter = "BUFF" },
                -- 雪怒圣物 (力量, 触发)
                { spellID = 128986, unitID = "player", caster = "all", filter = "BUFF" },
                -- 雪怒圣物 (敏捷, 触发)
                { spellID = 128984, unitID = "player", caster = "all", filter = "BUFF" },
                -- 赤精圣物 (精神, 触发)
                { spellID = 128987, unitID = "player", caster = "all", filter = "BUFF" },
                -- 骑士徽章 (爆击, 触发)
                { spellID = 162917, unitID = "player", caster = "all", filter = "BUFF" },
                -- 战争之颅 (爆击, 触发)
                { spellID = 162915, unitID = "player", caster = "all", filter = "BUFF" },
                -- 睡魔之袋 (爆击, 触发)
                { spellID = 162919, unitID = "player", caster = "all", filter = "BUFF" },
                -- 羽翼沙漏 (精神, 触发)
                { spellID = 162913, unitID = "player", caster = "all", filter = "BUFF" },

                -- 坦
                -- 岩心雕像
                { spellID = 176982, unitID = "player", caster = "all", filter = "BUFF" },
                -- 齐布的愚忠
                { spellID = 176460, unitID = "player", caster = "all", filter = "BUFF" },
                -- 普尔的盲目之眼
                { spellID = 176876, unitID = "player", caster = "all", filter = "BUFF" },
                -- 石化食肉孢子
                { spellID = 165824, unitID = "player", caster = "all", filter = "BUFF" },
                -- 不眠奥术精魂
                { spellID = 177053, unitID = "player", caster = "all", filter = "BUFF" },
                -- 无懈合击石板
                { spellID = 176873, unitID = "player", caster = "all", filter = "BUFF" },
                -- 爆裂熔炉之门
                { spellID = 177056, unitID = "player", caster = "all", filter = "BUFF" },
                -- 重击护符
                { spellID = 177102, unitID = "player", caster = "all", filter = "BUFF" },
                -- 鲁克的不幸护符 (减伤, 使用)
                { spellID = 146343, unitID = "player", caster = "all", filter = "BUFF" },
                -- 砮皂之毅 (躲闪, 使用)
                { spellID = 146344, unitID = "player", caster = "all", filter = "BUFF" },
                -- 季鹍的复苏之风 (生命, 触发)
                { spellID = 138973, unitID = "player", caster = "all", filter = "BUFF" },
                -- 赞达拉之韧 (生命, 使用)
                { spellID = 126697, unitID = "player", caster = "all", filter = "BUFF" },
                -- 嗜血者的精致小瓶 (精通, 触发)
                { spellID = 138864, unitID = "player", caster = "all", filter = "BUFF" },
                -- 影踪突袭营的坚定护符 (躲闪, 使用)
                { spellID = 138728, unitID = "player", caster = "all", filter = "BUFF" },
                -- 梦魇残片 (躲闪, 触发)
                { spellID = 126646, unitID = "player", caster = "all", filter = "BUFF" },
                -- 龙血之瓶 (躲闪, 触发)
                { spellID = 126533, unitID = "player", caster = "all", filter = "BUFF" },
                -- 玉质军阀俑 (精通, 使用)
                { spellID = 126597, unitID = "player", caster = "all", filter = "BUFF" },

                -- 物理敏捷DPS
                -- 黑心执行者勋章
                { spellID = 176984, unitID = "player", caster = "all", filter = "BUFF" },
                -- 双面幸运金币
                { spellID = 177597, unitID = "player", caster = "all", filter = "BUFF" },
                -- 毁灭之鳞
                { spellID = 177038, unitID = "player", caster = "all", filter = "BUFF" },
                -- 多肉龙脊奖章
                { spellID = 177035, unitID = "player", caster = "all", filter = "BUFF" },
                -- 跃动的山脉之心
                { spellID = 176878, unitID = "player", caster = "all", filter = "BUFF" },
                -- 蜂鸣黑铁触发器
                { spellID = 177067, unitID = "player", caster = "all", filter = "BUFF" },
                -- 既定之天命 (敏捷, 触发)
                { spellID = 146308, unitID = "player", caster = "all", filter = "BUFF" },
                -- 哈洛姆的护符 (敏捷, 触发)
                { spellID = 148903, unitID = "player", caster = "all", filter = "BUFF" },
                -- 暴怒之印 (敏捷, 触发)
                { spellID = 148896, unitID = "player", caster = "all", filter = "BUFF" },
                -- 滴答作响的黑色雷管 (敏捷, 触发)
                { spellID = 146310, unitID = "player", caster = "all", filter = "BUFF" },
                -- 雪怒之律 (爆击, 触发)
                { spellID = 146312, unitID = "player", caster = "all", filter = "BUFF" },
                -- 邪恶魂能 (敏捷, 触发)
                { spellID = 138938, unitID = "player", caster = "all", filter = "BUFF" },
                -- 杀戮护符 (急速, 触发)
                { spellID = 138895, unitID = "player", caster = "all", filter = "BUFF" },
                -- 重生符文 (转换, 触发)
                { spellID = 139120, unitID = "player", caster = "all", filter = "BUFF" },
                { spellID = 139121, unitID = "player", caster = "all", filter = "BUFF" },
                { spellID = 139117, unitID = "player", caster = "all", filter = "BUFF" },
                -- 雷纳塔基的灵魂符咒 (敏捷, 触发)
                { spellID = 138756, unitID = "player", caster = "all", filter = "BUFF" },
                -- 影踪突袭营的邪恶护符 (敏捷, 触发)
                { spellID = 138699, unitID = "player", caster = "all", filter = "BUFF" },
                -- 飞箭奖章 (爆击, 使用)
                { spellID = 136086, unitID = "player", caster = "all", filter = "BUFF" },
                -- 萦雾之恐 (爆击, 触发)
                { spellID = 126649, unitID = "player", caster = "all", filter = "BUFF" },
                -- 玉质盗匪俑 (急速, 使用)
                { spellID = 126599, unitID = "player", caster = "all", filter = "BUFF" },
                -- 群星之瓶 (敏捷, 触发)
                { spellID = 126554, unitID = "player", caster = "all", filter = "BUFF" },
                -- PvP飾品 (敏捷, 使用)
                { spellID = 126690, unitID = "player", caster = "all", filter = "BUFF" },
                -- PvP飾品 (敏捷, 觸發)
                { spellID = 126707, unitID = "player", caster = "all", filter = "BUFF" },

                -- 物理力量DPS
                -- 活体火山微粒
                { spellID = 176974, unitID = "player", caster = "all", filter = "BUFF" },
                -- 齐亚诺斯的剑鞘
                { spellID = 177189, unitID = "player", caster = "all", filter = "BUFF" },
                -- 泰克图斯的脉动之心
                { spellID = 177040, unitID = "player", caster = "all", filter = "BUFF" },
                -- 抽搐暗影之瓶
                { spellID = 176874, unitID = "player", caster = "all", filter = "BUFF" },
                -- 尖啸之魂号角
                { spellID = 177042, unitID = "player", caster = "all", filter = "BUFF" },
                -- 熔炉主管的徽记
                { spellID = 177096, unitID = "player", caster = "all", filter = "BUFF" },
                -- 迦拉卡斯的邪恶之眼 (力量, 触发)
                { spellID = 146245, unitID = "player", caster = "all", filter = "BUFF" },
                -- 索克的尾巴尖 (力量, 触发)
                { spellID = 146250, unitID = "player", caster = "all", filter = "BUFF" },
                -- 斯基尔的沁血护符 (力量, 触发)
                { spellID = 146285, unitID = "player", caster = "all", filter = "BUFF" },
                -- 融火之核 (力量, 触发)
                { spellID = 148899, unitID = "player", caster = "all", filter = "BUFF" },
                -- 天神迅捷 (急速, 触发)
                { spellID = 146296, unitID = "player", caster = "all", filter = "BUFF" },
                -- 季鹍的传说之羽 (力量, 触发)
                { spellID = 138759, unitID = "player", caster = "all", filter = "BUFF" },
                -- 赞达拉之火 (力量, 触发)
                { spellID = 138958, unitID = "player", caster = "all", filter = "BUFF" },
                -- 普莫迪斯的狂怒咒符 (力量, 触发)
                { spellID = 138870, unitID = "player", caster = "all", filter = "BUFF" },
                -- 双后的凝视 (爆击, 触发)
                { spellID = 139170, unitID = "player", caster = "all", filter = "BUFF" },
                -- 破盔者奖章 (爆击, 使用)
                { spellID = 136084, unitID = "player", caster = "all", filter = "BUFF" },
                -- 影踪突袭营的野蛮护符 (力量, 触发)
                { spellID = 138702, unitID = "player", caster = "all", filter = "BUFF" },
                -- 黑雾漩涡 (急速, 触发)
                { spellID = 126657, unitID = "player", caster = "all", filter = "BUFF" },
                -- 雷神的遗诏 (力量, 触发)
                { spellID = 126582, unitID = "player", caster = "all", filter = "BUFF" },
                -- 玉质御者俑 (力量, 使用)
                { spellID = 126599, unitID = "player", caster = "all", filter = "BUFF" },
                -- 铁腹炒锅 (急速, 使用)
                { spellID = 129812, unitID = "player", caster = "all", filter = "BUFF" },
                -- PvP飾品 (力量, 使用)
                { spellID = 126679, unitID = "player", caster = "all", filter = "BUFF" },
                -- PvP飾品 (力量, 觸發)
                { spellID = 126700, unitID = "player", caster = "all", filter = "BUFF" },

                -- 法系通用
                -- 科普兰的清醒
                { spellID = 177594, unitID = "player", caster = "all", filter = "BUFF" },
                -- 雷衝勳章 (智力, 使用)
                { spellID = 136082, unitID = "player", caster = "all", filter = "BUFF" },
                -- 翠玉執政官刻像 (暴擊, 使用)
                { spellID = 126605, unitID = "player", caster = "all", filter = "BUFF" },
                -- PvP飾品 (法術強度, 使用)
                { spellID = 126683, unitID = "player", caster = "all", filter = "BUFF" },
                -- PvP飾品 (法術強度, 觸發)
                { spellID = 126705, unitID = "player", caster = "all", filter = "BUFF" },

                -- 法系DPS
                -- 動亂聚焦水晶
                { spellID = 176882, unitID = "player", caster = "all", filter = "BUFF" },
                -- 狂怒之心护符
                { spellID = 176980, unitID = "player", caster = "all", filter = "BUFF" },
                -- 虚无碎片
                { spellID = 176875, unitID = "player", caster = "all", filter = "BUFF" },
                -- 髟鼠蜥人灵魂容器
                { spellID = 177046, unitID = "player", caster = "all", filter = "BUFF" },
                -- 达玛克的无常护符
                { spellID = 177051, unitID = "player", caster = "all", filter = "BUFF" },
                -- 黑铁微型坩埚
                { spellID = 177081, unitID = "player", caster = "all", filter = "BUFF" },
                -- 伊墨苏斯的净化之缚 (智力, 触发)
                { spellID = 146046, unitID = "player", caster = "all", filter = "BUFF" },
                -- 卡德里斯的剧毒图腾 (智力, 触发)
                { spellID = 148906, unitID = "player", caster = "all", filter = "BUFF" },
                -- 亚煞极的黑暗之血 (智力, 触发)
                { spellID = 146184, unitID = "player", caster = "all", filter = "BUFF" },
                -- 狂怒水晶 (智力, 触发)
                { spellID = 148897, unitID = "player", caster = "all", filter = "BUFF" },
                -- 玉珑之噬 (爆击, 触发)
                { spellID = 146218, unitID = "player", caster = "all", filter = "BUFF" },
                -- 雷神的精准之视 (智力, 触发)
                { spellID = 138963, unitID = "player", caster = "all", filter = "BUFF" },
                -- 张叶的辉煌精华 (智力, 触发)
                { spellID = 139133, unitID = "player", caster = "all", filter = "BUFF" },
                -- 九头蛇之息 (智力, 触发)
                { spellID = 138898, unitID = "player", caster = "all", filter = "BUFF" },
                -- 乌苏雷的最终抉择 (智力, 触发)
                { spellID = 138786, unitID = "player", caster = "all", filter = "BUFF" },
                -- 影踪突袭营的烈性咒符 (急速, 触发)
                { spellID = 138703, unitID = "player", caster = "all", filter = "BUFF" },
                -- 惊怖精华 (急速, 触发)
                { spellID = 126659, unitID = "player", caster = "all", filter = "BUFF" },
                -- 宇宙之光 (智力, 触发)
                { spellID = 126577, unitID = "player", caster = "all", filter = "BUFF" },

                -- 治療
                -- 完美的活性蘑菇
                { spellID = 176978, unitID = "player", caster = "all", filter = "BUFF" },
                -- 腐蚀治疗徽章
                { spellID = 176879, unitID = "player", caster = "all", filter = "BUFF" },
                -- 元素师的屏蔽护符
                { spellID = 177063, unitID = "player", caster = "all", filter = "BUFF" },
                -- 铁刺狗玩具
                { spellID = 177060, unitID = "player", caster = "all", filter = "BUFF" },
                -- 自动修复灭菌器
                { spellID = 177086, unitID = "player", caster = "all", filter = "BUFF" },
                -- 傲慢之棱光囚笼 (智力, 触发)
                { spellID = 146314, unitID = "player", caster = "all", filter = "BUFF" },
                -- 纳兹戈林的抛光勋章 (智力, 触发)
                { spellID = 148908, unitID = "player", caster = "all", filter = "BUFF" },
                -- 索克的酸蚀之牙 (智力, 触发)
                { spellID = 148911, unitID = "player", caster = "all", filter = "BUFF" },
                -- 间歇性变异平衡器 (精神, 触发)
                { spellID = 146317, unitID = "player", caster = "all", filter = "BUFF" },
                -- 九头蛇卵的铭文袋 (吸收, 触发)
                { spellID = 140380, unitID = "player", caster = "all", filter = "BUFF" },
                -- 赫利东的垂死之息 (法力, 触发)
                { spellID = 138856, unitID = "player", caster = "all", filter = "BUFF" },
                -- 骄阳之魂 (精神, 触发)
                { spellID = 126640, unitID = "player", caster = "all", filter = "BUFF" },
                -- 秦希的偏振之印 (智力, 触发)
                { spellID = 126588, unitID = "player", caster = "all", filter = "BUFF" },

            --專業技能
                -- 神經突觸彈簧
                { spellID = 126734, unitID = "player", caster = "player", filter = "BUFF", fuzzy = true },
                -- 硝基推進器
                { spellID = 54861, unitID = "player", caster = "all", filter = "BUFF" },
                -- 降落傘
                { spellID = 55001, unitID = "player", caster = "all", filter = "BUFF" },
                -- 德萊尼煉金石
                { spellID = 60234, unitID = "player", caster = "all", filter = "BUFF" },

            --武器附魔
                -- 涓咏
                { spellID = 116660, unitID = "player", caster = "all", filter = "BUFF" },
                -- 玉魂
                { spellID = 104993, unitID = "player", caster = "all", filter = "BUFF" },
                -- 钢铁之舞
                { spellID = 120032, unitID = "player", caster = "all", filter = "BUFF" },
                -- 爆裂领主的毁灭瞄准镜
                { spellID = 109085, unitID = "player", caster = "all", filter = "BUFF" },
                -- 雷神之印
                { spellID = 159234, unitID = "player", caster = "all", filter = "BUFF" },
                -- 战歌之印
                { spellID = 159675, unitID = "player", caster = "all", filter = "BUFF" },
                -- 血环之印
                { spellID = 173322, unitID = "player", caster = "all", filter = "BUFF" },
                -- 霜狼之印
                { spellID = 159676, unitID = "player", caster = "all", filter = "BUFF" },
                -- 影月之印
                { spellID = 159678, unitID = "player", caster = "all", filter = "BUFF" },
                -- 黑石之印
                { spellID = 159679, unitID = "player", caster = "all", filter = "BUFF" },

            --藥水
                -- Draenic Agility Potion
                { spellID = 156423, unitID = "player", caster = "player", filter = "BUFF" },
                -- Draenic Intellect Potion
                { spellID = 156426, unitID = "player", caster = "player", filter = "BUFF" },
                -- Draenic Strength Potion
                { spellID = 156428, unitID = "player", caster = "player", filter = "BUFF" },
                -- Draenic Armor Potion
                { spellID = 156430, unitID = "player", caster = "player", filter = "BUFF" },
                -- 玉蛟
                { spellID = 105702, unitID = "player", caster = "player", filter = "BUFF" },
                -- 兔妖之咬
                { spellID = 105697, unitID = "player", caster = "player", filter = "BUFF" },
                -- 魔古之力
                { spellID = 105706, unitID = "player", caster = "player", filter = "BUFF" },
                -- 卡法加速
                { spellID = 125282, unitID = "player", caster = "player", filter = "BUFF" },

            --特殊buff
                -- 偷天換日
                { spellID = 57933, unitID = "player", caster = "all", filter = "BUFF" },
                -- 嗜血術
                { spellID = 2825, unitID = "player", caster = "all", filter = "BUFF" },
                -- 英勇氣概
                { spellID = 32182, unitID = "player", caster = "all", filter = "BUFF" },
                -- 時間扭曲
                { spellID = 80353, unitID = "player", caster = "all", filter = "BUFF" },
                -- 上古狂亂
                { spellID = 90355, unitID = "player", caster = "all", filter = "BUFF" },
                -- 警戒
                { spellID = 114030, unitID = "player", caster = "all", filter = "BUFF" },
                -- 群体法术反射
                { spellID = 114028, unitID = "player", caster = "all", filter = "BUFF" },
                -- 振奮咆哮
                { spellID = 97463, unitID = "player", caster = "all", filter = "BUFF" },
                -- 反魔法力场
                { spellID = 145629, unitID = "player", caster = "all", filter = "BUFF" },
                -- 犧牲聖禦
                { spellID = 6940, unitID = "player", caster = "all", filter = "BUFF" },
                -- 保護聖禦
                { spellID = 1022, unitID = "player", caster = "all", filter = "BUFF" },
                -- 虔誠光環
                { spellID = 31821, unitID = "player", caster = "all", filter = "BUFF" },
                -- 守护之魂
                { spellID = 47788, unitID = "player", caster = "all", filter = "BUFF" },
                -- 痛苦镇压
                { spellID = 33206, unitID = "player", caster = "all", filter = "BUFF" },
                -- 真言術：壁
                { spellID = 81782, unitID = "player", caster = "all", filter = "BUFF" },
                -- 吸血鬼的拥抱
                { spellID = 15286, unitID = "player", caster = "all", filter = "BUFF" },
                -- 灵魂链接图腾
                { spellID = 98008, unitID = "player", caster = "all", filter = "BUFF" },
                -- 气茧护体
                { spellID = 116849, unitID = "player", caster = "all", filter = "BUFF" },
                -- 烟雾弹
                { spellID = 88611, unitID = "player", caster = "all", filter = "BUFF" },
                -- 铁木树皮
                { spellID = 102342, unitID = "player", caster = "all", filter = "BUFF" },
                -- 奔窜咆哮
                { spellID = 106898, unitID = "player", caster = "all", filter = "BUFF" },
                -- 灵狐守护
                { spellID = 172106, unitID = "player", caster = "all", filter = "BUFF" },
                -- 魔法增效
                { spellID = 159916, unitID = "player", caster = "all", filter = "BUFF" },

            --橙色多彩
                -- 不屈之源钻 (耐力, 减伤)
                { spellID = 137593, unitID = "player", caster = "all", filter = "BUFF" },
                -- 阴险之源钻 (爆击, 急速)
                { spellID = 137590, unitID = "player", caster = "all", filter = "BUFF" },
                -- 英勇之源钻 (智力, 节能)
                { spellID = 137331, unitID = "player", caster = "all", filter = "BUFF" },
                { spellID = 137247, unitID = "player", caster = "all", filter = "BUFF" },
                { spellID = 137323, unitID = "player", caster = "all", filter = "BUFF" },
                { spellID = 137326, unitID = "player", caster = "all", filter = "BUFF" },
                { spellID = 137288, unitID = "player", caster = "all", filter = "BUFF" },

            --橙色披风 
                -- 赤精之魂 (治疗)
                { spellID = 146200, unitID = "player", caster = "all", filter = "BUFF" },
                -- 雪怒之捷 (物理)
                { spellID = 146194, unitID = "player", caster = "all", filter = "BUFF" },
                -- 玉珑之精 (法系)
                { spellID = 146198, unitID = "player", caster = "all", filter = "BUFF" },
                -- 砮皂之韧 (坦克)
                { spellID = 148010, unitID = "player", caster = "all", filter = "BUFF" },

            --種族天賦
                -- 血之烈怒
                { spellID = 20572, unitID = "player", caster = "player", filter = "BUFF" },
                -- 狂暴
                { spellID = 26297, unitID = "player", caster = "player", filter = "BUFF" },
                -- 石像形态
                { spellID =  65116, unitID = "player", caster = "player", filter = "BUFF" },
                -- 疾步夜行
                { spellID =  68992, unitID = "player", caster = "player", filter = "BUFF" },
                -- 影遁
                { spellID =  58984, unitID = "player", caster = "player", filter = "BUFF" },
                -- 纳鲁的赐福
                { spellID =  28880, unitID = "player", caster = "all", filter = "BUFF" },

            --套装特效    
				--法師T16, 冰凍意念
                { spellID = 146557, unitID = "player", caster = "all", filter = "BUFF" },
                { spellID = 145252, unitID = "player", caster = "all", filter = "BUFF" },
		},
		{
			Name = "PVE/PVP_P",
			Direction = "UP",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 60,
			Position = {unpack(C["filger_position"].pve_player)},
		--职业
			--死亡騎士
                -- 啃食
                { spellID = 91800, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 暴猛痛擊
                { spellID = 91797, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 窒息術
                { spellID = 108194, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 冷酷凜冬
                { spellID = 115001, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 絞殺
                { spellID = 47476, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 黑暗幻象
                { spellID = 77606, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 冰鍊術
                { spellID = 45524, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 凍瘡
                { spellID = 50435, unitID = "player", caster = "all", filter = "DEBUFF" },

            --德魯伊
                -- 颶風術
                { spellID = 33786, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 猛力重擊
                { spellID = 5211, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 傷殘術
                { spellID = 22570, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 掠魂咆哮
                { spellID = 99, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 太陽光束
                { spellID = 78675, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 精靈沉默
                { spellID = 114238, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 糾纏根鬚
                { spellID = 339, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 無法移動
                { spellID = 45334, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 感染之傷
                { spellID = 58180, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 颱風
                { spellID = 61391, unitID = "player", caster = "all", filter = "DEBUFF" },

            --獵人
                -- 豹群守護
                { spellID = 13159, unitID = "player", caster = "all", filter = "BUFF" },
                -- 脅迫
                { spellID = 24394, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 禁錮射擊
                { spellID = 117526, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 冰凍陷阱
                { spellID = 3355, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 翼龍釘刺
                { spellID = 19386, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 險裡逃生
                { spellID = 136634, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 震盪射擊
                { spellID = 5116, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 凍痕
                { spellID = 61394, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 霜雷之息 (奇特奇美拉)
                { spellID = 54644, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 腳踝粉碎 (鱷魚)
                { spellID = 50433, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 時間扭曲 (扭曲巡者)
                { spellID = 35346, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 音波衝擊 (蝙蝠)
                { spellID = 50519, unitID = "player", caster = "all", filter = "DEBUFF" },

                --法師
                -- 極度冰凍
                { spellID = 44572, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 變形術
                { spellID = 118, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 霜之環
                { spellID = 82691, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 龍之吐息
                { spellID = 31661, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 霜顎
                { spellID = 102051, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 冰凍術 (水元素)
                { spellID = 33395, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 冰霜新星
                { spellID = 122, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 寒冰結界
                { spellID = 111340, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 冰錐術
                { spellID = 120, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 減速術
                { spellID = 31589, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 寒冰箭
                { spellID = 116, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 霜火箭
                { spellID = 44614, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 冰凍
                { spellID = 7321, unitID = "player", caster = "all", filter = "DEBUFF" },

            --武僧
                -- 點穴
                { spellID = 115078, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 掃葉腿
                { spellID = 119381, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 狂拳連打
                { spellID = 120086, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 鐵牛衝鋒波
                { spellID = 119392, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 傷筋斷骨
                { spellID = 116706, unitID = "player", caster = "all", filter = "DEBUFF" },

            --聖騎士
                -- 制裁之錘
                { spellID = 853, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 制裁之拳
                { spellID = 105593, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 懺悔
                { spellID = 20066, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 盲目之光
                { spellID = 105421, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 復仇之盾
                { spellID = 31935, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 暈眩 - 復仇之盾
                { spellID = 63529, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 公正聖印
                { spellID = 20170, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 罪之重擔
                { spellID = 110300, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 問罪
                { spellID = 2812, unitID = "player", caster = "all", filter = "DEBUFF" },

            --牧師
                -- 支配心智
                { spellID = 605, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 心靈尖嘯
                { spellID = 8122, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 心靈恐慌
                { spellID = 64044, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 罪與罰
                { spellID = 87204, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 沉默
                { spellID = 15487, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 虛無觸鬚之握
                { spellID = 114404, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 心靈震爆雕紋
                { spellID = 87194, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 精神鞭笞
                { spellID = 15407, unitID = "player", caster = "all", filter = "DEBUFF" },

            --盜賊
                -- 腎擊
                { spellID = 408, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 偷襲
                { spellID = 1833, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 悶棍
                { spellID = 6770, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 致盲
                { spellID = 2094, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 鑿擊
                { spellID = 1776, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 絞喉 - 沉默
                { spellID = 1330, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 煙霧彈
                { spellID = 76577, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 擲殺
                { spellID = 26679, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 致殘毒藥
                { spellID = 3409, unitID = "player", caster = "all", filter = "DEBUFF" },

            --薩滿
                -- 妖術
                { spellID = 51514, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 靜電衝擊
                { spellID = 118905, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 粉碎
                { spellID = 118345, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 地震術
                { spellID = 77505, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 陷地
                { spellID = 64695, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 地縛術
                { spellID = 3600, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 冰霜震擊
                { spellID = 8056, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 雷霆風暴
                { spellID = 51490, unitID = "player", caster = "all", filter = "DEBUFF" },

            --術士
                -- 暗影之怒
                { spellID = 30283, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 投擲利斧 (惡魔守衛)
                { spellID = 89766, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 恐懼術
                { spellID = 118699, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 恐懼嚎叫
                { spellID = 5484, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 血性恐懼
                { spellID = 137143, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 死影纏繞
                { spellID = 6789, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 誘惑 (魅魔)
                { spellID = 6358, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 迷惑 (Shivarra)
                { spellID = 115268, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 痛苦動盪
                { spellID = 31117, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 焚燒
                { spellID = 17962, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 暗影之焰
                { spellID = 47960, unitID = "player", caster = "all", filter = "DEBUFF" },

            --戰士
                -- 暴風怒擲
                { spellID = 132169, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 震懾波
                { spellID = 132168, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 戰爭使者
                { spellID = 105771, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 震地怒吼
                { spellID = 107566, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 斷筋
                { spellID = 1715, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 刺耳怒吼
                { spellID = 12323, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 巨像碎擊
                { spellID = 86346, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 衝鋒昏迷
                { spellID = 7922, unitID = "player", caster = "all", filter = "DEBUFF" },

        --種族天賦
                -- 戰爭踐踏
                { spellID = 20549, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 震動掌
                { spellID = 107079, unitID = "player", caster = "all", filter = "DEBUFF" },
                -- 奧流之術
                { spellID = 28730, unitID = "player", caster = "all", filter = "DEBUFF" },

        --副本
			-- 决战奥格瑞玛 Siege Of Orgrimmar 953
				-- 1	伊墨苏斯 [Immerseus]
				-- 邪煞池
				{spellID = 143297, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 腐蚀冲击
				{spellID = 143436, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 煞能腐蚀 H
				{spellID = 143579, unitID = "player", caster = "all", filter = "DEBUFF"},
				
				-- 2	堕落的守护者 [FallenProtectors]
				-- 锁喉
				{spellID = 143198, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 苦痛印记
				{spellID = 143840, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 暗影虚弱
				{spellID = 144176, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 煞能灼烧
				{spellID = 143423, unitID = "player", caster = "all", filter = "DEBUFF"},
				
				-- 3	诺鲁什 [Norushen]
				-- 净化
				{spellID = 144452, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 自惑
				{spellID = 146124, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 纠缠腐蚀
				{spellID = 144514, unitID = "player", caster = "all", filter = "DEBUFF"},
				
				-- 4	傲之煞 [ShaofPride]
				-- 受损自尊
				{spellID = 144358, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 傲气光环
				{spellID = 146817, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 投影
				{spellID = 146822, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 泰坦之赐
				{spellID = 146594, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 泰坦之力
				{spellID = 144364, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 动摇的决心 H
				{spellID = 147207, unitID = "player", caster = "all", filter = "DEBUFF"},
				
				-- 5	迦拉卡斯 [Galakras]
				-- 毒性云雾
				{spellID = 147705, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 烈焰箭
				{spellID = 146765, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 迦拉克隆之焰 (点名)
				--{spellID = 147068, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 迦拉克隆之焰 (debuff)
				{spellID = 147029, unitID = "player", caster = "all", filter = "DEBUFF"},
				
				-- 6	钢铁战蝎 [IronJuggernaut]
				-- 燃烧护甲
				{spellID = 144467, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 爆裂焦油
				{spellID = 144498, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 切割激光
				{spellID = 146325, unitID = "player", caster = "all", filter = "DEBUFF"},
				
				-- 7	库卡隆黑暗萨满 [KorkronDarkShaman]
				-- 冰霜风暴打击
				{spellID = 144215, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 撕裂
				{spellID = 144304, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 剧毒之雾
				{spellID = 144089, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 钢铁囚笼 H
				{spellID = 144330, unitID = "player", caster = "all", filter = "DEBUFF"},
				
				-- 8	纳兹戈林将军 [GeneralNazgrim]
				-- 碎甲重击
				{spellID = 143494, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 碎骨重锤
				{spellID = 143638, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 刺客印记
				{spellID = 143480, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 猎人印记
				{spellID = 143882, unitID = "player", caster = "all", filter = "DEBUFF"},
				
				-- 9	马尔考罗克 [Malkorok]
				-- 致命打击
				{spellID = 142990, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 散逸能量
				{spellID = 142913, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 受难 H
				{spellID = 143919, unitID = "player", caster = "all", filter = "DEBUFF"},
				
				-- 10	潘达利亚战利品 [SpoilsOfPandria]
				-- 设置炸药
				{spellID = 145987, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 浓缩信息素
				{spellID = 145747, unitID = "player", caster = "all", filter = "DEBUFF"},
				
				-- 11	嗜血的索克 [ThokTheBloodthirsty]
				-- 恐慌
				{spellID = 143766, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 灼热吐息
				{spellID = 143767, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 酸性吐息
				{spellID = 143780, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 冰冻吐息
				{spellID = 143773, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 锁定
				{spellID = 143445, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 冰冻之血
				{spellID = 143800, unitID = "player", caster = "all", filter = "DEBUFF"},
				
				-- 12	攻城匠师黑索 [SiegecrafterBlackfuse]
				-- 电荷冲击
				{spellID = 143385, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 过热
				{spellID = 143856, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 图像识别
				{spellID = 144236, unitID = "player", caster = "all", filter = "DEBUFF"},
				
				-- 13	卡拉克西英杰 [ParagonsOfTheKlaxxi]
				-- 注射
				{spellID = 143339, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 红色毒素
				{spellID = 142533, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 蓝色毒素
				{spellID = 142532, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 黄色毒素
				{spellID = 142534, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 橙色毒素
				{spellID = 142547, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 橙色催化爆炸之环
				{spellID = 142803, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 绿色毒素
				{spellID = 142549, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 绿色催化诡异之雾
				{spellID = 142945, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 紫色催化热罐燃料
				{spellID = 143572, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 白色毒素
				{spellID = 142550, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 血脉暴露
				{spellID = 142931, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 挥砍
				{spellID = 143275, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 基因变异
				{spellID = 143279, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 凿击
				{spellID = 143939, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 盾击
				{spellID = 143974, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 酸性血液
				{spellID = 142315, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 催眠术
				{spellID = 142671, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 瞄准
				{spellID = 142948, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 炎界的火线
				{spellID = 142808, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 变异缺陷
				{spellID = 148589, unitID = "player", caster = "all", filter = "DEBUFF"},
				
				-- 14	加尔鲁什·地狱咆哮 [GarroshHellscream]
				-- 绝望之握
				{spellID = 145183, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 强化绝望之握
				{spellID = 145195, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 绝望之破
				{spellID = 145213, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 信念
				{spellID = 148994, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 勇气
				{spellID = 148983, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 希望
				{spellID = 149004, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 亵渎(P2)
				--{spellID = 144762, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 亵渎(P3)
				{spellID = 144817, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 亚煞极之触
				{spellID = 145065, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 強化亚煞极之触
				{spellID = 145171, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 凝视 H
				{spellID = 147665, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 液态火焰 H
				{spellID = 147136, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 恶意 H
				{spellID = 147209, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 恶意冲击 H
				{spellID = 147235, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 决战奥格瑞玛 [结束]
				
				
			-- 悬槌堡 994
				-- 1	卡加斯·刃拳 [Kargath Bladefist]
				-- 穿刺 (T)
				{spellID = 159113, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 迸裂创伤 (T) 1~2层
				{spellID = 159178, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 烈焰喷射
				{spellID = 159311, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 钢铁炸弹
				{spellID = 159386, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 暴虐酒
				{spellID = 159413, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 搜寻猎物
				{spellID = 162497, unitID = "player", caster = "all", filter = "DEBUFF"},
				
				-- 2	屠夫 [The Butcher]
				-- 捶肉槌 (T) 2~3层
				{spellID = 156151, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 切肉刀
				{spellID = 156147, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 龟裂创伤
				{spellID = 156152, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 白鬼硫酸
				{spellID = 163046, unitID = "player", caster = "all", filter = "DEBUFF"},
				
				-- 3	泰克图斯 [Tectus]
				-- 石化
				{spellID = 162892, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 晶化弹幕 - 点名
				{spellID = 162346, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 晶化弹幕 - 踩到火
				{spellID = 162370, unitID = "player", caster = "all", filter = "DEBUFF"},
				
				-- 4	布兰肯斯波 [Brackenspore]
				-- 溃烂 (T) 4~6层
				{spellID = 163241, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 死疽吐息
				{spellID = 159220, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 蚀脑真菌
				{spellID = 163140, unitID = "player", caster = "all", filter = "DEBUFF"},
				{spellID = 160179, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 滑溜溜的苔藓
				{spellID = 163590, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 爆裂灌注
				{spellID = 165223, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 回春孢子
				{spellID = 159426, unitID = "player", caster = "all", filter = "DEBUFF"},
				
				-- 5	独眼魔双子 [Twin Ogron]
				-- 防御削弱
				{spellID = 159709, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 致衰咆哮
				{spellID = 158026, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 烈焰
				{spellID = 158241, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 奥术之伤 (T)
				{spellID = 167200, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 奥能动荡
				{spellID = 163372, unitID = "player", caster = "all", filter = "DEBUFF"},
				
				-- 6	克拉戈 [Ko'ragh]
				-- 魔能散射：奥术 (T)
				{spellID = 162186, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 魔能散射：火焰
				{spellID = 162185, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 魔能散射：冰霜
				{spellID = 172813, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 魔能散射：暗影
				{spellID = 162184, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 废灵璧垒
				{spellID = 156803, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 压制力场
				{spellID = 161345, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 腐蚀能量
				{spellID = 161242, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 魔能散射：邪能 - 点名
				{spellID = 172895, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 魔能散射：邪能 - 踩到火
				{spellID = 172917, unitID = "player", caster = "all", filter = "DEBUFF"},
				
				-- 7	元首马尔高克 [Imperator Mar'gok]
				-- 混沌标记 (T) P1换T
				{spellID = 158605, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 混沌标记：偏移 (T) P2换T
				{spellID = 164176, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 混沌标记：强固 (T) P3换T
				{spellID = 164178, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 混沌标记：复制 (T) P4换T
				{spellID = 164191, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 奥术愤怒 P1
				{spellID = 156225, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 奥术愤怒 P2
				{spellID = 164004, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 奥术愤怒 P3
				{spellID = 164005, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 奥术愤怒 P4
				{spellID = 164006, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 减速
				{spellID = 157801, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 锁定
				{spellID = 157763, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 毁灭共鸣
				{spellID = 159200, unitID = "player", caster = "all", filter = "DEBUFF"},
				-- 碾碎护甲
				{spellID = 158553, unitID = "player", caster = "all", filter = "DEBUFF"},
				
				
				--[==[
				
			-- 黑石铸造厂 988
				-- 1	格鲁尔 [Gruul]
				{spellID = 155326, unitID = "player", caster = "all", filter = "DEBUFF"},
				
				-- 2	奥尔高格 [Oregorger]
				{spellID = 156324, unitID = "player", caster = "all", filter = "DEBUFF"},
				
				-- 3	兽王达玛克 [Beastlord Darmac]
				{spellID = 155365, unitID = "player", caster = "all", filter = "DEBUFF"},
				{spellID = 155399, unitID = "player", caster = "all", filter = "DEBUFF"},
				{spellID = 154989, unitID = "player", caster = "all", filter = "DEBUFF"},
				{spellID = 155499, unitID = "player", caster = "all", filter = "DEBUFF"},
				
				-- 4	缚火者卡格拉兹 [Flamebender Ka'graz]
				{spellID = 155277, unitID = "player", caster = "all", filter = "DEBUFF"},
				
				-- 5	汉斯加尔与弗兰佐克 [Hans'gar and Franzok]
				{spellID = 157139, unitID = "player", caster = "all", filter = "DEBUFF"},
				
				-- 6	主管索格尔 [Operator Thogar]
				{spellID = 155921, unitID = "player", caster = "all", filter = "DEBUFF"},
				
				-- 7	爆裂熔炉 [The Blast Furnace]
				{spellID = 155240, unitID = "player", caster = "all", filter = "DEBUFF"},
				{spellID = 155242, unitID = "player", caster = "all", filter = "DEBUFF"},
				
				-- 8	克罗莫格 [Kromog]
				{spellID = 157060, unitID = "player", caster = "all", filter = "DEBUFF"},
				
				-- 9	钢铁女武神 [The Iron Maidens]
				{spellID = 158315, unitID = "player", caster = "all", filter = "DEBUFF"},
				
				-- 10	黑手 [Blackhand]
				{spellID = 156096, unitID = "player", caster = "all", filter = "DEBUFF"},
				 
				--]==]

		--其他
                -- 火箭燃料漏油
                { spellID = 94794, unitID = "player", caster = "all", filter = "DEBUFF" },
		},
		{
			Name = "PVE/PVP_T",
			Direction = "UP",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 60,
			Position = {unpack(C["filger_position"].pve_target)},

	--职业
		-- Death knight
			-- Anti-Magic Shell
			{spellID = 48707, unitID = "target", caster = "all", filter = "BUFF"},
			-- Desecrated Ground
			{spellID = 115018, unitID = "target", caster = "all", filter = "BUFF"},
			-- Lichborne
			{spellID = 49039, unitID = "target", caster = "all", filter = "BUFF"},
			-- Icebound Fortitude
			{spellID = 48792, unitID = "target", caster = "all", filter = "BUFF"},
			-- Pillar of Frost
			{spellID = 51271, unitID = "target", caster = "all", filter = "BUFF"},
			-- Death's Advance
			{spellID = 96268, unitID = "target", caster = "all", filter = "BUFF"},
			-- Debuffs
			-- Remorseless Winter
			{spellID = 115001, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Asphyxiate
			{spellID = 108194, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Gnaw (Ghoul)
			{spellID = 91800, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Monstrous Blow (Mutated Ghoul)
			{spellID = 91797, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Strangulate
			{spellID = 47476, unitID = "target", caster = "all", filter = "DEBUFF"},

		-- Druid
			-- Survival Instincts
			{spellID = 61336, unitID = "target", caster = "all", filter = "BUFF"},
			-- Barkskin
			{spellID = 22812, unitID = "target", caster = "all", filter = "BUFF"},
			-- Ironbark
			{spellID = 102342, unitID = "target", caster = "all", filter = "BUFF"},
			-- Nature's Grasp
			{spellID = 170856, unitID = "target", caster = "all", filter = "BUFF"},
			-- Stampeding Roar
			{spellID = 77764, unitID = "target", caster = "all", filter = "BUFF"},
			-- Incarnation: Tree of Life
			{spellID = 117679, unitID = "target", caster = "all", filter = "BUFF"},
			-- Berserk
			{spellID = 50334, unitID = "target", caster = "all", filter = "BUFF"},
			-- Debuffs
			-- Cyclone
			{spellID = 33786, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Mighty Bash
			{spellID = 5211, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Maim
			{spellID = 22570, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Rake
			{spellID = 163505, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Incapacitating Roar
			{spellID = 99, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Solar Beam
			{spellID = 78675, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Fae Silence
			{spellID = 114238, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Entangling Roots
			{spellID = 339, unitID = "target", caster = "all", filter = "DEBUFF"},

		-- Hunter
			-- Aspect of the Pack
			{spellID = 13159, unitID = "target", caster = "all", filter = "BUFF"},
			-- Aspect of the Cheetah
			{spellID = 5118, unitID = "target", caster = "all", filter = "BUFF"},
			-- Deterrence
			{spellID = 19263, unitID = "target", caster = "all", filter = "BUFF"},
			-- Posthaste
			{spellID = 118922, unitID = "target", caster = "all", filter = "BUFF"},
			-- Debuffs
			-- Freezing Trap
			{spellID = 3355, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Wyvern Sting
			{spellID = 19386, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Binding Shot
			{spellID = 117526, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Intimidation
			{spellID = 24394, unitID = "target", caster = "all", filter = "DEBUFF"},

		-- Mage
			-- Ice Block
			{spellID = 45438, unitID = "target", caster = "all", filter = "BUFF"},
			-- Invisibility
			{spellID = 66, unitID = "target", caster = "all", filter = "BUFF"},
			-- Evocation
			{spellID = 12051, unitID = "target", caster = "all", filter = "BUFF"},
			-- Temporal Shield
			{spellID = 115610, unitID = "target", caster = "all", filter = "BUFF"},
			-- Alter Time
			{spellID = 110909, unitID = "target", caster = "all", filter = "BUFF"},
			-- Debuffs
			-- Cauterize
			{spellID = 87023, unitID = "target", caster = "target", filter = "DEBUFF"},
			-- Polymorph
			{spellID = 118, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Deep Freeze
			{spellID = 44572, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Ring of Frost
			{spellID = 82691, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Dragon's Breath
			{spellID = 31661, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Frostjaw
			{spellID = 102051, unitID = "target", caster = "all", filter = "DEBUFF"},

		-- Monk
			-- Touch of Karma
			{spellID = 125174, unitID = "target", caster = "target", filter = "BUFF"},
			-- Ring of Peace
			{spellID = 116844, unitID = "target", caster = "target", filter = "BUFF"},
			-- Diffuse Magic
			{spellID = 122783, unitID = "target", caster = "target", filter = "BUFF"},
			-- Debuffs
			-- Paralysis
			{spellID = 115078, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Leg Sweep
			{spellID = 119381, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Fists of Fury
			{spellID = 120086, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Charging Ox Wave
			{spellID = 119392, unitID = "target", caster = "all", filter = "DEBUFF"},

		-- Paladin
			-- Divine Shield
			{spellID = 642, unitID = "target", caster = "all", filter = "BUFF"},
			-- Hand of Protection
			{spellID = 1022, unitID = "target", caster = "all", filter = "BUFF"},
			-- Hand of Sacrifice
			{spellID = 6940, unitID = "target", caster = "all", filter = "BUFF"},
			-- Hand of Freedom
			{spellID = 1044, unitID = "target", caster = "all", filter = "BUFF"},
			-- Hand of Purity
			{spellID = 114039, unitID = "target", caster = "all", filter = "BUFF"},
			-- Devotion Aura
			{spellID = 31821, unitID = "target", caster = "all", filter = "BUFF"},
			-- Ardent Defender
			{spellID = 31850, unitID = "target", caster = "all", filter = "BUFF"},
			-- Divine Protection
			{spellID = 498, unitID = "target", caster = "all", filter = "BUFF"},
			-- Guardian of Ancient Kings
			{spellID = 86659, unitID = "target", caster = "all", filter = "BUFF"},
			-- Debuffs
			-- Hammer of Justice
			{spellID = 853, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Fist of Justice
			{spellID = 105593, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Repentance
			{spellID = 20066, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Turn Evil
			{spellID = 10326, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Blinding Light
			{spellID = 105421, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Avenger's Shield
			{spellID = 31935, unitID = "target", caster = "all", filter = "DEBUFF"},

		-- Priest
			-- Dispersion
			{spellID = 47585, unitID = "target", caster = "all", filter = "BUFF"},
			-- Pain Suppression
			{spellID = 33206, unitID = "target", caster = "all", filter = "BUFF"},
			-- Guardian Spirit
			{spellID = 47788, unitID = "target", caster = "all", filter = "BUFF"},
			-- Phantasm
			{spellID = 114239, unitID = "target", caster = "all", filter = "BUFF"},
			-- Fear Ward
			{spellID = 6346, unitID = "target", caster = "all", filter = "BUFF"},
			-- Debuffs
			-- Dominate Mind
			{spellID = 605, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Psychic Scream
			{spellID = 8122, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Psychic Horror
			{spellID = 64044, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Silence
			{spellID = 15487, unitID = "target", caster = "all", filter = "DEBUFF"},

		-- Rogue
			-- Cloak of Shadows
			{spellID = 31224, unitID = "target", caster = "all", filter = "BUFF"},
			-- Evasion
			{spellID = 5277, unitID = "target", caster = "all", filter = "BUFF"},
			-- Cheating Death
			{spellID = 45182, unitID = "target", caster = "all", filter = "BUFF"},
			-- Combat Insight
			{spellID = 74002, unitID = "target", caster = "all", filter = "BUFF"},
			-- Shadow Dance
			{spellID = 51713, unitID = "target", caster = "all", filter = "BUFF"},
			-- Debuffs
			-- Kidney Shot
			{spellID = 408, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Cheap Shot
			{spellID = 1833, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Sap
			{spellID = 6770, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Blind
			{spellID = 2094, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Garrote - Silence
			{spellID = 1330, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Smoke Bomb
			{spellID = 76577, unitID = "target", caster = "all", filter = "DEBUFF"},

		-- Shaman
			-- Grounding Totem Effect
			{spellID = 8178, unitID = "target", caster = "all", filter = "BUFF"},
			-- Shamanistic Rage
			{spellID = 30823, unitID = "target", caster = "all", filter = "BUFF"},
			-- Spiritwalker's Grace
			{spellID = 79206, unitID = "target", caster = "all", filter = "BUFF"},
			-- Debuffs
			-- Hex
			{spellID = 51514, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Static Charge
			{spellID = 118905, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Pulverize (Earth Elemental)
			{spellID = 118345, unitID = "target", caster = "all", filter = "DEBUFF"},

			-- Warlock
			-- Dark Bargain
			{spellID = 110913, unitID = "target", caster = "all", filter = "BUFF"},
			-- Unending Resolve
			{spellID = 104773, unitID = "target", caster = "all", filter = "BUFF"},
			-- Soulstone
			{spellID = 20707, unitID = "target", caster = "all", filter = "BUFF"},
			-- Debuffs
			-- Banish
			{spellID = 710, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Shadowfury
			{spellID = 30283, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Axe Toss (Felguard)
			{spellID = 89766, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Fear
			{spellID = 118699, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Howl of Terror
			{spellID = 5484, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Blood Horror
			{spellID = 137143, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Mortal Coil
			{spellID = 6789, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Seduction (Succubus)
			{spellID = 6358, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Mesmerize (Shivarra)
			{spellID = 115268, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Unstable Affliction
			{spellID = 31117, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},

		-- Warrior
			-- Spell Reflection
			{spellID = 23920, unitID = "target", caster = "all", filter = "BUFF"},
			-- Mass Spell Reflection
			{spellID = 114028, unitID = "target", caster = "all", filter = "BUFF"},
			-- Die by the Sword
			{spellID = 118038, unitID = "target", caster = "all", filter = "BUFF"},
			-- Shield Wall
			{spellID = 871, unitID = "target", caster = "all", filter = "BUFF"},
			-- Berserker Rage
			{spellID = 18499, unitID = "target", caster = "all", filter = "BUFF"},
			-- Last Stand
			{spellID = 12975, unitID = "target", caster = "all", filter = "BUFF"},
			-- Bladestorm
			{spellID = 46924, unitID = "target", caster = "all", filter = "BUFF"},
			-- Debuffs
			-- Storm Bolt
			{spellID = 132169, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Shockwave
			{spellID = 132168, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Intimidating Shout
			{spellID = 5246, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Silenced (Gag Order)
			{spellID = 18498, unitID = "target", caster = "all", filter = "DEBUFF"},

			-- Racial
			-- War Stomp
			{spellID = 20549, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Quaking Palm
			{spellID = 107079, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Arcane Torrent
			{spellID = 28730, unitID = "target", caster = "all", filter = "DEBUFF"},

			-- Heart of Fear
			-- Impaling Spear (Wind Lord Mel'jarak)
			{spellID = 122224, unitID = "target", caster = "all", filter = "DEBUFF"},

		-- All
			-- Warsong Flag
			{spellID = 23333, unitID = "target", caster = "all", filter = "BUFF"},
			{spellID = 23335, unitID = "target", caster = "all", filter = "BUFF"},
			-- Netherstorm Flag
			{spellID = 34976, unitID = "target", caster = "all", filter = "BUFF"},
			-- Orb of Power
			{spellID = 121175, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Carrying Seaforium
			{spellID = 66271, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Drink
			{spellID = 80167, unitID = "target", caster = "all", filter = "BUFF"},
		},
	},
}
