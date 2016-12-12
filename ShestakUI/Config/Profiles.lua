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
--		T.CustomFilgerSpell = {
--			{"T_DEBUFF_ICON", {spellID = 115767, unitID = "target", caster = "player", filter = "DEBUFF"}},
--		}
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
--	Oz@Pozzo dell'Eternità Config
----------------------------------------------------------------------------------------
if T.name == "Oz" and T.realm == "Pozzo dell'Eternità" then
	C["position"].bank = {"RIGHT", ChatFrame1, "BOTTOM", 349, 371}
	C["position"].bn_popup = {"BOTTOMRIGHT", Minimap, "TOPRIGHT", 2, 5}
	C["position"].vehicle = {"BOTTOMLEFT", "ActionBarAnchor", "BOTTOMRIGHT", 109, 100}
	C["position"].ghost = {"TOPLEFT", "oUF_Player", "TOPLEFT", -2, 65}
	C["position"].quest = {"TOPRIGHT", UIParent, "TOPRIGHT", -238, -111}
	C["position"].loot = {"TOPLEFT", UIParent, "TOPLEFT", 21, -532}
	C["position"].group_loot = {"TOPLEFT", UIParent, "TOPLEFT", 241, -211}
	C["position"].threat_meter = {"BOTTOM", "oUF_Target", "BOTTOM", -283, 77}
	C["position"].raid_cooldown = {"TOPRIGHT", UIParent, "TOPRIGHT", -21, -115}
	C["position"].enemy_cooldown = {"BOTTOMLEFT", "oUF_Target", "BOTTOMRIGHT", 9, -62}
	C["position"].raid_buffs = {"BOTTOMLEFT", Minimap, "TOPLEFT", -2, 5}
	C["position"].raid_utility = {"TOPLEFT", UIParent, "TOPLEFT", 241, -21}
	C["position"].extra_button = {"RIGHT", "oUF_Player", "BOTTOM", -53, -126}
	C["position"].stance_bar = {"RIGHT", "oUF_Player", "BOTTOM", 82, -85}
	C["position"].unitframes.player = {"TOPLEFT", "ActionBarAnchor", "BOTTOMRIGHT", -558, 373}
	C["position"].unitframes.target = {"TOPRIGHT", "ActionBarAnchor", "BOTTOMLEFT", 558, 373}
	C["position"].unitframes.tank = {"BOTTOMLEFT", "ActionBarAnchor", "BOTTOMRIGHT", 5, 18}
	C["position"].unitframes.player_castbar = {"CENTER", UIParent, "CENTER", 0, 136}
	C["position"].unitframes.target_castbar = {"BOTTOM", "oUF_Target", "BOTTOM", -272, -4}
	C["position"].unitframes.raid_heal = {"TOPLEFT", "ActionBarAnchor", "BOTTOMRIGHT", -331, 335}
	C["media"].border_color = {0.1, 0.1, 0.1, 1}
	C["general"].welcome_message = false
	C["misc"].invite_keyword = "inv"
	C["misc"].item_level = true
	C["misc"].move_blizzard = true
	C["announcements"].flask_food = true
	C["announcements"].pull_countdown = false
	C["automation"].release = false
	C["automation"].decline_duel = false
	C["automation"].solve_artifact = false
	C["skins"].blizzard_frames = true
	C["skins"].minimap_buttons = true
	C["skins"].dbm = true
	C["skins"].npcscan = true
	C["skins"].skada = true
	C["skins"].my_role_play = true
	C["combattext"].icons = false
	C["combattext"].scrollable = true
	C["combattext"].dk_runes = false
	C["combattext"].killingblow = true
	C["reminder"].raid_buffs_size = 16.8
	C["threat"].width = 125
	C["threat"].bar_rows = 2
	C["tooltip"].item_icon = true
	C["tooltip"].talents = true
	C["tooltip"].achievements = false
	C["tooltip"].title = true
	C["tooltip"].spell_id = true
	C["tooltip"].average_lvl = true
	C["tooltip"].raid_icon = true
	C["tooltip"].who_targetting = true
	C["tooltip"].item_transmogrify = true
	C["chat"].background = true
	C["chat"].filter = false
	C["chat"].chat_bar = true
	C["chat"].chat_bar_mouseover = true
	C["chat"].tabs_mouseover = true
	C["chat"].damage_meter_spam = true
	C["minimap"].size = 116
	C["minimap"].toggle_menu = false
	C["map"].map_boss_count = true
	C["loot"].auto_greed = false
	C["nameplate"].show_castbar_name = true
	C["nameplate"].class_icons = true
	C["nameplate"].track_auras = true
	C["nameplate"].healer_icon = true
	C["actionbar"].hotkey = false
	C["actionbar"].bottombars = 1
	C["aura"].focus_debuffs = true
	C["aura"].fot_debuffs = true
	C["aura"].pet_debuffs = true
	C["aura"].tot_debuffs = true
	C["aura"].cast_by = true
	C["filger"].show_tooltip = true
	C["unitframe"].own_color = true
	C["unitframe"].uf_color = {0.15, 0.15, 0.15}
	C["unitframe"].enemy_health_color = false
	C["unitframe"].color_value = true
	C["unitframe"].bar_color_value = true
	C["unitframe"].castbar_icon = true
	C["unitframe"].icons_pvp = true
	C["unitframe"].plugins_gcd = true
	C["unitframe"].plugins_reputation_bar = true
	C["unitframe"].plugins_experience_bar = true
	C["unitframe"].plugins_friendship_bar = true
	C["unitframe"].plugins_smooth_bar = true
	C["unitframe"].plugins_enemy_spec = true
	C["unitframe"].plugins_fader = true
	C["unitframe"].plugins_diminishing = true
	C["raidframe"].raid_tanks_tt = true
	C["raidframe"].raid_groups = 8
	C["raidframe"].icons_role = true
	C["raidframe"].plugins_aura_watch_timer = true
	C["raidframe"].plugins_auto_resurrection = true
	C["toppanel"].enable = false
	C["stats"].battleground = true
