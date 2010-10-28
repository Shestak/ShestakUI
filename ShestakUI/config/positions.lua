----------------------------------------------------------------------------------------
--	Position options
----------------------------------------------------------------------------------------
SettingsCF["position"] = {
	-- Miscellaneous positions
	["minimap"] = {"BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -23, 26},		-- Minimap
	["map"] = {"CENTER", UIParent, "CENTER", 0, 70},						-- Map
	["chat"] = {"BOTTOMLEFT", UIParent, "BOTTOMLEFT", 24, 22},				-- Chat
	["bag"]	= {"BOTTOMRIGHT", Minimap, "TOPRIGHT", -1, 8},					-- Bag
	["bank"] = {"LEFT", UIParent, "LEFT", 23, 150},							-- Bank
	["bn_popup"] = {"BOTTOMLEFT", UIParent, "BOTTOMLEFT", 21, 20},			-- BattleNet popup
	["tooltip"] = {"BOTTOMRIGHT", Minimap, "TOPRIGHT", 2, 5},				-- Tooltip
	["ticket"] = {"TOPLEFT", UIParent, "TOPLEFT", 20, -20},					-- GM ticket
	["attempt"] = {"TOP", UIParent, "TOP", -85, -20},						-- Attempts frame
	["capture_bar"] = {"TOP", UIParent, "TOP", 0, 0},						-- BG capture bars
	["vehicle"] = {"BOTTOM", Minimap, "TOP", 0, 30},						-- Vehicle frame
	["uierror"] = {"TOP", UIParent, "TOP", 0, -30},							-- Errors frame
	["quest"] = {"TOPLEFT", UIParent, "TOPLEFT", 25, -10},					-- Quest log
	["loot"] = {"TOPLEFT", UIParent, "TOPLEFT", 245, -220},					-- Loot
	["group_loot"] = {"BOTTOM", UIParent, "BOTTOM", -210, 500},				-- Group roll loot
	["threat_meter"] = {"BOTTOMLEFT", "oUF_Target", "TOPLEFT", 0, -123},	-- Threat meter
	["raid_cooldown"] = {"TOPLEFT", UIParent, "TOPLEFT", 51, -28},			-- Raid cooldowns
	["enemy_cooldown"] = {"BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 63, 62},	-- Enemy cooldowns
	["pulse_cooldown"] = {"CENTER", UIParent, "CENTER", 0, 0},				-- Pulse cooldowns
	["bg_score"] = {"BOTTOMLEFT", UIParent, "BOTTOM", 176, 6},				-- BG stats
	-- ActionBar positions
	["bottom_bars"] = {"BOTTOM", UIParent, "BOTTOM", 0, 8},					-- Bottom bars
	["right_bars"] = {"BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -21, 320},	-- Right bars
	["pet_horizontal"] = {"BOTTOMRIGHT", UIParent, "BOTTOM", -175, 167},	-- Horizontal pet bar
	["stance_bar"] = {"BOTTOMRIGHT", UIParent, "BOTTOM", -202, 167},		-- Stance/Shift/Totem bars
	["vehicle_bar"] = {"BOTTOMRIGHT", "Bar1Holder", "BOTTOMLEFT", -3, 0},	-- Vehicle button
	-- UnitFrame positions
	["player_buffs"] = {"TOPRIGHT", UIParent, "TOPRIGHT", -22, -20},		-- Player buffs
	unitframes = {
		["player"] = {"BOTTOM", UIParent, "BOTTOM", -284, 236},						-- Player frame
		["target"] = {"BOTTOM", UIParent, "BOTTOM", 284, 236},						-- Target frame
		["target_target"] = {"BOTTOMRIGHT", "oUF_Target", "TOPRIGHT", 0, -54},		-- ToT frame
		["pet"] = {"BOTTOMLEFT", "oUF_Player", "TOPLEFT", 0, -54},					-- Pet frame
		["focus"] = {"BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 0, -54},				-- Focus frame
		["focus_target"] = {"BOTTOMLEFT", "oUF_Target", "TOPLEFT", 0, -54},			-- Focus target frame
		["party_heal"] = {"TOPLEFT", "oUF_Player", "BOTTOMRIGHT", 11, -12},			-- Heal layout Party frames
		["raid_heal"] = {"TOPLEFT", "oUF_Player", "BOTTOMRIGHT", 11, -12},			-- Heal layout Raid frames
		["party_dps"] = {"BOTTOMLEFT", UIParent, "LEFT", 22, -70},					-- DPS layout Party frames
		["raid_dps"] = {"TOPLEFT", UIParent, "TOPLEFT", 22, -22},					-- DPS layout Raid frames
		["arena"] = {"BOTTOMRIGHT", UIParent, "RIGHT", -20, -70},					-- Arena frames
		["boss"] = {"BOTTOMRIGHT", UIParent, "RIGHT", -20, -70},					-- Boss frames
		["tank"] = {"BOTTOMLEFT", UIParent, "BOTTOM", 176, 26},						-- Tank frames
		["player_portrait"] = {"TOPRIGHT", "oUF_Player", "TOPLEFT", -11, 28},		-- Player Portrait
		["target_portrait"] = {"TOPLEFT", "oUF_Target", "TOPRIGHT", 11, 28},		-- Target Portrait
		["player_castbar"] = {"BOTTOMLEFT", "oUF_Player", "BOTTOMRIGHT", 58, 0},	-- Player Castbar
		["target_castbar"] = {"CENTER", "oUF_Player_Castbar", "CENTER", -23, 35},	-- Target Castbar
		["focus_castbar"] = {"CENTER", UIParent, "CENTER", 0, 250},					-- Focus Castbar icon
	},
}