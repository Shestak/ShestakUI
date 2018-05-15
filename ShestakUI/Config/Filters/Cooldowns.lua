local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Rebirth -> http://www.wowhead.com/spell=20484
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
if C.raidcooldown.enable == true then
	T.raid_spells = {

	}
end

if C.enemycooldown.enable == true then
	T.enemy_spells = {

	}
end

if C.pulsecooldown.enable == true then
	T.pulse_ignored_spells = {

	}
end