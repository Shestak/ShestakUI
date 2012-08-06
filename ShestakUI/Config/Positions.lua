﻿local T, C, L = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Position options
----------------------------------------------------------------------------------------
C["position"] = {
	-- Miscellaneous positions
	["minimap"] = {"TOPRIGHT", UIParent, "TOPRIGHT", -21, -21},						-- Minimap
	["map"] = {"BOTTOM", UIParent, "BOTTOM", -120, 320},							-- Map
	["chat"] = {"BOTTOMLEFT", UIParent, "BOTTOMLEFT", 24, 23},						-- Chat
	["bag"] = {"BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -21, 24},					-- Bag
	["bank"] = {"LEFT", UIParent, "LEFT", 23, 150},									-- Bank
	["bn_popup"] = {"BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -21, 157},				-- BattleNet popup
	["achievement"] = {"TOP", UIParent, "TOP", 0, -20},								-- Achievements frame
	["tooltip"] = {"BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -21, 157},				-- Tooltip
	["attempt"] = {"TOP", UIParent, "TOP", -85, -25},								-- Attempts frame
	["capture_bar"] = {"TOP", UIParent, "TOP", 0, 3},								-- BG capture bars
	["vehicle"] = {"BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -245, 160},				-- Vehicle frame
	["uierror"] = {"TOP", UIParent, "TOP", 0, -30},									-- Errors frame
	["quest"] = {"TOPRIGHT", UIParent, "TOPRIGHT", -389, -167},						-- Quest log
	["loot"] = {"TOPLEFT", UIParent, "TOPLEFT", 245, -220},							-- Loot
	["group_loot"] = {"BOTTOM", UIParent, "BOTTOM", -210, 500},						-- Group roll loot
	["threat_meter"] = {"BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -245, 24},			-- Threat meter
	["raid_cooldown"] = {"TOPRIGHT", UIParent, "TOPRIGHT", -172, -169},				-- Raid cooldowns
	["enemy_cooldown"] = {"BOTTOMLEFT", "oUF_Player", "TOPRIGHT", 33, 62},			-- Enemy cooldowns
	["pulse_cooldown"] = {"CENTER", UIParent, "CENTER", 0, 0},						-- Pulse cooldowns
	["bg_score"] = {"BOTTOMLEFT", ActionButton12, "BOTTOMRIGHT", 10, -2},			-- BG stats
	["self_buffs"] = {"CENTER", UIParent, "CENTER", 0, 190},						-- Self buff reminder
	["raid_buffs"] = {"BOTTOMLEFT", Minimap, "BOTTOMLEFT", -2, -24},				-- Raid buff reminder
	["top_panel"] = {"TOP", UIParent, "TOP", 0, -118},								-- Top panel
	["raid_utility"] = {"BOTTOMLEFT", Minimap, "BOTTOMLEFT", -21, -195},			-- Raid utility
	["damage_meter"] = {"BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -23, 26},			-- Damage meter
	-- ActionBar positions
	["bottom_bars"] = {"BOTTOM", UIParent, "BOTTOM", 0, 8},							-- Bottom bars
	["right_bars"] = {"BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -21, 320},			-- Right bars
	["pet_horizontal"] = {"BOTTOMRIGHT", UIParent, "BOTTOM", -175, 167},			-- Horizontal pet bar
	["stance_bar"] = {"TOPLEFT", UIParent, "TOPLEFT", 21, -21},						-- Stance/Shift/Totem bars
	["vehicle_bar"] = {"BOTTOMRIGHT", ActionButton1, "BOTTOMLEFT", -3, 0},			-- Vehicle button
	-- UnitFrame positions
	["player_buffs"] = {"TOPLEFT", Minimap, "TOPLEFT", -422, 2},					-- Player buffs
	unitframes = {
		["player"] = {"BOTTOMRIGHT", "ActionBarAnchor", "TOPLEFT", -5, 247},		-- Player frame
		["target"] = {"BOTTOMLEFT", "ActionBarAnchor", "TOPRIGHT", 5, 247},			-- Target frame
		["target_target"] = {"TOPRIGHT", "oUF_Target", "BOTTOMRIGHT", 0, -19},		-- ToT frame
		["pet"] = {"TOPLEFT", "oUF_Player", "BOTTOMLEFT", 0, -19},					-- Pet frame
		["focus"] = {"TOPRIGHT", "oUF_Player", "BOTTOMRIGHT", 0, -19},				-- Focus frame
		["focus_target"] = {"TOPLEFT", "oUF_Target", "BOTTOMLEFT", 0, -19},			-- Focus target frame
		["party_heal"] = {"TOPLEFT", "oUF_Player", "BOTTOMRIGHT", 7, -19},			-- Heal layout Party frames
		["raid_heal"] = {"TOPLEFT", "oUF_Player", "BOTTOMRIGHT", 7, -19},			-- Heal layout Raid frames
		["party_dps"] = {"BOTTOMLEFT", UIParent, "LEFT", 23, -70},					-- DPS layout Party frames
		["raid_dps"] = {"TOPLEFT", UIParent, "TOPLEFT", 23, -51},					-- DPS layout Raid frames
		["arena"] = {"BOTTOMRIGHT", UIParent, "RIGHT", -23, -70},					-- Arena frames
		["boss"] = {"BOTTOMRIGHT", UIParent, "RIGHT", -23, -70},					-- Boss frames
		["tank"] = {"BOTTOM", "UIParent", "BOTTOM", 302, 35},						-- Tank frames
		["player_portrait"] = {"TOPRIGHT", "oUF_Player", "TOPLEFT", -8, 0},			-- Player Portrait
		["target_portrait"] = {"TOPLEFT", "oUF_Target", "TOPRIGHT", 6, 0},			-- Target Portrait
		["player_castbar"] = {"BOTTOM", "ActionBarAnchor", "TOP", 0, 235},			-- Player Castbar
		["target_castbar"] = {"BOTTOM", "oUF_Player_Castbar", "TOP", 0, 7},			-- Target Castbar
		["focus_castbar"] = {"CENTER", UIParent, "CENTER", 0, 250},					-- Focus Castbar icon
	},
}

-- edit by Oz of shestak. org --