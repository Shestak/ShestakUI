local T, C, L = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	ShestakUI personal configuration file
--	BACKUP THIS FILE BEFORE UPDATING!
--	ATTENTION: When saving changes to a file encoded file should be in UTF8
----------------------------------------------------------------------------------------
--	Configuration example:
----------------------------------------------------------------------------------------
-- if T.name == "MegaChar" then
--		C["chat"].width = 100500
-- 		C["tooltip"].cursor = false
--		C["unitframe"].plugins_totem_bar = false
--		C["addon"].pvp = {ADDON1, ADDON2, ADDON3, ETC}
--		C["addon"].raid = {ADDON1, ADDON2, ADDON3, ETC}
--		C["position"].tooltip = {"BOTTOMRIGHT", Minimap, "TOPRIGHT", 2, 5}
--		C["position"].bottom_bars = {"BOTTOM", UIParent, "BOTTOM", 2, 8}
--		C["position"].unitframes.tank = {"BOTTOMLEFT", UIParent, "BOTTOM", 176, 68}
-- end
----------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------
--	Per Class Config (overwrite general)
--	Class need to be UPPERCASE
----------------------------------------------------------------------------------------
if T.class == "DRUID" then

end

----------------------------------------------------------------------------------------
--	Per Character Name Config (overwrite general and class)
--	Name need to be case sensitive
----------------------------------------------------------------------------------------
if T.name == "Добрыйдоктор" then
	C["misc"].raid_tools = true
	C["misc"].invite_keyword = "докрейд"
	C["chat"].chat_bar = true
	C["raidframe"].raid_tanks_tt = true
	C["stats"].guild_repair = false
elseif T.name == "Бэкстер" or T.name == "Варбой" or T.name == "Бекстап" then
	C["general"].welcome_message = false
	C["misc"].invite_keyword = "inv"
	C["misc"].ach_screens = true
	C["misc"].announce_interrupt = true
	C["combattext"].killingblow = true
	C["pulsecooldown"].enable = true
	C["tooltip"].shift_modifer = true
	C["tooltip"].cursor = true
	C["tooltip"].title = true
	C["tooltip"].talents = true
	C["tooltip"].spell_id = true
	C["tooltip"].average_lvl = true
	C["chat"].chat_bar = true
	C["chat"].spam = true
	C["chat"].background = true
	C["chat"].combatlog = false
	C["actionbar"].split_bars = true
	C["actionbar"].rightbars_mouseover = false
	C["actionbar"].petbar_horizontal = true
	C["aura"].focus_debuffs = true
	C["aura"].cast_by = true
	C["unitframe"].icons_pvp = true
	C["unitframe"].plugins_gcd = true
	C["unitframe"].plugins_talents = true
	C["unitframe"].boss_on_right = false
	C["unitframe"].plugins_experience_bar = true
	C["unitframe"].icons_combo_point_new = true
	C["stats"].battlegeound = true
	C["addon"].pvp = {"Capping"}
	C["addon"].party = {"BigWigs", "LittleWigs", "Skada", "RaidAchievement", "Fatality"}
	C["addon"].raid = {"BigWigs", "Skada", "Boss_shieldsmonitor", "PhoenixStyle", "RaidAchievement", "Fatality", "RaidSlackCheck"}
	C["position"].threat_meter = {"BOTTOMLEFT", UIParent, "BOTTOMLEFT", 380, 18}
	C["position"].unitframes.tank = {"BOTTOMLEFT", UIParent, "BOTTOM", 176, 68}
elseif T.name == "Чаккноррис" or T.name == "Нупачимучка" or T.name == "Пратифный" or T.name == "Рукалицо"
	or T.name == "Трольпаладин" or T.name == "Чаккерс" or T.name == "Релика" or T.name == "Тинейд" then
	C["media"].texture = "Interface\\AddOns\\Media_texture\\TextureTuk.tga"
	C["general"].welcome_message = false
	C["general"].custom_lagtolerance = true
	C["misc"].auto_quest = true
	C["misc"].shift_marking = false
	C["misc"].raid_tools = false
	C["misc"].ach_screens = true
	C["combattext"].crit_prefix = ""
	C["combattext"].crit_postfix = ""
	C["combattext"].merge_aoe_spam_time = 1
	C["raidcooldown"].enable = false
	C["tooltip"].item_icon = true
	C["tooltip"].title = true
	C["tooltip"].raid_icon = true
	C["tooltip"].who_targetting = true
	C["tooltip"].hide_combat = true
	C["chat"].combatlog = false
	C["nameplate"].combat = true
	C["actionbar"].show_grid = false
	C["unitframe"].castbar_latency = false
	C["unitframe"].enemy_health_color = false
	C["raidframe"].icons_lfd_role = true
	C["raidframe"].plugins_healcomm = false
	C["threat"].enable = false
	if T.name == "Трольпаладин" or T.name == "Рукалицо"	or T.name == "Чаккерс" then
		C["actionbar"].bottombars = 3
	end
end

----------------------------------------------------------------------------------------
--	Per Max Character Level Config (overwrite general, class and name)
----------------------------------------------------------------------------------------
if T.level ~= MAX_PLAYER_LEVEL then

end

