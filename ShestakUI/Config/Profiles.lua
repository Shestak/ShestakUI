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
--		C["tooltip"].cursor = false
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
	C["misc"].auto_quest = true
	C["misc"].auto_accept_invite = true
	C["misc"].vehicle_mouseover = true
	C["misc"].quest_auto_button = true
	C["announcements"].spells = true
	C["skins"].blizzard_frames = true
	C["combattext"].crit_postfix = ""
	C["combattext"].crit_prefix = ""
	C["combattext"].stop_ve_spam = true
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
	C["chat"].combatlog = false
	C["chat"].spam = true
	C["nameplate"].track_auras = true
	C["actionbar"].toggle_mode = false
	C["unitframe"].arena_on_right = false
	C["unitframe"].plugins_vengeance_bar = false
	C["raidframe"].plugins_auto_resurrection = true
	C["stats"].fps = false
	C["stats"].battleground = true
	if T.level == MAX_PLAYER_LEVEL then
		C["misc"].ach_screens = true
		C["stats"].experience = false
		C["combattext"].heal_treshold = 500
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
	C["misc"].auto_quest = true
	C["misc"].shift_marking = false
	C["misc"].raid_tools = false
	C["misc"].ach_screens = true
	C["misc"].auto_accept_invite = true
	C["announcements"].drinking = true
	C["announcements"].interrupts = true
	C["skins"].dbm = true
	C["skins"].blizzard_frames = true
	C["skins"].minimap_buttons = true
	C["skins"].combustion_helper = true
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
	C["aura"].focus_debuffs = true
	C["unitframe"].castbar_latency = false
	C["unitframe"].enemy_health_color = false
	C["raidframe"].icons_lfd_role = true
	C["threat"].enable = false
	if T.name ~= "Релика" then
		C["raidframe"].plugins_healcomm = false
	end
	if T.name == "Чаккноррис" then
		C["actionbar"].show_grid = false
	end
end

----------------------------------------------------------------------------------------
--	Oz@Runetotem Config
----------------------------------------------------------------------------------------
if T.name == "Oz" and T.realm == "Runetotem" then
	C["position"].bn_popup = {"BOTTOMLEFT", UIParent, "BOTTOMLEFT", 381, 24}
	C["position"].quest = {"TOPLEFT", UIParent, "TOPLEFT", 21, -46}
	C["position"].threat_meter = {"CENTER", UIParent, "CENTER", 0, -154}
	C["position"].raid_cooldown = {"TOPRIGHT", UIParent, "TOPRIGHT", -21, -115}
	C["position"].top_panel = {"BOTTOM", UIParent, "BOTTOM", 0, 7}
	C["position"].bottom_bars = {"BOTTOM", UIParent, "BOTTOM", 0, 41}
	C["position"].stance_bar = {"TOPLEFT", UIParent, "TOPLEFT", 21, -21}
	C["position"].unitframes.player = {"BOTTOM", UIParent, "BOTTOM", -284, 289}
	C["position"].unitframes.target = {"BOTTOM", UIParent, "BOTTOM", 283, 289}
	C["position"].unitframes.raid_dps = {"TOPLEFT", UIParent, "TOPLEFT", 23, -115}
	C["position"].unitframes.player_portrait = {"TOPRIGHT", "oUF_Player", "TOPLEFT", -12, 0}
	C["position"].unitframes.target_portrait = {"TOPLEFT", "oUF_Target", "TOPRIGHT", 10, 0}
	C["position"].unitframes.player_castbar = {"BOTTOM", "ActionBarAnchor", "TOP", 0, 223}
	C["position"].unitframes.target_castbar = {"BOTTOM", "ActionBarAnchor", "TOP", 11, 246}
	C["media"].border_color = {0.1, 0.1, 0.1, 1}
	C["misc"].auto_decline_duel = false
	C["misc"].auto_resurrection = false
	C["misc"].ach_screens = true
	C["skins"].blizzard_frames = true
	C["skins"].dbm = true
	C["combattext"].scrollable = true
	C["combattext"].dk_runes = false
	C["combattext"].killingblow = true
	C["enemycooldown"].show_always = true
	C["threat"].width = 150
	C["threat"].bar_rows = 2
	C["tooltip"].item_icon = true
	C["tooltip"].talents = true
	C["tooltip"].title = true
	C["tooltip"].average_lvl = true
	C["tooltip"].raid_icon = true
	C["tooltip"].who_targetting = true
	C["chat"].background = true
	C["chat"].filter = false
	C["loot"].auto_greed = false
	C["nameplate"].show_castbar_name = true
	C["nameplate"].class_icons = true
	C["actionbar"].hotkey = false
	C["actionbar"].bottombars = 1
	C["actionbar"].rightbars = 3
	C["actionbar"].shapeshift_mouseover = false
	C["aura"].show_spiral = true
	C["aura"].focus_debuffs = true
	C["aura"].fot_debuffs = true
	C["aura"].pet_debuffs = true
	C["aura"].tot_debuffs = true
	C["aura"].cast_by = true
	C["unitframe"].own_color = true
	C["unitframe"].uf_color = {0.15, 0.15, 0.15}
	C["unitframe"].enemy_health_color = false
	C["unitframe"].color_value = true
	C["unitframe"].bar_color_value = true
	C["unitframe"].castbar_icon = true
	C["unitframe"].castbar_latency = false
	C["unitframe"].icons_pvp = true
	C["unitframe"].portrait_enable = true
	C["unitframe"].portrait_classcolor_border = false
	C["unitframe"].portrait_height = 27
	C["unitframe"].portrait_width = 27
	C["unitframe"].plugins_necro_strike = true
	C["unitframe"].plugins_smooth_bar = true
	C["unitframe"].plugins_talents = true
	C["raidframe"].raid_tanks_tt = true
	C["raidframe"].icons_lfd_role = true
	C["toppanel"].mouseover = false
	C["toppanel"].width = 333
	C["stats"].battleground = true
	C["stats"].guild_repair = false
