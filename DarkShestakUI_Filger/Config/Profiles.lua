local T, C, L, _ = unpack(ShestakUI)
if C.unitframe.enable ~= true then return end

----------------------------------------------------------------------------------------
--	ShestakUI_Filger personal configuration file
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
--	Shestak Config
----------------------------------------------------------------------------------------
if (T.name == "Вершок" or T.name == "Вещмешок" or T.name == "Гребешок" or T.name == "Кулешок" or T.name == "Лапушок"  	
or T.name == "Обушок" or T.name == "Ремешок" or T.name == "Торгашок" or T.name == "Черешок"
or T.name == "Женишок" or T.name == "Шестак" or T.name == "Дефляция") then
	if T.class == "DRUID" then
		add("P_BUFF_ICON", {spellID = 100977, unitID = "player", caster = "player", filter = "BUFF"})
		add("P_BUFF_ICON", {spellID = 33763, unitID = "player", caster = "player", filter = "BUFF"})
		add("P_BUFF_ICON", {spellID = 774, unitID = "player", caster = "player", filter = "BUFF"})
		add("P_BUFF_ICON", {spellID = 8936, unitID = "player", caster = "player", filter = "BUFF"})
	end
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
	end
end