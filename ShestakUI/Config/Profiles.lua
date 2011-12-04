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
	C["stats"].fps = false
	C["stats"].guild_repair = false
	C["stats"].battleground = true
	if T.level == MAX_PLAYER_LEVEL then
		C["misc"].ach_screens = true
		C["stats"].experience = false
		C["combattext"].heal_treshold = 500
	end
	if T.realm == "Дракономор" then
		C["unitframe"].icons_pvp = true
	end
end

----------------------------------------------------------------------------------------
--	Sw2rT1 Config
----------------------------------------------------------------------------------------
if T.name == "Чаккноррис" or T.name == "Нупачимучка" or T.name == "Пратифный" or T.name == "Рукалицо"
	or T.name == "Трольпаладин" or T.name == "Чаккерс" or T.name == "Релика" or T.name == "Тинейд" or T.name == "Тупаяшколота" then
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
	C["position"].bn_popup = {"BOTTOMLEFT", UIParent, "BOTTOMLEFT", 400, 24}
	C["position"].quest = {"TOPRIGHT", UIParent, "TOPRIGHT", -21, -85}
	C["position"].threat_meter = {"BOTTOM", UIParent, "BOTTOM", 0, 107}
	C["position"].raid_cooldown = {"TOPRIGHT", UIParent, "TOPRIGHT", -21, -115}
	C["position"].unitframes.player = {"BOTTOM", UIParent, "BOTTOM", -283, 243}
	C["position"].unitframes.target = {"BOTTOM", UIParent, "BOTTOM", 283, 243}
	C["general"].welcome_message = false
	C["misc"].auto_decline_duel = false
	C["misc"].auto_resurrection = false
	C["misc"].ach_screens = true
	C["skins"].blizzard_frames = true
	C["skins"].dbm = true
	C["combattext"].scrollable = true
	C["combattext"].dk_runes = false
	C["combattext"].killingblow = true
	C["enemycooldown"].show_always = true
	C["tooltip"].item_icon = true
	C["tooltip"].talents = true
	C["tooltip"].title = true
	C["tooltip"].average_lvl = true
	C["tooltip"].raid_icon = true
	C["tooltip"].who_targetting = true
	C["chat"].filter = false
	C["loot"].auto_greed = false
	C["nameplate"].show_castbar_name = true
	C["nameplate"].class_icons = true
	C["actionbar"].hotkey = false
	C["actionbar"].bottombars = 1
	C["actionbar"].rightbars = 3
	C["aura"].focus_debuffs = true
	C["aura"].tot_debuffs = true
	C["aura"].cast_by = true
	C["unitframe"].castbar_icon = true
	C["unitframe"].castbar_latency = false
	C["unitframe"].plugins_rune_bar = false
	C["unitframe"].plugins_smooth_bar = true
	C["unitframe"].plugins_talents = true
	C["raidframe"].raid_tanks_tt = true
	C["raidframe"].icons_lfd_role = true
	C["stats"].battleground = true
	C["stats"].guild_repair = false
end