local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	ShestakUI personal configuration file
--	BACKUP THIS FILE BEFORE UPDATING!
--	ATTENTION: When saving changes to a file encoded file should be in UTF8
----------------------------------------------------------------------------------------
--	Configuration example:
----------------------------------------------------------------------------------------
-- if T.name == "MegaChar" then
--		C["chat"].width = 100500
--		C["tooltip"].cursor = false
--		C["unitframe_class_bar"].totem = false
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
if T.name == "CharacterName" then

end

----------------------------------------------------------------------------------------
--	Per Max Character Level Config (overwrite general, class and name)
----------------------------------------------------------------------------------------
if T.level ~= MAX_PLAYER_LEVEL then

end

----------------------------------------------------------------------------------------
--	Shestak Config
----------------------------------------------------------------------------------------
if T.author == true then
	C["general"].welcome_message = false
	C["general"].custom_lagtolerance = true
	C["misc"].vehicle_mouseover = true
	C["misc"].quest_auto_button = true
	C["misc"].hide_bg_spam = true
	C["misc"].item_level = true
	C["misc"].gem_counter = true
	C["misc"].already_known = true
	C["misc"].disenchanting = true
	C["misc"].sum_buyouts = true
	C["misc"].profession_database = true
	C["announcements"].spells = true
	C["announcements"].flask_food = true
	C["announcements"].toy_train = true
	C["announcements"].says_thanks = true
	C["announcements"].feasts = true
	C["announcements"].portals = true
	C["automation"].accept_quest = true
	C["automation"].auto_collapse = true
	C["automation"].skip_cinematic = true
	C["automation"].auto_role = true
	C["automation"].tab_binder = true
	C["automation"].currency_cap = true
	C["skins"].blizzard_frames = true
	C["combattext"].crit_postfix = ""
	C["combattext"].dk_runes = false
	C["combattext"].dispel = false
	C["combattext"].interrupt = false
	C["threat"].hide_solo = true
	C["tooltip"].shift_modifer = true
	C["tooltip"].cursor = true
	C["tooltip"].title = true
	C["tooltip"].talents = true
	C["tooltip"].average_lvl = true
	C["tooltip"].who_targetting = true
	C["tooltip"].raid_icon = true
	C["tooltip"].unit_role = true
	C["tooltip"].reforge = true
	C["tooltip"].symbiosis = true
	C["tooltip"].instance_lock = true
	C["chat"].combatlog = false
	C["chat"].spam = true
	C["chat"].damage_meter_spam = true
	C["minimap"].toggle_menu = false
	C["map"].map_boss_count = true
	C["nameplate"].track_auras = true
	C["nameplate"].healer_icon = true
	C["actionbar"].toggle_mode = false
	C["unitframe"].arena_on_right = false
	C["unitframe"].plugins_talents = true
	C["unitframe"].plugins_diminishing = true
	C["unitframe_class_bar"].vengeance = false
	C["stats"].fps = false
	C["stats"].battleground = true
	C["toppanel"].enable = false
	if T.level == MAX_PLAYER_LEVEL then
		C["automation"].screenshot = true
		C["stats"].experience = false
		C["combattext"].heal_treshold = 500
	else
		C["map"].explore_map = true
	end
	if T.class == "DRUID" or T.class == "PRIEST" then
		C["misc"].click_cast = true
		if T.class == "PRIEST" then
			C["announcements"].lightwell = true
		end
	end
	if T.realm ~= "Дракономор" then
		C["automation"].accept_invite = true
	end
end

