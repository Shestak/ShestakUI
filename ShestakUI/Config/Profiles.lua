local T, C, L, _ = unpack(select(2, ...))
----------------------------------------------------------------------------------------
--	Own Config
----------------------------------------------------------------------------------------
--if T.realm == "" or T.realm == "" then

--Settings options
	--media
	--general
	C["general"].welcome_message = false
	--misc
	C["misc"].chars_currency = true
	C["misc"].quest_auto_button = true
	C["misc"].sum_buyouts = true
	C["misc"].move_blizzard = true
	C["misc"].archaeology = true
	C["misc"].already_known = true
	C["misc"].item_level = true
	C["misc"].disenchanting = true
	C["misc"].enchantment_scroll = true
	C["misc"].gem_counter = true
	--announcements
	C["announcements"].flask_food_auto = true
	C["announcements"].spells = true
	C["announcements"].flask_food_raid = true
	C["announcements"].portals = true
	C["announcements"].toys = true
	C["announcements"].flask_food = true
	C["announcements"].bad_gear = true
	C["announcements"].spells_from_all = true
	C["announcements"].says_thanks = true
	C["announcements"].lightwell = true
	C["announcements"].interrupts = true
	C["announcements"].feasts = true
	--automation
	C["automation"].accept_quest = true
	C["automation"].tab_binder = true
	C["automation"].screenshot = true
	C["automation"].auto_role = true
	C["automation"].decline_duel = false
	--skins
	C["skins"].skada = true
	C["skins"].npcscan = true
	C["skins"].blizzard_frames = true
	C["skins"].combustion_helper = true
	C["skins"].dbm = true
	C["skins"].ace3 = true
	--combattext
	C["combattext"].killingblow = true
	C["combattext"].icon_size = 11
	--reminder
	--raidcooldown
	--enemycooldown
	C["enemycooldown"].show_inpvp = true
	--pulsecooldown
	C["pulsecooldown"].enable = true
	--threat
	C["threat"].enable = false
	--tooltip
	C["tooltip"].talents = true
	C["tooltip"].item_count = true
	C["tooltip"].item_icon = true
	C["tooltip"].item_transmogrify = true
	C["tooltip"].unit_role = true
	C["tooltip"].who_targetting = true
	C["tooltip"].instance_lock = true
	C["tooltip"].spell_id = true
	C["tooltip"].raid_icon = true
	C["tooltip"].average_lvl = true
	C["tooltip"].rank = false
	--chat
	C["chat"].chat_bar = true
	C["chat"].tabs_mouseover = true
	C["chat"].combatlog = false
	C["chat"].filter = false
	C["chat"].chat_bar_mouseover = true
	--bag
	C["bag"].button_size = 33
	C["bag"].bag_columns = 8
	C["bag"].bank_columns = 16
	--minimap
	--map
	C["map"].map_boss_count = true
	C["map"].fog_of_war = true
	C["map"].explore_map = true
	--loot
	C["loot"].auto_greed = false
	C["loot"].auto_confirm_de = false
	--nameplate
	C["nameplate"].healer_icon = true
	C["nameplate"].track_auras = true
	C["nameplate"].class_icons = true
	--actionbar
	C["actionbar"].bottombars = 2
	C["actionbar"].rightbars = 2
	C["actionbar"].macro = true
	C["actionbar"].petbar_horizontal = true
	C["actionbar"].stancebar_mouseover = false
	--aura
	C["aura"].cast_by = true
	C["aura"].focus_debuffs = true
	--unitframe
	C["unitframe"].plugins_diminishing = true
	C["unitframe"].icons_pvp = true
	C["unitframe"].castbar_icon = true
	C["unitframe"].castbar_ticks = true
	C["unitframe"].plugins_smooth_bar = true
	C["unitframe"].plugins_fader = false
	C["unitframe"].plugins_gcd = true
	--unitframe_class_bar
	C["unitframe_class_bar"].range = true
	--raidframe
	C["raidframe"].raid_tanks_tt = true
	C["raidframe"].plugins_aura_watch_timer = true
	C["raidframe"].plugins_debuffhighlight_icon = true
	C["raidframe"].icons_role = true
	C["raidframe"].player_in_party = false
	C["raidframe"].raid_groups = 8
	--toppanel
	C["toppanel"].enable = true
	C["toppanel"].mouseover = true
	C["toppanel"].height = 0
	C["toppanel"].width = 0
	--stats
	C["stats"].battleground = true
	--error
	C["error"].black = false
	C["error"].combat = true
	--font
	C["font"].unit_frames_font_size = 11
	C["font"].combat_text_font_style = "OUTLINE"
	C["font"].chat_font_style = "OUTLINE"
--Position options
	C["position"].quest = {"TOPRIGHT", UIParent, "TOPRIGHT", -33, -75}
	C["position"].raid_cooldown = {"TOPRIGHT", UIParent, "TOPRIGHT", -21, -75}
	C["position"].unitframes.arena = {"BOTTOMRIGHT", UIParent, "RIGHT", -270, -70}
	C["position"].unitframes.boss = {"BOTTOMRIGHT", UIParent, "RIGHT", -270, -70}
	C["position"].pet_horizontal = {"BOTTOM", UIParent, "BOTTOM", 0, 64}
	C["position"].stance_bar = {"BOTTOM", UIParent, "BOTTOM", 154, 64}
--end
