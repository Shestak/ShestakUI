local T, C, L, _ = unpack(ShestakUI)
if C.unitframe.enable ~= true then return end

----------------------------------------------------------------------------------------
--	DarkShestakUI_Filger personal configuration file
--	BACKUP THIS FILE BEFORE UPDATING!
--	ATTENTION: When saving changes to a file encoded file should be in UTF8
----------------------------------------------------------------------------------------
--	Configuration example:
----------------------------------------------------------------------------------------
-- if T.name == "MegaChar" then
--		C["settings_filger"].show_tooltip = true
--		C["positions_filger"].player_buff_icon = {"BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 2, 173}
--		add("T_DEBUFF_ICON", {spellID = 115767, unitID = "target", caster = "player", filter = "DEBUFF"})
-- end
----------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------
--	Function for insert spell
----------------------------------------------------------------------------------------
local add = function(place, spell)
	for class, _ in pairs(C["filger_spells"]) do
		if class == T.class then
			for i = 1, #C["filger_spells"][class], 1 do
				if C["filger_spells"][class][i]["Name"] == place then
					table.insert(C["filger_spells"][class][i], spell)
				end
			end
		end
	end
end

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
--	Oz@Pozzo dell'Eternita Config
----------------------------------------------------------------------------------------
if T.name == "Oz" and T.realm == "Pozzo dell'Eternita" then
	C["filger_settings"].show_tooltip = true
end

----------------------------------------------------------------------------------------
--	m2jest1c Config
----------------------------------------------------------------------------------------
if T.coauthor == true then
	add("T_DEBUFF_ICON", {spellID = 123712, unitID = "target", caster = "all", filter = "DEBUFF"}) -- Scary Fog (Lei Shi HM)
	if T.class == "WARRIOR" then
		add("T_DEBUFF_ICON", {spellID = 115767, unitID = "target", caster = "player", filter = "DEBUFF"}) -- Deep Wounds
	end
	if T.class == "PRIEST" then
		add("COOLDOWN", {spellID = 108968, filter = "CD"}) -- Void Shift
	end
	if T.class == "WARLOCK" then
		add("P_BUFF_ICON", {spellID = 116202, unitID = "player", caster = "player", filter = "BUFF"}) -- Aura of the Elements
		add("P_BUFF_ICON", {spellID = 119839, unitID = "player", caster = "player", filter = "BUFF"}) -- Fury Ward
		add("P_BUFF_ICON", {spellID = 104025, unitID = "player", caster = "player", filter = "BUFF"}) -- Immolation Aura
		add("P_PROC_ICON", {spellID = 60234, unitID = "player", caster = "player", filter = "BUFF"}) -- Zen Alchemist Stone (Int)
		add("P_PROC_ICON", {spellID = 104510, unitID = "player", caster = "player", filter = "BUFF"}) -- Windsong
	end
end