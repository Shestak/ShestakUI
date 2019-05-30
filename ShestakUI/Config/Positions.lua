local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Position options
--	BACKUP THIS FILE BEFORE UPDATING!
----------------------------------------------------------------------------------------
C["position"] = {
	-- Miscellaneous positions
	["minimap_buttons"] = {"TOPRIGHT", Minimap, "TOPLEFT", -3, 2},					-- Minimap buttons
	["minimap"] = {"BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -21, 24},				-- Minimap
	["map"] = {"BOTTOM", UIParent, "BOTTOM", 0, 320},								-- Map
	["chat"] = {"BOTTOMLEFT", UIParent, "BOTTOMLEFT", 24, 23},						-- Chat
	["bag"] = {"BOTTOMRIGHT", Minimap, "TOPRIGHT", 2, 5},							-- Bag
	["bank"] = {"LEFT", UIParent, "LEFT", 23, 150},									-- Bank
	["bn_popup"] = {"BOTTOMLEFT", ChatFrame1, "TOPLEFT", -3, 24},					-- Battle.net popup
	["achievement"] = {"TOP", UIParent, "TOP", 0, -21},								-- Achievements frame
	["tooltip"] = {"BOTTOMRIGHT", Minimap, "TOPRIGHT", 2, 5},						-- Tooltip
	["attempt"] = {"TOP", UIParent, "TOP", 0, -25},									-- Attempts frame
	["capture_bar"] = {"TOP", UIParent, "TOP", 0, 3},								-- BG capture bars
	["vehicle"] = {"BOTTOM", Minimap, "TOP", 0, 27},								-- Vehicle frame
	["ghost"] = {"BOTTOM", Minimap, "TOP", 0, 5},									-- Ghost frame
	["uierror"] = {"TOP", UIParent, "TOP", 0, -30},									-- Errors frame
	["quest"] = {"TOPLEFT", UIParent, "TOPLEFT", 21, -2},							-- Quest log
	["quest_timer"] = {"BOTTOM", Minimap, "TOP", 0, 64},							-- Quest timer
	["loot"] = {"TOPLEFT", UIParent, "TOPLEFT", 245, -220},							-- Loot
	["group_loot"] = {"BOTTOM", UIParent, "BOTTOM", -238, 500},						-- Group roll loot
	["threat_meter"] = {"BOTTOMLEFT", "ActionBarAnchor", "BOTTOMRIGHT", 7, 16},		-- Threat meter
	["raid_cooldown"] = {"TOPLEFT", UIParent, "TOPLEFT", 21, -30},					-- Raid cooldowns
	["enemy_cooldown"] = {"BOTTOMLEFT", "oUF_Player", "TOPRIGHT", 33, 62},			-- Enemy cooldowns
	["pulse_cooldown"] = {"CENTER", UIParent, "CENTER", 0, 0},						-- Pulse cooldowns
	["bg_score"] = {"BOTTOMLEFT", ActionButton12, "BOTTOMRIGHT", 10, -2},			-- BG stats
	["player_buffs"] = {"TOPRIGHT", UIParent, "TOPRIGHT", -21, -21},				-- Player buffs
	["self_buffs"] = {"CENTER", UIParent, "CENTER", 0, 190},						-- Self buff reminder
	["raid_buffs"] = {"BOTTOMLEFT", Minimap, "TOPLEFT", -2, 5},						-- Raid buff reminder
	["top_panel"] = {"TOP", UIParent, "TOP", 0, -21},								-- Top panel
	["raid_utility"] = {"TOP", UIParent, "TOP", -280, 1},							-- Raid utility
	["archaeology"] = {"BOTTOMRIGHT", Minimap, "TOPRIGHT", 2, 5},					-- Archaeology frame
	["auto_button"] = {"BOTTOMLEFT", Minimap, "TOPLEFT", -2, 27},					-- Auto button
	["extra_button"] = {"BOTTOMRIGHT", ActionButton1, "BOTTOMLEFT", -3, 0},			-- Extra action button
	["alt_power_bar"] = {"TOP", UIParent, "TOP", 0, -21},							-- Alt power bar
	["talking_head"] = {"TOP", UIParent, "TOP", 0, -21},							-- Talking Head
	-- ActionBar positions
	["bottom_bars"] = {"BOTTOM", UIParent, "BOTTOM", 0, 8},							-- Bottom bars
	["right_bars"] = {"BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -21, 330},			-- Right bars
	["pet_horizontal"] = {"BOTTOMRIGHT", UIParent, "BOTTOM", -175, 167},			-- Horizontal pet bar
	["stance_bar"] = {"BOTTOMRIGHT", UIParent, "BOTTOM", -202, 167},				-- Stance bar
	["vehicle_bar"] = {"BOTTOMRIGHT", ActionButton1, "BOTTOMLEFT", -3, 0},			-- Vehicle button
	["micro_menu"] = {"TOPLEFT", UIParent, "TOPLEFT", 2, -2},						-- Micro menu
	-- UnitFrame positions
	unitframes = {
		["player"] = {"BOTTOMRIGHT", "ActionBarAnchor", "TOPLEFT", -9, 175},		-- Player frame
		["target"] = {"BOTTOMLEFT", "ActionBarAnchor", "TOPRIGHT", 9, 175},			-- Target frame
		["target_target"] = {"TOPRIGHT", "oUF_Target", "BOTTOMRIGHT", 0, -11},		-- ToT frame
		["pet"] = {"TOPLEFT", "oUF_Player", "BOTTOMLEFT", 0, -11},					-- Pet frame
		["focus"] = {"TOPRIGHT", "oUF_Player", "BOTTOMRIGHT", 0, -11},				-- Focus frame
		["focus_target"] = {"TOPLEFT", "oUF_Target", "BOTTOMLEFT", 0, -11},			-- Focus target frame
		["party_heal"] = {"TOPLEFT", "oUF_Player", "BOTTOMRIGHT", 11, -12},			-- Heal layout Party frames
		["raid_heal"] = {"TOPLEFT", "oUF_Player", "BOTTOMRIGHT", 11, -12},			-- Heal layout Raid frames
		["party_dps"] = {"BOTTOMLEFT", UIParent, "LEFT", 23, -70},					-- DPS layout Party frames
		["raid_dps"] = {"TOPLEFT", UIParent, "TOPLEFT", 22, -22},					-- DPS layout Raid frames
		["arena"] = {"BOTTOMRIGHT", UIParent, "RIGHT", -60, -70},					-- Arena frames
		["boss"] = {"BOTTOMRIGHT", UIParent, "RIGHT", -23, -70},					-- Boss frames
		["tank"] = {"BOTTOMLEFT", "ActionBarAnchor", "BOTTOMRIGHT", 10, 18},		-- Tank frames
		["player_portrait"] = {"TOPRIGHT", "oUF_Player", "TOPLEFT", -12, 27},		-- Player Portrait
		["target_portrait"] = {"TOPLEFT", "oUF_Target", "TOPRIGHT", 10, 27},		-- Target Portrait
		["player_castbar"] = {"BOTTOM", "ActionBarAnchor", "TOP", 0, 175},			-- Player Castbar
		["target_castbar"] = {"BOTTOM", "oUF_Player_Castbar", "TOP", 0, 7},			-- Target Castbar
		["focus_castbar"] = {"CENTER", UIParent, "CENTER", 0, 250},					-- Focus Castbar icon
	},
	-- Filger positions
	filger = {
		["player_buff_icon"] = {"BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 2, 173},	-- "P_BUFF_ICON"
		["player_proc_icon"] = {"BOTTOMLEFT", "oUF_Target", "TOPLEFT", -2, 173},	-- "P_PROC_ICON"
		["special_proc_icon"] = {"BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 2, 213},	-- "SPECIAL_P_BUFF_ICON"
		["target_debuff_icon"] = {"BOTTOMLEFT", "oUF_Target", "TOPLEFT", -2, 213},	-- "T_DEBUFF_ICON"
		["target_buff_icon"] = {"BOTTOMLEFT", "oUF_Target", "TOPLEFT", -2, 253},	-- "T_BUFF"
		["pve_debuff"] = {"BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 2, 253},			-- "PVE/PVP_DEBUFF"
		["pve_cc"] = {"TOPLEFT", "oUF_Player", "BOTTOMLEFT", -2, -44},				-- "PVE/PVP_CC"
		["cooldown"] = {"BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 63, C.unitframe.plugins_swing and 29 or 17},	-- "COOLDOWN"
		["target_bar"] = {"BOTTOMLEFT", C.unitframe.portrait_enable and "oUF_Target_Portrait" or "oUF_Target", "BOTTOMRIGHT", C.unitframe.portrait_enable and 6 or 9, C.unitframe.portrait_enable and -3 or -41},	-- "T_DE/BUFF_BAR"
	},
}

if T.classic then
	C.position.quest = {"TOPLEFT", UIParent, "TOPLEFT", 21, -36}
end