----------------------------------------------------------------------------------------
--	Font replace for zhTW and zhCN client
----------------------------------------------------------------------------------------
if T.client == "zhTW" then
	C["media"].normal_font = "Fonts\\bLEI00D.ttf"
	C["media"].pixel_font = "Fonts\\bLEI00D.ttf"
	C["media"].pixel_font_style = "OUTLINE"
	C["media"].pixel_font_size = 11

	C["font"].stats_font = "Fonts\\bLEI00D.ttf"
	C["font"].stats_font_size = 12
	C["font"].stats_font_style = "OUTLINE"
	C["font"].stats_font_shadow = true

	C["font"].combat_text_font = "Fonts\\bLEI00D.ttf"
	C["font"].combat_text_font_size = 16
	C["font"].combat_text_font_style = ""
	C["font"].combat_text_font_shadow = true

	C["font"].chat_font = "Fonts\\bLEI00D.ttf"
	C["font"].chat_font_style = ""
	C["font"].chat_font_shadow = true

	C["font"].chat_tabs_font = "Fonts\\bLEI00D.ttf"
	C["font"].chat_tabs_font_size = 12
	C["font"].chat_tabs_font_style = "OUTLINE"
	C["font"].chat_tabs_font_shadow = true

	C["font"].action_bars_font = "Fonts\\bLEI00D.ttf"
	C["font"].action_bars_font_size = 12
	C["font"].action_bars_font_style = "OUTLINE"
	C["font"].action_bars_font_shadow = true

	C["font"].threat_meter_font = "Fonts\\bLEI00D.ttf"
	C["font"].threat_meter_font_size = 12
	C["font"].threat_meter_font_style = "OUTLINE"
	C["font"].threat_meter_font_shadow = true

	C["font"].raid_cooldowns_font = "Fonts\\bLEI00D.ttf"
	C["font"].raid_cooldowns_font_size = 12
	C["font"].raid_cooldowns_font_style = "OUTLINE"
	C["font"].raid_cooldowns_font_shadow = true

	C["font"].cooldown_timers_font = "Fonts\\bLEI00D.ttf"
	C["font"].cooldown_timers_font_size = 13
	C["font"].cooldown_timers_font_style = "OUTLINE"
	C["font"].cooldown_timers_font_shadow = true

	C["font"].loot_font = "Fonts\\bLEI00D.ttf"
	C["font"].loot_font_size = 13
	C["font"].loot_font_style = "OUTLINE"
	C["font"].loot_font_shadow = true

	C["font"].nameplates_font = "Fonts\\bLEI00D.ttf"
	C["font"].nameplates_font_size = 13
	C["font"].nameplates_font_style = "OUTLINE"
	C["font"].nameplates_font_shadow = true

	C["font"].unit_frames_font = "Fonts\\bLEI00D.ttf"
	C["font"].unit_frames_font_size = 12
	C["font"].unit_frames_font_style = "OUTLINE"
	C["font"].unit_frames_font_shadow = true

	C["font"].auras_font = "Fonts\\bLEI00D.ttf"
	C["font"].auras_font_size = 11
	C["font"].auras_font_style = "OUTLINE"
	C["font"].auras_font_shadow = true

	C["font"].filger_font = "Fonts\\bLEI00D.ttf"
	C["font"].filger_font_size = 14
	C["font"].filger_font_style = "OUTLINE"
	C["font"].filger_font_shadow = true

	C["font"].stylization_font = "Fonts\\bLEI00D.ttf"
	C["font"].stylization_font_size = 12
	C["font"].stylization_font_style = ""
	C["font"].stylization_font_shadow = true
elseif T.client == "zhCN" then
	C["media"].normal_font = "Fonts\\ZYKai_T.ttf"
	C["media"].pixel_font = "Fonts\\ZYKai_T.ttf"
	C["media"].pixel_font_style = "OUTLINE"
	C["media"].pixel_font_size = 11
end

----------------------------------------------------------------------------------------
--	My Config
----------------------------------------------------------------------------------------
if T.author == true then
	C["general"].welcome_message = false
	C["general"].custom_lagtolerance = true
	C["misc"].auto_quest = true
	C["misc"].vehicle_mouseover = true
	C["misc"].ach_screens = true
	C["misc"].quest_auto_button = true
	C["combattext"].crit_postfix = ""
	C["combattext"].crit_prefix = ""
	C["combattext"].heal_treshold = 500
	C["combattext"].stop_ve_spam = true
	C["combattext"].dk_runes = false
	C["combattext"].dispel = false
	C["combattext"].interrupt = false
	C["tooltip"].shift_modifer = true
	C["tooltip"].cursor = true
	C["tooltip"].title = true
	C["tooltip"].talents = true
	C["tooltip"].average_lvl = true
	C["tooltip"].who_targetting = true
	C["chat"].combatlog = false
	C["chat"].spam = true
	C["actionbar"].toggle_mode = false
	C["unitframe"].arena_on_right = false
	C["unitframe"].icons_combo_point_new = true
	C["stats"].fps = false
	C["stats"].guild_repair = false
	C["stats"].battleground = true
	if T.realm == "Дракономор" then
		C["unitframe"].icons_pvp  = true
	end
end