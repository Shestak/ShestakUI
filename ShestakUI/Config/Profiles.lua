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
if T.name == "Бэкстер" or T.name == "Варбой" or T.name == "Бекстап" or T.name == "Жахаюшопздц" then
	C["general"].welcome_message = false
	C["misc"].invite_keyword = "inv"
	C["misc"].ach_screens = true
	C["misc"].announce_interrupt = true
	C["combattext"].killingblow = true
	C["pulsecooldown"].enable = true
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
elseif T.name == "Чаккноррис" or T.name == "Нупачимучка" or T.name == "Пратифный" or T.name == "Рукалицо"
	or T.name == "Трольпаладин" or T.name == "Чаккерс" or T.name == "Релика" or T.name == "Тинейд" or T.name == "Тупаяшколота" then
	C["media"].texture = "Interface\\AddOns\\Media_texture\\TextureTuk.tga"
	C["general"].welcome_message = false
	C["general"].custom_lagtolerance = true
	C["misc"].auto_quest = true
	C["misc"].shift_marking = false
	C["misc"].raid_tools = false
	C["misc"].ach_screens = true
	C["misc"].auto_accept_invite = true
	C["misc"].announce_interrupt = true
	C["skins"].dbm = true
	C["skins"].recount = true
	C["combattext"].crit_prefix = ""
	C["combattext"].crit_postfix = ""
	C["combattext"].merge_aoe_spam_time = 1
	C["raidcooldown"].enable = false
	C["tooltip"].item_icon = true
	C["tooltip"].title = true
	C["tooltip"].raid_icon = true
	C["tooltip"].who_targetting = true
	C["tooltip"].hide_combat = true
	C["tooltip"].item_count = true
	C["chat"].combatlog = false
	C["nameplate"].combat = true
	C["unitframe"].castbar_latency = false
	C["unitframe"].enemy_health_color = false
	C["raidframe"].icons_lfd_role = true
	C["threat"].enable = false
	if T.name == "Трольпаладин" or T.name == "Рукалицо"	or T.name == "Чаккерс" then
		C["actionbar"].bottombars = 3
	end
	if T.name ~= "Релика" then
		C["raidframe"].plugins_healcomm = false
	end
	if T.name == "Чаккноррис" then
		C["actionbar"].show_grid = false
	end
end

----------------------------------------------------------------------------------------
--	Per Max Character Level Config (overwrite general, class and name)
----------------------------------------------------------------------------------------
if T.level ~= MAX_PLAYER_LEVEL then

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
	C["tooltip"].raid_icon = true
	C["chat"].combatlog = false
	C["chat"].spam = true
	C["nameplate"].class_icons = true
	C["nameplate"].track_auras = true
	C["actionbar"].toggle_mode = false
	C["unitframe"].arena_on_right = false
	C["unitframe"].icons_combo_point_new = true
	C["stats"].fps = false
	C["stats"].guild_repair = false
	C["stats"].battleground = true
	if T.level == MAX_PLAYER_LEVEL then
		C["stats"].experience = false
		C["combattext"].heal_treshold = 500
	end
	if T.realm == "Дракономор" then
		C["unitframe"].icons_pvp  = true
	end
end