end

----------------------------------------------------------------------------------------
--	ILF7-Virinea Config
----------------------------------------------------------------------------------------
if (T.name == "Мейнстрим" or T.name == "Мейнвульф" or T.name == "Махес" or T.name == "Ночнойшорох"
or T.name == "Виринейка" or T.name == "Вирин" or T.name == "Вириней" or T.name == "Виринеа"
or T.name == "Лунорог" or T.name == "Вирка") and T.realm == "Азурегос" then
	C["media"].pixel_font = C.media.normal_font
	C["media"].pixel_font_style = "OUTLINE"
	C["media"].pixel_font_size = 14
	C["general"].custom_lagtolerance = true
	C["misc"].auto_decline_duel = false
	C["misc"].auto_accept_invite = true
	C["misc"].invite_keyword = "инвайт"
	C["misc"].ach_screens = true
	C["skins"].blizzard_frames = true
	C["skins"].minimap_buttons = true
	C["reminder"].solo_buffs_sound = true
	C["reminder"].raid_buffs_always = true
	C["reminder"].raid_buffs_size = 25
	C["pulsecooldown"].enable = true
	C["pulsecooldown"].sound = true
	C["pulsecooldown"].anim_scale = 2
	C["pulsecooldown"].threshold = 10
	C["threat"].enable = false
	C["tooltip"].item_icon = true
	C["tooltip"].health_value = true
	C["tooltip"].talents = true
	C["tooltip"].achievements = false
	C["tooltip"].title = true
	C["tooltip"].spell_id = true
	C["tooltip"].average_lvl = true
	C["tooltip"].raid_icon = true
	C["tooltip"].who_targetting = true
	C["tooltip"].item_count = true
	C["chat"].background = true
	C["chat"].background_alpha = 0.45
	C["chat"].chat_bar = true
	C["chat"].bubbles = false
	C["bag"].button_size = 35
	C["bag"].bank_columns = 15
	C["minimap"].tracking_icon = true
	C["minimap"].size = 200
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
	C["actionbar"].macro = true
	C["actionbar"].button_size = 35
	C["actionbar"].classcolor_border = true
	C["actionbar"].toggle_mode = false
	C["actionbar"].bottombars = 3
	C["actionbar"].rightbars = 2
	C["aura"].player_buff_size = 35
	C["aura"].show_spiral = true
	C["aura"].focus_debuffs = true
	C["aura"].tot_debuffs = true
	C["aura"].cast_by = true
	C["aura"].classcolor_border = true
	C["unitframe"].bar_color_value = true
	C["unitframe"].castbar_icon = true
	C["unitframe"].icons_pvp = true
	C["unitframe"].portrait_enable = true
	C["unitframe"].plugins_reputation_bar = true
	C["unitframe"].plugins_experience_bar = true
	C["unitframe"].plugins_talents = true
	C["unitframe"].plugins_combat_feedback = true
	C["raidframe"].raid_tanks_tt = true
	C["raidframe"].icons_lfd_role = true
	C["raidframe"].plugins_debuffhighlight_icon = true
	C["raidframe"].plugins_aura_watch_timer = true
	C["raidframe"].raid_groups = 8
	C["toppanel"].height = 120
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
	if T.name == "Мейнстрим" or T.name == "Мейнвульф" or T.name == "Махес" or T.name == "Ночнойшорох" then
		C["position"].stance_bar = {"BOTTOM", UIParent, "BOTTOM", -345, 166}
		C["position"].group_loot = {"RIGHT", UIParent, "RIGHT", -331, -24}
		C["position"].raid_cooldown = {"TOPLEFT", UIParent, "TOPLEFT", 285, -20}
		C["position"].quest = {"TOPRIGHT", UIParent, "TOPRIGHT", -270, -100}
		C["position"].vehicle_bar = {"BOTTOMLEFT", UIParent, "BOTTOMLEFT", 440, 175}
		C["position"].unitframes.tank = {"LEFT", UIParent, "LEFT", 23, 0}
		C["combattext"].icon_size = 25
		C["combattext"].heal_treshold = 1000
		C["chat"].width = 398
		C["chat"].height = 300
		C["actionbar"].split_bars = true
		C["stats"].battleground = true
	elseif T.name == "Виринейка" or T.name == "Вирин" or T.name == "Виринеа" or T.name == "Лунорог" or T.name == "Вирка" or T.name == "Вириней" then
		C["position"].unitframes.player = {"TOPLEFT", UIParent, "TOPLEFT", 90, -60}
		C["position"].unitframes.target = {"TOP", UIParent, "TOP", -200, -60}
		C["position"].achievement = {"TOP", UIParent, "TOP", 0, -170}
		C["position"].stance_bar = {"BOTTOM", UIParent, "BOTTOM", -95, 120}
		C["position"].group_loot = {"CENTER", UIParent, "CENTER", 0, -235}
		C["position"].raid_cooldown = {"TOPLEFT", UIParent, "TOPLEFT", 285, -20}
		C["position"].quest = {"TOPLEFT", UIParent, "TOPLEFT", 20, -170}
		C["position"].vehicle_bar = {"BOTTOM", UIParent, "BOTTOM", 200, 120}
		C["position"].enemy_cooldown = {"BOTTOM", UIParent, "BOTTOM", -140, 185}
		C["combattext"].enable = false
		C["chat"].width = 380
		C["chat"].height = 150
		C["actionbar"].shapeshift_mouseover = false
		C["unitframe"].show_boss = false
		C["raidframe"].raid_tanks = false
		C["stats"].experience = false
	end
end