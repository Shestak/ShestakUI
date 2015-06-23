local T, C, L, _ = unpack(ShestakUI)
if C.unitframe.enable ~= true then return end

C["filger_position"] = {
	player_buff = {"BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 2, 173},	-- "P_BUFF"
	player_proc = {"BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 2, 213},	-- "P_PROC"
	player_special = {"BOTTOMLEFT", "oUF_Player", "TOPRIGHT", 33, 80},	-- "P_SPECIAL"
	
	player_raid = {"BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 2, 253},	-- "P_RAID"
	target_raid = {"BOTTOMLEFT", "oUF_Target", "TOPLEFT", -2, 253},		-- "T_RAID"

	target_buff = {"BOTTOMLEFT", "oUF_Target", "TOPLEFT", -2, 173},		-- "T_BUFF"
	target_proc = {"BOTTOMLEFT", "oUF_Target", "TOPLEFT", -2, 213},		-- "T_PROC"
	
	pve_player = {"BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 2, 333},		-- "PVE/PVP_P"
	pve_target = {"BOTTOMLEFT", "oUF_Target", "TOPLEFT", -2, 333},		-- "PVE/PVP_T"
	
	pve_cc = {"TOPLEFT", "oUF_Player", "BOTTOMLEFT", -2, -44},		-- "PVE/PVP_CC"
	
	cooldown = {"BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 63, C.unitframe.plugins_swing and 29 or 17},		-- "COOLDOWN"
	target_bar = {"BOTTOMLEFT", C.unitframe.portrait_enable and "oUF_Target_Portrait" or "oUF_Target", "BOTTOMRIGHT", C.unitframe.portrait_enable and 6 or 9, C.unitframe.portrait_enable and -3 or -41},	-- "T_DE/BUFF_BAR"
}
