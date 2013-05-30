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
--		C["filger_settings"].show_tooltip = true
--		C["filger_position"].player_buff_icon = {"BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 2, 173}
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
--	Shestak Config
----------------------------------------------------------------------------------------
if T.author == true then
	C["filger_settings"].show_tooltip = false
	if T.class == "DRUID" then
		add("P_BUFF_ICON", {spellID = 100977, unitID = "player", caster = "player", filter = "BUFF"})
		add("P_BUFF_ICON", {spellID = 33763, unitID = "player", caster = "player", filter = "BUFF"})
		add("P_BUFF_ICON", {spellID = 774, unitID = "player", caster = "player", filter = "BUFF"})
		add("P_BUFF_ICON", {spellID = 8936, unitID = "player", caster = "player", filter = "BUFF"})
	end
end

----------------------------------------------------------------------------------------
--	Oz@Pozzo dell'Eternità Config
----------------------------------------------------------------------------------------
if T.name == "Oz" and T.realm == "Pozzo dell'Eternità" then
	add("P_BUFF_ICON", {spellID = 114851, unitID = "player", caster = "player", filter = "BUFF"})	-- Blood Charge
	add("P_BUFF_ICON", {spellID = 91342, unitID = "pet", caster = "player", filter = "BUFF"})		-- Shadow Infusion
end

----------------------------------------------------------------------------------------
--	Medusa@Pozzo dell'Eternità Config
----------------------------------------------------------------------------------------
if T.name == "Medusa" and T.realm == "Pozzo dell'Eternità" then
	add("COOLDOWN", {spellID = 586, filter = "CD"})													-- Fade
	add("COOLDOWN", {spellID = 6346, filter = "CD"})												-- Fear Ward
	add("COOLDOWN", {spellID = 123040, filter = "CD"})												-- Mindbender
	add("COOLDOWN", {spellID = 17, filter = "CD"})													-- Power Word: Shield
	add("COOLDOWN", {spellID = 34433, filter = "CD"})												-- Shadowfiend
	add("P_BUFF_ICON", {spellID = 112833, unitID = "player", caster = "player", filter = "BUFF"})	-- Spectral Guise (buff)
	add("COOLDOWN", {spellID = 112833, filter = "CD"})												-- Spectral Guise (cooldown)
	add("COOLDOWN", {spellID = 15286, filter = "CD"})												-- Vampiric Embrace
	add("COOLDOWN", {spellID = 108968, filter = "CD"})												-- Void Shift
end

-- Edit by Oz of shestakdotorg --