end

----------------------------------------------------------------------------------------
--	Sw2rT1 Config
----------------------------------------------------------------------------------------
if (T.name == "Чаккичак" or T.name == "Чаккноррис" or T.name == "Чакерс"
or T.name == "Чакернаут" or T.name == "Чаккис" or T.name == "Эзэрвуд" or T.name == "Какес") and T.realm == "Подземье" then
	C["general"].welcome_message = false
	C["misc"].shift_marking = false
	C["misc"].raid_tools = false
	C["misc"].hide_bg_spam = true
	C["misc"].disenchanting = true
	C["misc"].hide_talking_head = true
	C["announcements"].pull_countdown = false
	C["automation"].accept_invite = true
	C["automation"].accept_quest = true
	C["automation"].auto_collapse = true
	C["automation"].currency_cap = true
	C["skins"].blizzard_frames = true
	C["skins"].minimap_buttons = true
	C["skins"].dbm = true
	C["combattext"].crit_prefix = ""
	C["combattext"].crit_postfix = ""
	C["raidcooldown"].enable = false
	C["threat"].enable = false
	C["tooltip"].item_icon = true
	C["tooltip"].title = true
	C["tooltip"].raid_icon = true
	C["tooltip"].average_lvl = true
	C["tooltip"].item_count = true
	C["tooltip"].instance_lock = true
	C["chat"].combatlog = false
	C["chat"].damage_meter_spam = true
	C["bag"].ilvl = true
	C["map"].fog_of_war = true
	C["nameplate"].combat = true
	C["unitframe"].enemy_health_color = false
	C["unitframe"].castbar_latency = false
	C["raidframe"].raid_groups = 6
	C["raidframe"].icons_role = true
	C["toppanel"].enable = false
	C["position"].quest = {"TOPRIGHT", UIParent, "TOPRIGHT", -52, -73}
end

----------------------------------------------------------------------------------------
--	Wetxius Config
----------------------------------------------------------------------------------------
if IsWetxius then
	C["general"].welcome_message = false
	C["misc"].shift_marking = false
	C["misc"].vehicle_mouseover = true
	C["misc"].quest_auto_button = true
	C["misc"].disenchanting = true
	C["misc"].click_cast = true
	C["misc"].enchantment_scroll = true
	C["announcements"].bad_gear = true
	C["automation"].accept_invite = true
	C["automation"].accept_quest = true
	C["automation"].auto_collapse = true
	C["automation"].auto_role = true
	C["automation"].tab_binder = true
	C["skins"].blizzard_frames = true
	C["skins"].minimap_buttons = true
	C["skins"].bigwigs = true
	C["combattext"].crit_prefix = ""
	C["combattext"].blizz_head_numbers = true
	C["combattext"].dk_runes = false
	C["pulsecooldown"].enable = true
	C["pulsecooldown"].threshold = 8
	C["threat"].enable = false
	C["tooltip"].hide_combat = true
	C["tooltip"].rank = false
	C["tooltip"].spell_id = true
	C["tooltip"].unit_role = true
	C["chat"].background = true
	C["chat"].spam = true
	C["chat"].damage_meter_spam = true
	C["chat"].chat_bar = true
	C["chat"].chat_bar_mouseover = true
	C["chat"].combatlog = false
	C["minimap"].toggle_menu = false
	C["map"].fog_of_war = true
	C["nameplate"].health_value = true
	C["nameplate"].healer_icon = true
	C["actionbar"].toggle_mode = false
	C["actionbar"].bottombars = 3
	C["aura"].show_spiral = true
	C["aura"].cast_by = true
	C["filger"].show_tooltip = true
	C["unitframe"].castbar_icon = true
	C["unitframe"].plugins_enemy_spec = true
	C["raidframe"].solo_mode = true
	C["raidframe"].icons_leader = false
	C["toppanel"].enable = false
	C["stats"].fps = false
	C["stats"].battleground = true
	C["stats"].currency_cooking = false
	C["stats"].currency_professions = false
	C["stats"].currency_raid = false
	C["stats"].currency_pvp = false
	C["stats"].currency_misc = false
	C["font"].stats_font = C.media.normal_font
	C["font"].stats_font_style = "OUTLINE"
	C["font"].stats_font_size = 12
	C["position"].bag = {"BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -21, 20}
	C["position"].bank = {"BOTTOMLEFT", UIParent, "BOTTOMLEFT", 21, 20}
	C["position"].auto_button = {"BOTTOMLEFT", "oUF_Player", "TOPRIGHT", 33, 83}
	C["position"].unitframes.arena = {"BOTTOMRIGHT", UIParent, "RIGHT", -55, -70}
	if T.level == MAX_PLAYER_LEVEL then
		C["automation"].screenshot = true
		C["combattext"].heal_treshold = 1000
		C["stats"].experience = false
	end

	local frame = CreateFrame("Frame")
	frame:RegisterEvent("PLAYER_LOGIN")
	frame:SetScript("OnEvent", function()
		SetCVar("lootUnderMouse", 1)
	end)
end