----------------------------------------------------------------------------------------
--	Sw2rT1 Config
----------------------------------------------------------------------------------------
if T.name == "Чаккноррис" or T.name == "Нупачимучка" or T.name == "Пратифный"
or T.name == "Рукалицо" or T.name == "Трольпаладин" or T.name == "Чаккерс"
or T.name == "Релика" or T.name == "Тинейд" or T.name == "Тупаяшколота" then
	C["media"].texture = "Interface\\AddOns\\Media_texture\\TextureTuk.tga"
	C["general"].welcome_message = false
	C["general"].custom_lagtolerance = true
	C["misc"].shift_marking = false
	C["misc"].raid_tools = false
	C["misc"].already_known = true
	C["misc"].disenchanting = true
	C["announcements"].drinking = true
	C["announcements"].interrupts = true
	C["announcements"].says_thanks = true
	C["announcements"].pull_countdown = false
	C["automation"].accept_invite = true
	C["automation"].accept_quest = true
	C["automation"].auto_collapse = true
	C["automation"].skip_cinematic = true
	C["automation"].auto_role = true
	C["automation"].cancel_bad_buffs = true
	C["automation"].currency_cap = true
	C["skins"].blizzard_frames = true
	C["skins"].minimap_buttons = true
	C["skins"].combustion_helper = true
	C["skins"].dbm = true
	C["combattext"].crit_prefix = ""
	C["combattext"].crit_postfix = ""
	C["combattext"].merge_aoe_spam_time = 1
	C["raidcooldown"].enable = false
	C["enemycooldown"].show_inpvp = true
	C["threat"].enable = false
	C["tooltip"].item_icon = true
	C["tooltip"].title = true
	C["tooltip"].raid_icon = true
	C["tooltip"].who_targetting = true
	C["tooltip"].hide_combat = true
	C["tooltip"].item_count = true
	C["tooltip"].reforge = true
	C["tooltip"].instance_lock = true
	C["chat"].combatlog = false
	C["chat"].damage_meter_spam = true
	C["nameplate"].combat = true
	C["aura"].focus_debuffs = true
	C["unitframe"].castbar_latency = false
	C["unitframe"].enemy_health_color = false
	C["raidframe"].icons_role = true
	if T.name ~= "Релика" then
		C["raidframe"].plugins_healcomm = false
	end
	if T.name == "Чаккноррис" then
		C["actionbar"].show_grid = false
	end
end

