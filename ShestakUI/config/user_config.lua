----------------------------------------------------------------------------------------
--	ShestakUI personal configuration file
--	BACKUP THIS FILE BEFORE UPDATING!
--	ATTENTION: When saving changes to a file encoded file should be in UTF8
----------------------------------------------------------------------------------------
--	Configuration example:
----------------------------------------------------------------------------------------
-- if SettingsDB.name == "MegaChar" then
--		SettingsCF["chat"].width = 100500
-- 		SettingsCF["tooltip"].cursor = false
--		SettingsCF["unitframe"].plugins_totem_bar = false
--		SettingsCF["addon"].pvp = {ADDON1, ADDON2, ADDON3, ETC}
--		SettingsCF["addon"].raid = {ADDON1, ADDON2, ADDON3, ETC}
--		SettingsCF["position"].tooltip = {"BOTTOMRIGHT", Minimap, "TOPRIGHT", 2, 5}
--		SettingsCF["position"].bottom_bars = {"BOTTOM", UIParent, "BOTTOM", 2, 8}
-- end
----------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------
--	Font replace for zhTW and zhCN client
----------------------------------------------------------------------------------------
if SettingsDB.client == "zhTW" then
	SettingsCF["media"].normal_font = [[Fonts\bLEI00D.ttf]]
	SettingsCF["media"].pixel_font = [[Fonts\bLEI00D.ttf]]
	SettingsCF["media"].pixel_font_style = "OUTLINE"
elseif SettingsDB.client == "zhCN" then
	SettingsCF["media"].normal_font = [[Fonts\ZYKai_T.ttf]]
	SettingsCF["media"].pixel_font = [[Fonts\ZYKai_T.ttf]]
	SettingsCF["media"].pixel_font_style = "OUTLINE"
end

----------------------------------------------------------------------------------------
--	Per Class Config (overwrite general)
--	Class need to be UPPERCASE
----------------------------------------------------------------------------------------
if SettingsDB.class == "DRUID" then

end

----------------------------------------------------------------------------------------
--	Per Character Name Config (overwrite general and class)
--	Name need to be case sensitive
----------------------------------------------------------------------------------------
if SettingsDB.name == "Черешок" 
	or SettingsDB.name == "Вершок"
	or SettingsDB.name == "Вещмешок" 
	or SettingsDB.name == "Гребешок" 
	or SettingsDB.name == "Кулешок" 
	or SettingsDB.name == "Лапушок" 
	or SettingsDB.name == "Обушок" 
	or SettingsDB.name == "Ремешок"
	or SettingsDB.name == "Шестак" then
	SettingsCF["general"].minimap_icon = false
	SettingsCF["general"].welcome_message = false
	SettingsCF["misc"].auto_quest = true
	SettingsCF["misc"].vehicle_mouseover = true
	SettingsCF["misc"].quest_auto_button = true
	SettingsCF["misc"].raid_tools = true
	SettingsCF["combattext"].treshold = 500
	SettingsCF["combattext"].heal_treshold = 1000
	SettingsCF["combattext"].crit_postfix = ""
	SettingsCF["combattext"].crit_prefix = ""
	SettingsCF["combattext"].healing = false
	SettingsCF["tooltip"].shift_modifer = true
	SettingsCF["tooltip"].cursor = true
	SettingsCF["tooltip"].title = true
	SettingsCF["tooltip"].talents = true
	SettingsCF["unitframe"].arena_on_right = false
	SettingsCF["error"].black = false
	SettingsCF["error"].white = true
end