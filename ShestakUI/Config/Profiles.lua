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

end

----------------------------------------------------------------------------------------
--	Oz@Pozzo dell'Eternità Config
----------------------------------------------------------------------------------------
if T.name == "Oz" and T.realm == "Pozzo dell'Eternità" then
	C["position"].vehicle = {"BOTTOMLEFT", "ActionBarAnchor", "BOTTOMRIGHT", 109, 100}
	C["position"].ghost = {"TOPLEFT", "oUF_Player", "TOPLEFT", -2, 65}
	C["position"].loot = {"TOPLEFT", UIParent, "TOPLEFT", 21, -532}
	C["position"].group_loot = {"TOPLEFT", UIParent, "TOPLEFT", 241, -211}
	C["position"].threat_meter = {"BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -245, 24}
	C["position"].enemy_cooldown = {"BOTTOMLEFT", "oUF_Target", "BOTTOMRIGHT", 5, -67}
	C["position"].raid_utility = {"TOPLEFT", UIParent, "TOPLEFT", 241, -21}
	C["position"].extra_button = {"RIGHT", "oUF_Player", "BOTTOM", -53, -126}
	C["position"].unitframes.player = {"TOPLEFT", "ActionBarAnchor", "BOTTOMRIGHT", -558, 407}
	C["position"].unitframes.target = {"TOPRIGHT", "ActionBarAnchor", "BOTTOMLEFT", 558, 407}
	C["position"].unitframes.player_castbar = {"BOTTOMRIGHT", "oUF_Player", "BOTTOMLEFT", -203, -194}
	C["position"].unitframes.target_castbar = {"TOPLEFT", "oUF_Target", "TOPRIGHT", -512, 56}
	C["position"].unitframes.raid_heal = {"TOPLEFT", "ActionBarAnchor", "BOTTOMRIGHT", -331, 407}
	C["media"].overlay_color = {0, 0, 0, 0.5}
	C["general"].welcome_message = false
	C["misc"].profession_database = true
	C["automation"].screenshot = true
	C["automation"].logging_combat = true
	C["combattext"].scrollable = true
	C["chat"].background = true
	C["chat"].background_alpha = 0.5
	C["minimap"].toggle_menu = false
	C["actionbar"].hotkey = false
	C["aura"].fot_debuffs = true
	C["aura"].pet_debuffs = true
	C["aura"].tot_debuffs = true
	C["unitframe"].own_color = true
	C["unitframe"].color_value = true
	C["unitframe"].alternative_portraits = true
	C["raidframe"].raid_tanks_tt = true
	C["raidframe"].raid_groups = 8
	C["raidframe"].raid_portraits = true
	C["raidframe"].plugins_aura_watch_timer = true
	C["raidframe"].plugins_auto_resurrection = true
end

----------------------------------------------------------------------------------------
--	Medusa@Pozzo dell'Eternità Config
----------------------------------------------------------------------------------------
if T.name == "Medusa" and T.realm == "Pozzo dell'Eternità" then
	C["position"].minimap = {"BOTTOM", UIParent, "BOTTOM", 200, 52}
	C["position"].chat = {"BOTTOM", Minimap, "BOTTOM", -338, -26}
	C["position"].ghost = {"TOPLEFT", "oUF_Player", "TOPLEFT", -2, 65}
	C["position"].quest = {"TOPLEFT", UIParent, "TOPLEFT", 21, -165}
	C["position"].enemy_cooldown = {"BOTTOMLEFT", "oUF_Target", "BOTTOMRIGHT", 5, -66}
	C["position"].bg_score = {"BOTTOMLEFT", ActionButton12, "BOTTOMRIGHT", -540, 25}
	C["position"].player_buffs_tiny_dps_layout_two = {"TOPRIGHT", UIParent, "TOPRIGHT", -21, -21}
	C["position"].raid_buffs = {"BOTTOMLEFT", Minimap, "BOTTOMLEFT", -2, -25}
	C["position"].top_panel = {"BOTTOM", Minimap, "BOTTOM", -365, 141}
	C["position"].extra_button = {"RIGHT", "oUF_Player", "BOTTOM", -53, -126}
	C["position"].bottom_bars = {"BOTTOMRIGHT", Minimap, "TOPLEFT", 132, 5}
	C["position"].vehicle_bar = {"BOTTOMRIGHT", ActionButton1, "BOTTOMLEFT", -212, 0}
	C["position"].unitframes.player = {"BOTTOMRIGHT", Minimap, "TOPLEFT", -408, 276}
	C["position"].unitframes.player_castbar = {"CENTER", UIParent, "CENTER", 0, -84}
	C["general"].welcome_message = false
	C["automation"].screenshot = true
	C["automation"].logging_combat = true
	C["skins"].tiny_dps = false
	C["skins"].tiny_dps_layout_two = true
	C["combattext"].scrollable = true
	C["reminder"].raid_buffs_size = 19.8
	C["chat"].top_editbox = false
	C["chat"].background = true
	C["chat"].width = 254
	C["chat"].height = 130
	C["chat"].chat_bar = false
	C["chat"].tabs_mouseover = false
	C["minimap"].size = 134
	C["minimap"].toggle_menu = false
	C["nameplate"].health_value = true
	C["actionbar"].button_size = 24.4
	C["actionbar"].toggle_mode = false
	C["aura"].player_buff_size = 24.4
	C["aura"].fot_debuffs = true
	C["aura"].pet_debuffs = true
	C["aura"].tot_debuffs = true
	C["unitframe"].plugins_fader = true
	C["raidframe"].deficit_health = true
	C["raidframe"].raid_tanks_tt = true
	C["raidframe"].raid_groups = 8
	C["raidframe"].raid_groups_vertical = true
	C["raidframe"].plugins_aura_watch_timer = true
	C["toppanel"].enable = true
	C["toppanel"].mouseover = false
	C["toppanel"].height = 24
	C["toppanel"].width = 206
	C["stats"].friend = false
	C["stats"].bags = false
	C["stats"].experience = false	
end

----------------------------------------------------------------------------------------
--	Lunamorta & Nagiko@Pozzo dell'Eternità Config
----------------------------------------------------------------------------------------
if T.name == "Lunamorta" or T.name == "Nagiko" and T.realm == "Pozzo dell'Eternità" then
	C["font"].stats_font = C.media.normal_font
	C["font"].stats_font_style = "OUTLINE"
	C["font"].stats_font_size = 14
	C["font"].combat_text_font = C.media.normal_font
	C["font"].combat_text_font_style = "OUTLINE"
	C["font"].combat_text_font_size = 16
	C["font"].chat_tabs_font = C.media.normal_font
	C["font"].chat_tabs_font_style = "OUTLINE"
	C["font"].chat_tabs_font_size = 12
	C["font"].action_bars_font = C.media.normal_font
	C["font"].action_bars_font_style = "OUTLINE"
	C["font"].action_bars_font_size = 12
	C["font"].raid_cooldowns_font = C.media.normal_font
	C["font"].raid_cooldowns_font_style = "OUTLINE"
	C["font"].raid_cooldowns_font_shadow = true
	C["font"].raid_cooldowns_font_size = 12
	C["font"].threat_meter_font = C.media.normal_font
	C["font"].threat_meter_font_style = "OUTLINE"
	C["font"].threat_meter_font_shadow = true
	C["font"].threat_meter_font_size = 12
	C["font"].cooldown_timers_font = C.media.normal_font
	C["font"].cooldown_timers_font_style = "OUTLINE"
	C["font"].cooldown_timers_font_size = 16
	C["font"].loot_font = C.media.normal_font
	C["font"].loot_font_style = "OUTLINE"
	C["font"].loot_font_size = 12
	C["font"].stylization_font = C.media.normal_font
	C["font"].stylization_font_style = "OUTLINE"
	C["font"].stylization_font_size = 12
	C["font"].bags_font = C.media.normal_font
	C["font"].bags_font_style = "OUTLINE"
	C["font"].bags_font_size = 12
	C["position"].threat_meter = {"BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -245, 24}
	C["position"].player_buffs = {"TOPLEFT", Minimap, "TOPLEFT", -572, 2}
	C["position"].stance_bar = {"TOPLEFT", UIParent, "TOPLEFT", 323, -21}
	C["position"].micro_menu = {"TOPLEFT", UIParent, "TOPLEFT", 21, -21}
	C["position"].unitframes.arena = {"RIGHT", oUF_Target, "RIGHT", -242, 7}
	C["position"].unitframes.boss = {"RIGHT", oUF_Target, "RIGHT", -242, 7}
	C["media"].border_color = {0.1, 0.1, 0.1, 1}
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
	C["actionbar"].button_size = 35
	C["actionbar"].split_bars = true
	C["actionbar"].toggle_mode = false
	C["actionbar"].rightbars_mouseover = false
	C["actionbar"].micromenu = true
	C["aura"].player_buff_size = 35	
	C["aura"].pet_debuffs = true
	C["aura"].player_aura_only = true
	C["unitframe"].alternative_portraits = true
end

-- Edit by Oz of shestakdotorg --
