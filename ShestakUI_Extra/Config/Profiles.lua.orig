local T, C, L = unpack(ShestakUI)

----------------------------------------------------------------------------------------
--	ShestakUI_Extra personal configuration file
--	BACKUP THIS FILE BEFORE UPDATING!
--	ATTENTION: When saving changes to a file encoded file should be in UTF8
----------------------------------------------------------------------------------------
--	Configuration example:
----------------------------------------------------------------------------------------
-- if T.name == "MegaChar" then
--		C["extra_general"].click_cast = true
-- 		C["extra_general"].move_blizzard = false
--		C["extra_bar"].enable = true
--		C["extra_skins"].blizzard_frames = true
--		C["extra_position"].micro_menu = {"TOPLEFT", UIParent, "TOPLEFT", 2, -2}
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
	C["extra_general"].disenchanting = true
	C["extra_general"].poison = true
	C["extra_general"].item_level = true
	C["extra_general"].skip_cinematic = true
	C["extra_general"].auto_role = true
	C["extra_general"].tab_binder = true
	C["extra_general"].map_boss_count = true
	C["extra_general"].instance_lock = true
	C["extra_general"].item_transmogrify = true
	C["extra_general"].healer_icon = true
	C["extra_general"].damage_meter_spam = true
	C["extra_general"].sum_buyouts = true
	C["extra_general"].gem_counter = true
	C["extra_announce"].flask_food = true
	C["extra_announce"].toy_train = true
	C["extra_announce"].says_thanks = true
	if T.class == "DRUID" then
		C["extra_general"].click_cast = true
		C["extra_general"].buff_automator = true
	end
	if T.class == "PRIEST" then
		C["extra_general"].click_cast = true
		C["extra_announce"].lightwell = true
	end
	if T.class == "PALADIN" then
		C["extra_announce"].bad_tank = true
	end
	if T.level ~= MAX_PLAYER_LEVEL then
		C["extra_general"].explore_map = true
	end
end

----------------------------------------------------------------------------------------
--	Oz Config
----------------------------------------------------------------------------------------
if T.name == "Oz" then
	C["extra_position"].extra_bar = {"BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -245, 24}
	C["extra_general"].move_blizzard = true
	C["extra_general"].arena_calc = true
	C["extra_general"].align = true
	C["extra_general"].item_level = true
	C["extra_general"].tab_binder = true
	C["extra_general"].map_boss_count = true
	C["extra_general"].gem_counter = true
	C["extra_general"].item_transmogrify = true
	C["extra_general"].healer_icon = true
	C["extra_general"].damage_meter_spam = true
	C["extra_announce"].flask_food = true
	C["extra_bar"].enable = true
	C["extra_bar"].mouseover = true
	C["extra_skins"].blood_shield_tracker = true
	C["extra_skins"].my_role_play = true
	C["extra_skins"].npcscan = true
end

----------------------------------------------------------------------------------------
--	ILF7-Virinea Config
----------------------------------------------------------------------------------------
if (T.name == "Мейнстрим" or T.name == "Мейнвульф" or T.name == "Мейнрейн" or T.name == "Мейнгрейв"
or T.name == "Виринейка" or T.name == "Вирин" or T.name == "Вириней" or T.name == "Виринеа"
or T.name == "Лунорог" or T.name == "Вирка" or T.name == "Виринка") and T.realm == "Азурегос" then
	C["extra_general"].move_blizzard = true
	C["extra_general"].align = true
	C["extra_general"].color_picker = true
	C["extra_general"].skip_cinematic = true
	C["extra_general"].item_level = true
	C["extra_general"].disenchanting = true
	C["extra_general"].tab_binder = true
	C["extra_general"].explore_map = true
	C["extra_general"].map_boss_count = true
	C["extra_general"].instance_lock = true
	C["extra_general"].item_transmogrify = true
	C["extra_general"].healer_icon = true
	C["extra_general"].damage_meter_spam = true
	C["extra_general"].sum_buyouts = true
	C["extra_general"].gem_counter = true
	C["extra_announce"].flask_food = true
	C["extra_announce"].flask_food_auto = true
	C["extra_announce"].my_fps = true
	C["extra_skins"].atlasloot = true
	if T.name == "Мейнстрим" or T.name == "Мейнвульф" or T.name == "Мейнрейн" or T.name == "Мейнгрейв" then
		C["extra_position"].mark_bar = {"BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -225, 160}
		C["extra_general"].mark_bar = true
		C["extra_general"].auto_role = true
		C["extra_general"].buff_automator = true
	elseif T.name == "Виринеа" then
		C["extra_announce"].lightwell = true
	end
end