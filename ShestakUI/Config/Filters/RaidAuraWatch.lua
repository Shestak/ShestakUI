local T, C, L, _ = unpack(select(2, ...))
if C.raidframe.plugins_aura_watch ~= true then return end

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Renew -> http://www.wowhead.com/spell=139
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
T.RaidBuffs = {
	DRUID = {
		{774, "TOPRIGHT", {0.8, 0.4, 0.8}},					-- Rejuvenation
		{8936, "BOTTOMLEFT", {0.2, 0.8, 0.2}},				-- Regrowth
		{33763, "TOPLEFT", {0.4, 0.8, 0.2}},				-- Lifebloom
		{48438, "BOTTOMRIGHT", {0.8, 0.4, 0}},				-- Wild Growth
		{102342, "LEFT", {0.45, 0.3, 0.2}, true},			-- Ironbark
		{155777, "RIGHT", {0.4, 0.9, 0.4}},					-- Rejuvenation (Germination)
	},
	MONK = {
		{119611, "TOPRIGHT", {0.2, 0.7, 0.7}},				-- Renewing Mist
		{132120, "BOTTOMLEFT", {0.4, 0.8, 0.2}},			-- Enveloping Mist
		{124081, "BOTTOMRIGHT", {0.7, 0.4, 0}},				-- Zen Sphere
		{116849, "LEFT", {0.81, 0.85, 0.1}, true},			-- Life Cocoon
	},
	PALADIN = {
		{53563, "TOPRIGHT", {0.7, 0.3, 0.7}},				-- Beacon of Light
		{20925, "BOTTOMLEFT", {0.9, 0.9, 0.1}},				-- Sacred Shield
		{114163, "BOTTOMLEFT", {0.9, 0.6, 0.4}},			-- Eternal Flame
		{157007, "TOPLEFT", {1, 0.5, 0.2}},					-- Beacon of Insight
		{1022, "BOTTOMRIGHT", {0.2, 0.2, 1}, true},			-- Hand of Protection
		{1044, "BOTTOMRIGHT", {0.89, 0.45, 0}, true},		-- Hand of Freedom
		{1038, "BOTTOMRIGHT", {0.93, 0.75, 0}, true},		-- Hand of Salvation
		{6940, "BOTTOMRIGHT", {0.89, 0.1, 0.1}, true},		-- Hand of Sacrifice
		{114039, "BOTTOMRIGHT", {0.4, 0.6, 0.8}, true},		-- Hand of Purity
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
		{974, "BOTTOMRIGHT", {0.2, 0.7, 0.2}, true},		-- Earth Shield
	},
	HUNTER = {
		{35079, "TOPRIGHT", {0.2, 0.2, 1}},					-- Misdirection
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
		{114030, "TOPLEFT", {0.2, 0.2, 1}},					-- Vigilance
		{3411, "TOPRIGHT", {0.89, 0.1, 0.1}},				-- Intervene
	},
	ALL = {
		{23333, "LEFT", {1, 0, 0}, true}, 					-- Warsong flag, Horde
		{23335, "LEFT", {0, 0, 1}, true},					-- Warsong flag, Alliance
		{34976, "LEFT", {1, 0, 0}, true}, 					-- Netherstorm Flag
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

-- Blackrock Foundry 黑石铸造厂 
	--Gruul 格鲁尔 
	[SpellName(155080)] = 4, -- Inferno Slice 煉獄切割 分担组DOT 
	[SpellName(155078)] = 3, -- Overwhelming Blows 压迫打击 普攻坦克易伤 
	[SpellName(162322)] = 5, -- Inferno Strike 炼狱打击 吃刀坦克易伤 
	[SpellName(155506)] = 2, -- Petrified 石化 

	--Oregorger 奥尔高格 
	[SpellName(156203)] = 5, -- Retched Blackrock 呕吐黑石 远程躲 
	[SpellName(156374)] = 5, -- Explosive Shard 爆炸裂片 近战躲 
	[SpellName(156297)] = 3, -- Acid Torrent 酸液洪流 副坦克易伤 
	[SpellName(173471)] = 4, -- Acid Maw 酸液巨口 主坦克DOT 
	[SpellName(155900)] = 2, -- Rolling Fury 翻滚之怒 击倒 

	--Blast Furnace 爆裂熔炉 
	[SpellName(156932)] = 5, -- Rupture 崩裂 
	[SpellName(178279)] = 4, -- Bomb 炸弹 
	[SpellName(155192)] = 4, -- Bomb 炸弹 
	[SpellName(176121)] = 6, -- Volatile Fire 不稳定的火焰 点名八码爆炸 
	[SpellName(155196)] = 2, -- Fixate 锁定 
	[SpellName(155743)] = 5, -- Slag Pool 熔渣池 
	[SpellName(155240)] = 3, -- Tempered 淬火 坦克易伤 
	[SpellName(155242)] = 3, -- Heat 高热 三层换坦 
	[SpellName(155225)] = 5, -- Melt 熔化 点名 
	[SpellName(155223)] = 5, -- Melt熔化 

	--Hans'gar and Franzok 汉斯加尔与弗兰佐克 
	[SpellName(157139)] = 3, -- Shattered Vertebrae 折脊碎椎 跳跃易伤 
	[SpellName(160838)] = 2, -- Disrupting Roar干扰怒吼 
	[SpellName(160845)] = 2, -- Disrupting Roar干扰怒吼 
	[SpellName(160847)] = 2, -- Disrupting Roar干扰怒吼 
	[SpellName(160848)] = 2, -- Disrupting Roar干扰怒吼 
	[SpellName(155818)] = 4, -- Scorching Burns 灼热燃烧 场地边缘的火 

	--Flamebender Ka'graz 缚火者卡格拉兹 
	[SpellName(154952)] = 3, -- Fixate 锁定 
	[SpellName(155074)] = 1, -- Charring Breath 焦灼吐息 坦克易伤 
	[SpellName(155049)] = 2, -- Singe 火焰链接 
	[SpellName(154932)] = 4, -- Molten Torrent 熔岩激流 点名分摊 
	[SpellName(155277)] = 5, -- Blazing Radiance炽热光辉 点名AOE 
	[SpellName(155314)] = 1, -- Lava Slash 岩浆猛击 冲锋火线 
	[SpellName(163284)] = 2, -- Rising Flames升腾烈焰 坦克DOT 

	--Kromog 克罗莫格 
	[SpellName(156766)] = 1, -- Warped Armor 扭曲护甲 坦克易伤 
	[SpellName(157059)] = 2, -- Rune of Grasping Earth 纠缠之地符文 
	[SpellName(161839)] = 3, -- Rune of Crushing Earth 破碎大地符文 
	[SpellName(161923)] = 3, -- Rune of Crushing Earth 破碎大地符文 

	-- Beastlord Darmac兽王达玛克
	[SpellName(154960)] = 4, -- Pinned Down 长矛钉刺 
	[SpellName(155061)] = 1, -- Rend and Tear 狂乱撕扯 狼阶段流血 
	[SpellName(162283)] = 1, -- Rend and Tear 狂乱撕扯 BOSS继承的流血 
	[SpellName(154989)] = 3, -- Inferno Breath 炼狱吐息 
	[SpellName(154981)] = 5, -- Conflagration 爆燃 秒驱 
	[SpellName(155030)] = 2, -- Seared Flesh 炽燃利齿 龙阶段坦克易伤 
	[SpellName(155236)] = 2, -- Crush Armor 碾碎护甲 象阶段坦克易伤 
	[SpellName(155499)] = 3, -- Superheated Shrapnel 高热弹片 
	[SpellName(155657)] = 4, -- Flame Infusion 烈焰灌注 
	[SpellName(159044)] = 1, -- Epicenter 强震 
	[SpellName(162277)] = 1, -- Epicenter 强震 

	--Operator Thogar 主管索戈尔 
	[SpellName(155921)] = 2, -- Enkindle 点燃 坦克易伤 
	[SpellName(165195)] = 4, -- Prototype Pulse Grenade 实验型脉冲手雷 
	[SpellName(156310)] = 3, -- Lava Shock 熔岩震击 
	[SpellName(159481)] = 3, -- Delayed Siege Bomb 延时攻城炸弹 
	[SpellName(164380)] = 2, -- Burning 燃烧 
	[SpellName(164280)] = 2, -- Heat Blast 热能冲击 

	--Iron Maidens 钢铁女武神 
	[SpellName(156631)] = 2, -- Rapid Fire 急速射击 
	[SpellName(164271)] = 3, -- Penetrating Shot 穿透射击 
	[SpellName(158601)] = 1, -- Dominator Blast 主炮轰击 
	[SpellName(156214)] = 4, -- Convulsive Shadows 震颤暗影 
	[SpellName(158315)] = 2, -- Dark Hunt 暗影猎杀 
	[SpellName(159724)] = 3, -- Blood Ritual 鲜血仪式 
	[SpellName(158010)] = 2, -- 浸血觅心者 
	[SpellName(158692)] = 1, -- Bloodsoaked Heartseeker 致命投掷 
	[SpellName(158702)] = 2, -- Fixate 锁定 
	[SpellName(158683)] = 3, -- Corrupted Blood 堕落之血 

	--Warlord Blackhand 黑手 
	[SpellName(156096)] = 5, -- Marked for Death 死亡标记  
   	
-- Highmaul 悬槌堡 
	-- Kargath Bladefist 卡加斯 
	[SpellName(158986)] = 2, -- 冲锋 
	[SpellName(159178)] = 5, -- 迸裂创伤         
	[SpellName(162497)] = 3, -- 搜寻猎物       
	[SpellName(163130)] = 3, -- 着火 

	-- The Butcher 屠夫 
	[SpellName(156151)] = 3, -- Berserker Rush 捶肉槌 
	[SpellName(156147)] = 5, -- The Cleaver 切肉刀           
	[SpellName(156152)] = 3, -- Gushing Wounds 龟裂创伤         
	[SpellName(163046)] = 4, -- Pale Vitriol 白鬼硫酸 

	-- Tectus 泰克图斯 
	[SpellName(162346)] = 4,  -- crystalline barrage 晶化弹幕 点名 
	[SpellName(162370)] = 3, -- Crystalline Barrage 晶化弹幕 踩到 

	-- Brackenspore 布兰肯斯波 
	[SpellName(163242)] = 5, -- Infesting Spores 感染孢子 
	[SpellName(159426)] = 5, -- Rejuvenating Spores 回春孢子 
	[SpellName(163241)] = 4, -- Rot 溃烂 
	[SpellName(159220)] = 2,  -- Necrotic Breath 死疽吐息   
	[SpellName(160179)] = 2,  -- Mind Fungus 蚀脑真菌 
	[SpellName(165223)] = 6, -- Burning Infusion 爆裂灌注 
	[SpellName(163666)] = 3, -- Pulsing Heat 脉冲高热 

	-- Twin Ogron 独眼魔双子 
	[SpellName(155569)] = 3, -- Injured 受伤 
	[SpellName(158241)] = 4, -- Blaze 烈焰   
	[SpellName(163372)] = 4, -- Arcane Volatility 奥能动荡 
	[SpellName(167200)] = 3, -- Arcane Wound 奥术致伤 
	[SpellName(163297)] = 3, -- Arcane Twisted 扭曲奥能 

	-- Koragh 克拉戈 
	[SpellName(172813)] = 5, -- Expel Magic: Frost 魔能散射：冰霜 
	[SpellName(162185)] = 5, -- Expel Magic: Fire 魔能散射：火焰 
	[SpellName(162184)] = 3, -- Expel Magic: Shadow 魔能散射：暗影 
	[SpellName(162186)] = 2, -- Expel Magic: Arcane 魔能散射：奥术 
	[SpellName(161345)] = 2, -- Suppression Field 压制力场 
	[SpellName(161242)] = 3, -- Caustic Energy 废灵璧垒 
	[SpellName(172886)] = 4, -- Mark of Nullification 废灵标记
	[SpellName(172895)] = 4, -- Expel Magic: Fel 魔能散射：邪能  点名 
	[SpellName(172917)] = 4, -- Expel Magic: Fel 魔能散射：邪能  踩到 
	[SpellName(163472)] = 2, -- Dominating Power 统御之力 

	-- Imperator Mar'gok 元首 
	[SpellName(157763)] = 3,  -- Fixate 锁定         
	[SpellName(159515)] = 4, -- Accelerated Assault 狂莽突击         
	[SpellName(156225)] = 4, -- Branded 烙印       
	[SpellName(164004)] = 4, -- Branded: Displacement 烙印：偏移         
	[SpellName(164006)] = 4, -- Branded: Replication 烙印：强固         
	[SpellName(164005)] = 4, -- Branded: Fortification 烙印：复制         
	[SpellName(158605)] = 2, -- Mark of Chaos 混沌标记         
	[SpellName(164176)] = 2, -- Mark of Chaos: Displacement 混沌标记：偏移           
	[SpellName(164178)] = 2, -- Mark of Chaos: Fortification 混沌标记：强固         
	[SpellName(164191)] = 2, -- Mark of Chaos: Replication 混沌标记：复制

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
