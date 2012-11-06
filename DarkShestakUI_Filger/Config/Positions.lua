local T, C, L, _ = unpack(ShestakUI)
if C.unitframe.enable ~= true then return end

Filger_Settings = {
	config_mode = false,
	max_test_icon = 5,
	player_buff_icon = {"BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 2, 173},	-- "P_BUFF_ICON"
	player_proc_icon = {"BOTTOMLEFT", "oUF_Target", "TOPLEFT", -2, 173},	-- "P_PROC_ICON"
	special_proc_icon = {"BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 2, 213},	-- "SPECIAL_P_BUFF_ICON"
	target_debuff_icon = {"BOTTOMLEFT", "oUF_Target", "TOPLEFT", -2, 213},	-- "T_DEBUFF_ICON"
	target_buff_icon = {"BOTTOMLEFT", "oUF_Target", "TOPLEFT", -2, 253},	-- "T_BUFF"
	pve_debuff = {"BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 2, 253},			-- "PVE/PVP_DEBUFF"
	pve_cc = {"TOPLEFT", "oUF_Player", "BOTTOMLEFT", -2, -44},				-- "PVE/PVP_CC"
	cooldown = {"BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 63, C.unitframe.plugins_swing and 29 or 17},		-- "COOLDOWN"
	target_bar = {"BOTTOMLEFT", "oUF_Target", "BOTTOMRIGHT", 5, -41},	-- "T_DE/BUFF_BAR"
}