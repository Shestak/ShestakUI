local T, C, L, _ = unpack(ShestakUI)

----------------------------------------------------------------------------------------
--	ShestakUI_Extra personal configuration file
--	BACKUP THIS FILE BEFORE UPDATING!
--	ATTENTION: When saving changes to a file encoded file should be in UTF8
----------------------------------------------------------------------------------------
--	Configuration example:
----------------------------------------------------------------------------------------
-- if T.name == "MegaChar" then
--		C["extra_general"].buff_automator = true
--		C["extra_bar"].enable = true
--		C["extra_skins"].mfclip = true
--		C["extra_position"].mark_bar = {"CENTER", UIParent, "CENTER", 100, 50}
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
--	Oz@Pozzo dell'Eternità Config
----------------------------------------------------------------------------------------
if T.oz == true then
	C["extra_position"].extra_bar = {"BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -237, 24}
	C["extra_bar"].enable = true
	C["extra_bar"].mouseover = true
end

----------------------------------------------------------------------------------------
--	ILF7-Virinea Config
----------------------------------------------------------------------------------------
if (T.name == "Мейнстрим" or T.name == "Мейнвульф" or T.name == "Мейнрейн" or T.name == "Мейнгрейв"
or T.name == "Виринейка" or T.name == "Вирин" or T.name == "Вириней" or T.name == "Виринеа"
or T.name == "Лунорог" or T.name == "Вирка" or T.name == "Виринка") and T.realm == "Азурегос" then
	C["extra_general"].color_picker = true
	C["extra_announce"].my_fps = true
	if T.name == "Мейнстрим" or T.name == "Мейнвульф" or T.name == "Мейнрейн" or T.name == "Мейнгрейв" then
		C["extra_position"].mark_bar = {"BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -225, 160}
		C["extra_bar"].mark_bar = true
		C["extra_general"].buff_automator = true
	end
end

----------------------------------------------------------------------------------------
--	Nagiko@Pozzo dell'Eternità Config
----------------------------------------------------------------------------------------
if T.name == "Nagiko" and T.realm == "Pozzo dell'Eternità" then
	C["extra_position"].extra_bar = {"CENTER", oUF_Target, "CENTER", 56, 251}
	C["extra_bar"].enable = true
end

-- edit by Oz of shestak. org --