----------------------------------------------------------------------------------------
--	Oz@Pozzo dell'Eternità Config
----------------------------------------------------------------------------------------
if T.oz == true then
	C["position"].threat_meter = {"BOTTOM", UIParent, "BOTTOM", 0, 294}
	C["position"].enemy_cooldown = {"BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -402, 321}
	C["position"].unitframes.player = {"BOTTOM", UIParent, "BOTTOM", 0, 388}
	C["position"].unitframes.target = {"BOTTOM", UIParent, "BOTTOM", 283, 388}
	C["position"].unitframes.pet = {"BOTTOMLEFT", UIParent, "BOTTOMLEFT", 379, 75}
	C["position"].unitframes.focus = {"BOTTOMLEFT", UIParent, "BOTTOMLEFT", 379, 238}
	C["position"].unitframes.focus_target = {"BOTTOMLEFT", UIParent, "BOTTOMLEFT", 379, 166}
	C["position"].unitframes.party_heal = {"BOTTOM", UIParent, "BOTTOM", -235, 253}
	C["position"].unitframes.raid_heal = {"BOTTOM", UIParent, "BOTTOM", -235, 95}
	C["position"].unitframes.player_castbar = {"CENTER", UIParent, "CENTER", 0, -202}
	C["position"].unitframes.target_castbar = {"CENTER", UIParent, "CENTER", 11, -179}
	C["general"].welcome_message = false
	C["misc"].afk_spin_camera = false
	C["misc"].profession_database = true
	C["automation"].screenshot = true
	C["automation"].logging_combat = true
	C["combattext"].scrollable = true
	C["enemycooldown"].show_always = true
	C["threat"].width = 128
	C["threat"].bar_rows = 3
	C["actionbar"].hotkey = false
	C["aura"].focus_debuffs = true
	C["aura"].fot_debuffs = true
	C["aura"].pet_debuffs = true
	C["aura"].tot_debuffs = true
	C["unitframe"].alternative_portraits = true
	C["unitframe"].plugins_gcd = true
	C["raidframe"].raid_tanks_tt = true
	C["raidframe"].raid_groups = 8
	C["raidframe"].raid_groups_vertical = true
	C["raidframe"].raid_portraits = true
	C["raidframe"].plugins_aura_watch_timer = true
	C["raidframe"].plugins_auto_resurrection = true
end

----------------------------------------------------------------------------------------
--	ILF7-Virinea Config
----------------------------------------------------------------------------------------
if (T.name == "Мейнстрим" or T.name == "Мейнвульф" or T.name == "Мейнрейн" or T.name == "Мейнгрейв"
or T.name == "Виринейка" or T.name == "Вирин" or T.name == "Вириней" or T.name == "Виринеа"
or T.name == "Лунорог" or T.name == "Вирка" or T.name == "Виринка") and T.realm == "Азурегос" then
	C["media"].pixel_font = C.media.normal_font
	C["media"].pixel_font_style = "OUTLINE"
	C["media"].pixel_font_size = 14
	C["general"].custom_lagtolerance = true
	C["misc"].invite_keyword = "+"
	C["misc"].quest_auto_button = true
	C["misc"].profession_database = true
	C["misc"].already_known = true
	C["misc"].item_level = true
	C["misc"].gem_counter = true
	C["misc"].disenchanting = true
	C["misc"].sum_buyouts = true
	C["misc"].move_blizzard = true
	C["misc"].color_picker = true
	C["announcements"].drinking = true
	C["announcements"].interrupts = true
	C["announcements"].spells = true
	C["announcements"].spells_from_all = true
	C["announcements"].toy_train = true
	C["announcements"].says_thanks = true
	C["announcements"].flask_food = true
	C["announcements"].flask_food_auto = true
	C["announcements"].feasts = true
	C["announcements"].portals = true
	C["automation"].screenshot = true
	C["automation"].accept_invite = true
	C["automation"].decline_duel = false
	C["automation"].cancel_bad_buffs = true
	C["automation"].tab_binder = true
	C["automation"].logging_combat = true
	C["skins"].blizzard_frames = true
	C["skins"].minimap_buttons = true
	C["skins"].atlasloot = true
	C["combattext"].blizz_head_numbers = true
	C["reminder"].solo_buffs_sound = true
	C["reminder"].raid_buffs_always = true
	C["reminder"].raid_buffs_size = 20
	C["enemycooldown"].show_always = true
	C["pulsecooldown"].enable = true
	C["pulsecooldown"].sound = true
	C["pulsecooldown"].anim_scale = 2
	C["pulsecooldown"].threshold = 5
	C["threat"].enable = false
	C["tooltip"].item_icon = true
	C["tooltip"].health_value = true
	C["tooltip"].talents = true
	C["tooltip"].title = true
	C["tooltip"].spell_id = true
	C["tooltip"].average_lvl = true
	C["tooltip"].raid_icon = true
	C["tooltip"].who_targetting = true
	C["tooltip"].item_count = true
	C["tooltip"].unit_role = true
	C["tooltip"].reforge = true
	C["tooltip"].symbiosis = true
	C["tooltip"].instance_lock = true
	C["tooltip"].item_transmogrify = true
	C["chat"].background = true
	C["chat"].background_alpha = 0.45
	C["chat"].height = 165
	C["chat"].chat_bar = true
	C["chat"].bubbles = false
	C["chat"].damage_meter_spam = true
	C["bag"].button_size = 35
	C["bag"].bank_columns = 15
	C["minimap"].tracking_icon = true
	C["minimap"].size = 165
	C["map"].map_boss_count = true
	C["map"].explore_map = true
	C["loot"].icon_size = 40
	C["loot"].width = 300
	C["loot"].auto_greed = false
	C["loot"].auto_confirm_de = false
	C["nameplate"].height = 12
	C["nameplate"].ad_height = 20
	C["nameplate"].ad_width = 50
	C["nameplate"].combat = true
	C["nameplate"].health_value = true
	C["nameplate"].show_castbar_name = true
	C["nameplate"].class_icons = true
	C["nameplate"].track_auras = true
	C["nameplate"].auras_size = 30
	C["nameplate"].healer_icon = true
	C["actionbar"].macro = true
	C["actionbar"].button_size = 35
	C["actionbar"].classcolor_border = true
	C["actionbar"].toggle_mode = false
	C["actionbar"].bottombars = 3
	C["actionbar"].rightbars = 2
	C["actionbar"].stancebar_mouseover = false
	C["aura"].player_buff_size = 35
	C["aura"].show_spiral = true
	C["aura"].focus_debuffs = true
	C["aura"].tot_debuffs = true
	C["aura"].cast_by = true
	C["aura"].classcolor_border = true
	C["unitframe"].bar_color_value = true
	C["unitframe"].castbar_icon = true
	C["unitframe"].castbar_ticks = true
	C["unitframe"].icons_pvp = true
	C["unitframe"].portrait_enable = true
	C["unitframe"].plugins_gcd = true
	C["unitframe"].plugins_swing = true
	C["unitframe"].plugins_reputation_bar = true
	C["unitframe"].plugins_experience_bar = true
	C["unitframe"].plugins_talents = true
	C["unitframe"].plugins_combat_feedback = true
	C["unitframe"].plugins_diminishing = true
	C["raidframe"].raid_tanks_tt = true
	C["raidframe"].icons_role = true
	C["raidframe"].plugins_debuffhighlight_icon = true
	C["raidframe"].plugins_aura_watch_timer = true
	C["raidframe"].raid_groups = 8
	C["raidframe"].plugins_auto_resurrection = true
	C["stats"].battleground = true
	C["error"].hide = false
	C["font"].stats_font = C.media.pixel_font
	C["font"].stats_font_style = "OUTLINE"
	C["font"].stats_font_size = 14
	C["font"].combat_text_font = C.media.pixel_font
	C["font"].combat_text_font_style = "OUTLINE"
	C["font"].combat_text_font_size = 18
	C["font"].chat_tabs_font = C.media.pixel_font
	C["font"].chat_tabs_font_style = ""
	C["font"].chat_tabs_font_shadow = true
	C["font"].chat_tabs_font_size = 12
	C["font"].action_bars_font = C.media.pixel_font
	C["font"].action_bars_font_style = "OUTLINE"
	C["font"].action_bars_font_size = 12
	C["font"].raid_cooldowns_font = C.media.pixel_font
	C["font"].raid_cooldowns_font_style = ""
	C["font"].raid_cooldowns_font_shadow = true
	C["font"].raid_cooldowns_font_size = 14
	C["font"].cooldown_timers_font = C.media.pixel_font
	C["font"].cooldown_timers_font_style = "OUTLINE"
	C["font"].cooldown_timers_font_size = 22
	C["font"].loot_font = C.media.pixel_font
	C["font"].loot_font_style = "OUTLINE"
	C["font"].loot_font_size = 14
	C["font"].nameplates_font = C.media.pixel_font
	C["font"].nameplates_font_style = "OUTLINE"
	C["font"].nameplates_font_size = 14
	C["font"].unit_frames_font = C.media.pixel_font
	C["font"].unit_frames_font_style = ""
	C["font"].unit_frames_font_shadow = true
	C["font"].unit_frames_font_size = 14
	C["font"].auras_font = C.media.pixel_font
	C["font"].auras_font_style = "OUTLINE"
	C["font"].auras_font_size = 16
	C["font"].filger_font = C.media.pixel_font
	C["font"].filger_font_style = "OUTLINE"
	C["font"].filger_font_size = 16
	C["font"].stylization_font = C.media.pixel_font
	C["font"].stylization_font_style = "OUTLINE"
	C["font"].stylization_font_size = 16
	C["font"].bags_font = C.media.pixel_font
	C["font"].bags_font_style = "OUTLINE"
	C["font"].bags_font_size = 14
	if T.name == "Мейнстрим" or T.name == "Мейнвульф" or T.name == "Мейнрейн" or T.name == "Мейнгрейв" then
		C["position"].stance_bar = {"BOTTOM", UIParent, "BOTTOM", -345, 166}
		C["position"].group_loot = {"RIGHT", UIParent, "RIGHT", -331, -24}
		C["position"].raid_cooldown = {"TOPLEFT", UIParent, "TOPLEFT", 285, -20}
		C["position"].quest = {"TOPRIGHT", UIParent, "TOPRIGHT", -270, -100}
		C["position"].vehicle_bar = {"BOTTOMLEFT", UIParent, "BOTTOMLEFT", 440, 175}
		C["position"].unitframes.tank = {"LEFT", UIParent, "LEFT", 23, 0}
		C["automation"].accept_quest = true
		C["automation"].auto_role = true
		C["combattext"].icon_size = 25
		C["combattext"].heal_treshold = 5000
		C["chat"].width = 398
		C["actionbar"].split_bars = true
	elseif T.name == "Виринейка" or T.name == "Вирин" or T.name == "Вириней" or T.name == "Виринеа"
	or T.name == "Лунорог" or T.name == "Вирка" or T.name == "Виринка" then
		C["position"].unitframes.player = {"TOPLEFT", UIParent, "TOPLEFT", 90, -60}
		C["position"].unitframes.target = {"TOP", UIParent, "TOP", -200, -60}
		C["position"].achievement = {"TOP", UIParent, "TOP", 0, -170}
		C["position"].stance_bar = {"BOTTOM", UIParent, "BOTTOM", -95, 120}
		C["position"].group_loot = {"CENTER", UIParent, "CENTER", 0, -235}
		C["position"].raid_cooldown = {"TOPLEFT", UIParent, "TOPLEFT", 285, -20}
		C["position"].quest = {"TOPLEFT", UIParent, "TOPLEFT", 20, -170}
		C["position"].vehicle_bar = {"BOTTOM", UIParent, "BOTTOM", 200, 120}
		C["position"].enemy_cooldown = {"BOTTOM", UIParent, "BOTTOM", -140, 185}
		C["chat"].width = 380
		C["unitframe"].show_boss = false
		C["raidframe"].raid_tanks = false
		C["stats"].experience = false
	end
	if T.class == "PRIEST" then
		C["announcements"].lightwell = true
	end
end

----------------------------------------------------------------------------------------
--	Nagiko@Pozzo dell'Eternità Config
----------------------------------------------------------------------------------------
if T.name == "Ozzolo" and T.realm == "Pozzo dell'Eternità" then
	C["font"].stats_font_style = "OUTLINE"
	C["font"].stats_font_size = 14
	C["font"].combat_text_font_style = "OUTLINE"
	C["font"].combat_text_font_size = 18
	C["font"].chat_tabs_font_size = 12
	C["font"].action_bars_font_style = "OUTLINE"
	C["font"].action_bars_font_size = 12
	C["font"].raid_cooldowns_font_style = ""
	C["font"].raid_cooldowns_font_shadow = true
	C["font"].raid_cooldowns_font_size = 14
	C["font"].threat_meter_font_style = "OUTLINE"
	C["font"].threat_meter_font_shadow = true
	C["font"].threat_meter_font_size = 14
	C["font"].cooldown_timers_font_style = "OUTLINE"
	C["font"].cooldown_timers_font_size = 22
	C["font"].loot_font_style = "OUTLINE"
	C["font"].loot_font_size = 14
	C["font"].nameplates_font_style = "OUTLINE"
	C["font"].nameplates_font_size = 14
	C["font"].stylization_font_style = "OUTLINE"
	C["font"].stylization_font_size = 14
	C["font"].bags_font_style = "OUTLINE"
	C["font"].bags_font_size = 14
	C["position"].player_buffs = {"TOPLEFT", Minimap, "TOPLEFT", -572, 2}
	C["position"].stance_bar = {"TOPLEFT", UIParent, "TOPLEFT", 323, -21}
	C["position"].micro_menu = {"TOPLEFT", UIParent, "TOPLEFT", 21, -21}
	C["position"].unitframes.arena = {"RIGHT", oUF_Target, "RIGHT", -242, 7}
	C["position"].unitframes.boss = {"RIGHT", oUF_Target, "RIGHT", -242, 7}
	C["media"].border_color = {0.2, 0, 0.2, 1}
	C["misc"].profession_database = true
	C["combattext"].enable = false
	C["pulsecooldown"].enable = true
	C["pulsecooldown"].sound = true
	C["pulsecooldown"].anim_scale = 2
	C["pulsecooldown"].threshold = 5
	C["chat"].background = true
	C["chat"].tabs_mouseover = false
	C["bag"].button_size = 35
	C["minimap"].tracking_icon = true
	C["nameplate"].height = 12
	C["nameplate"].ad_height = 20
	C["nameplate"].ad_width = 50
	C["nameplate"].track_auras = true
	C["nameplate"].auras_size = 30
	C["actionbar"].button_size = 35
	C["actionbar"].split_bars = true
	C["actionbar"].rightbars_mouseover = false
	C["actionbar"].micromenu = true
	C["aura"].player_buff_size = 35	
	C["aura"].focus_debuffs = true
	C["aura"].pet_debuffs = true
	C["unitframe"].own_color = false
	C["unitframe"].portrait_enable = true
end

-- edit by Oz of shestak. org --
