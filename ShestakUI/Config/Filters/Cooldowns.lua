local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Rebirth -> http://www.wowhead.com/spell=20484
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
if C.raidcooldown.enable == true then
	T.raid_spells = {
				--复活技能
		[20484] = 600,	-- Rebirth 复生 德鲁伊
		[61999] = 600,	-- Raise Ally 盟友复生 DK
		[20707] = 600,	-- Soulstone 灵魂石 术士
		[126393] = 600,	-- Eternal Guardian (Quilen) 永恒守护者 猎人
		[159956] = 600,	-- Dust of Life (Moth) 生命之尘 猎人
		[159931] = 600,	-- Gift of Chi-Ji (Crane) 赤精之赐 猎人
		
		--群体治疗 
		[740] = 180,  -- 宁静 
		[115310] = 180,  -- 还魂术 
		[64843] = 180,  -- 神圣赞美诗 
		[108280] = 180,  -- 治疗之潮图腾 
		[157535] = 90,  -- 蟠龙之息 
		
		--群体减伤 
		[62618] = 180,  -- 真言术：障 
		[98008] = 180,  -- 灵魂链接图腾 
		[31821] = 180,   -- 虔诚光环 
		[51052] = 120,  -- 反魔法领域 
		[97462] = 180,  -- 集结呐喊 
		[88611] = 180,  --烟雾弹
		
		--单体减伤
		[102342] = 60,  --铁木树皮 
		[116849] = 100,  --作茧缚命 
		[6940] = 120,  --牺牲之手 
		[33206] = 180,  --痛苦压制 
		[47788] = 180,  --守护之魂 
		[114030] = 120,  --警戒 
		
		--团队增益
		[32182] = 300,  -- 英勇 
		[2825] = 300,  -- 嗜血 
		[80353] = 300,  -- 时间扭曲 
		[90355] = 300,  -- 远古狂乱   
		[159916] = 120,  -- 魔法增效 
		[106898] = 120,  -- 狂奔怒吼 
		[172106] = 180,  -- 灵狐守护 
	}
end

if C.enemycooldown.enable == true then
	T.enemy_spells = {
		-- Interrupts and Silences
		[57994] = 12,	-- Wind Shear
		[47528] = 15,	-- Mind Freeze
		[80965] = 15,	-- Skull Bash
		[116705] = 15,	-- Spear Hand Strike
		[96231] = 15,	-- Rebuke
		[1766] = 15,	-- Kick
		[6552] = 15,	-- Pummel
		[102051] = 20,	-- Frostjaw
		[147362] = 24,	-- Counter Shot
		[2139] = 24,	-- Counterspell
		[19647] = 24,	-- Spell Lock
		[115781] = 24,	-- Optical Blast
		[102060] = 40,	-- Disrupting Shout
		[15487] = 45,	-- Silence
		[47476] = 60,	-- Strangulate
		[78675] = 60,	-- Solar Beam
		-- Crowd Controls
		[115078] = 15,	-- Paralysis
		[20066] = 15,	-- Repentance
		[10326] = 15,	-- Turn Evil
		[108194] = 30,	-- Asphyxiate
		[1499] = 30,	-- Freezing Trap
		[44572] = 30,	-- Deep Freeze
		[105593] = 30,	-- Fist of Justice
		[8122] = 30,	-- Psychic Scream
		[30283] = 30,	-- Shadowfury
		[107570] = 30,	-- Storm Bolt
		[5484] = 40,	-- Howl of Terror
		[19386] = 45,	-- Wyvern Sting
		[113724] = 45,	-- Ring of Frost
		[119381] = 45,	-- Leg Sweep
		[64044] = 45,	-- Psychic Horror
		[51514] = 45,	-- Hex
		[6789] = 45,	-- Mortal Coil
		[853] = 60,		-- Hammer of Justice
		[108200] = 60,	-- Remorseless Winter
		-- Defense abilities
		[48707] = 45,	-- Anti-Magic Shell
		[31224] = 60,	-- Cloak of Shadows
		[8143] = 60,	-- Tremor Totem
		[46924] = 60,	-- Bladestorm
		[108978] = 90,	-- Alter Time
		[49039] = 120,	-- Lichborne
		[137562] = 120,	-- Nimble Brew
		[47585] = 120,	-- Dispersion
		[1856] = 120,	-- Vanish
		[19263] = 180,	-- Deterrence
		[33206] = 180,	-- Pain Suppression
		[7744] = 180,	-- Will of the Forsaken (Racial)
	}
end

if C.pulsecooldown.enable == true then
	T.pulse_ignored_spells = {
		--GetSpellInfo(779),	-- Swipe
		--GetSpellInfo(6807),	-- Maul
	}
end
