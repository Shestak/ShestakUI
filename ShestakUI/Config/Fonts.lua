local T, C, L = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	ShestakUI fonts configuration file
--	BACKUP THIS FILE BEFORE UPDATING!
----------------------------------------------------------------------------------------
--	Configuration example:
----------------------------------------------------------------------------------------
-- C["font"] = {
--		-- Stats font
--		["stats_font"] = "Interface\\AddOns\\ShestakUI\\Media\\Fonts\\Normal.ttf",
-- 		["stats_font_size"] = 11,
--		["stats_font_style"] = "",
--		["stats_font_shadow"] = true,
-- }
----------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------
--	Fonts options
----------------------------------------------------------------------------------------
C["font"] = {
	-- Stats font
	["stats_font"] = "Interface\\AddOns\\ShestakUI\\Media\\Fonts\\Pixel.ttf",
	["stats_font_size"] = 8,
	["stats_font_style"] = "OUTLINEMONOCHROME",
	["stats_font_shadow"] = false,
	
	-- Combat text font
	["combat_text_font"] = "Interface\\AddOns\\ShestakUI\\Media\\Fonts\\Pixel.ttf",
	["combat_text_font_size"] = 16,
	["combat_text_font_style"] = "OUTLINEMONOCHROME",
	["combat_text_font_shadow"] = false,
	
	-- Chat font
	["chat_font"] = "Interface\\AddOns\\ShestakUI\\Media\\Fonts\\Normal.ttf",
	["chat_font_style"] = "",
	["chat_font_shadow"] = true,
	
	-- Chat tabs font
	["chat_tabs_font"] = "Interface\\AddOns\\ShestakUI\\Media\\Fonts\\Pixel.ttf",
	["chat_tabs_font_size"] = 8,
	["chat_tabs_font_style"] = "OUTLINEMONOCHROME",
	["chat_tabs_font_shadow"] = false,
	
	-- Action bars font
	["action_bars_font"] = "Interface\\AddOns\\ShestakUI\\Media\\Fonts\\Pixel.ttf",
	["action_bars_font_size"] = 8,
	["action_bars_font_style"] = "OUTLINEMONOCHROME",
	["action_bars_font_shadow"] = false,
	
	-- Threat meter font
	["threat_meter_font"] = "Interface\\AddOns\\ShestakUI\\Media\\Fonts\\Pixel.ttf",
	["threat_meter_font_size"] = 8,
	["threat_meter_font_style"] = "OUTLINEMONOCHROME",
	["threat_meter_font_shadow"] = false,
	
	-- Raid cooldowns font
	["raid_cooldowns_font"] = "Interface\\AddOns\\ShestakUI\\Media\\Fonts\\Pixel.ttf",
	["raid_cooldowns_font_size"] = 8,
	["raid_cooldowns_font_style"] = "OUTLINEMONOCHROME",
	["raid_cooldowns_font_shadow"] = false,
	
	-- Cooldowns timer font
	["cooldown_timers_font"] = "Interface\\AddOns\\ShestakUI\\Media\\Fonts\\Pixel.ttf",
	["cooldown_timers_font_size"] = 16,
	["cooldown_timers_font_style"] = "OUTLINEMONOCHROME",
	["cooldown_timers_font_shadow"] = false,
	
	-- Loot font
	["loot_font"] = "Interface\\AddOns\\ShestakUI\\Media\\Fonts\\Pixel.ttf",
	["loot_font_size"] = 8,
	["loot_font_style"] = "OUTLINEMONOCHROME",
	["loot_font_shadow"] = false,
	
	-- Nameplates font
	["nameplates_font"] = "Interface\\AddOns\\ShestakUI\\Media\\Fonts\\Pixel.ttf",
	["nameplates_font_size"] = 8,
	["nameplates_font_style"] = "OUTLINEMONOCHROME",
	["nameplates_font_shadow"] = false,
	
	-- Unit frames font
	["unit_frames_font"] = "Interface\\AddOns\\ShestakUI\\Media\\Fonts\\Pixel.ttf",
	["unit_frames_font_size"] = 8,
	["unit_frames_font_style"] = "OUTLINEMONOCHROME",
	["unit_frames_font_shadow"] = false,
	
	-- Auras font
	["auras_font"] = "Interface\\AddOns\\ShestakUI\\Media\\Fonts\\Pixel.ttf",
	["auras_font_size"] = 8,
	["auras_font_style"] = "OUTLINEMONOCHROME",
	["auras_font_shadow"] = false,
	
	-- Filger font
	["filger_font"] = "Interface\\AddOns\\ShestakUI\\Media\\Fonts\\Pixel.ttf",
	["filger_font_size"] = 8,
	["filger_font_style"] = "OUTLINEMONOCHROME",
	["filger_font_shadow"] = false,
	
	-- Stylization font
	["stylization_font"] = "Interface\\AddOns\\ShestakUI\\Media\\Fonts\\Pixel.ttf",
	["stylization_font_size"] = 8,
	["stylization_font_style"] = "OUTLINEMONOCHROME",
	["stylization_font_shadow"] = false,

	-- Bags font
	["bags_font"] = "Interface\\AddOns\\ShestakUI\\Media\\Fonts\\Pixel.ttf",
	["bags_font_size"] = 8,
	["bags_font_style"] = "OUTLINEMONOCHROME",
	["bags_font_shadow"] = false,
}

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

	C["font"].bags_font = "Fonts\\bLEI00D.ttf"
	C["font"].bags_font_size = 11
	C["font"].bags_font_style = "OUTLINE"
	C["font"].bags_font_shadow = true
elseif T.client == "zhCN" then
	C["media"].normal_font = "Fonts\\ZYKai_T.ttf"
	C["media"].pixel_font = "Fonts\\ZYKai_T.ttf"
	C["media"].pixel_font_style = "OUTLINE"
	C["media"].pixel_font_size = 11
end