----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example : Incinerate Flesh from Lord Jaraxxus -> http://www.wowhead.com/?spell=67049
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
if SettingsCF.reminder.solo_buffs_enable == true then
	SettingsDB.buffs_reminder = {
		PRIEST = {
			588,	-- Inner Fire
			73413,	-- Inner Will
		},
		HUNTER = {
			13165,	-- Aspect of the Hawk
			20043,	-- Aspect of the Wild
			82661,	-- Aspect of the Fox
		},
		MAGE = {
			30482,	-- Molten Armor
			7302,	-- Frost Armor
			6117,	-- Mage Armor
		},
		WARLOCK = {
			28176,	-- Fel Armor
			687,	-- Demon Armor
		},
		PALADIN = {
			31801,	-- Seal of Truth
			20154,	-- Seal of Righteousness
			85126,	-- Seal of Command
			20164,	-- Seal of Justice
			20165,	-- Seal of Insight
		},
		SHAMAN = {
			52127,	-- Water Shield
			324,	-- Lightning Shield
			974,	-- Earth Shield
		},
		WARRIOR = {
			469,	-- Commanding Shout
			6673,	-- Battle Shout
		},
		DEATHKNIGHT = {
			57330,	-- Horn of Winter
			31634,	-- Shaman Strength of Earth Totem
			6673,	-- Battle Shout
			93435,	-- Roar of Courage
		},
		DRUID = {
			1126,	-- Mark of the Wild
			20217,	-- Blessing of Kings
		},
	}
end