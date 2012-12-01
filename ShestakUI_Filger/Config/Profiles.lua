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
--		F["settings"].show_tooltip = true
--		F["positions"].player_buff_icon = {"BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 2, 173}
--		add("T_DEBUFF_ICON", {spellID = 115767, unitID = "target", caster = "player", filter = "DEBUFF"})
-- end
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
--	Function for insert spell
----------------------------------------------------------------------------------------
local add = function(place, spell)
	for class, _ in pairs(F["spells"]) do
		if class == T.class then
			for i = 1, #F["spells"][class], 1 do
				if F["spells"][class][i]["Name"] == place then
					table.insert(F["spells"][class][i], spell)
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
--	Shestak Config
----------------------------------------------------------------------------------------
if T.author == true then
	if T.class == "DRUID" then
		add("P_BUFF_ICON", {spellID = 100977, unitID = "player", caster = "player", filter = "BUFF"})
	end
end